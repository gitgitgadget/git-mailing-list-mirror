Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC004C43334
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 09:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiFZJ3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 05:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiFZJ3y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 05:29:54 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31AB11C11
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 02:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1656235776;
        bh=YzmvR5yve6pz0bihL4bPWHN4yQ0XtPZDjQ6er9a57ms=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Irep6KiJzCT4MJwLOgxmVXrLQHSpCmvA+k8Mi4LTzBu4C+RXOp7JdYmlz+XdFuwHs
         dlDNZ5vW/D/a/Kf8mINJysSoePdT/gfwOweDUVfIymOoijL5I5zfLDAdyrp99Gm1xg
         2TeNdBWTmfxEbMrGi/YDJTSAuFSlQGQLTXOjCPm4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyvB8-1nkAXi3Mu2-00vlG2; Sun, 26
 Jun 2022 11:29:36 +0200
Message-ID: <6727daf1-f077-7319-187e-ab4e55de3b2d@web.de>
Date:   Sun, 26 Jun 2022 11:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] revert: optionally refer to commit in the "reference"
 format
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsfp2b30k.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqsfp2b30k.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FTlNRzekGaCDHfhpUf08y72WTvxwNlYgWI4W4lE3AiwDfLeGHul
 E/Sht6Omm11roZwYaxf+ix/7RwcrfEC0vrjZwTM3gfd2vWrep6ga1f9vt/4udCMjjDQdD+B
 6pV53ORaO1t4C95K7a5GitefpMVANRXPy5FhTKN71r07VPfK31MpS2/+N8vCzEtdEMNv/jm
 K0/9OzbcyHcP8nKJp7Lxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3cfwCQ21mU8=:fMwhKJGuUKcMOqsU65V2Wf
 i+Z+r/i75Z+zlmcq/RJMKp9pFEq/l6jzMa/JiKUaqJTwLvluvyJoEOf32wHiDY+TXbAz9BmUd
 NBdNJJqwySL2ivWPDGzJAJUFI4aImbfVo93/CpIjZnr4fCXg1/EoORYnrxpgvu9tVpaA556bY
 2nE9PaqDEfZ44buP6S0YF62V8I3sbg28nYVUsm32ep8aM81+ffGER88FWO0dC3TQOGBAQTLhI
 DlrAtpW8x2JONgnbkPeBNpLRBB9dKkqhwLZ0bzIUth/Ev6v1s6BzFf3m7xYW/+pvPT8YgckKN
 /UFZgjaAeOYwXHW0j8I4+7E8JKpp5dL0U58hL2mRbbHO9OXSQbtO0ZsiU7Oqg9Eb+70E9fDuh
 4T0irR7U+96Hax5obr/Pe4yRThYfxa3utmlqDQcUcslExpffdh+J8IbSaHHpwEGqWpWSTSYJ/
 PZjknDmN1RbyAA/QJYcKiw6m0CF7MxRD9j/ZKqS9/9TRfMmTxyOK8AORXlQwDIEU3k9j/wHdo
 pCOy8WKAj6TPBYi/cjhQMzXoKgUet0TMJ/HPGqjOrJ49CzxRkBPU+gcPnig47w8ExE+7Y8WEQ
 1ABqNBCuSyV/6X4HoX5MJy85HnvhlmLtTnjcmX74zY6J4NufEljErgNfyckKd0E5uG4mAh0zj
 kfCMkdqOnMl/a76JZ1vkpahVMMw78vUWV9wDcB4gOy4gKtxAHG9KNOggvI1N7RwVfbHrfeXCH
 NYtElBr5vQkf9cnJNWUhWUqZUYPgOG95L9aqtlj8nAYqbLTrUNXIuMXwYPZj3PQVRWeS0ViRA
 5ubj3KKXj+WNG+v1Eu/W+nSuuxB56Y5cl+GIUIvIfDm/WJn+gUJ2QacbPd9ArnO/KxEFn5PqH
 SwUk7rKDeCRMaXxV0Mv1l0DMSk1RFzENfxgOkAjnAxLyWS7HoVGgDx4YWrPxMnN3cICiEE5JX
 wAZ+xTjeBcY3tx48wncoWqhsOgvcWiB5xH4YmcZIWaxII+Oy8cw7ttBuxqt1/T0fDMm0yXRT1
 G8vgBoTRWxxnQZnOdR90FsZP0zBMfrde7DRMIUHUDDuGgnd6FnZ2dva3UQyvnE82FBBsDhqaM
 UvVGDGewPCbIlkioobCtZXup/ke+TPhEWRe
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.05.22 um 06:32 schrieb Junio C Hamano:
> ---
>  Documentation/config/revert.txt |  3 +++
>  Documentation/git-revert.txt    |  9 +++++++++
>  builtin/revert.c                |  2 ++
>  sequencer.c                     | 32 +++++++++++++++++++++++++++-----
>  sequencer.h                     |  1 +
>  t/t3501-revert-cherry-pick.sh   | 31 +++++++++++++++++++++++++++++++
>  6 files changed, 73 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/config/revert.txt
>
> diff --git a/Documentation/config/revert.txt b/Documentation/config/reve=
rt.txt
> new file mode 100644
> index 0000000000..797bfb6d62
> --- /dev/null
> +++ b/Documentation/config/revert.txt
> @@ -0,0 +1,3 @@
> +revert.reference::
> +	Setting this variable to true makes `git revert` to behave
> +	as if the `--reference` option is given.

Shouldn't this be "were" instead of "is"?  Not fully sure.  Anyway:

=2D-- >8 ---
Subject: [PATCH] revert: config documentation fixes

43966ab315 (revert: optionally refer to commit in the "reference"
format, 2022-05-26) added the documentation file config/revert.txt.
Actually include it in config.txt.

Make is used with a bare infinitive after the object; remove the "to".

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/config.txt        | 2 ++
 Documentation/config/revert.txt | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e284b042f2..e376d547ce 100644
=2D-- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -495,6 +495,8 @@ include::config/repack.txt[]

 include::config/rerere.txt[]

+include::config/revert.txt[]
+
 include::config/safe.txt[]

 include::config/sendemail.txt[]
diff --git a/Documentation/config/revert.txt b/Documentation/config/revert=
.txt
index 797bfb6d62..802d6faca2 100644
=2D-- a/Documentation/config/revert.txt
+++ b/Documentation/config/revert.txt
@@ -1,3 +1,3 @@
 revert.reference::
-	Setting this variable to true makes `git revert` to behave
+	Setting this variable to true makes `git revert` behave
 	as if the `--reference` option is given.
=2D-
2.36.1
