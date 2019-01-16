Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 274B11F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 00:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfAPAie (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 19:38:34 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44242 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfAPAid (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 19:38:33 -0500
Received: by mail-pf1-f202.google.com with SMTP id b17so3286314pfc.11
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 16:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=asYuIsGOvHe/sWcjC8K1vDS+5gmfI6ck43aEc/UhPWw=;
        b=UtBTNipDjikftIWdPzd2m5Fh8p0/t0I45m4YPBSATQBMuZdN7bda+2ika8JYMo//2G
         7ck7jdOnYfaSfYlQzGDrE/2Y/nUpZYHdNyliC4xgOrA1/zMK1PFk/+rtL6XahldJg+vb
         Dhz2YPLGCCvXACdaKAfH2FjZmt7nbxsteBC16VIYAi94yGD441wp/asHenjesxbnUqWr
         ogI6/WjwI64OpLs3bMr9A3W1ePaWnpVCtHh1NKiKrAbMHTOI08lyPVlaQfVQipQ0lLK6
         2JyB0vFAR/4ZJNiUfv8+iCLwxN71jLQIruGjrU7fCsKZdaAu6kcgKtOn/eWBjy1pKz5Q
         uXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=asYuIsGOvHe/sWcjC8K1vDS+5gmfI6ck43aEc/UhPWw=;
        b=Cn1rb8cKpRtTKlYiZ8QlA4CJymYxodlaMri9+FqhsZamB+POh6xfGPWptAx6bFazw7
         jlQo733/VvEGhll9LOvH9xPtbCt0AaY8YOhFwHwLSMdjiGPcyxk4g0VEThLnAk3x1oRx
         0aWQN/BOazb/J5Zx5qvMypUxh9lnAJsidCTwH6qGn84K+RqyTyTq1VyaCexxGtQRaub4
         UTOAgvNnN5anY3rQhXnhFPP9znkZk8QKVXoZbk3N3n9t+gCeenejVXzGitwLXZAjRLSn
         eA9/ecwORMb7h8/OFZXZctMSLxHluR3RreCfQm3+N1DQNuhcnjqflMmKQpxVtN7k9XE7
         VPCw==
X-Gm-Message-State: AJcUukdr27GVDcErc1ioiQhF+1Spt52tkcXSgKWr4GCyietJWvx65223
        S4nXkcWXKOrxK+31+KWRUQO01Gfk7iL2tNwC7c9L
X-Google-Smtp-Source: ALg8bN7FKQx2wJXHQKoBHq2ZKk5s4il444pVtMqpCgyz9OYoYBF6qLBuhgJwaPSE/VpU1wnOOVP9gb0IqqCcEod+Y7xs
X-Received: by 2002:a62:6b8a:: with SMTP id g132mr2420177pfc.8.1547599112358;
 Tue, 15 Jan 2019 16:38:32 -0800 (PST)
Date:   Tue, 15 Jan 2019 16:38:28 -0800
In-Reply-To: <xmqqr2ddpl8q.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190116003828.64889-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqr2ddpl8q.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v2 0/4] Sideband the whole fetch v2 response
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Ah...yes, you're right. I forgot to build before running the tests. I'll
> > take a look.
> 
> Thanks.

Thanks once again for taking a look. It turns out that it's because
progress messages are sometimes split across PKT-LINEs depending on your
luck, and we need to retain the "leftover" on a \2 sideband in order to
combine it with the next one if necessary. So, for example, the
following fixup works:

	diff --git a/sideband.c b/sideband.c
	index c185c38637..d5da587d68 100644
	--- a/sideband.c
	+++ b/sideband.c
	@@ -117,7 +117,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
	 int demultiplex_sideband(const char *me, char *buf, int len, int die_on_error)
	 {
	        static const char *suffix;
	-       struct strbuf outbuf = STRBUF_INIT;
	+       static struct strbuf outbuf = STRBUF_INIT;
	        int retval = 0;
	        const char *b, *brk;
	        int band;
	@@ -187,8 +187,7 @@ int demultiplex_sideband(const char *me, char *buf, int len, int die_on_error)
	                                    "" : DISPLAY_PREFIX);
	                        maybe_colorize_sideband(&outbuf, b, strlen(b));
	                }
	-               retval = SIDEBAND_PROGRESS;
	-               break;
	+               return SIDEBAND_PROGRESS; /* skip cleanup */
	        case 1:
	                retval = SIDEBAND_PRIMARY;
	                break;

We could make the caller of demultiplex_sideband() store the outbuf, but
at this point, it might be better to refactor packet_reader into its own
file and have it depend on both pkt-line.h and sideband.h. If you (or
anyone else) have any ideas, let me know what you think. I'll think
further about this too.
