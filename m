Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1737220179
	for <e@80x24.org>; Mon, 20 Jun 2016 07:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbcFTHhu (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 03:37:50 -0400
Received: from forward9o.cmail.yandex.net ([37.9.109.56]:40670 "EHLO
	forward9o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931AbcFTHhr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2016 03:37:47 -0400
Received: from mxback10o.mail.yandex.net (mxback10o.mail.yandex.net [37.140.190.24])
	by forward9o.cmail.yandex.net (Yandex) with ESMTP id A10F22106C
	for <git@vger.kernel.org>; Mon, 20 Jun 2016 10:36:29 +0300 (MSK)
Received: from web24o.yandex.ru (web24o.yandex.ru [95.108.205.124])
	by mxback10o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id gKLlDSseM0-aSauLYlc;
	Mon, 20 Jun 2016 10:36:28 +0300
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=proff.email; s=mail; t=1466408188;
	bh=oD0PEVhm9Pscclfuxb3qsHlsg4SU2T561mQ54eXPud4=;
	h=X-Yandex-Sender-Uid:From:To:Subject:MIME-Version:Message-Id:
	 X-Mailer:Date:Content-Transfer-Encoding:Content-Type;
	b=vNjflpm9sKIlCrAYL+XYvjh7OEoD4t7xjQBPOlbRUx5qnzCtyYTTVUyf7RbxgKh6k
	 Rbw+ZNEhZvDGqBNT8+RXxKv+kjVKz+IFxmiseivN8sE/l5hrJFkGhKgENR3AA0vvWJ
	 r0SjWXb/WyPXkGuzSzRhFnDIoFw5P/9KQk5rPiqQ=
Authentication-Results:	mxback10o.mail.yandex.net; dkim=pass header.i=@proff.email
X-Yandex-Suid-Status: 1 0,1 1130000030016099
X-Yandex-Sender-Uid: 1130000012816100
Received: by web24o.yandex.ru with HTTP;
	Mon, 20 Jun 2016 10:36:28 +0300
From:	=?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCe0LLRh9C40L3QvdC40LrQvtCy?= 
	<proff@proff.email>
To:	git@vger.kernel.org
Subject: may be bug in svn fetch no-follow-parent
MIME-Version: 1.0
Message-Id: <4094761466408188@web24o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:	Mon, 20 Jun 2016 10:36:28 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Why git svn fetch try to handle mergeinfo changes when no-follow-parent is enabled?
Git try to follow parents regardless of this option value.
If branch created without this option then git will follow parent succesfully
If branch created with this option then git try to follow and fail with "cannot find common ancestor" error
If branch does not exists (ignored) then git try to follow and fail with "couldn't find revmap" error. It is very long operation
