Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA2F1F667
	for <e@80x24.org>; Thu, 17 Aug 2017 02:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbdHQCqv (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 22:46:51 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38070 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbdHQCqt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 22:46:49 -0400
Received: by mail-pg0-f66.google.com with SMTP id 123so7411078pga.5
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 19:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=7wIskqBd5t1Qf6F+5OhcmJvBZZ7ARy9d6ti22SQiDrE=;
        b=ADNDZdJveAVXl/e64Z91GjkdscbwkLJO23svT2mQeCj/1jE/Y7hneW4wihb2deYJav
         nlNLH6sXSR561vaxzMcQ8t4EmS2c+71Dep+B9n6ym4TppY22lxEU/PoykFeaXTfAMhZj
         GqGuC0FNvwnQ1/9UYrZ0bi6lHNQVR6eXup96b8VKJf1H9UcgTmnX7oVKxRDqEc3Ly61b
         RkpyzOmcLqqZ0Ot+Qifcu26dPVuGwlcTfhZdMhuqsB/TxjsWJX+j+tsMsldHCRReFPOq
         Ip30qGZvnC6rP4bpnpd8mH2IOEZsVqsTh2xFLOFuJ/9L6qXBuPPx744JJzRDwHc1g8xo
         /YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=7wIskqBd5t1Qf6F+5OhcmJvBZZ7ARy9d6ti22SQiDrE=;
        b=in14fbo0f3UECB5aJj6nwdcXCmpeWPdksRFNba/C2EZQ7kMgTzWy4DzmR1V6rOMmx5
         Sab9z1GI59v8GLS5JjCNAE6RYzgBlbK1gcaIzcFYP8Bj+S7ikK+ULhJCaVAU5pFxaDF6
         tkbryu9FL/swpjnRhyc9xev4/4lqXgiXipUxiX921Qk2a6gZAK9wRQi7FKEoOjgP4RBK
         Phpk0Nz7qBnRKJrSVB4GajW6ruje2ljvH5G53iUrThSzZYoumP7SEQZsADRQFKWta4x9
         4ymSEu0SPo8ZkZff2qZ5VpEWOzquLOxRFQyoGjYcHlaeDQ3l2xwckj/yK9Y1C7mNnLHF
         Y7PQ==
X-Gm-Message-State: AHYfb5h8ziADWE1J+IQ8S6n80jYCHWAYqwrOk86FCzFh2pd1gupEtQEO
        a3va81Qc0TGN5g==
X-Received: by 10.84.224.201 with SMTP id k9mr4154544pln.263.1502938009048;
        Wed, 16 Aug 2017 19:46:49 -0700 (PDT)
Received: from unique-pc ([157.50.14.209])
        by smtp.googlemail.com with ESMTPSA id t3sm3791600pfb.147.2017.08.16.19.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Aug 2017 19:46:48 -0700 (PDT)
Message-ID: <1502938058.1710.14.camel@gmail.com>
Subject: Re: [PATCH] hook: use correct logical variable
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     sbeller@google.com, git@vger.kernel.org
In-Reply-To: <xmqqa830sptq.fsf@gitster.mtv.corp.google.com>
References: <20170711141111.7538-3-kaarticsivaraam91196@gmail.com>
         <20170814084646.30781-1-kaarticsivaraam91196@gmail.com>
         <xmqqwp66ui5h.fsf@gitster.mtv.corp.google.com>
         <4e2c5bd8-48c9-fc8c-2c2c-ede3951019fc@gmail.com>
         <xmqqa830sptq.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 17 Aug 2017 08:17:38 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-08-15 at 10:28 -0700, Junio C Hamano wrote:
> I did shoot for conciseness, but what is a lot more important is to
> record what is at the core of the issue.  "I found it by doing A"
> can hint to careful readers why doing A leads to an undesirable
> behaviour, but when there are other ways to trigger problems that
> come from the same cause, "I found it by doing A" is less useful
> unless we also record "Doing A reveals the underlying problem X"
> that can be shared by other ways B, C, ... to trigger it.  The
> careful readers need to guess what the X is.
> 
> And once you identify the underlying problem X and record _that_ in
> the log message, I and A in "I found it by doing A" becomes much
> less interesting and the readers do not have to guess.
> 
> Your "A" is 'git commit --amend -s' with the disabled part of hook
> enabled.  But I think 'git commit' without "--amend" and "-s" would
> also show an issue that come from the same root cause.  The hook
> will add SoB that is based on the author, not the committer.  That
> resulting commit would be different from 'git commit -s' without the
> hook enabled, which would add SoB based on the commiter name (that
> would be a "B", that causes a related but different problem that
> comes from the same underlying issue "X" which is "we should
> consistently use the committer info like other parts of the
> system").
> 
> In any case, thanks for a fix-up.  Let's move this forward quickly,
> as it is an update to a topic that is already in 'master'.
> 
> Thanks.

Seeing the reply, I changed my opinion that "it isn't worth the effort
to write a better commit message for the change". I've given a try but
it got a little off-hand. Let me know if there's ways in which it could
be simplified and/or improved.

-- 
Kaartic
