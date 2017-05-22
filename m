Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C556B20281
	for <e@80x24.org>; Mon, 22 May 2017 08:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbdEVI1z (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 04:27:55 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:32805 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbdEVI1y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 04:27:54 -0400
Received: by mail-it0-f66.google.com with SMTP id l145so13000992ita.0
        for <git@vger.kernel.org>; Mon, 22 May 2017 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VsOs7Q9UNJUcvrYfgSqeEzIC03lSvX8qBPCknM6NDUQ=;
        b=o1TLapEo1VPxkm7Wzj2WP/XXrqwY9gIOLJVDF6YxrrCVeXvIr/kO0NRPEkNu3KOmbJ
         9wRBrLdIjsGHcnTH/VjNb2A1pVMBkb9Cc9jlMfjDlmtZuFxOrzwlBOheVy92n7sxiKdL
         OS/fPHv0jUldAxvK11z9GuzAoR4PEJFnqbStMCBuHViaZolat4mBY8nlh3K6bMoBIv3k
         +ZrkWnRN3jMtKOF31Eu/+K/ZFSccNNthF7idtBCI2UpdYYIJDBbfpLGSk+b0W4/k+h5W
         TBPLb3T7y7O/3o0O0HMEYNLdAd33WicTNVpWw8mxDd0GRagUZvtfMYfolsNjbN9GYJlm
         hUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VsOs7Q9UNJUcvrYfgSqeEzIC03lSvX8qBPCknM6NDUQ=;
        b=b6gkCI/1I2Ma640hGRSUo1YhGlGP/0iecgdcEBn67Vlmxp3qIXeHQ6J+anoPDxUIWB
         GJbEmBxDgdJATGra2eAj66PjIrIHat43n3p6yhBmSuf8CFc4zcPc0JNDUT0OyrZaroOS
         /aj4Jml7vDqQQFSscFE9/4P7ajmXr+EImkn4PTMDpUZv+9x+K8NIpNePmZkr4pcfJik+
         Nbv4sGcHtR6GbR7jiQmHInCEwIOZCsi5nXBWvF6pKbr6Ssu7ezo+1LMfvxWkKDbxN8YB
         KjBYlaARhrSb+IAXA7adrOWfuqh12YqtMynRJAR7lbjDLgFBM1QEe6klPH8zl5GH57gm
         EeNA==
X-Gm-Message-State: AODbwcBOk70YJ6gVtvg1uhxVl2+1jg20eg6+27wIJdTTvL93yZeTW5mp
        FzuPcN37ranLkDDelAP+ivt1NK/U1g==
X-Received: by 10.36.138.131 with SMTP id v125mr38511073itd.66.1495441673800;
 Mon, 22 May 2017 01:27:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 22 May 2017 01:27:33 -0700 (PDT)
In-Reply-To: <xmqq7f19ppy6.fsf@gitster.mtv.corp.google.com>
References: <20170520115429.12289-1-avarab@gmail.com> <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com>
 <20170520115429.12289-3-avarab@gmail.com> <xmqqtw4dptek.fsf@gitster.mtv.corp.google.com>
 <xmqq7f19ppy6.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 22 May 2017 10:27:33 +0200
Message-ID: <CACBZZX52etn7jjT13tDfiQL2ondBAK8G7MuLvG5bmm8Fmn-FwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sha1dc: optionally use sha1collisiondetection as a submodule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 4:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> But when somebody (like me?) feels strongly enough, such a change
>> can always come on top of this patch, so let's have this
>> manual-configuration-only version as our first step.
>
> Just so that I have something I can come back to, here it is with a
> log message.
>
> -- >8 --
> Subject: [PATCH] sha1collisiondetection: automatically enable when submodule is populated
>
> If a user wants to experiment with the version of collision
> detecting sha1 from the submodule, the user needed to not just
> populate the submodule but also needed to turn the knob.
>
> A Makefile trick is easy enough to do so, so let's do this.  When
> somebody with a copy of the submodule populated wants not to use it,
> that can be done by overriding it in config.mak or from the command
> line, e.g. "make DC_SHA1_SUBMODULE= all".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 6baad1669e..8d33936a12 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -989,6 +989,10 @@ EXTLIBS =
>
>  GIT_USER_AGENT = git/$(GIT_VERSION)
>
> +ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
> +DC_SHA1_SUBMODULE = auto
> +endif
> +
>  include config.mak.uname
>  -include config.mak.autogen
>  -include config.mak


I thought this should have something like this:

diff --git a/Makefile b/Makefile
index 8d33936a12..bbcac648a4 100644
--- a/Makefile
+++ b/Makefile
@@ -989,9 +989,11 @@ EXTLIBS =

 GIT_USER_AGENT = git/$(GIT_VERSION)

+ifndef DC_SHA1_SUBMODULE
 ifeq ($(wildcard
sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
 DC_SHA1_SUBMODULE = auto
 endif
+endif

 include config.mak.uname
 -include config.mak.autogen

I.e. so using sha1dc via DC_SHA1_SUBMODULE= even with the submodule
checked-out would work, but experimenting with it now that seems to do
the right thing, even though this is set unconditionally. There must
be some Makefile magic I'm missing here.

But in any case it would make sense to squash something like this into
your patch:

diff --git a/Makefile b/Makefile
index 8d33936a12..4d9c49ae17 100644
--- a/Makefile
+++ b/Makefile
@@ -148,7 +148,8 @@ all::
 # sha1collisiondetection shipped as a submodule instead of the
 # non-submodule copy in sha1dc/. This is an experimental option used
 # by the git project to migrate to using sha1collisiondetection as a
-# submodule.
+# submodule. Supplied implicitly if the sha1collisiondetection/
+# directory is found to be populated.
 #
 # Define OPENSSL_SHA1 environment variable when running make to link
 # with the SHA1 routine from openssl library.
