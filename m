From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: No working tree repository
Date: Tue, 15 Jun 2010 22:58:20 +0200
Message-ID: <vpq7hm0dndf.fsf@bauges.imag.fr>
References: <4C17BEB7.90403@cfl.rr.com> <vpqy6egi2va.fsf@bauges.imag.fr>
	<4C17C77C.9000002@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 22:58:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOdDP-00006y-0N
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 22:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462Ab0FOU6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 16:58:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34687 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758453Ab0FOU63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 16:58:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5FKoJuK007567
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 15 Jun 2010 22:50:19 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OOdDB-0002Hi-0C; Tue, 15 Jun 2010 22:58:21 +0200
In-Reply-To: <4C17C77C.9000002@cfl.rr.com> (Phillip Susi's message of "Tue\, 15 Jun 2010 14\:33\:32 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Jun 2010 22:50:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FKoJuK007567
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277239822.72945@YtNhRCmRFMKzjFqL0Z+sHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149225>

Phillip Susi <psusi@cfl.rr.com> writes:

> On 6/15/2010 2:10 PM, Matthieu Moy wrote:
>> This is called a "bare" repository. Now, you have the keyword to
>> RTFM ;-).
>
> Ahh, that's the magic word I was groping for.
>
> It seems that --bare on clone will prevent the checkout of the local
> working tree.  If I decide I do want the sources today I can just check
> them out, but what is the proper way to do the reverse?  I was thinking
> something like somehow empty the index file then do a git-reset or
> git-checkout-index to clean up the working tree to match the empty
> index, but I can't figure out how to empty the index.

rm -fr *  # use at your own risk
rm -f .git/index

Then, you can get back a tree with "git checkout" or "git checkout
HEAD -- .". The advantage of this solution over the empty-branch
solution is that although you destroyed your index, HEAD is still
there so "git log" and friends will show you where you are.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
