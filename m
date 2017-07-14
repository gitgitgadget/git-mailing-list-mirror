Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1C2C2027C
	for <e@80x24.org>; Fri, 14 Jul 2017 01:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbdGNBxx (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 21:53:53 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33055 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbdGNBxw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 21:53:52 -0400
Received: by mail-pg0-f54.google.com with SMTP id k14so38172388pgr.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 18:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HZze9bBqF6eZZpvlcpEMwQkGW0+RVT6HPjnhTG1TkFg=;
        b=hxkUI7RrK10Y+5o6oWinau842TlOfpjIxFG7xSPYLTBr+sqjMgynpH3hpNaiCMI52G
         adD5la1fpRFV134jrXaSN54heyEISMSxIU9/B1+Cye3klEBrRrku5mEnJ/5kOahLoof5
         2SaIgiIEsf4+EZk1MGaWRJm/CkxQUJs1YHApPFoCXVGkBb3L+qTDTKyCTg0lNJPATzQU
         dbYmh5JChdTHjyHPTHiny100kG/q/hbWhgMiYsAGXO2ef6BaPcsjPtKzovgy1lM0M8Qr
         M49Do3wsFQaG0II6IRDovei0RmSu3KKiCpkOHBzYPgRZ/X8RNv7xYtVPqBuf95bA1NED
         UKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HZze9bBqF6eZZpvlcpEMwQkGW0+RVT6HPjnhTG1TkFg=;
        b=U441rLkGOkXsm/RnUZlH8t/vRbHIZGQebLONmhKj4aJIAOx36ELe/7S3Ysc0Y/NxsA
         C/NYtRIlAEymIy//HXH2XLFQ5eDyB2Bu7aAuQ7ZWFARC9nmjoEk5fsJU99sM5Un6jjEc
         Lz3hteLNDLVIpIimZhd4xiCFw/vOxKffHEnqacEZiRDvvsBwMgM4i/uU0X3FYa9V+cQR
         jaEyW9A0v9hYjDf8p6lHhSp6fgDAJ7KM65PLKKJ+At+uP6ZqgF/EihG2LwgeP6RJt3bp
         ISMZ3xlk8vRvuoX7Z0SyhZC+6mEgFmfx8xbNFH9IDwuFSFK4RGqT3nVzRAh16oBr6CDp
         HQFw==
X-Gm-Message-State: AIVw111+zqTlgUi6HSYu3Zzulzmjmuc7IgmydUqvhM2gjL05GF0PLRUy
        /HzNT74Z5hrLVQ==
X-Received: by 10.98.11.4 with SMTP id t4mr2678419pfi.104.1499997231633;
        Thu, 13 Jul 2017 18:53:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id e77sm12799509pfk.123.2017.07.13.18.53.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 18:53:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Reed <benvreed@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Strange behavior with Git add -p in version 2.13.3
References: <CAEAWK2Nso0uFnn29B6=m=iV6-HjAEFTrrUg+b+7QzRhQ8TpZ6g@mail.gmail.com>
Date:   Thu, 13 Jul 2017 18:53:49 -0700
In-Reply-To: <CAEAWK2Nso0uFnn29B6=m=iV6-HjAEFTrrUg+b+7QzRhQ8TpZ6g@mail.gmail.com>
        (Ben Reed's message of "Thu, 13 Jul 2017 18:48:18 -0500")
Message-ID: <xmqqk23bss0i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Reed <benvreed@gmail.com> writes:

> Hello, I updated Git to 2.13.3, and now selecting 's' to split a
> change on a call to `git add -p` is not working. It's showing the list
> of options as if 's' is not a valid choice...
>
> Particularly, I'm getting...
> Stage this hunk [y,n,q,a,d,/,e,?]? s
> y - stage this hunk
> n - do not stage this hunk
> q - quit; do not stage this hunk or any of the remaining ones
> a - stage this hunk and all later hunks in the file
> d - do not stage this hunk or any of the later hunks in the file
> g - select a hunk to go to
> / - search for a hunk matching the given regex
> j - leave this hunk undecided, see next undecided hunk
> J - leave this hunk undecided, see next hunk
> k - leave this hunk undecided, see previous undecided hunk
> K - leave this hunk undecided, see previous hunk
> s - split the current hunk into smaller hunks
> e - manually edit the current hunk
> ? - print help
>
> Is anyone else having this problem? Does anybody know how to resolve
> it? I'm running on macOS Version 10.12.5.

I do not think it is MacOSX specific.  I notice that the prompt does
not even offer 's' as a valid choice, which typically means that the
hunk you are looking at is not splittable.

A splittable hunk has more than one blocks of "+addition" and/or
"-deletion" lines separated by at least one " context" line.  If
your hunk looks like this, for example:

-- >8 --
diff --git a/COPYING b/COPYING
index 536e55524d..35c4dd4473 100644
--- a/COPYING
+++ b/COPYING
@@ -3,7 +3,7 @@
  is concerned is _this_ particular version of the license (ie v2, not
  v2.2 or v3.x or whatever), unless explicitly otherwise stated.

- HOWEVER, in order to allow a migration to GPLv3 if that seems like
+ However, in order to allow a migration to GPLv3 if that seems like
  a good idea, I also ask that people involved with the project make
  their preferences known. In particular, if you trust me to make that
  decision, you might note so in your copyright message, ie something
Stage this hunk [y,n,q,a,d,/,e,?]?
-- 8< --

you would not see 's' offered as a valid choice.  If you are looking
at a splittable hunk, on the other hand:

-- >8 --
diff --git a/COPYING b/COPYING
index 536e55524d..02a5c58938 100644
--- a/COPYING
+++ b/COPYING
@@ -3,9 +3,9 @@
  is concerned is _this_ particular version of the license (ie v2, not
  v2.2 or v3.x or whatever), unless explicitly otherwise stated.

- HOWEVER, in order to allow a migration to GPLv3 if that seems like
+ However, in order to allow a migration to GPLv3 if that seems like
  a good idea, I also ask that people involved with the project make
- their preferences known. In particular, if you trust me to make that
+ *their* preferences known. In particular, if you trust me to make that
  decision, you might note so in your copyright message, ie something
  like

Stage this hunk [y,n,q,a,d,/,s,e,?]?
-- 8< --

you will see 's' offered as a valid choice.


