Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53B1D1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 12:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbdFIMDW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 08:03:22 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33898 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdFIMDV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 08:03:21 -0400
Received: by mail-wr0-f178.google.com with SMTP id g76so30579422wrd.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RtVQNc4pfroJ92QyX7ec0GNRvxg/2zhUdoHfszgtd4w=;
        b=ngoJITjog75cZdxYuw+bqchCL9W61rKG2WKMO2Fus2e+o8Lp/M7yyp6c1pRq7U27sO
         fkPlF+8/k41eNIgMGelbs34M7CClKqOr0/hckskgyuTs9OM31occOqaDCQnONbHqw0hD
         zA1URfPUIeY3cRxx0zdVjx4VVBvXPQlsxeGTlPmt+2crq/bken2J5VNwLN4Xj6O2XRtL
         28xEkWZczQS8G9WeONHoc1gUGghpOlqBUz5TkSpT1QYzR2EfifVp88m0tkqHUOcQ7bWK
         1OQsoxpiNwD+IZ8+Mudg+lc/IFPwXLp8b6Bh4499n0AkvSojkq+brxCOEDiRGgJ0Cuaa
         +i/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RtVQNc4pfroJ92QyX7ec0GNRvxg/2zhUdoHfszgtd4w=;
        b=F6ZS84jXlRfNZVLbh80tLou5bBVFwrYdnznCxK3jiqD0xjrhKgNF917AnCT2WQiYSF
         gK9EjG/dZmyxBHLCpqEwCAmjfZO2Ar0zSAzqwZTQWG56Swm5UtdzjFl5qCz9+45PP9z+
         AsjHLPbvNN6nF5FlwpBzU6mz6expHxnFR6TMP1jNV6rk9lvHJM1XRgEdW+F615jK4wJD
         bFuLMGJZa5ackHW3OJLm5Jhp9sMgb3cbQoMjFMK940q+UBm24JulQJcegAzsrCEny+Cc
         AeufCE+w0rpFhY5Yky+jY82yJcOi8UASCaiBcEmPtCBqkwvCPJYLdmVi8VJkMlGQLI+Z
         2DIQ==
X-Gm-Message-State: AKS2vOwHARCX72qm8QbdnJSr5RTuJ8zmb2bVYpIEUuzB2T8cOCZjdkjc
        JImp4S3e1I6D+A==
X-Received: by 10.28.48.72 with SMTP id w69mr7456844wmw.103.1497009800073;
        Fri, 09 Jun 2017 05:03:20 -0700 (PDT)
Received: from buc98hyl12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id z23sm1377693wrz.0.2017.06.09.05.03.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 05:03:19 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: "There are too many unreachable loose objects" - why don't we run 'git prune' automatically?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170609052755.dsuqd4gizi2opoya@sigill.intra.peff.net>
Date:   Fri, 9 Jun 2017 14:03:18 +0200
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7497DFA7-3F4E-4DB2-B31B-FDDEB2F30BB8@gmail.com>
References: <9C2F2EA2-0C59-4EA2-8C8E-10228FB82D90@gmail.com> <20170609052755.dsuqd4gizi2opoya@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Jun 2017, at 07:27, Jeff King <peff@peff.net> wrote:
>=20
> On Thu, Jun 08, 2017 at 02:45:48PM +0200, Lars Schneider wrote:
>=20
>> I recently ran into "There are too many unreachable loose objects; =
run=20
>> 'git prune' to remove them." after a "Auto packing the repository in=20=

>> background for optimum performance." message.
>>=20
>> This was introduced with a087cc9 "git-gc --auto: protect ourselves =
from=20
>> accumulated cruft" but I don't understand the commit message really.
>>=20
>> Why don't we call 'git prune' automatically? I though Git would prune
>> unreachable objects after 90 days by default anyways. Is the warning=20=

>> about unreachable objects that are not yet 90 days old?
>=20
> We _do_ call "git prune", but we do so with whatever configured
> expiration time is (by default 2 weeks; the 90-day expiration is for
> reflogs).
>=20
> The problem is that auto-gc kicked in because there were a bunch of
> loose objects, but after repacking and running "git prune" there were
> still enough loose objects to trigger auto-gc. Which means every =
command
> you run will do an auto-gc that never actually helps.
>=20
> So you have two options:
>=20
>  1. Wait until those objects expire (which may be up to 2 weeks,
>     depending on how recent they are), at which point your auto-gc =
will
>     finally delete them.
>=20
>  2. Run "git prune". Without an argument it prunes everything now,
>     with no expiration period.
>=20
> I agree the existing message isn't great. There should probably be a =
big
> advise() block explaining what's going on (and that expert users can
> disable).

How about this?

diff --git a/builtin/gc.c b/builtin/gc.c
index c2c61a57bb..12ee212544 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -473,9 +473,18 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	if (pack_garbage.nr > 0)
 		clean_pack_garbage();
=20
-	if (auto_gc && too_many_loose_objects())
-		warning(_("There are too many unreachable loose objects; =
"
-			"run 'git prune' to remove them."));
+	if (auto_gc && too_many_loose_objects()) {
+		warning(_("Auto packing did not lead to optimal results =
as the "
+			"repository contains too many unreachable =
objects."));
+		advice(_("Unreachable objects are Git objects (commits, =
files, ...) "
+			"that are not referenced by any branch or tag. =
This might happen "
+			"if you use 'git rebase' or if you delete =
branches. Auto packing "
+			"only prunes unreachable objects that are older =
than 2 weeks "
+			"(default, overridable by the config variable =
'gc.pruneExpire'). "
+			"Please run 'git prune' to prune all unreachable =
objects for "
+			"optimal repository performance."));
+	}
=20
 	if (!daemonized)
 		unlink(git_path("gc.log"));
- Lars

