From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Fri, 06 Jun 2008 23:53:05 -0700
Message-ID: <7vfxrppwha.fsf@gitster.siamese.dyndns.org>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
 <alpine.DEB.1.00.0806051946100.21190@racer> <484969F0.1030704@gnu.org>
 <alpine.DEB.1.00.0806061911300.1783@racer>
 <Jx4nZtFGdU-iUxlX24G6lzMyWe99Z53jtjQp9T9qkMJ1iZC0eZW6xg@cipher.nrlssc.navy.mil> <d45085aa0806061417ue3f1f51i6580acbb51070e5b@mail.gmail.com> <alpine.DEB.1.00.0806070006150.1783@racer> <d45085aa0806061713k72108a87qa6635a5935732f20@mail.gmail.com> <7vej7aqetd.fsf@gitster.siamese.dyndns.org> <d45085aa0806061743w65df3cd7pe4cf5fa29f83930a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Brandon Casey" <casey@nrlssc.navy.mil>,
	"Paolo Bonzini" <bonzini@gnu.org>, git@vger.kernel.org
To: "Cedric Vivier" <cedricv@neonux.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 08:54:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4sJc-00012d-4L
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 08:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbYFGGxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 02:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752859AbYFGGxX
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 02:53:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbYFGGxX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 02:53:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 46C2A1901;
	Sat,  7 Jun 2008 02:53:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7848E195F; Sat,  7 Jun 2008 02:53:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6AB4A0C4-345E-11DD-8DC4-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84176>

"Cedric Vivier" <cedricv@neonux.com> writes:

> On Sat, Jun 7, 2008 at 2:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Somebody suggested strvercmp(); how does the natcmp() compare with it?
>>
>
> Yeah I did, as a heads-up from the discussion on the apache
> mailing-list linked earlier.
> I've just checked out glibc's implementation, the result would be the
> same, the code seems better to me, and there is no doubt the license
> is 100% compatible this way [1], sounds cool.
>
> [1] as I guess we'd still have to borrow the code from glibc and put
> it into git's compat/ directory (or whatever name is choosen in the
> end for this kind of borrowed stuff) to make it work on non-glibc
> platforms (?)

Yes, and we have precedents to it, like compat/strcasestr.c
