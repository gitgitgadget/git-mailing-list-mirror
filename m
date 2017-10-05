Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197AE20281
	for <e@80x24.org>; Thu,  5 Oct 2017 13:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdJENW7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 09:22:59 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37832 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdJENWv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 09:22:51 -0400
Received: by mail-wr0-f194.google.com with SMTP id v38so6612140wrc.4
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 06:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=wHl8twu/cVhJ8PXazm5UiSIKa2eW5LdjGWQH3QdfTQk=;
        b=mGf4GAy34SdEV9JalGY0I2oy2ctNq/ktq3MwRMeJVvivk6vxpD66Mt2Mo25SEiYMHs
         btch/3O04xbm02F46u37hE+J4sbyNxUwaYlTHXr8ryDXGGmZSrrN1Nt80fv7NuoedP8l
         MoZWCJttnajD9PllMQRcTbsby2GazZHuApKRypzbofmV43qkdn1saQl9jkUKiPDsgRIJ
         g4YHG/N+1T/DA4H6gHacC89aM03o+XpIi64YubS3Xkle4kmeP0WtWKHgbUJ7Sr3aXE43
         0aUHn/YIS1OHT6UgbduA+dnwykUdX9g78IBMNGHIBbtEPjRE9g0P9/Y5i6NgsdvYT8eG
         VKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=wHl8twu/cVhJ8PXazm5UiSIKa2eW5LdjGWQH3QdfTQk=;
        b=K3XsDpDx5KncN8G9soGHmTkxLUNjSZp3gRzL82C5Cf/ZqMWCLnWRJcX1t6M/OuGsho
         X3w/m8sLndD6H5f+XSWVlBA2YPAkbjhvg3asKTHytptiVMufTtwYUTXaOkuiCsXDl3DV
         jQbVrhoLMnhJ7Fr35HJRh86ZcWXTkyTau4ZwN8e6G7oTfMSTq2dG2T3/5biDgVPyN9wB
         1B43Fr95KJvgG4hfFofyemwOUMIRuOAE4bfW80qV1qGjgxjZ6vm9ueFki9fggM0a+QlC
         /LS4clgq0o7GjlGNKwfe2Fvy477OeiosM/uc3wXxNaFQHEALdk2srLX4RKYvIqURl5Sm
         V3fQ==
X-Gm-Message-State: AMCzsaXPfj9oCG9FN0Nvel+ys0Sy8SfLaN5sHxZn/IE9SgYpXbo2tznU
        T2+6/zFlzh4/c7ZuWnWDMLG3DQzT
X-Google-Smtp-Source: AOwi7QBLrjtTWfQBlG5p2GpvBE+PbbpTvkTLuJkMpAjwpJCicPQ8M7beRN7s456cMWCbocaoOHhZGA==
X-Received: by 10.223.146.101 with SMTP id 92mr15040345wrj.21.1507209769771;
        Thu, 05 Oct 2017 06:22:49 -0700 (PDT)
Received: from donizetti.redhat.com (dynamic-adsl-78-12-246-117.clienti.tiscali.it. [78.12.246.117])
        by smtp.gmail.com with ESMTPSA id r15sm10864439wrc.30.2017.10.05.06.22.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 06:22:49 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/4] trailer: add "move" configuration for trailer.ifExists
Date:   Thu,  5 Oct 2017 15:22:43 +0200
Message-Id: <20171005132243.27058-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171005132243.27058-1-pbonzini@redhat.com>
References: <20171005132243.27058-1-pbonzini@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some cases, people apply patches to a queue branch immediately
with "git am -3 -s", and later collect Reviewed-by or Acked-by
trailers as they come in from the mailing list.

In this case, "where=after" does not have the desired behavior,
because it will add the trailer in an unorthodox position, after the
committer's Signed-off-by line.  The "move" configuration is intended
to be applied in such a case to the Signed-off-by header, like

    git interpret-trailers \
	--where end --if-missing doNothing --if-exists move
	"Signed-off-by: A U Thor <au@thor.example.org>"

or perhaps with an automated configuration

    [trailer "move-sob"]
    command = "'echo \"$(git config user.name) <$(git config user.email)>\"'"
    key = Signed-off-by
    where = end
    ifMissing = doNothing
    ifExists = move

Though this of course makes the most sense if the last Signed-off-by is
from the committer itself, and thus is not necessarily a good idea for
everyone.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/git-interpret-trailers.txt | 13 ++++++++---
 t/t7513-interpret-trailers.sh            | 37 ++++++++++++++++++++++++++++++++
 trailer.c                                | 26 +++++++++++++++++-----
 trailer.h                                |  1 +
 4 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 9dd19a1dd..1cdde492c 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -165,7 +165,7 @@ trailer.ifexists::
 	same <token> in the message.
 +
 The valid values for this option are: `addIfDifferentNeighbor` (this
-is the default), `addIfDifferent`, `add`, `replace` or `doNothing`.
+is the default), `addIfDifferent`, `add`, `replace`, `move` or `doNothing`.
 +
 With `addIfDifferentNeighbor`, a new trailer will be added only if no
 trailer with the same (<token>, <value>) pair is above or below the line
@@ -182,13 +182,20 @@ deleted and the new trailer will be added. The deleted trailer will be
 the closest one (with the same <token>) to the place where the new one
 will be added.
 +
