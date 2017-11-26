Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2126020A40
	for <e@80x24.org>; Sun, 26 Nov 2017 23:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdKZXB1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 18:01:27 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33724 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbdKZXB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 18:01:26 -0500
Received: by mail-wr0-f196.google.com with SMTP id 55so8444558wrx.0
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 15:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:from:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0Ck3W2itmnc5BaHAF3VKp4RKV40zYTyA+7R+q5vORO4=;
        b=DTBjcp1ywbyw0XZbyD/ITUmAnZ/tZpx6RTS0EUpFXhb4uvXNnlJH2zlkQE08AdBMtj
         rXsi26l4IgGNdND0RN8ybDW0TBr5YT0JaSi6W0FJEHGdofNa6EXXaanrXFv9Ohkf5Voq
         DUpGUoLEpZB7mwxEIYs5u2h3LW+PRAfyfvmLPz/6klv7cKQhvc8hrtfg53e9two0MDeE
         /OOQli89lE0bQNaNUgQQauL21yXruZNdCDzLgUdWTf7RMXwRJiFNmHrCSD+qdlqQPIKf
         KqayqMLkw7Bp/I85E0VSWZB0btDl+umJ+dCuytNGbTomlJBZGCWRUApjNPxz5zzTJSXA
         qYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:from:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0Ck3W2itmnc5BaHAF3VKp4RKV40zYTyA+7R+q5vORO4=;
        b=M857NGjcgP70sGMXS5259I+76ABEvokbN+mBA/gGHDkugirhYHDlvc8+TiiaOqLdOw
         Xgm5z155IeLYaeeMQM+6Xh1wLIcELd+JQZK/LxS/y4bzPng8gxM7zujYB0kK1VzxuN0z
         J2a1JxEYYALJ98i3rOk6FKXSg+IsZNmgc7MdTLhpOMVGNGPq0kJudrcqI5JXl8m2NIgI
         5pxuUb9VSmI9Nsg/0LLP4YbP8euf8YX3E9B0y17/9Kvz8fVGAJVD1gIUmH7dSDKDYL9C
         Tv0zjZp1v0wSBIUwr2G7tukYB3oRFALeL5+xI6bsqX+uluxR9bs2cYeplQIT+PucKPyN
         t0Ww==
X-Gm-Message-State: AJaThX6gToi4AMtX2L/y0FluQkYCaY8xg2iK/9hkZktKH3Rz+BkywFpX
        4zUH21hJECmVB8rWnl5tLPU=
X-Google-Smtp-Source: AGs4zMa3wj+gC6Gb72Ik4iihl9Z1cfZonV5bgEvwx7HBKbk0pX2mkC6sktmIbNAdUsQrELcEFFlIIw==
X-Received: by 10.223.166.205 with SMTP id t71mr31611683wrc.64.1511737284685;
        Sun, 26 Nov 2017 15:01:24 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id n143sm33109620wmd.31.2017.11.26.15.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2017 15:01:23 -0800 (PST)
Subject: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge, no
 working tree file changes)
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
Date:   Sun, 26 Nov 2017 23:35:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi to all,

Here`s my humble attempt on (once more) scratching a use case which 
seems to be desired occasionally through the years, obviously not 
enough to be actually implemented yet, but might be worth some more 
attention... :)

For the reference, some past mentions of (more or less) similar ideas 
are listed at the end of this e-mail[*1*], where I`m also Cc-ing 
people previously involved, might be still sharing interest - as this 
is my first "new thread" list message, I`m sorry if this is not an 
encouraged practice, please let me know.

Approach discussed here could have a few more useful applications, 
but one seems to be standing out the most - in case where multiple 
topic branches are temporarily merged for integration testing, it 
could be very useful to be able to post "hotfix" commits to merged 
branches directly, _without actually switching to them_ (and thus 
without touching working tree files), and still keeping everything 
merged, in one go.

Example starting point is "master" branch with 3 topic branches (A, 
B, C), to be (throwaway) merged for integration testing inside 
temporary "test" branch:

(1)        o---o---A (topicA)
          /
         /
        /
    ---o---o---M (master, test, HEAD)
        \   \
         \   o---B (topicB)
          \
           o---o---C (topicC)


This is what we end up with once "master" and topic branches are 
merged in merge commit M1 inside temporary "test" branch for further 
integration testing:

(2)        o---o---A (topicA)
          /         \
         /           M1 (test, HEAD)
        /           /||
    ---o---o---M---/ || (master)
        \   \       / |
         \   o---B-/  | (topicB)
          \           |
           o---o---C--/ (topicC)


Upon discovery of a fix needed inside "topicA", hotfix changes X 
should be committed to "topicA" branch and re-merged inside merge 
commit M2 on temporary integration "test" branch (previous temporary 
merge commit M1 is thrown away as uninteresting):

(3)        o---o---A---X (topicA)
          /             \
         /               M2 (test, HEAD)
        /               /||
    ---o---o---M-------/ || (master)
        \   \           / |
         \   o---B-----/  | (topicB)
          \              /
           o---o---C----/ (topicC)


Now, usually advised approach to get from (2) to (3), where one is 
expected to switch to desired topic branch, commit the change, and 
then re-merge everything again into integration testing branch, is 
arguably a bit tiresome, but where it actually fails short is the 
fact that branch switching back and forth (for each hotfix commit) 
could possibly keep changing a lot of files otherwise untouched by 
the hotfix changes we`re committing (but different between branches), 
causing build systems to needlessly waste what could be significant 
time compiling them again and again.

Example script proposes using something like this instead:

(4) git commit --onto-parent topicA
     
... in above-mentioned case (2) to commit X onto "topicA" branch 
directly, re-merging all previously merged integration testing topic 
branches at the same time, reaching state (3) without any 
intermediate branch switching (and without touching working tree, 
thus without needless recompilation).

Once integration tests pass, integration test branch will be thrown 
away and new commits on each topic branch should still be properly 
tested - we`re just deferring it not to do it in the middle of 
integration testing, saving some (or a lot) needless rebuild cycles 
at the same time (or in the first place, even).

Scripts in series:
  [1/3]: setup.sh
  [2/3]: git-merge-one-file--cached
  [3/3]: git-commit--onto-parent.sh

Regards, Buga

[*1*] Some previous list mentions of similar functionality, in order 
 of appearance, latest on top (I kind of remember seeing more, but 
 can`t find them now, please feel free to add here, or notify more 
 people interested in the past):

 - [PATCH/RFC] git-post: the opposite of git-cherry-pick (2017-10-05)
   https://public-inbox.org/git/c6b52120-98bf-d685-6dc0-3c83e9e80d30@kdbg.org/

 - "groups of files" in Git? (2017-07-11)
   https://public-inbox.org/git/CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com/

 - Making a (quick) commit to another branch (2013-04-27)
   https://public-inbox.org/git/517BDB6D.8040809@cedarsoft.com/

 - Commit to other branch (2010-05-31)
   https://public-inbox.org/git/4C03D9C1.1060404@cedarsoft.com/

 - [RFC] git commit --branch (2006-05-29)
   https://public-inbox.org/git/20060529202851.GE14325@admingilde.org/

 - n-heads and patch dependency chains (2006-04-03)
   https://public-inbox.org/git/4430D352.4010707@vilain.net/

 - Multi-headed branches (hydra? :)) for basic patch calculus (2006-04-02)
   https://public-inbox.org/git/1143950852.21233.23.camel@localhost.localdomain/
