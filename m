Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E95201A0
	for <e@80x24.org>; Fri, 12 May 2017 00:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756369AbdELAbV (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 20:31:21 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36317 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbdELAbU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 20:31:20 -0400
Received: by mail-pg0-f67.google.com with SMTP id h64so698537pge.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 17:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tbmWKVKQq585JHVpQSr7PcJteAXLIChXZqCIXJIixgg=;
        b=UbX77X3AdfMufM4b2NbucwL3yNZ/XgyNr6iqTm5FMXv/VG391xMoXAV21xsJ6PmOfQ
         6tNesoWCWxFlXSPQWSg/sXX3wYv4l0mMQ3MQTdLzef7LhhV6e2kATDhITrP9yTeyYztj
         VVnmkpLBGb1eFJyAUzVnrO5C3eSn8QPlDC+RenU7H1NdAFz5swf0ixmYbA89v83r4qSM
         PV+/k7/uSqt3q6hqMoJfyTYrcVgWFGlMQHnfuI4L+kTGG0XzT4v3MHh+mv7+6dfthZea
         iAv1cjfBQIPr1ADunYkxhbHujxOtl8NVJqN50y24LSV5KFoL9jLBe0J1urBHAJvr5SRe
         9pkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tbmWKVKQq585JHVpQSr7PcJteAXLIChXZqCIXJIixgg=;
        b=feteePm2TKj/i0/12+d8mpPtGxGVwyNi8ct+2a0kqOyqyB1XBDBc8uxyOE3+hbjEI5
         nUQQ3PkmYBCizucWsrE0y7+o/Mu1gdNySQykkNSMq14dgB7YIt77O+6SLKEbBSpSs8Qw
         xOZTdU7WtlgGza78lp3iiuELgyVz2ZaKPHaUCpMQh4QXH+SnFj0035miLDepeO0zMJoD
         GIVapbrTj6SYfEgwRiiaolskNszpDPtTXS5dSbKyHPHQBqPouuE/vJZdFgcUfyeWUkrD
         Ha1DZOB5a6pJlIsgMXpRNsPfPwqtUbA8+xRcd44x5jkt5OvJftZtcrGBJBpIgE6d6vP3
         Ox1Q==
X-Gm-Message-State: AODbwcBfREZGTj9u1/wxsoRfo8h8OuQE2Z60V7QzWzs4TWeQeOEvcYrP
        RFpIgdMzHaxN4A==
X-Received: by 10.98.215.72 with SMTP id v8mr1391768pfl.121.1494549078171;
        Thu, 11 May 2017 17:31:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id f193sm1889111pgc.54.2017.05.11.17.31.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 17:31:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefano Lattarini <stefano.lattarini@gmail.com>,
        =?utf-8?B?T25kxZllaiBC?= =?utf-8?B?w61sa2E=?= <neleai@seznam.cz>,
        "Arnold D . Robbins" <arnold@skeeve.com>
Subject: Re: [PATCH 0/7] Update the compat/regex engine from upstream
References: <20170504220043.25702-1-avarab@gmail.com>
Date:   Fri, 12 May 2017 09:31:14 +0900
In-Reply-To: <20170504220043.25702-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 4 May 2017 22:00:36 +0000")
Message-ID: <xmqq4lwqapbh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> See the first patch for motivation & why.
> ...

I do not necessarily agree with the upgrading strategy outlined in
1/7, but that is a separate issue.  There may be some other bits
that needs resurrecting out of "git log -p master compat/regex/",
but I cannot test them myself (the part changed by the following
patch have no effect in an environment where long is intptr_t, so
"make NO_REGEX=YesPlease" build does not fail for me), so I'm
letting Dscho's Windows builder find it out via Travis.

-- >8 --
Date: Fri, 12 May 2017 09:00:07 +0900
Subject: [PATCH] compat/regex: make it compile with -Werror=int-to-pointer-cast

The change by 56a1a3ab ("Silence GCC's "cast of pointer to integer
of a different size" warning", 2015-10-26) may need resurrecting; I
do not think an unprotected #include <stdint.h> is the best way to
do this, but for the purpose of places that needs further work,
thishsould do.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/regex/regcomp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 5e9ea26cd4..5688a639bf 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -24,9 +24,7 @@
    License along with the GNU C Library; if not, see
    <http://www.gnu.org/licenses/>.  */
 
-#ifdef HAVE_STDINT_H
 #include <stdint.h>
-#endif
 
 #ifdef HAVE_STRINGS_H
 #include <strings.h>
@@ -2641,7 +2639,7 @@ parse_dup_op (bin_tree_t *elem, re_string_t *regexp, re_dfa_t *dfa,
     old_tree = NULL;
 
   if (elem->token.type == SUBEXP)
-    postorder (elem, mark_opt_subexp, (void *) (long) elem->token.opr.idx);
+    postorder (elem, mark_opt_subexp, (void *) (intptr_t) elem->token.opr.idx);
 
   tree = create_tree (dfa, elem, NULL, (end == -1 ? OP_DUP_ASTERISK : OP_ALT));
   if (BE (tree == NULL, 0))
@@ -3868,7 +3866,7 @@ create_token_tree (re_dfa_t *dfa, bin_tree_t *left, bin_tree_t *right,
 static reg_errcode_t
 mark_opt_subexp (void *extra, bin_tree_t *node)
 {
-  int idx = (int) (long) extra;
+  int idx = (int) (intptr_t) extra;
   if (node->token.type == SUBEXP && node->token.opr.idx == idx)
     node->token.opt_subexp = 1;
 
-- 
2.13.0-334-gbb1c091dbc

