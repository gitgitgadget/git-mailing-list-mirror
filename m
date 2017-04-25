Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EE63207E2
	for <e@80x24.org>; Tue, 25 Apr 2017 04:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933659AbdDYELZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 00:11:25 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36682 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933389AbdDYELW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 00:11:22 -0400
Received: by mail-it0-f45.google.com with SMTP id g66so11802584ite.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 21:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=443X7MTT9t8TZbi7YPnQ/w0BvKcn2LDLMhgla7H195k=;
        b=QctAkHQWAaQGHJYBSF0dAtZgFbcvb/AE26qrFlXjfc1H3wb16GINXZ1Y2Ao2ePA647
         c6key3KcWcPAtMAHSBNiXqXjtaQUXF016K+DghGK0aY2JEVfMv8N7qya3vtsGLiLdAx1
         6zc1xu4+XZDo/A9WM27PSbN6qGk7Qxz9YzQXdSimhtWq9WdEGhIBinLHWXyLQK9hHLK2
         FeNhlpkJmxpvSrNwL0khJhh+mHV+h5bZzARSTuigbfQGfOdrXO3Ue9MZxlvR8MU4OZ5U
         M/KWHtJ3Ds83A0Et8JKwla9jmWK3tQizd5A44QZpqOhrjIVzSQkS49IaEIYx239n8QCo
         KuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=443X7MTT9t8TZbi7YPnQ/w0BvKcn2LDLMhgla7H195k=;
        b=An5Lq4UCn3KmLCzhKsmwwi+4vHtC/6lwG/DNvohkWIcvu2f6o7caDFfKPRqsz9jkqy
         UdZOKpJruxMw/Fz+D7Zn2aaGHYTySjU+tPbXsLiW7tzXwaLQv/UflQ7+JPbbPF7qOB/O
         ZXtYypMA9gQcYJRWVuAjFvvcaI5tTxevS7zIpa0aJ/gBRcpSD1rWu1tsLJCQMn8iqGlu
         o17iR7UHyuL2FsqApotT+u4XN0wodQYrquUurGIXHBtoYWRnfm/49FmF/50UEs+D615f
         aeFiswwrTbQmlw4lTop94lSuRSsjUJGb36OTIKwT8QWzWYXMqLZRsbDa4lkVYZs5onlK
         UuWA==
X-Gm-Message-State: AN3rC/417nkr+cId1HSZiq4MRrB7l/3zuVF4CkK2ZCd3rMc9x/YOmDQQ
        eOm/BSO7gMYEmw==
X-Received: by 10.36.105.133 with SMTP id e127mr18999083itc.114.1493093482068;
        Mon, 24 Apr 2017 21:11:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id 66sm9058864ior.34.2017.04.24.21.11.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 21:11:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] tests: fix tests broken under GETTEXT_POISON=YesPlease
References: <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com>
        <20170421185757.28978-1-avarab@gmail.com>
        <xmqq1ssi4nci.fsf@gitster.mtv.corp.google.com>
        <CACBZZX63VQK4fLSB2T8onXJ_hQE8dkOCAyFFM-C_yOfoMwxLMA@mail.gmail.com>
Date:   Mon, 24 Apr 2017 21:11:20 -0700
In-Reply-To: <CACBZZX63VQK4fLSB2T8onXJ_hQE8dkOCAyFFM-C_yOfoMwxLMA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 24 Apr
 2017 10:18:15
        +0200")
Message-ID: <xmqqmvb5w2hj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> My general approach when writing & maintaining this poison has been
> that it's fine if we skip some tests, even though we could be bending
> over backwards to run them, or even if we don't know the root cause
> beyond "the rebase machinery is always broken with poison".
>
> This is because once I'm satisfied that the breaking test isn't
> because of some new plumbing message that got i18n'd I don't see the
> point of keeping digging, it's fine to just skip the test, because we
> run it when we're not under poison, and we're satisfied that it's not
> breaking because of a new plumbing message being i18n'd we've
> fulfilled the entire reason for why this poison facility exists in the
> first place.

As to skipping tests, I am worried mostly because it is very easy to
mark one test as skipped under poison build, even where the side
effect from that test left behind in the trash repository is a
prerequisite for a later test to succeed.  For example, a test that
creates a tag may be marked as skipped-under-poison.  Then a new
test that is added to such a test may want to do something using
that tag, and it will succeed in the usual test.  As most people do
not test poison build, when somebody notices that the new test fails
under poison build, it is unclear if the breakage is due to new i18n
issues or something else, like a missing prerequisite tag due to
skipping an earlier test.

