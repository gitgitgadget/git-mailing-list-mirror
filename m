From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/5] bisect: introduce --no-checkout[=<ref>] support into porcelain.
Date: Sat, 30 Jul 2011 16:34:32 +0200
Message-ID: <201107301634.33710.chriscool@tuxfamily.org>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com> <1312014511-7157-4-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j6t@kdbg.org, gitster@pobox.com,
	jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 16:34:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnAcr-0008Ql-4i
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 16:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab1G3Oep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 10:34:45 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:44038 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785Ab1G3Oeo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 10:34:44 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8F193A61F5;
	Sat, 30 Jul 2011 16:34:35 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1312014511-7157-4-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178201>

On Saturday 30 July 2011 10:28:29 Jon Seymour wrote:
> diff --git a/git-bisect.sh b/git-bisect.sh
> index b2186a8..6c4e853 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -3,7 +3,7 @@
>  USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
>  LONG_USAGE='git bisect help
>          print this long help message.
> -git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
> +git bisect start [--no=checkout[=<ref>]] [<bad> [<good>...]] [--]

s/--no=checkout/--no-checkout/

> [<pathspec>...] reset bisect state and start bisection.
>  git bisect bad [<rev>]
>          mark <rev> a known-bad revision.
> @@ -34,6 +34,8 @@ require_work_tree
>  _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
>  _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> 
> +BISECT_NOCHECKOUT=$(test -f "${GIT_DIR}/BISECT_NOCHECKOUT" && cat
> "${GIT_DIR}/BISECT_NOCHECKOUT")

Is there a reason you use "${GIT_DIR}" instead of "$GIT_DIR" that is used 
everywhere else?

Thanks,
Christian.
