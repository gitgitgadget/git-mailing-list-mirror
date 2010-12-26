From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Possible bug in "git rebase" (non-interactive) with regards to post-rewrite
Date: Sun, 26 Dec 2010 11:38:20 +0100
Message-ID: <201012261138.21059.trast@student.ethz.ch>
References: <AANLkTikv+TuVK3uyEd5ymLRq6Qs7tQYm4kUH3t9hTtQP@mail.gmail.com> <7vipyl4aqx.fsf@alter.siamese.dyndns.org> <7vd3ot48ke.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mihai Rusu <dizzy@google.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 26 11:38:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWnzh-0003Us-2z
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 11:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab0LZKiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 05:38:23 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:5252 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729Ab0LZKiX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 05:38:23 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 26 Dec
 2010 11:38:20 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 26 Dec
 2010 11:38:21 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <7vd3ot48ke.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164186>

Junio C Hamano wrote:
> When "rebase --skip" is used to skip the last patch in the series, the
> code to wrap up the rewrite by copying the notes from old to new commits
> and also by running the post-rewrite hook was bypassed.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
[...]
> -if test "$this" -gt "$last"
> -then
> -	say Nothing to do.
> -	rm -fr "$dotest"
> -	exit
> -fi
> -
>  while test "$this" -le "$last"
>  do
>  	msgnum=`printf "%0${prec}d" $this`

Ack, thanks for patching this.

(I think it's saner anyway not to say "nothing to do" when the user
would expect "we're all done here"...)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
