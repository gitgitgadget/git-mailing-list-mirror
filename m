From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 8/9] git status: not "commit --dry-run" anymore
Date: Mon, 17 Aug 2009 10:57:26 +0200
Message-ID: <200908171057.27455.trast@student.ethz.ch>
References: <1250375997-10657-1-git-send-email-gitster@pobox.com> <1250375997-10657-8-git-send-email-gitster@pobox.com> <1250375997-10657-9-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 10:58:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcy2k-00073Z-3U
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 10:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757506AbZHQI6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 04:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757428AbZHQI6A
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 04:58:00 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:28960 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757455AbZHQI57 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 04:57:59 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 17 Aug
 2009 10:58:00 +0200
Received: from thomas.localnet (129.132.211.150) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 17 Aug
 2009 10:57:49 +0200
User-Agent: KMail/1.12.1 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <1250375997-10657-9-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126144>

Junio C Hamano wrote:
> This removes tentative "git stat" and make it take over "git status".
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * This alone fails some tests; 9/9 will be squashed in in the final round.
> 
>  Documentation/git-status.txt |   79 ++++++++++++++++++++++++++++++++++++-----
>  builtin-commit.c             |   29 ++-------------
>  builtin.h                    |    1 -
>  git.c                        |    1 -
>  4 files changed, 73 insertions(+), 37 deletions(-)
[...]
> -		{ "stat", cmd_stat, RUN_SETUP | NEED_WORK_TREE },
>  		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },

This lacks a corresponding update to the Makefile:

diff --git i/Makefile w/Makefile
index f384a52..8a7509c 100644
--- i/Makefile
+++ w/Makefile
@@ -383,7 +383,6 @@ BUILT_INS += git-init$X
 BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-peek-remote$X
 BUILT_INS += git-repo-config$X
-BUILT_INS += git-stat$X
 BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
