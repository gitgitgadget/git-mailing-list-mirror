From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] t5300-pack-object.sh: portability issue using /usr/bin/stat
Date: Fri, 06 Apr 2007 21:13:26 -0700
Message-ID: <7vabxkhleh.fsf@assigned-by-dhcp.cox.net>
References: <20070406234903.GJ3854@regex.yaph.org>
	<7vfy7dgcn1.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704062227430.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 06:13:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ha2Iu-0002Hs-85
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 06:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965271AbXDGEN3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 00:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbXDGEN3
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 00:13:29 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39653 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965271AbXDGEN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 00:13:28 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407041327.KCQP373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Apr 2007 00:13:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id k4DS1W00D1kojtg0000000; Sat, 07 Apr 2007 00:13:27 -0400
In-Reply-To: <alpine.LFD.0.98.0704062227430.28181@xanadu.home> (Nicolas
	Pitre's message of "Fri, 06 Apr 2007 22:33:34 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43960>

Nicolas Pitre <nico@cam.org> writes:

> On Fri, 6 Apr 2007, Junio C Hamano wrote:
>
>> arjen@yaph.org (Arjen Laarhoven) writes:
>> 
>> > In the test 'compare delta flavors', /usr/bin/stat is used to get file size.
>> > This isn't portable.  There already is a dependency on Perl, use its '-s'
>> > operator to get the file size.
>> 
>> If you do use Perl, then you do not want to do it as two
>> separate invocations with their result compared with test.
>> 
>> How about this on top of your patch?
>
> Well... since this test already depends on wc then why not just use that 
> instead of adding a perl dependency?

Because (1) other tests already use Perl; (2) wc -c reads pack
to find out the size, "-s $file" doesn't AFAIK.
