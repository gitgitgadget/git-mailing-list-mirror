Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 140C0202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 22:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbdJWWQP (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 18:16:15 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:50576 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdJWWQO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 18:16:14 -0400
Received: by mail-qk0-f180.google.com with SMTP id o187so23977276qke.7
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 15:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TFwqft5JCKi2t3+QCUOlQ08pZhflx6dZoNgft1ZhRLY=;
        b=MuEk9iwziqgVsPh8d1zWRc59ooM7RpmsLZp1qMDbY2TJwaQrBNriGYyjeCH2R65qHO
         z2ZDifiglBkwCbyfIXrxZ2gLI+CIlB1CqND+a8kaI7V9m3bNe/ZAwzIJS5v94TBl1aMF
         qJcr4iMcsnrfwVgv9KD3IvafwVaFziR5OQfBT81bixwYnAI1fER+11VHI9ddOJ5RM/lX
         +oennVtnP20MiBAmWYP9J5bzx2c2f0PQTwCCJHC6HmifzGyTRQlhOtMD61me5zI/YKWK
         0Pb1F2X0OHU0ESy4bLl8YWWF68YxsOrPvkdgG9mkgfdz7hM2sEcn6NNk2PjSXOQVYjLf
         5LLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TFwqft5JCKi2t3+QCUOlQ08pZhflx6dZoNgft1ZhRLY=;
        b=hdzW/H8HSvJ8CkVMgrwvV6OkHqeKcslZmBNB0RlV4xBCqbZSMQtmWwr2jqN6k4r936
         0QoHV5blbuoDXxWMBSJFJW3cRaEwtXvtvYM6iFSavhRU2fdn1JhID4FAKe4/AuPLowg3
         fjYmwOMnRw7ln2oq77MHGYmkpM23/RDWC4naOYOABXjUaTdVRLHCX8/9d3PDm8Lh34te
         NFcIJOiJFR8jCTSF4YXKw2eqG0dVdcdhYTr+FMHJnk6WHTxWnbR9o63rx5X5d2Sq4DRE
         7mu5UrQpPKtrwNBct5ruMxBSfwzMnFdbwzxkBpthvqLiQoKFaVSIC6yZxlr/GyizWcSo
         ACGw==
X-Gm-Message-State: AMCzsaVpIMAeqQaP0Tub/wGb4ox6R74ijrRiB5BWT6I3D7gX1dJepVLV
        OXlvTwnVpBtnOStpau+X0y6Q3WRPy47RUfirvF2gZg==
X-Google-Smtp-Source: ABhQp+RuSN8EiYVzWbTjhkf0Y7WxdAWgmlDdZ6egzJTSUjQfhhu55LTFWRt3CWi3mWvtbEdqGFafWKYzGkH1mENPqtk=
X-Received: by 10.55.175.132 with SMTP id y126mr21948244qke.45.1508796973734;
 Mon, 23 Oct 2017 15:16:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 23 Oct 2017 15:16:13 -0700 (PDT)
In-Reply-To: <20171023212916.4aarismli6io4ro6@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com> <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com> <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com> <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023212916.4aarismli6io4ro6@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Oct 2017 15:16:13 -0700
Message-ID: <CAGZ79kYwARXNWRS4AgwTP7peZiWiwCBvWFiEr9TbpbWjgysfZA@mail.gmail.com>
Subject: Re: [PATCH 1/5] connect: split git:// setup into a separate function
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, William Yan <wyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 23, 2017 at 2:29 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> The git_connect function is growing long.  Split the
> PROTO_GIT-specific portion to a separate function to make it easier to
> read.
>
> No functional change intended.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

This also looks good to me.

unrelated:
Patch 2 was very easy to review using "log -p -w --color-moved",
this one however was not. This is because -w caused the diff machinery
to generate a completely different diff. (Not showing the new function
completely but some weird function header trickery. The white space
mangled output is below; most of it was colored "moved")

I had to have -w as otherwise --color-moved would not work,
so maybe we want to have an option to ignore white space for the
sake of move detection only, not affecting the diff in general;
maybe '--ignore-white-space-in-move-detection'?

I think once this option is given, all we have to do is pay attention to
this option in diff.c#moved_entry_cmp/next_byte, which is best built
on top of Peffs recent fixes origin/jk/diff-color-moved-fix.
Would that be of interest for people?

Thanks,
Stefan

diff --git a/connect.c b/connect.c
index 7fbd396b35..068e70caad 100644
--- a/connect.c
+++ b/connect.c
@@ -851,36 +851,16 @@ static enum ssh_variant
determine_ssh_variant(const char *ssh_command,
 }

 /*
- * This returns a dummy child_process if the transport protocol does not
- * need fork(2), or a struct child_process object if it does.  Once done,
- * finish the connection with finish_connect() with the value returned from
- * this function (it is safe to call finish_connect() with NULL to support
- * the former case).
+ * Open a connection using Git's native protocol.
  *
- * If it returns, the connect is successful; it just dies on errors (this
- * will hopefully be changed in a libification effort, to return NULL when
- * the connection failed).
+ * The caller is responsible for freeing hostandport, but this function may
+ * modify it (for example, to truncate it to remove the port part).
  */
-struct child_process *git_connect(int fd[2], const char *url,
-                                  const char *prog, int flags)
+static struct child_process *git_connect_git(int fd[2], char *hostandport,
+                                             const char *path, const
char *prog,
+                                             int flags)
 {
-        char *hostandport, *path;
         struct child_process *conn = &no_fork;
-        enum protocol protocol;
-
-        /* Without this we cannot rely on waitpid() to tell
-         * what happened to our children.
-         */
-        signal(SIGCHLD, SIG_DFL);
-
-        protocol = parse_connect_url(url, &hostandport, &path);
-        if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
-                printf("Diag: url=%s\n", url ? url : "NULL");
-                printf("Diag: protocol=%s\n", prot_name(protocol));
-                printf("Diag: hostandport=%s\n", hostandport ?
hostandport : "NULL");
-                printf("Diag: path=%s\n", path ? path : "NULL");
-                conn = NULL;
-        } else if (protocol == PROTO_GIT) {
         struct strbuf request = STRBUF_INIT;
         /*
          * Set up virtual host information based on where we will
@@ -925,6 +905,41 @@ struct child_process *git_connect(int fd[2],
const char *url,

         free(target_host);
         strbuf_release(&request);
+        return conn;
+}
+
+/*
+ * This returns a dummy child_process if the transport protocol does not
+ * need fork(2), or a struct child_process object if it does.  Once done,
+ * finish the connection with finish_connect() with the value returned from
+ * this function (it is safe to call finish_connect() with NULL to support
+ * the former case).
+ *
+ * If it returns, the connect is successful; it just dies on errors (this
+ * will hopefully be changed in a libification effort, to return NULL when
+ * the connection failed).
+ */
+struct child_process *git_connect(int fd[2], const char *url,
+                                  const char *prog, int flags)
+{
+        char *hostandport, *path;
+        struct child_process *conn = &no_fork;
+        enum protocol protocol;
+
+        /* Without this we cannot rely on waitpid() to tell
+         * what happened to our children.
+         */
+        signal(SIGCHLD, SIG_DFL);
+
+        protocol = parse_connect_url(url, &hostandport, &path);
+        if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
+                printf("Diag: url=%s\n", url ? url : "NULL");
+                printf("Diag: protocol=%s\n", prot_name(protocol));
+                printf("Diag: hostandport=%s\n", hostandport ?
hostandport : "NULL");
+                printf("Diag: path=%s\n", path ? path : "NULL");
+                conn = NULL;
+        } else if (protocol == PROTO_GIT) {
+                conn = git_connect_git(fd, hostandport, path, prog, flags);
         } else {
                 struct strbuf cmd = STRBUF_INIT;
                 const char *const *var;
