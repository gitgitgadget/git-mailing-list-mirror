Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD2AC001DD
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 16:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjGMQhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 12:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjGMQhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 12:37:09 -0400
X-Greylist: delayed 564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jul 2023 09:36:44 PDT
Received: from mail.nicholasjohnson.ch (mail.nicholasjohnson.ch [93.95.231.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4F62D66
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 09:36:43 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nicholasjohnson.ch;
        s=dkim1; t=1689265634;
        bh=JwLomMKJgY9rLPilFfPJ60nAbI6uV7MLl8OWCN6KnRI=;
        h=Date:Subject:From:To:From;
        b=QUvAnEpRu89ZODX7wII4Vhc2o6mfn5MR70QWyHerZFogs6JPKcoyiHVmRvXmM3fJJ
         /2eZLnRaJ0nEpjF9XRnz75BsvMNGTAeZGgPGonvSPGfpPjrJ10fGxqi1UEdEB+UHcW
         U7JuPUwknvPm20n3tWSfvNQ2T4QGO3n5BlEYse/d2c7WAHO50buPbRsTnhReSrH6eb
         ijQVyuOa3d4nWYTa41/QCMpdrXZ5E4teo0nX3RiMQdQ/BTVCHFHs0vRk6SRfkeAUEs
         J5mmcLpFIT5ug0GuuAcvhq94mR79/K46bYtm5f6M8zY2jyRU0CrFJD/7OaT2Os0eqz
         Pdh32IiD3G7WQ==
Date:   Thu, 13 Jul 2023 16:27:46 +0000
Subject: Git Privacy
From:   "nick" <nick@nicholasjohnson.ch>
To:     <git@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple years ago, I created git-privacy[1]. In it, I explain how
having exact commit times in a Git repo, over a long enough timespan,
can potentially be used to deduce private information about a
developer's life. Then I go on to explain the steps to prevent this
private information leakage.

I know this is low on the list of priorities when it comes to increasing
one's digital privacy, but I think it still matters. It's certainly
relevant to developers who need to remain anonymous while version
controlling their public software.

I was wondering if it would be appropriate to implement a feature which
would allow for automatic obfuscation of Git committer and author
timestamps without the need to assign environment variables or use Git
hooks. Perhaps a config option to automatically set the date to a time
before Git was invented?

Might there a better way to implement these ideas than what I'm
thinking? Please provide some feedback.


References:
1: https://git.nicholasjohnson.ch/git-privacy/
