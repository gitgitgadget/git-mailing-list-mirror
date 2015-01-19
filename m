From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] branch: add support for --dry-run option
Date: Mon, 19 Jan 2015 15:20:51 +0100
Message-ID: <54BD12C3.5050802@drmicha.warpmail.net>
References: <1421480159-4848-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 15:21:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDDCN-0004mG-GG
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 15:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbbASOUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 09:20:54 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35803 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751734AbbASOUx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 09:20:53 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id DD58120006
	for <git@vger.kernel.org>; Mon, 19 Jan 2015 09:20:52 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 19 Jan 2015 09:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=mMI8fSeQt6GNtJXu4bjiUg
	kr1L0=; b=stLstZmLcX7JOdCwMjsIP6AS6yPHeMlCotbdFV97miaSd1bjxkuyXa
	s7x30VOk0HehHggpLt3XAncuph5FHFfcK7bhIjLAcgqq0bXq7fTsE9uWNte5i18r
	2pQUw5sFhW6gSfrT67D/S2VDQkgkumL1pyXkkO3DVESLihNPEymYA=
X-Sasl-enc: SXQf4hbUea4/Kxq4xtOhTWoJaqmcm7nEjj+XCnN39j6v 1421677252
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4A6D0C00018;
	Mon, 19 Jan 2015 09:20:52 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1421480159-4848-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262616>

Alexander Kuleshov schrieb am 17.01.2015 um 08:35:
> This patch adds support -d/--dry-run option for branch(es) deletion.
> If -d/--dry-run option passed to git branch -d branch..., branch(es)
> will not be removed, instead just print list of branches that are
> to be removed.
> 
> For example:
> 
>     $ git branch
>     a
>     b
>     c
>     * master
> 
>     $ git branch -d -n a b c
>     delete branch 'a' (261c0d1)
>     delete branch 'b' (261c0d1)
>     delete branch 'c' (261c0d1)

Is there a case where deleting "a b c" would not delete "a b c"?

In other words: What new information does a dry-run give the user, other
than what "branch --list -v" would give already? (We could need a
shortcut on the latter, but that is a different topic.)

Michael
