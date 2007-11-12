From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] setup_git_directory: Setup cwd properly if worktree is
   found
Date: Mon, 12 Nov 2007 13:53:49 +0100
Message-ID: <47384CDD.5000209@viscovery.net>
References: <20071112112408.GA5420@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 13:54:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrYnt-0003XP-DR
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 13:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839AbXKLMxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2007 07:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755045AbXKLMxy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 07:53:54 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:21999 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbXKLMxy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 07:53:54 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IrYn0-00035X-MJ; Mon, 12 Nov 2007 13:53:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6EBA854D; Mon, 12 Nov 2007 13:53:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071112112408.GA5420@laptop>
X-Spam-Score: -0.8 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_60=1, UPPERCASE_25_50=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64614>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> +export SAVED_WORK_DIR=3D$(pwd)/work
> +export GIT_DIR=3D"$(pwd)"/repo.git
> +export GIT_CONFIG=3D"$GIT_DIR"/config
> +export GIT_WORK_TREE=3D"$(pwd)"/work

These are not very portable; use:

    GIT_DIR=3D"$(pwd)"/repo.git
    GIT_CONFIG=3D"$GIT_DIR"/config
    GIT_WORK_TREE=3D"$(pwd)"/work
    export GIT_DIR GIT_CONFIG GIT_WORK_TREE

The first one also needs $(pwd) quoted.

-- Hannes
