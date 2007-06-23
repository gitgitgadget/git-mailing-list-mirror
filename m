From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9500: skip gitweb tests if perl version is too old
Date: Sat, 23 Jun 2007 03:14:08 -0700
Message-ID: <7vps3n3rm7.fsf@assigned-by-dhcp.pobox.com>
References: <20070622154908.GA7946MdfPADPa@greensroom.kotnet.org>
	<7vps3n89mb.fsf@assigned-by-dhcp.pobox.com>
	<20070623085751.GX955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Jun 23 12:14:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I22d9-0006a8-PA
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 12:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbXFWKOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 06:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbXFWKOK
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 06:14:10 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:43538 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbXFWKOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 06:14:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070623101408.YPGS17635.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Jun 2007 06:14:08 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id EyE81X0021kojtg0000000; Sat, 23 Jun 2007 06:14:08 -0400
In-Reply-To: <20070623085751.GX955MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Sat, 23 Jun 2007 10:57:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50726>

Sven Verdoolaege <skimo@kotnet.org> writes:

> On Fri, Jun 22, 2007 at 11:31:40PM -0700, Junio C Hamano wrote:
>> Sven Verdoolaege <skimo@kotnet.org> writes:
>> > +perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
>> > +    test_expect_success 'skipping gitweb tests, perl version is too old' :
>> > +    test_done
>> > +    exit
>> > +}
>> > +
>> 
>> Hmph.  Even something silly like:
>> 
>> 	perl -MEncode -e 'decode_utf8("", Encode::FB_CLUCK)'
>> 
>> seem to succeed for me with 5.8.8.
>> 
>
> Maybe I'm missing something, but it's supposed to succeed
> for perl versions that are recent enough.

Well, "Encode::FB_CLUCK" is a bogus symbol even in recent Perl.
IOW, the tested function does not seem to care if I give
whatever garbage as the second parameter.

But I guess you are only interested if the perl used to run
gitweb barfs with that two parameter, so the original check
would be the right way.

Will apply, but I am about to go to bed, so it will be
tomorrow.

Thanks.
