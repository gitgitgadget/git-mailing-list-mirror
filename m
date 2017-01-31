Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 974BE1F437
	for <e@80x24.org>; Tue, 31 Jan 2017 17:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbdAaRLg (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 12:11:36 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33435 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbdAaRLf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 12:11:35 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so28720354pfg.0
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 09:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9W+XmWOsQbPbtnp2UeQCDaMkJhGgKI2RJOj0803Slys=;
        b=eV6HBIW2GoFr4FmVZUhlFz1ioEQvsoqyo/AoQxjhEZltbTGSIdYMZrpAl3ay7Ruo5u
         jskWD/zuPPJe2KCbyfCf84QGRyzS21cYRCRuDH3UK742y7FIpyw6kTeBPbOuKvEJ3vM6
         y9hlMqqisqlwXE8GBhnRZaqGxZTkPwTD5oBHIsRW0fCfvoq4l47K9hQbm//z/r5/8Qkc
         OWjLdBIjLsWOq1I+PmM9sFe7GZOl2iHOJBvj2JqCS0RZqpBqrBV3Z6HLV9405cuiybNC
         E08NDwa9+dwvMsU4vV+DFSwg0JGaFPaKgwJhll5UqobwLXMIR5vqfAN3cDQamwKKE5N8
         gmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9W+XmWOsQbPbtnp2UeQCDaMkJhGgKI2RJOj0803Slys=;
        b=ZFgAIls1O4K64amWriiq5WUEjE6EGcMbUse1kRiPnGzW9g1SP3c60ORvxUV6d3ItWq
         yEPh47aCwvCzvsORyzcT16qiy6SNzbsBItWtFLkjDwdsVoc8PlMuVRKYw/QQJgGdld5U
         GoQX+sWmdaNuROET5mHahgAEsvJCMVAaWsz+3XnCVfvjLDv+jgsc5VvkjVIuvAIJjs40
         oGhoMbyTtV2mVuDzhUBVCo9C5Ku42w1QNsbKMVPKXjHV0f43WIAgGC1l7jq0ylKrMZpL
         Dbv+yZ66HvPR8+RzDD8AD7OU8yN4mmBVk+Cjfqn+63+vJ58DprhnjQuyIAm3Iyy3Qyhb
         HMdw==
X-Gm-Message-State: AIkVDXIws50q7yOdkM5h6GkZ8wLbaqyMKM/71HuQOiJS6rCR/cqUHCWuvG9qJdS9P/GuDg==
X-Received: by 10.99.114.91 with SMTP id c27mr31862700pgn.163.1485882694424;
        Tue, 31 Jan 2017 09:11:34 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a052:8a35:4bb5:b253])
        by smtp.gmail.com with ESMTPSA id w25sm42917207pge.9.2017.01.31.09.11.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 09:11:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] refs: add option core.logAllRefUpdates = always
References: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
        <20170127100948.29408-1-cornelius.weig@tngtech.com>
        <20170127100948.29408-2-cornelius.weig@tngtech.com>
        <xmqq37g0us5p.fsf@gitster.mtv.corp.google.com>
        <xmqq8tpstaus.fsf@gitster.mtv.corp.google.com>
        <68b6ac92-459d-849d-9589-e1fa500e2572@tngtech.com>
Date:   Tue, 31 Jan 2017 09:11:32 -0800
In-Reply-To: <68b6ac92-459d-849d-9589-e1fa500e2572@tngtech.com> (Cornelius
        Weig's message of "Tue, 31 Jan 2017 14:16:25 +0100")
Message-ID: <xmqq7f5brw6z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cornelius Weig <cornelius.weig@tngtech.com> writes:

> And again, thanks for not yelling. I overlooked that the
> "should_autocreate_reflog" return value should have been negated as
> shown below.

Heh---I AM blind.  I didn't spot it even though I was staring at the
code and even tweaking it (for the constness thing).

> Should I resend this patch, or is it easier for you
> to do the change yourself?

I can squash it in, now we have and the list saw all the bits
necessary.

Thanks for working on this.

> Interdiff v2..v3:
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 81ea2ed..1e8631a 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -612,8 +612,10 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>         const char *old_desc, *reflog_msg;
>         if (opts->new_branch) {
>                 if (opts->new_orphan_branch) {
> -                       const char *refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
> -                       if (opts->new_branch_log && should_autocreate_reflog(refname)) {
> +                       char *refname;
> +
> +                       refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
> +                       if (opts->new_branch_log && !should_autocreate_reflog(refname)) {
>                                 int ret;
>                                 struct strbuf err = STRBUF_INIT;
>  
> @@ -622,6 +624,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>                                         fprintf(stderr, _("Can not do reflog for '%s': %s\n"),
>                                                 opts->new_orphan_branch, err.buf);
>                                         strbuf_release(&err);
> +                                       free(refname);
>                                         return;
>                                 }
>                                 strbuf_release(&err);
