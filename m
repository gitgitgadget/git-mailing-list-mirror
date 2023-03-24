Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1411EC6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 12:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCXMN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 08:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjCXMN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 08:13:56 -0400
X-Greylist: delayed 153 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Mar 2023 05:13:41 PDT
Received: from mail.aegee.org (mail.aegee.org [144.76.142.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E17D149BD
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 05:13:41 -0700 (PDT)
Received: from webmail.aegee.org (localhost [127.0.0.1])
        by mail.aegee.org (8.17.1/8.17.1) with ESMTP id 32OCB6oQ2246918
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 12:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
        t=1679659866; i=dkim+sm-localhost@aegee.org;
        bh=jL9nYFIpXvbfavjc7Fn8RPQ2h5WEiHJpgsHE5idnVoY=;
        h=Date:From:To:Subject;
        b=cRfZtS1LzijeJ7T9M8+iI81SOFmf0CwAsaCB4G0JvpjHPdMRiIYZp6jdRWilSs7q7
         6RlZaoE9sN7qjCM8IrQFnlloOgETg6xY84eHZP3FngJOAF1oOdI25WApkmK/FAM/VC
         D7M/pGkFWPv1Lfq0V9DYCcT6qejEtPKA/Dtu0FGODE+ZPSlOY4Xm4Yo87bUZYZ1Qf+
         6VsPuHwrYjv1REczOES8d0ckqz9XykEqVvoomJoKTKyNJdtzu6SeQoBJw5yRpehJBh
         pyinYYTK0lJAQHNykhLD6RLt7dlrTEkdM/gBleEoIFu3fcue76WjevfPvjU7JA+Bvc
         vdWAcuf9n8qrmq7oDhi3nXaMqCCim2CaM/2iiM0R+g+Hw7Tec9laIc6VzBXMy5iqHv
         o10VVgqxx7yMXcryqz6vMf86XeWjFWgOcitIO2iZ6jqB3rOH4YFs/0Emav3HYVZnty
         J5tigNTd4z2cHFGKIz+LjDLxBlFzFRenFcqHgjW4Q0UZqREgxsOWgKqfmuq7yu2zhC
         l1FQHmrscxX6XWBb7q1lXNrBZMgYrliBXt3WDAQJGDTcOuT0qhMnkBZHz7Sb78Ho3Z
         OtuMlIa5TGcOkRv6hbimFAqgnSUa4Qm7jC/0oL3KBMa8zgpG1IdfcGNN8UC240Yb1a
         khUoT1QuuczKWxXi4BglKddM=
Authentication-Results: mail.aegee.org/32OCB6oQ2246918; dkim=none
MIME-Version: 1.0
Date:   Fri, 24 Mar 2023 13:11:06 +0100
From:   =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_=D0=9F=D0=B0=D0=BB=D0=B0?=
         =?UTF-8?Q?=D1=83=D0=B7=D0=BE=D0=B2?= <dilyan.palauzov@aegee.org>
To:     git@vger.kernel.org
Subject: rebase has no --cleanup option
Message-ID: <e2ceba47235e2f7e4f6889954111044d@aegee.org>
X-Sender: dilyan.palauzov@aegee.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

in rare cases I want to write commit messages with leading # sign and 
for these messages I call “git commit --cleanup==whitespace”.  So far, 
so good.

Now I want to rebase - modify (edit) the commit message of an old 
commit, or squash a commit, which has leading # in its comment.  I 
cannot pass --cleanup=whitespace and this is the problem description 
here — the #-lines disappear after rebase (edit/squash operations).

In theory I could set the commit.cleanup configuration parameter (in 
.gitconfig), but I prefer not to do this, as I do not want to disable 
permanently the stripping of lines with leading # in git commit 
messages.

Please add --cleanup= option to the rebase command.

I use here the command-line git client 2.39.2, not a GUI or whatsoever.

Kind regards
   Дилян
