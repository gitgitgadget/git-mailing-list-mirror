Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81CB61F516
	for <e@80x24.org>; Sat, 30 Jun 2018 08:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeF3IjQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 04:39:16 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37490 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbeF3IjN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 04:39:13 -0400
Received: by mail-it0-f67.google.com with SMTP id p17-v6so5982484itc.2
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 01:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4HGC9hr1Zmz5j/NbJbAi7bZiJIuINR0B1D8cCNnugXI=;
        b=TmNXZASB4MDyW9L/lZygzY3mASuJ+83jR7Hk1ndLVNYpFoxTnfYqpiQsGAPB0XJsCj
         BSuKH5bbV4i+/+0QH1rNjR7DDLd+EsiVJBPFMn4GtCDxSGujBTdv6OascX1TAAJX1L7R
         sgFVpaY2gbANwzD8QOJF5T6YmUfvh6Giro8hb0GoT3VqRtgtG6SCas6Ng9xlBI0oGBRF
         SxzxvAe+1HSd7luP6dv4164NuHQl84vcPm3De9to1oXLE1qbN0GdUf3N2G0Fk55sqU1h
         DpInt9v8dtR3UlaKdGa6WavT7bqgyJhX+bOleZakejdnk/OCvmhuS/R5iT4+Z/9AYelR
         NWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4HGC9hr1Zmz5j/NbJbAi7bZiJIuINR0B1D8cCNnugXI=;
        b=i93wzgAbnOgoHGawq74MRIZfMbsoNESxs4EGkkEpgF1Eraxxm6aF8gHHXbmab9HwMs
         avcSianDZd3lR5jejq9aGCnx9j3cJMq5/ITxt30FdmeQMoK8pnoFiUO+7kLmYmJnDqxJ
         DZEUCYReXP44081DNsHsBnUb3LD+Y64izeAKSAJ/fmKpJNb3JT2ffzCRMGVqmuVzXn0X
         zFTWeZ3MP4dfbLJpqB9F0aLb3cV1k9Nr8vjPkX0T95GYpw3qJRyp4BHbp5g+tbpxxlF7
         Q6jnpV5TQKp4kN4DdUpl3qGeqeTSNAcFax6yLIvCd9XBDL6RuQ+6bxrw0iPW75pYih+s
         t0Ww==
X-Gm-Message-State: APt69E0a8xTMzsalpvl5KcRcfETR441AHXPuAQvg6k9O/P1PhdquK1P3
        iBfJWnoBo3xkmP6NdgQSCyp7asB1evvfUvXyzxwKgY7F
X-Google-Smtp-Source: AAOMgpejYYr2wnqPtLWBEMP0MWxWCPRtqyP75nq1gOZ2y4Ep7n8G4POKx27/X2fFn2bCB7s6+VI1ZQfYwyiQCpiNK1I=
X-Received: by 2002:a02:1045:: with SMTP id 66-v6mr14554525jay.133.1530347952774;
 Sat, 30 Jun 2018 01:39:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 01:39:12
 -0700 (PDT)
In-Reply-To: <20180630083542.20347-1-chriscool@tuxfamily.org>
References: <20180630083542.20347-1-chriscool@tuxfamily.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 30 Jun 2018 10:39:12 +0200
Message-ID: <CAP8UFD2GEUERdMXgEO2ZA4L4ZZa=WnZ14EUHM1be-rsmgDSV0g@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Introducing remote ODBs
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 30, 2018 at 10:35 AM, Christian Couder
<christian.couder@gmail.com> wrote:

> Changes compared to V1 of this patch series
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>   - fix tests failures
>   - error out when more than one "odb.<name>.promisorremote" exist
>     with the same <name>

Here is the diff with V1:

diff --git a/remote-odb.c b/remote-odb.c
index 5b9d1930b5..eb580ca513 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -21,6 +21,17 @@ static struct odb_helper
*find_or_create_helper(const char *name, int len)
     return o;
 }

+static struct odb_helper *do_find_odb_helper(const char *remote)
+{
+    struct odb_helper *o;
+
+    for (o = helpers; o; o = o->next)
+        if (o->remote && !strcmp(o->remote, remote))
+            return o;
+
+    return NULL;
+}
+
 static int remote_odb_config(const char *var, const char *value, void *data)
 {
     struct odb_helper *o;
@@ -33,8 +44,22 @@ static int remote_odb_config(const char *var, const
char *value, void *data)

     o = find_or_create_helper(name, namelen);

-    if (!strcmp(subkey, "promisorremote"))
-        return git_config_string(&o->remote, var, value);
+    if (!strcmp(subkey, "promisorremote")) {
+        const char *remote;
+        int res = git_config_string(&remote, var, value);
+
+        if (res)
+            return res;
+
+        if (do_find_odb_helper(remote))
+            return error(_("when parsing config key '%s' "
+                       "helper for remote '%s' already exists"),
+                     var, remote);
+
+        o->remote = remote;
+
+        return 0;
+    }
     if (!strcmp(subkey, "partialclonefilter"))
         return git_config_string(&o->partial_clone_filter, var, value);

@@ -71,11 +96,7 @@ struct odb_helper *find_odb_helper(const char *remote)
     if (!remote)
         return helpers;

-    for (o = helpers; o; o = o->next)
-        if (!strcmp(o->remote, remote))
-            return o;
-
-    return NULL;
+    return do_find_odb_helper(remote);
 }

 int has_remote_odb(void)
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index b29c0d3d39..9d513ebf57 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -23,10 +23,10 @@ promise_and_delete () {
     delete_object repo "$HASH"
 }

-test_expect_success 'extensions.partialclone without filter' '
+test_expect_success 'promisor remote without filter' '
     test_create_repo server &&
     git clone --filter="blob:none" "file://$(pwd)/server" client &&
-    git -C client config --unset core.partialclonefilter &&
+    git -C client config --unset odb.origin.partialclonefilter &&
     git -C client fetch origin
 '

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index a4fe6508bd..0c47599568 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -285,7 +285,7 @@ test_expect_success 'partial fetch' '
     rm -rf client "$(pwd)/trace" &&
     git init client &&
     SERVER="file://$(pwd)/server" &&
-    test_config -C client extensions.partialClone "$SERVER" &&
+    test_config -C client odb.magic.promisorRemote "$SERVER" &&

     GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
         fetch --filter=blob:none "$SERVER" master:refs/heads/other &&
