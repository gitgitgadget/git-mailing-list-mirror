From: Andriy Gapon <avg@FreeBSD.org>
Subject: Re: Bug in git rebase --continue in v1.8.4
Date: Wed, 04 Sep 2013 11:02:04 +0300
Message-ID: <5226E8FC.8070208@FreeBSD.org>
References: <5221E661.1070200@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=X-VIET-VPS
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 04 10:09:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH89C-0001SY-AC
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 10:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762130Ab3IDIJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 04:09:01 -0400
Received: from citadel.icyb.net.ua ([212.40.38.140]:3921 "EHLO
	citadel.icyb.net.ua" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610Ab3IDII7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 04:08:59 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Sep 2013 04:08:59 EDT
Received: from porto.starpoint.kiev.ua (porto-e.starpoint.kiev.ua [212.40.38.100])
	by citadel.icyb.net.ua (8.8.8p3/ICyb-2.3exp) with ESMTP id LAA22446
	for <git@vger.kernel.org>; Wed, 04 Sep 2013 11:02:41 +0300 (EEST)
	(envelope-from avg@FreeBSD.org)
Received: from localhost ([127.0.0.1])
	by porto.starpoint.kiev.ua with esmtp (Exim 4.34 (FreeBSD))
	id 1VH82z-0006LB-Hh
	for git@vger.kernel.org; Wed, 04 Sep 2013 11:02:41 +0300
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:17.0) Gecko/20130810 Thunderbird/17.0.8
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233818>

Christoph Mallon said:
> if I run rebase --continue (e.g. after a conflict resolution), then the rebase always ends with this error message:
> 	It seems that there is already a rebase-apply directory, and
> 	I wonder if you are in the middle of another rebase.  If that is the
> 	case, please try
>         	git rebase (--continue | --abort | --skip)
> 	If that is not the case, please
>         	rm -fr "/home/tron/gitRebaseTest/test/.git/rebase-apply"
> 	and run me again.  I am stopping in case you still have something
> 	valuable there.
> 
> This happens on git v1.8.4 on FreeBSD. It is fine with v1.8.3.4.

I observe exactly the same problem.
I also use FreeBSD and the problem started with 1.8.4.

Judging by the lack of followups, could this be a FreeBSD-specific problem?
Any thoughts / suggestions?
Thank you!

> It seems to be caused by
> a1549e1049439386b9fd643fae236ad3ba649650, specifically this hunk:
> 	--- a/git-rebase--am.sh
> 	+++ b/git-rebase--am.sh
> 	 <at>  <at>  -7,12 +7,12  <at>  <at>  case "$action" in
> 	 continue)
> 	  git am --resolved --resolvemsg="$resolvemsg" &&
> 	  move_to_original_branch
> 	- exit
> 	+ return
> 	  ;;
> 	 skip)
> 	  git am --skip --resolvemsg="$resolvemsg" &&

-- 
Andriy Gapon
