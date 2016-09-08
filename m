Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F47B1F859
	for <e@80x24.org>; Thu,  8 Sep 2016 00:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbcIHAtq (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 20:49:46 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:37808 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbcIHAto (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 20:49:44 -0400
Received: by mail-it0-f53.google.com with SMTP id e124so52922250ith.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 17:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=GFic7SfQEshKum/6id5Q7UxRJAL/O6Ki2qiFE2NkOdM=;
        b=aVQybl1vj18riWb5j/A2mXhsOJxhYlfiWclz8imxk17sM5njwuz80zhT199mTRwVsq
         MmM8VeAB5dgF3ZGK1/n3s6T7+jQ8BbjvXssfO1DQPZEtMF2nrQ7ExonUA9LUAseGhrUH
         /mOyZnFaxuyEy1sx0EWmaoxJjEn3CFOTvuHAKRzl5LsW0UuL6BlUeI+d0C5wplieS6/k
         +Tyd7pi4b8+iw00VUQC8fZy/R3bj9AZ9sqUZ1b3uZEV5A4Ojl0xTaGi2amtvqgEZR4Ma
         e6H4wvHx6jPC5/59JOXgv6KplSiskqd2/JGVExJfm2APiuMaSrtc3u4sL6DehQ7yc41P
         v7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GFic7SfQEshKum/6id5Q7UxRJAL/O6Ki2qiFE2NkOdM=;
        b=XDZv6fnwvGZS8kfYPv60VK0EhwxmjJy7wUpyvOWR2Q0NfT0ZR/8y3cxXfkhB5KoN10
         uXHMFRl2pZEd9bsyr1pjB7b/Unut9GGf2yCwy6CfphfP+SGEe4Qv4GFzZXCNKRNlCoOl
         BY5J35J4U7nggco5qhpLW2d2/0Q77mq6nFLso6HSROAAjBz7ZUSJKtYMlWdhlu1VASRn
         F6UtfH9QS/ox5DX2BBXhK+HKOJAIMWn6Y3nOTwJjbZJKDX7slBjrVCY8ZHq43xlhMAMu
         HoJs6mp49znWltw21ElKN7E+cxb2kbRubGzCx8XeoSQSZEnN9YPpZmRaj6fttxJoSQd/
         Rjkw==
X-Gm-Message-State: AE9vXwMGIcsCcTsbiL7G9EmwLzb4UxI+SI/DqlXchnUd1lcRI9lIsDwlIrv2StvpvrnL7EOE6kH5WT+u8hmJkA==
X-Received: by 10.36.111.199 with SMTP id x190mr11476087itb.61.1473295783062;
 Wed, 07 Sep 2016 17:49:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.40 with HTTP; Wed, 7 Sep 2016 17:49:12 -0700 (PDT)
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Sep 2016 07:49:12 +0700
Message-ID: <CACsJy8BF_mnSUcEeH=RBMyfh8RrQGJ4dwm_svsC4TciJtECn_w@mail.gmail.com>
Subject: "fatal error in commit_refs" from pushing to github
To:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I got the message in the subject when pushing to github today. Yes I
know it's github, not git. But according to stackoveflow [1] it's a
local problem. Which makes me think, if we know exactly what this is
(or at least roughly the problem area), maybe we could improve git to
catch it locally in the first place (and because other git servers may
not have the same protection as github).  Jeff maybe you can reveal
something about this "fatal error in commit_refs"? I'm sure it's not
in git code. But I would understand if the answer is "no".

$ git push origin +ZZZ
Counting objects: 95, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (39/39), done.
Writing objects: 100% (95/95), 15.78 KiB | 0 bytes/s, done.
Total 95 (delta 80), reused 69 (delta 56)
remote: Resolving deltas: 100% (80/80), completed with 49 local objects.
remote: fatal error in commit_refs
To github.com:XXX/YYY.git
 ! [remote rejected] ZZZ -> ZZZ (failure)
error: failed to push some refs to 'git@github.com:XXX/YYY.git'


[1] https://stackoverflow.com/questions/37341960/how-do-i-fix-remote-fatal-error-in-commit-refs-errors-trying-to-push-with-git
-- 
Duy
