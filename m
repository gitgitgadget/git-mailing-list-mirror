Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1076820209
	for <e@80x24.org>; Sat,  1 Jul 2017 17:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbdGARXU (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 13:23:20 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34387 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdGARXT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 13:23:19 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so18659917pge.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references
         :disposition-notification-to:date:mime-version
         :content-transfer-encoding;
        bh=l/uW75u+4nBGJK1foiLahB1n3OGW2pq4FH/f/weZO00=;
        b=jnefKCwzS+8BHyeiJWXdeP4gE++K1FfJRJxdUVlfy+ZJUqEfhsfQ3Lr2SYoOlFVWj7
         w/YPEyBXIt/8WqSocFhvtrKu6MR6qKgkuWNquU/jNZhn1shizKi5zqHQcCUXk4xA2B01
         e/hVYBRtxxtnn1PGGi2Aw17I+AEbZXFsKt/5lQYq1lbSj9f0my6ztGlNgxmVW2M1Qxay
         Ejv9xs6538qiCanFKzCpAAneX3h6DvPaAQK8RwS3fSOQ8NFABoYPLtx2/hnugrPtFGfG
         ByaLcze12M8XqBhG2cr9IESrmWQRfAtTbmpm7X4rgTCdWZMINm2F4T7ThuvODjGJuZik
         EAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:disposition-notification-to:date:mime-version
         :content-transfer-encoding;
        bh=l/uW75u+4nBGJK1foiLahB1n3OGW2pq4FH/f/weZO00=;
        b=k42za1OkOBXeUw0/nZ/ElDCxYjqpvOaydQhRu355YxcQH3ylLlxKzUIREjbOBMjYuW
         LCqw8HCGkf3uQAZPD3kmjJ42CeaGh4EB2IEknN//aVtR1O2LhyJeWGqaNCCuQzHogmKH
         sBbZaWnVFy0F4xXY0Q+j4V5WxC3+NN+cdEHJL7HqtndYo8FIToDrQ1sAhKXHdX9UG7Y/
         bGFRwud70qR27rCOjVh3/FwOWJxjxAwPQ+lfNnML3ypS/kw7zuWLD4zB4i1jKImp+0Au
         43J/XfW193wfeHrti3+DojGhNpkYf132AHHprnrUUCIlQJCfGMMt1dET+BVNFMY4b0YK
         xpJQ==
X-Gm-Message-State: AIVw110N7i5diTYESJDmBK3tP6/ARfVvfGpRG3stKjFgX3Py1rEL2qN/
        U6fsWkrJ2Ksv4Q==
X-Received: by 10.99.147.19 with SMTP id b19mr1689928pge.154.1498929798764;
        Sat, 01 Jul 2017 10:23:18 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id x64sm26171092pfk.20.2017.07.01.10.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Jul 2017 10:23:18 -0700 (PDT)
Message-ID: <1498925790.4321.7.camel@gmail.com>
Subject: "git intepret-trailers" vs. "sed script" to add the signature
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
In-Reply-To: <1498918546.4321.1.camel@gmail.com>
References: <20170630154306.26993-1-kaarticsivaraam91196@gmail.com>
         <xmqq1sq1togq.fsf@gitster.mtv.corp.google.com>
         <1498918546.4321.1.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 01 Jul 2017 21:46:30 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-07-01 at 19:45 +0530, Kaartic Sivaraam wrote:
> On Fri, 2017-06-30 at 09:44 -0700, Junio C Hamano wrote:
> > It does look like a hack.  I was wondering if "interpret-trailers"
> > is mature enough and can be used for this by now.
> 
> It does look promising except for a few differences from the hook
> which
> I'll explain in the following mail.

interpet-trailers
=================

After enabling the script I tried the following (shown here as a diff)
to add the signature with "interpret-trailers",

    diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
    index 6473bcacd..9f8cbe7fd 100755
    --- a/templates/hooks--prepare-commit-msg.sample
    +++ b/templates/hooks--prepare-commit-msg.sample
    @@ -33,4 +33,4 @@ case "$2,$3" in
     esac
     
     SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
    -grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
    +git interpret-trailers --in-place --trailer "$SOB" "$1"

It adds the signature if it's not present in the following cases,

* commit
* merge
* commit --amend
* commit -F
* cherry-pick

It's pretty good in adding the signature except that it's not in line
with "git commit -s" whose resulting "spacing" (new lines before and
after) as shown in the editor is given below,

> 
> 
> Signed-off-by: Test <hello@example.org>
> 
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be ignored, and an empty message aborts the commit.
> ...

The spacing of "git interpret-trailers" in the editor for the relevant
cases are,

commit
------

> 
> Signed-off-by: Test <hello@example.org>
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be ignored, and an empty message aborts the commit.
> ...


commit --amend
--------------

> Empty commit to test amending 
>  
> Signed-off-by: Test <hello@example.org> 
>  
> # Please enter the commit message for your changes. Lines starting 
> # with '#' will be ignored, and an empty message aborts the commit. 
> ...


merge
-----
> Merge branch 'hook-test' into hook-test-merge
> 
> Signed-off-by: Test <hello@example.org>
> 
> # Please enter a commit message to explain why this merge is necessary,
> # especially if it merges an updated upstream into a topic branch.
> #
> # Lines starting with '#' will be ignored, and an empty message aborts
> # the commit.

So, it seems that excepting for 'commit' it has quite a nice spacing. I
guess we could add something like the following to fix that,

    # Add new line after SOB in case of "git commit"
    NEW_LINE='\
    '
    if [ -z "$2" ]
    then
      sed -i "1i$NEW_LINE" "$1"
    fi


sed-script
==========
I also tried to add the signature that immitates the "-s" option
of "git commit" using "sed" but it works only in following cases,

* commit
* commit --amend
* merge

It doesn't seem to work in cases where user doesn't edit the message
using the editor. I'm not sure why.

I'm not including a patch of my manual way here as "git interpret-
trailers" (with the fix added) seems quite promising (at least to me).

I'll send a typical patch that uses "git interpret-headers" as a
follow-up.

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
