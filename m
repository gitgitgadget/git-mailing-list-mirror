From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 1/2] t3404: extra checks and s/! git/test_must_fail git/
Date: Fri, 20 Jun 2008 13:48:32 -0500
Message-ID: <X-0hXtX7hZGzbL_zS7e4VUMsiMfWiIfABUCFp28XZx0@cipher.nrlssc.navy.mil>
References: <alpine.DEB.1.00.0806201407230.6439@racer> <1213986614-19536-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 20:49:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9lfz-00027B-0M
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 20:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbYFTSsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 14:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYFTSsj
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 14:48:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54908 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbYFTSsj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 14:48:39 -0400
Received: by mail.nrlssc.navy.mil id m5KImXYo022143; Fri, 20 Jun 2008 13:48:33 -0500
In-Reply-To: <1213986614-19536-1-git-send-email-s-beyer@gmx.net>
X-OriginalArrivalTime: 20 Jun 2008 18:48:33.0027 (UTC) FILETIME=[3D35F530:01C8D306]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85672>

Stephan Beyer wrote:

> @@ -380,7 +397,7 @@ test_expect_success 'interrupted squash works as expected' '
>  	! FAKE_LINES="1 squash 3 2" git rebase -i HEAD~3 &&

These can be converted to use test_must_fail by using a sub-shell
as Junio demonstrated:

	(
		FAKE_LINES="1 squash 3 2" &&
		export FAKE_LINES &&
		test_must_fail git rebase -i HEAD~3
	) &&

-brandon
