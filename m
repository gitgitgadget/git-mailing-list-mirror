Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9116320D12
	for <e@80x24.org>; Thu,  1 Jun 2017 01:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751052AbdFABbM (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 21:31:12 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33796 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdFABbL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 21:31:11 -0400
Received: by mail-pf0-f181.google.com with SMTP id 9so22721370pfj.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 18:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bnwhL5PWdbVXF/qmCG6o2bsB1AqfQLUZbsTqmrtwF2I=;
        b=nxcELmzhmgaTYWdQ2hSL9M0xwMx38o9L87r1TEga+BUCXq9g2P8bOFtjkzpmvLMgmg
         h/lLzMetwYcHHHL3tVtv7oXPgLi1ffWGZHJC1AZ31ozn8VsVzq+OTENxHy26UiR3W/AQ
         poJYIpvdtZFSjOMg8Y8I1DC1wSWlHn0rVa2lEDYK/Fu9HNTNJO4rmoW8DGjEgf31pG6n
         LlqC/Y0LAk8p5KLMNa71eojtD+po2nC+TL6mBhVI8n1ETDohgVP6XB9b0Iw4IdwWQ71d
         qOKE/+2hM8RRRfvzQg2kXYKr44N0i8FbxJppvs7B8Wcjjy17OjKxCjhoipiMtAAoegUW
         sBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bnwhL5PWdbVXF/qmCG6o2bsB1AqfQLUZbsTqmrtwF2I=;
        b=Bu7quXeeiVzrsirzMvzp9xmSekCUblCaR8fyUGKOVJbG2dayWHkWKAER9vYgOiW36k
         ENKomtFCW0RlqfZYB7PqilcWQrKoPyvx03sUEjcBc88PCwiwbXv9EZ5bzjW9Meg2JU7Z
         5KXte2HCpqG3NlPR+hRFZANFF2+CiMAfXmUnd8on3o+0evLns0NNY8h3uFluNOuKCNS6
         m0R3YU8qDBtpWfh7FiyDepT45xMEPydPKCQFiiOb2KSTuwnq/g5GDBbBuYvRz8sVVRpM
         jyVfe5GujMqonoNB74hQkVCi9cIv0wuFqZIYNc5tqiX0tm1eK5cEANtCYaZcQz02iWPX
         aUJw==
X-Gm-Message-State: AODbwcDhSYMHZBmkfgda/Nu422E86EVTkXIRUTM5y2S/TeX00UTk+ehq
        alniiePcT7R9CA==
X-Received: by 10.98.220.201 with SMTP id c70mr34409831pfl.230.1496280670387;
        Wed, 31 May 2017 18:31:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id b1sm34714922pfc.27.2017.05.31.18.31.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 18:31:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atousa Duprat <atousa.p@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Animi Vulpis <animi.vulpis@gmail.com>, git@vger.kernel.org
Subject: Re: [Bug] git branch -v has problems with carriage returns
References: <CALKRkrxHNao6NY+-_UmznHdq29yVJJynu8Xx5M__YfK9UkdOAw@mail.gmail.com>
        <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com>
        <3d02b958-5f72-9676-bce9-afca962c07df@kdbg.org>
        <CA+izobteEUSisKXNr=k5BcN9hVV4nyqYPWuRLAgV-rg9chH4_g@mail.gmail.com>
Date:   Thu, 01 Jun 2017 10:31:08 +0900
In-Reply-To: <CA+izobteEUSisKXNr=k5BcN9hVV4nyqYPWuRLAgV-rg9chH4_g@mail.gmail.com>
        (Atousa Duprat's message of "Tue, 30 May 2017 22:32:52 -0700")
Message-ID: <xmqqmv9s8per.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atousa Duprat <atousa.p@gmail.com> writes:

> Here is my first attempt at fixing the issue.
>
> There are two problems in ref-filter.c:
>
> First, copy_subject() has been modified to turn '\n' into a space and
> every other ascii control character to be ignored.
>
> Second, find_subpos() doesn't realize that a line that only contains a
> '\r\n' is a blank line – at least when using crlf convention.
> I have changed things so that a sequence of either '\n' or "\r\n"
> separate the subject from the body of the commit message.
> I am not looking at the crlf setting because it doesn't seem like a
> useful distinction – when one would we ever care for \r\n not to be a
> blank line?  But it could be done...
>
> Both fixes are minimal, but it feels like they are a issues with the
> specific encoding.  Does git mandate ascii or utf-8 commit messages?
> If not, there may be a larger issue here with encodings and line-end
> conventions at the very least in ref-filter.c
> Guidance would be appreciated for how to deal with this issue...
>
> Patch attached.

Doesn't this share the problem I pointed out in the other attempt in

  https://public-inbox.org/git/xmqqy3tppu13.fsf@gitster.mtv.corp.google.com/

In short, any patch that special cases CR will not get the original
behaviour back correctly.  The original never special cased CR; it
stripped isspace() at the end of lines, and turning of CRLF into LF
is merely just one effect of it.

You can apply the attached patch and see what "git branch -v"
produces.  We should only see "one", not "one line3_long line4", for
branch-two in the output.  Then replace the SP between %s and \n in
the printf thing with \r and repeat the experiment.

Thanks.

 t/t3203-branch-output.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index a428ae6703..79b80a2d3f 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -13,7 +13,8 @@ test_expect_success 'make commits' '
 
 test_expect_success 'make branches' '
 	git branch branch-one &&
-	git branch branch-two HEAD^
+	git branch branch-two $(printf "%s \n" one "" line3_long line4 |
+	     git commit-tree HEAD:)
 '
 
 test_expect_success 'make remote branches' '
