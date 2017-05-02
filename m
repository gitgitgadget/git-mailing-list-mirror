Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA1D207D6
	for <e@80x24.org>; Tue,  2 May 2017 00:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbdEBAVS (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 20:21:18 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35021 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750712AbdEBAVS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 20:21:18 -0400
Received: by mail-pf0-f196.google.com with SMTP id o68so10693459pfj.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 17:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=18CZqzn5oscNzDTwpJW/VVvyVCu4QneijkQTXKpMKqc=;
        b=qoVEdH0mNKzCNYkF2cPF35iq2A/j9kfGD9aqZkqMNFoFf9B6/1MxhC/kzQkWBAiBdu
         EIaG888NiqvjV5euT+SXB0DtEXxgiwlxOpvG+OD9b1LJPBngHnWNa0ufRNHp29l2WAum
         6DExBKktJR8S3YN3DxMfIe0/0rMJo/xdFqrcgnAo5uYzTFL0qhf62kISi0lOdj12Vbq+
         ZpEc6ayAL3H4D/FEY0G6HSRcGe4HJ+3bXf6yrQ3n1t6meDCxYfscQnsD6Kl3O3g+iJtg
         PB5A3KD51amN09w35A6qTSghBd2esxMXWFDVIdxv69406njldHya49mBGopnz71YpwJE
         U1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=18CZqzn5oscNzDTwpJW/VVvyVCu4QneijkQTXKpMKqc=;
        b=pwVjVJKyA2iZAOD2v5b1bjbVnC3vUHWvfU268/D6+tGQmkLYFfkLlH8ZWQGxwiiUsh
         R2NvzvQRYOf8p5lLZExGSeZysNoKoSq/Ih8qSNRTrrs9DVhHlDNndMpHBFEjL7rJ2GUO
         /0+otq2B3csT5lQBSW+IXUMgVhuj1giHZ2EJ+SyCK9VNSz0MQHpD/1+S7e/TF0Ghcbrq
         U5Bzolcih+Y4plFZ/WVIab6aOkvPNUQgxVUtQLy9xUOHhuIBM0VrOpZcPJQhBoH3G/yr
         1RXVvvMxCBOqNKWlCWOi632RL3GKwcS0n8O4nJWeL8g45FcKu54pIg6FYr4y3aqXZBzw
         wbUg==
X-Gm-Message-State: AN3rC/4Drx+obkC8O2R/tkZxYAncRFxx5xcVFoSVixvlnQ9JMM38jr1v
        Q3V6eD5H6k0evQ==
X-Received: by 10.84.174.197 with SMTP id r63mr37418134plb.67.1493684477024;
        Mon, 01 May 2017 17:21:17 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:1193:d4d9:e46d:aae8])
        by smtp.gmail.com with ESMTPSA id p80sm26037398pfk.50.2017.05.01.17.21.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 17:21:16 -0700 (PDT)
Date:   Mon, 1 May 2017 17:21:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] credential doc: make multiple-helper behavior more prominent
 (Re: [PATCH] clone: handle empty config values in -c)
Message-ID: <20170502002114.GV28740@aiede.svl.corp.google.com>
References: <20170502000515.GU28740@aiede.svl.corp.google.com>
 <20170502000856.GI39135@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502000856.GI39135@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject: credential doc: make multiple-helper behavior more prominent

Git's configuration system works by reading multiple configuration
files in order, from general to specific:

 - first, the system configuration /etc/gitconfig
 - then the user's configuration (~/.gitconfig or ~/.config/git/config)
 - then the repository configuration (.git/config)

For single-valued configuration items, the latest value wins.  For
multi-valued configuration items, values accumulate in that order.

For example, this allows setting a credential helper globally in
~/.gitconfig that git will try to use in all repositories, regardless
of whether they additionally provide another helper.  This is usually
a nice thing --- e.g. I can install helpers to use my OS keychain and
to cache credentials for a short period of time globally.

Sometimes people want to be able to override an inherited setting.
For the credential.helper setting, this is done by setting the
configuration item to empty before giving it a new value.  This is
already documented by the documentation is hard to find ---
git-config(1) says to look at gitcredentials(7) and the config
reference in gitcredentials(7) doesn't mention this issue.

Move the documentation to the config reference to make it easier to
find.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Brandon Williams wrote:

>> Noticed while trying to set credential.helper during a clone to use a
>> specific helper without inheriting from ~/.gitconfig and
>> /etc/gitconfig.  That is, I ran
>>
>> 	git clone -c credential.helper= \
>> 		-c credential.helper=myhelper \
>> 		https://example.com/repo
>>
>> intending to produce the configuration
>>
>> 	[credential]
>> 		helper =
>> 		helper = myhelper
>>
>> Without this patch, the 'helper =' line is not included and the
>> credential helper from /etc/gitconfig gets used.
>>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>> Thoughts?
>
> After reading this I'm still a little fuzzy on why the empty helper line
> is needed to avoid using the credential helper from /etc/gitconfig.

See "git help credentials":

       If there are multiple instances of the credential.helper configuration
       variable, each helper will be tried in turn, and may provide a
       username, password, or nothing. Once Git has acquired both a username
       and a password, no more helpers will be tried.

       If credential.helper is configured to the empty string, this resets the
       helper list to empty (so you may override a helper set by a
       lower-priority config file by configuring the empty-string helper,
       followed by whatever set of helpers you would like).

That's a bit obscure, though --- I didn't find it when I looked in "git
help config".  How about this patch?

Tested using 'make -C Documentation gitcredentials.7'.

 Documentation/gitcredentials.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index f3a75d1ce1..f970196bc1 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -101,16 +101,6 @@ $ git help credential-foo
 $ git config --global credential.helper foo
 -------------------------------------------
 
-If there are multiple instances of the `credential.helper` configuration
-variable, each helper will be tried in turn, and may provide a username,
-password, or nothing. Once Git has acquired both a username and a
-password, no more helpers will be tried.
-
-If `credential.helper` is configured to the empty string, this resets
-the helper list to empty (so you may override a helper set by a
-lower-priority config file by configuring the empty-string helper,
-followed by whatever set of helpers you would like).
-
 
 CREDENTIAL CONTEXTS
 -------------------
@@ -162,6 +152,16 @@ helper::
 	shell (so, for example, setting this to `foo --option=bar` will execute
 	`git credential-foo --option=bar` via the shell. See the manual of
 	specific helpers for examples of their use.
++
+If there are multiple instances of the `credential.helper` configuration
+variable, each helper will be tried in turn, and may provide a username,
+password, or nothing. Once Git has acquired both a username and a
+password, no more helpers will be tried.
++
+If `credential.helper` is configured to the empty string, this resets
+the helper list to empty (so you may override a helper set by a
+lower-priority config file by configuring the empty-string helper,
+followed by whatever set of helpers you would like).
 
 username::
 
-- 
2.13.0.rc1.294.g07d810a77f

