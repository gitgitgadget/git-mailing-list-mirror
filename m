Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDF1A1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 12:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbfGQMHQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 08:07:16 -0400
Received: from smtp-b16-93.magic.fr ([188.130.16.93]:38056 "EHLO
        srv2448.sd-france.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfGQMHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 08:07:16 -0400
X-Greylist: delayed 3375 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jul 2019 08:07:15 EDT
Received: from helsinki.magic.fr (helsinki.magic.fr [188.130.33.134])
        by srv2448.sd-france.net (8.14.7/8.14.7) with ESMTP id x6HBAwex093889
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 13:10:58 +0200
Received: (qmail 6033 invoked from network); 17 Jul 2019 13:10:51 +0200
Received: from static-176-158-133-18.ftth.abo.bbox.fr (HELO Mail) (176.158.133.18)
  by nrgic.fr with SMTP; 17 Jul 2019 13:10:51 +0200
Received: from [192.168.6.120] (baptisted.eugdns [192.168.6.120])
        by Mail with ESMTPA
        ; Wed, 17 Jul 2019 13:10:55 +0200
To:     git@vger.kernel.org
From:   Baptiste Delestre <baptisted@eugensystems.com>
Subject: git fetch --no-tags still fetch tags when remote name is provided
Message-ID: <07af82bd-0f4d-77b3-b5ae-e1efc887ade5@eugensystems.com>
Date:   Wed, 17 Jul 2019 13:10:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!
I have two remotes with different tags, so when I use "git fetch" it 
removes the tag from the other remote and add tag from the origin remote.
So I tried to use "git fetch --no-tags" to prevent this behavior and I 
have no use for those tags locally.
The problem is it works for the origin remote but when I fetch the other 
remote with "git fetch --no-tags other" it fetch tags.
The same happen when fetching a group or with "git fetch --all --no-tags".
I have tried to set the "remote.<remote>.tagOpt = --no-tags" option in 
git config with no difference in behavior.

Is there a way to force tags not to be updated at all with "git fetch 
--all" in this case?

(git version 2.22.0.windows.1 and git version 2.18.0.windows.1)
Regards,
Baptiste


