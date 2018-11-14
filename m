Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478F71F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 12:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeKNWb0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 17:31:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51389 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbeKNWb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 17:31:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id w7-v6so15248436wmc.1
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 04:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mw8fFeQbsaA5tWO28jwMQs0KxIZPNJhPmQL9H8y56E0=;
        b=tWWThcez46qBhhhZX/n6xZScBiqX4WETlnsOic/MA6Byt1KxOjg56D8ESwuHJK6PJW
         4nrejqR0jboz41UJ3bh46NmaT2hLqSoQ1ZzuIhAF9OlqhtNqqKkE9NrAdJyZYPEjywYQ
         Dg87PmQ50qXEOhvV5lwFAwn7bNBlhr9PYwBTDTMf+fxXSS0jIUEG34r3l8YWGDbkAHmH
         DRXUUCOOocyNupnlHe5lGDW7EyQL9gU9Cn6SoAKPsv9S+b21wJpIbWjN6CulJbF3IIzk
         4mtD5RLj4glrKu0oxQTh3YLMwhGhTVIv3ngd+XViODxPwfnqhLHXTWSo8bjM+wP6+TK6
         fsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mw8fFeQbsaA5tWO28jwMQs0KxIZPNJhPmQL9H8y56E0=;
        b=Sso3XevOQ6iXybqK1NkRqy5VqAmR8/PLSGUbdhgawDyQiSN+F0EjGHqbOPf6b7+ooz
         NJ21Ph+Kub5XAs6SCbIeLwSGfLfYhpO4aqfV5PXxdPH6CptefYs0xryIxK5s0pxiIF6R
         ze+lRctnjUH5n1A12dZoAiZpymd9IYz7oLztdqfgN+B0uikcpaO7EmNXek0W7CXDVDgL
         c5vcgvc8JRPAr7mYdltAkFbnBQzP2mVh83xq2XRGGEenYefN36Hqrpl2XDSJ0/0BddKJ
         DHiu7/TLGiG/ugE+MSCWsokoAoJitCQqWbysx154xaMp1nZuPvKX7gSkkcTfr1ngfdYJ
         JA5A==
X-Gm-Message-State: AGRZ1gJ7N+g+JFNRLRlef894B57gqusZ1R4aXkpy0hJvPm68yS/e8AHc
        y0fHlA03iTL5kHWzBHe5jmU=
X-Google-Smtp-Source: AJdET5ftoJTfJkaGPHHSHd68fPZQTmDK+G7oRtQpy1s+xEAIH6gQfRFFOxlzbMQT/VkwEqkjsn2/cg==
X-Received: by 2002:a1c:e5cf:: with SMTP id c198-v6mr1727324wmh.113.1542198500763;
        Wed, 14 Nov 2018 04:28:20 -0800 (PST)
Received: from localhost.localdomain (x4db1d05b.dyn.telefonica.de. [77.177.208.91])
        by smtp.gmail.com with ESMTPSA id j18-v6sm26287672wmf.39.2018.11.14.04.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 04:28:19 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        "H . Merijn Brand" <h.m.brand@xs4all.nl>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Olga Telezhnaia <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] ref-filter: don't look for objects when outside of a repository
Date:   Wed, 14 Nov 2018 13:27:25 +0100
Message-Id: <20181114122725.18659-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.gbfcc7ed3e6
In-Reply-To: <xmqq5zytpa65.fsf@gitster-ct.c.googlers.com>
References: <xmqq5zytpa65.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command 'git ls-remote --sort=authordate <remote>' segfaults when
run outside of a repository, ever since the introduction of its
'--sort' option in 1fb20dfd8e (ls-remote: create '--sort' option,
2018-04-09).

While in general the 'git ls-remote' command can be run outside of a
repository just fine, its '--sort=<key>' option with certain keys does
require access to the referenced objects.  This sorting is implemented
using the generic ref-filter sorting facility, which already handles
missing objects gracefully with the appropriate 'missing object
deadbeef for HEAD' message.  However, being generic means that it
checks replace refs while trying to retrieve an object, and while
doing so it accesses the 'git_replace_ref_base' variable, which has
not been initialized and is still a NULL pointer when outside of a
repository, thus causing the segfault.

Make ref-filter more careful upfront while parsing the format string,
and make it error out when encountering a format atom requiring object
access when we are not in a repository.  Also add a test to ensure
that 'git ls-remote --sort' fails gracefully when executed outside of
a repository.

Reported-by: H.Merijn Brand <h.m.brand@xs4all.nl>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

On Tue, Sep 25, 2018 at 01:57:38PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > However, if we go for a more informative error message, then wouldn't
> > it be better to add this condition in populate_value() before it even
> > calls get_object()?  Then we could also add the problematic format
> > specifier to the error message (I think, but didn't actually check),
> > just in case someone specified multiple sort keys.
> 
> Even though I suspect that verify_ref_format() is the logically the
> right place to do this (after all, it is about seeing if the format
> makes sense, and a format that requires an object access used
> outside a repository should trigger an verification error), doing
> that in populate_value() probably strikes the best balance, I would
> think.

We are dealing with format specifiers used for sorting here, and those
don't go through verify_ref_format().

So how about this patch instead?

I think it will catch all cases where a user would try to use a format
specifier, for any purpose, requiring object access outside of a
repository (though I don't know whether there are any other cases
besides 'git ls-remote --sort=...'; but perhaps in the future
'ls-remote' will get a '--format' option as well), and it does so
before performing a potentially expensive query to the remote.  OTOH,
it won't change the documented "missing object" error message when run
inside a repo but the necessary object is indeed missing.


 ref-filter.c         | 4 ++++
 t/t5512-ls-remote.sh | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 0c45ed9d94..a1290659af 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -534,6 +534,10 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	if (ARRAY_SIZE(valid_atom) <= i)
 		return strbuf_addf_ret(err, -1, _("unknown field name: %.*s"),
 				       (int)(ep-atom), atom);
+	if (valid_atom[i].source != SOURCE_NONE && !have_git_dir())
+		return strbuf_addf_ret(err, -1,
+				       _("not a git repository, but the field '%.*s' requires access to object data"),
+				       (int)(ep-atom), atom);
 
 	/* Add it in, including the deref prefix */
 	at = used_atom_cnt;
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 91ee6841c1..32e722db2e 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -302,6 +302,12 @@ test_expect_success 'ls-remote works outside repository' '
 	nongit git ls-remote dst.git
 '
 
+test_expect_success 'ls-remote --sort fails gracefully outside repository' '
+	# Use a sort key that requires access to the referenced objects.
+	nongit test_must_fail git ls-remote --sort=authordate "$TRASH_DIRECTORY" 2>err &&
+	test_i18ngrep "^fatal: not a git repository, but the field '\''authordate'\'' requires access to object data" err
+'
+
 test_expect_success 'ls-remote patterns work with all protocol versions' '
 	git for-each-ref --format="%(objectname)	%(refname)" \
 		refs/heads/master refs/remotes/origin/master >expect &&
-- 
2.19.1.1182.gbfcc7ed3e6