+With `move`, an existing trailer with the same (<token>, <value>) will be
+deleted and the new trailer will be added.  If more equal pairs exists,
+the deleted trailer will be the closest one to the place where the new one
+will be added.
++
 With `doNothing`, nothing will be done; that is no new trailer will be
 added if there is already one with the same <token> in the message.
 
 trailer.ifmissing::
 	This option makes it possible to choose what action will be
-	performed when there is not yet any trailer with the same
-	<token> in the message.
+	performed when the `ifexists` action fails.  This means that
+	there is not yet any trailer with the same <token> in the message
+	or, for the `move` action only, there is no identical trailer
+	in the message.
 +
 The valid values for this option are: `add` (this is the default) and
 `doNothing`.
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 164719d1c..a0f21fefd 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1052,6 +1052,43 @@ test_expect_success 'using "ifExists = doNothing"' '
 	test_cmp expected actual
 '
 
+test_expect_success 'require token and value match when "ifExists = move"' '
+	git config trailer.fix.ifExists "move" &&
+	git config trailer.fix.where "start" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: 22
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Z
+		Fixes: 53
+	EOF
+	(cat complex_message; echo Fixes: 53) | \
+	git interpret-trailers \
+		--trailer "fix=22" \
+		>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'look for all trailers when "ifExists = move"' '
+	git config trailer.fix.ifMissing "doNothing" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: 22
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Z
+		Fixes: 53
+	EOF
+	(cat complex_message; echo Fixes: 22; echo Fixes: 53) | \
+	git interpret-trailers \
+		--trailer "fix=22" \
+		>actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'the default is "ifMissing = add"' '
 	git config trailer.cc.key "Cc: " &&
 	git config trailer.cc.where "before" &&
diff --git a/trailer.c b/trailer.c
index ce0d94074..4915bda8f 100644
--- a/trailer.c
+++ b/trailer.c
@@ -202,6 +202,14 @@ static int check_if_different(struct trailer_item *in_tok,
 	return 0;
 }
 
+static int check_if_same(struct trailer_item *in_tok,
+			 struct trailer_item *neighbor,
+			 struct arg_item *arg_tok,
+			 struct list_head *head)
+{
+	return same_trailer(in_tok, arg_tok);
+}
+
 static int check_if_different_neighbor(struct trailer_item *in_tok,
 				       struct trailer_item *neighbor,
 				       struct arg_item *arg_tok,
@@ -255,6 +263,8 @@ static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg
 		}
 		arg_tok->value = apply_command(arg_tok->conf.command, arg);
 		free((char *)arg);
+		free(arg_tok->conf.command);
+		arg_tok->conf.command = NULL;
 	}
 }
 
@@ -314,9 +324,9 @@ static int apply_arg(struct trailer_item *in_tok,
 	return 1;
 }
 
-static void apply_arg_if_exists(struct trailer_item *in_tok,
-				struct arg_item *arg_tok,
-				struct list_head *head)
+static int apply_arg_if_exists(struct trailer_item *in_tok,
+			       struct arg_item *arg_tok,
+			       struct list_head *head)
 {
 	switch (arg_tok->conf.if_exists) {
 	case EXISTS_DO_NOTHING:
@@ -324,6 +334,9 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 	case EXISTS_REPLACE:
 		apply_arg(in_tok, arg_tok, head, NULL, 1);
 		break;
+	case EXISTS_MOVE:
+		/* Look for another trailer if the match fails.  */
+		return apply_arg(in_tok, arg_tok, head, check_if_same, 1);
 	case EXISTS_ADD:
 		apply_arg(in_tok, arg_tok, head, NULL, 0);
 		break;
@@ -337,6 +350,7 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 		die("BUG: trailer.c: unhandled value %d",
 		    arg_tok->conf.if_exists);
 	}
+	return 1;
 }
 
 static void apply_arg_if_missing(struct list_head *head,
@@ -367,8 +381,8 @@ static int find_same_and_apply_arg(struct list_head *head,
 		in_tok = list_entry(pos, struct trailer_item, list);
 		if (!same_token(in_tok, arg_tok))
 			continue;
-		apply_arg_if_exists(in_tok, arg_tok, head);
-		return 1;
+		if (apply_arg_if_exists(in_tok, arg_tok, head))
+			return 1;
 	}
 	return 0;
 }
@@ -423,6 +437,8 @@ int trailer_set_if_exists(enum trailer_if_exists *item, const char *value)
 		*item = EXISTS_ADD;
 	else if (!strcasecmp("replace", value))
 		*item = EXISTS_REPLACE;
+	else if (!strcasecmp("move", value))
+		*item = EXISTS_MOVE;
 	else if (!strcasecmp("doNothing", value))
 		*item = EXISTS_DO_NOTHING;
 	else
diff --git a/trailer.h b/trailer.h
index 6d7f8c2a5..0fbdab38d 100644
--- a/trailer.h
+++ b/trailer.h
@@ -16,6 +16,7 @@ enum trailer_if_exists {
 	EXISTS_ADD_IF_DIFFERENT,
 	EXISTS_ADD,
 	EXISTS_REPLACE,
+	EXISTS_MOVE,
 	EXISTS_DO_NOTHING
 };
 enum trailer_if_missing {
-- 
2.14.2

