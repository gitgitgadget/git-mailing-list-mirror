Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B84A01F42D
	for <e@80x24.org>; Thu, 24 May 2018 17:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034013AbeEXREJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 13:04:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37600 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033920AbeEXREI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 13:04:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id l1-v6so7361673wmb.2
        for <git@vger.kernel.org>; Thu, 24 May 2018 10:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=i5o3FfMHbLnQtaEbj5eISkiS76OmstzfZBYVB83mdUE=;
        b=uEthYuPdZbWtlLNZuk+wp3LTFCyz3D3EPMkqS9jrZD4/1Z294/zROI+H+Jp64IUVgS
         Dzl/MQ2wqw1+FQU2PUVYXcnc/BVbWOeu6eRqSyrkyedGDuf3ELJP/9D/7sDZtvEB+x0A
         LlDsZABuAY3gLCFCFQjHBIKHy/jppJkyj9yI+kBedNOjBhTYW62Am4fdjOIfDwwGpABV
         KUResYyWoRoAxtvR/XhxOZJJDiatE9M5wbGEvmwK1GGktkA+EZwhJS2YIHXaex0uHp7R
         J0wt/TPO7J0VQEvXetHhLPWns5Tz3FUx++Q1St2Ms2/OQQv/KxEeaw3vfmHKML6hawbH
         aNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=i5o3FfMHbLnQtaEbj5eISkiS76OmstzfZBYVB83mdUE=;
        b=F6905QkO1b8DvP2sRf3qVx0uvFnZ0NbSF6Z1tfl97LnWvOp8nNwlW8UVTx7FVAByEJ
         7CO5q6OsQQvpzzL5xwmdvPzvy/XnEmnWk4zi9LyNfj1s7fuP7mW+Tx9ToX7WFQt1+FQW
         Y86fxPsgg/lvY6FWc2MUWxkCquax/iLkcy2WRJPRi/FN+wYd579aQHm1z/mbblLxrXEF
         k/Ap2BDxmRW+CQzmJ9B6KJy6feULgTBaNC7am65wCT0t4EyKdmNAKxQDeOWvbuB5zlSU
         je1Fk19LedtefwGOyFbxqtUayZlqNR6/IkG16uJrLuP9w5cliAkfGUzLrtWQTBcSqybX
         64lA==
X-Gm-Message-State: ALKqPwfEDiHwF/ai5sOu1/Z141tUStsrwafR1IqfaB3gMWU+DhjMqAi7
        xTMdUjjl+x7WjcyHlPklu77TC/ty
X-Google-Smtp-Source: AB8JxZr5FtjXJEidOgY6jZv6bqDSDvaCWs+RZASymQtW7BqwQUhtx8hTK+EwuITwIQPclKrxSo3QTg==
X-Received: by 2002:a50:a782:: with SMTP id i2-v6mr12993822edc.164.1527181446907;
        Thu, 24 May 2018 10:04:06 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id g11-v6sm11981315edg.64.2018.05.24.10.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 10:04:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: BUG: No way to set fsck.<msg-id> when cloning
References: <87vabd6pp2.fsf@evledraar.gmail.com> <20180524155807.GA11253@alpha>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180524155807.GA11253@alpha>
Date:   Thu, 24 May 2018 19:04:04 +0200
Message-ID: <87tvqx6l4r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 24 2018, Kevin Daudt wrote:

> On Thu, May 24, 2018 at 05:25:29PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> When I do:
>>
>>     git -c fetch.fsckObjects=true clone git@github.com:robbyrussell/oh-my-zsh.git
>>
>> I get:
>>
>>     error: object 2b7227859263b6aabcc28355b0b994995b7148b6: zeroPaddedFilemode: contains zero-padded file modes
>>     fatal: Error in object
>>     fatal: index-pack failed
>>
>> The docs (https://git-scm.com/docs/git-config#git-config-fsckltmsg-idgt)
>> say you can override this with -c fsck.zeroPaddedFilemode = ignore, but
>> I see in builtin/fsck.c that just fsck_config() knows about this, and
>> indeed this works *after* you clone the repo when you use 'git fsck'.
>>
>> I don't have time to fix this now, but what's the best approach here?
>> Make all the relevant commands copy what fsck_config() is doing, or
>> should fsck_object() be lazily looking up this config by itself?
>
> Apparently someone reported this earlier[0]. Johannes replied:
>
>>  Well, you can apparently have your cake and eat it too (see
>> https://git-scm.com/docs/git-config#git-config-receivefsckltmsg-idgt):
>>
>> receive.fsck.<msg-id>::
>>         When `receive.fsckObjects` is set to true, errors can be switched
>>         to warnings and vice versa by configuring the `receive.fsck.<msg-id>`
>>         setting where the `<msg-id>` is the fsck message ID and the value
>>         is one of `error`, `warn` or `ignore`. For convenience, fsck prefixes
>>         the error/warning with the message ID, e.g. "missingEmail: invalid
>>         author/committer line - missing email" means that setting
>>         `receive.fsck.missingEmail = ignore` will hide that issue.
>>
>> In your case, use receive.fsck.zeroPaddedFilemode=ignore=warn (or
>> =ignore).
>
> [0]https://public-inbox.org/git/alpine.DEB.2.21.1.1801042125430.32@MININT-6BKU6QN.europe.corp.microsoft.com/
>
> Hope this helps, Kevin.

That doesn't work, because that's for the server-side, but I need the
fetch.fsck.* that doesn't exist. This works (I'll send a better patch
with tests / docs etc. soon):

diff --git a/fetch-pack.c b/fetch-pack.c
index 490c38f833..9e4282788e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -19,6 +19,7 @@
 #include "sha1-array.h"
 #include "oidset.h"
 #include "packfile.h"
+#include "fsck.h"

 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -33,6 +34,7 @@ static int agent_supported;
 static int server_supports_filtering;
 static struct lock_file shallow_lock;
 static const char *alternate_shallow_file;
+static struct strbuf fsck_msg_types = STRBUF_INIT;

 /* Remember to update object flag allocation in object.h */
 #define COMPLETE	(1U << 0)
@@ -935,7 +937,8 @@ static int get_pack(struct fetch_pack_args *args,
 			 */
 			argv_array_push(&cmd.args, "--fsck-objects");
 		else
-			argv_array_push(&cmd.args, "--strict");
+			argv_array_pushf(&cmd.args, "--strict%s",
+					 fsck_msg_types.buf);
 	}

 	cmd.in = demux.out;
@@ -1409,6 +1412,31 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	return ref;
 }

+static int fetch_pack_config_cb(const char *var, const char *value, void *cb)
+{
+	if (strcmp(var, "fetch.fsck.skiplist") == 0) {
+		const char *path;
+
+		if (git_config_pathname(&path, var, value))
+			return 1;
+		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
+			fsck_msg_types.len ? ',' : '=', path);
+		free((char *)path);
+		return 0;
+	}
+
+	if (skip_prefix(var, "fetch.fsck.", &var)) {
+		if (is_valid_msg_type(var, value))
+			strbuf_addf(&fsck_msg_types, "%c%s=%s",
+				fsck_msg_types.len ? ',' : '=', var, value);
+		else
+			warning("Skipping unknown msg id '%s'", var);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
 static void fetch_pack_config(void)
 {
 	git_config_get_int("fetch.unpacklimit", &fetch_unpack_limit);
@@ -1417,7 +1445,7 @@ static void fetch_pack_config(void)
 	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
 	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);

-	git_config(git_default_config, NULL);
+	git_config(fetch_pack_config_cb, NULL);
 }

 static void fetch_pack_setup(void)
