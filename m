Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993AB20A78
	for <e@80x24.org>; Wed,  1 Feb 2017 23:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbdBAXMA (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 18:12:00 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36089 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbdBAXL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 18:11:59 -0500
Received: by mail-pf0-f193.google.com with SMTP id 19so32776142pfo.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 15:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ymw9dfSIw1JpOd81RVEMv7yllznP/X5fHoJa2jdeYjk=;
        b=BituaBNN9KSmMiaUSW7oDttseSw84w4YPO7G78cPVvd54kOPLnZ1vXIFpQmt7ZVS3v
         Aqnxuc0GGQWMWEnHeaYxfllNKNzML2eLvYQnbbAFR1LIj07K7sf3TtDFdjkAZwkln/V2
         CURsu7y1Aw7UDBsVyG619Lt+TfYIxRM03O55SXJOddQII0/m5/PU25ilzBshxYNpBDDc
         OFQF4tjhZS6ZGfj4NuzOcK04SAf2fEGw4fKNKAZvPJIQIjDAlQlyXio7CJQ9UVIMQl+L
         7Q/svwr7nf7gAbKF93VjTgNYIcHipDNXNbu/UfKmbCVWi3phtHcECoaxcBZYp441KQTj
         7RFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ymw9dfSIw1JpOd81RVEMv7yllznP/X5fHoJa2jdeYjk=;
        b=UrdOxvVdi3BDIfIJfYC8KnNmXzxlsKzc+1fincdEBFY+6RQpaM/JzQWzalx8RWjdOB
         7tTJBdCQrSyihqUZpIkZd3AEtFtRWm8ZpugZrZIDcSzOeM+NCDaqf/lRQQfnbPtO1n1i
         O0ihNq9JPXCpvt1JCL8nqfDnBDdoaKS8p249kpCaNdAQN9m5gPMR4RWzfpTz8CecQ4CY
         uDt3knXK8qYCZh+D+K8pj1TPT8jtlkwWVBdRHpC11LVqb0nxA7hFB07GC7p6WDdYx9ap
         ND3H+pOfKqPBke++GEyF1Ek4m59xiCjLSLLXiwXV1vmjaW4Dhm/YUXMGdF4/IXmNeOPH
         Yq5A==
X-Gm-Message-State: AIkVDXJfnu/twE3dqV/avjvV8EuGP+/6JKKNcMpcKbExXEmA4z9ku767PPSj6CtkomUi1Q==
X-Received: by 10.99.121.78 with SMTP id u75mr6845944pgc.202.1485990718766;
        Wed, 01 Feb 2017 15:11:58 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id j128sm52355769pfg.73.2017.02.01.15.11.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 15:11:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     cornelius.weig@tngtech.com, git@vger.kernel.org
Subject: Re: [PATCH] doc: add note about ignoring --no-create-reflog
References: <20170201220727.18070-1-cornelius.weig@tngtech.com>
        <xmqq4m0do86p.fsf@gitster.mtv.corp.google.com>
        <20170201223520.b4er3av67ev5m3ls@sigill.intra.peff.net>
Date:   Wed, 01 Feb 2017 15:11:57 -0800
In-Reply-To: <20170201223520.b4er3av67ev5m3ls@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 1 Feb 2017 23:35:21 +0100")
Message-ID: <xmqqmve5mrpe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This might be nitpicking, but it's _not_ ignored. It still negates an
> earlier "--create-reflog". It is only that it does not override the
> decision to create a reflog caused by the setting of
> core.logallrefupdates.

OK, rolling them all into one, how about this as an amend?

-- >8 --
From: Cornelius Weig <cornelius.weig@tngtech.com>
Date: Wed, 1 Feb 2017 23:07:27 +0100
Subject: [PATCH] doc: add note about ignoring '--no-create-reflog'

The commands git-branch and git-tag accept the '--create-reflog'
option, and create reflog even when core.logallrefupdates
configuration is explicitly set not to.

On the other hand, the negated form '--no-create-reflog' is accepted
as a valid option but has no effect (other than overriding an
earlier '--create-reflog' on the command line). This silent noop may
puzzle users.  To communicate that this is a known limitation, add a
short note in the manuals for git-branch and git-tag.

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-branch.txt | 3 +++
 Documentation/git-tag.txt    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 5516a47b54..102e426fd8 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -91,6 +91,9 @@ OPTIONS
 	based sha1 expressions such as "<branchname>@\{yesterday}".
 	Note that in non-bare repositories, reflogs are usually
 	enabled by default by the `core.logallrefupdates` config option.
+	The negated form `--no-create-reflog` does not override the
+	default, even though it overrides `--create-reflog` that appears
+	earlier on the command line.
 
 -f::
 --force::
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 2ac25a9bb3..fd7eeae075 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -152,6 +152,9 @@ This option is only applicable when listing tags without annotation lines.
 --create-reflog::
 	Create a reflog for the tag. To globally enable reflogs for tags, see
 	`core.logAllRefUpdates` in linkgit:git-config[1].
+	The negated form `--no-create-reflog` does not override the
+	default, even though it overrides `--create-reflog` that appears
+	earlier on the command line.
 
 <tagname>::
 	The name of the tag to create, delete, or describe.
-- 
2.11.0-800-g4bf73cb6b2

