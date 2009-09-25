From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git clone sending unneeded objects
Date: Fri, 25 Sep 2009 21:34:13 +0200
Message-ID: <vpqvdj6izt6.fsf@bauges.imag.fr>
References: <m2tz0j154o.fsf@igel.home>
	<alpine.LFD.2.00.0908082246020.440@xanadu.home>
	<m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Hin-Tak Leung <hintak.leung@gmail.com>
To: Jason Merrill <jason@redhat.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 21:35:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrGZI-0004lk-UK
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 21:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbZIYTev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 15:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbZIYTev
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 15:34:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45064 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946AbZIYTeu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 15:34:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n8PJTbqj004846
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 25 Sep 2009 21:29:37 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MrGYX-0004go-TF; Fri, 25 Sep 2009 21:34:13 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1MrGYX-0005Hk-L6; Fri, 25 Sep 2009 21:34:13 +0200
In-Reply-To: <4ABD0669.7050309@redhat.com> (Jason Merrill's message of "Fri\, 25 Sep 2009 14\:05\:29 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Sep 2009 21:29:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8PJTbqj004846
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254511778.46788@wvg6A4vI1Zw/L+PGvtJoOA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129107>

Jason Merrill <jason@redhat.com> writes:

> On 08/09/2009 03:43 AM, Andreas Schwab wrote:
>> Nicolas Pitre<nico@cam.org>  writes:
>>
>>> If you do a clone using the git:// protocol and the server sends you
>>> only the ref for the trunk branch,
>>
>> A clone will fetch all branches from refs/heads/*.
>>
>>> then it should send you only objects reachable from that branch.
>>
>> Apparantly this does not work.  I'd guess the extra objects are needed
>> due to the delta compression.
>
> I just tried doing a clone of the GCC repository, then git gc
> --prune=now, and another clone specifying --reference to the first,
> and it wanted to download all the unreachable objects again.  So it
> doesn't seem to be a compression issue.
>
> This is with git 1.6.4 on both ends.

Which protocol did you use?

If you use git:// or ssh://, it's normally a security feature that Git
sends you only reachable objects. If it doesn't, it's a serious bug.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
