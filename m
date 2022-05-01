Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B14C433F5
	for <git@archiver.kernel.org>; Sun,  1 May 2022 09:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244194AbiEAJjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 May 2022 05:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244866AbiEAJjE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 May 2022 05:39:04 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC3F1B79E
        for <git@vger.kernel.org>; Sun,  1 May 2022 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1651397718;
        bh=Qwvn/mGTRoWlcwjfNhTX4zGku4w65oLtLKUz5/Oc38w=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qAj8e/0y4ajuAyu2H25Zx2Pk+TD4wlIKbUDv2a5ni6WH5CKJYWBLkPuAFLLdsyGxB
         /3E9ziRs0V0iHvsdpCadvAE9osKZv7GZMKxp6K30gqzzzh6f3VgjMGMOurBUdWy1IA
         W7bJKnNXcYqRkH78cAcHfS0OgnG8FHLGq3nf4/OI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjET-1nNfY90ALv-00WuOX; Sun, 01
 May 2022 11:35:18 +0200
Message-ID: <6af1aed1-ab13-ee0e-e979-d2f826ec776a@web.de>
Date:   Sun, 1 May 2022 11:35:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] 2.36 format-patch regression fix
Content-Language: en-US
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Daniel Li <dan@danielyli.com>, git@vger.kernel.org
References: <CAHVT7hW28jMcphDPhcUG==mycCWDaAt46wWo68=oTcSvebHWwg@mail.gmail.com>
 <xmqqzgk388tt.fsf@gitster.g> <xmqqo80j87g0.fsf_-_@gitster.g>
 <c36896a1-6247-123b-4fa3-b7eb24af1897@web.de>
 <20220430163232.ytvwru4fnylow2jk@carlos-mbp.lan>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20220430163232.ytvwru4fnylow2jk@carlos-mbp.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1G0xw5JlrznYha7jKnl40DwfnPAv7WjJPhk8ucBq9o14QwH1V7D
 fT4wW+jqUKA+onMdN17LNCnCdjCanYRi7y8SCS5vjasqK5ylNXf/m14URS2tnaTbEOBCW8n
 de23NaYusqmiGz996U6FXNuXVg8D2UuC1s2I5seuM6GowPKCjfkWkIaK+eeLNYQ+x9wUBFV
 MB+Uq+adoZdzg1aRPkfNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ERxka9x0D8o=:us2R3IIbbGjDkU89qBcxbd
 V2kk8ut5Z+Dchwynbnae3E451rmTKE0NsJZB5gElUbiFvSRqD43aMbPcMY/wFcP+m0u3CkKL/
 OSWxSv0w3bZ7w3IbqKYavw6DwgqOIDEMlhSoaIf/8XqQeQ+C7UQS/Evb4zMsp+AcoCEaKqUYA
 lPfqQXd3g9E1JXojnzdLFqPDtRqz9fzhSpmtu+kyjkzeJZLGMALMjK4K8UCctgCBRV5Wln9e3
 C3I3FVI2zxqb6a2bzXoo+kpeRbcIsAQfn7MvmJZ37d8EvX+LuAPQTggNRJZGFXsz+Orpvjeb1
 q6D86lI5mzrlweGo1DZTIv/YcRYaZ7LEgWJpJLWs9i8CkPgcaCLEOXWugvTpD7kWJokHCKa2y
 k2Rtq4dMQwjh6uPzS08xUN+7cwpOYV0iBmowUSVXC6XdHJNKN7qliy6jpDqQO8hx7eeXZ8zBT
 Xq1NMsIz2y+NWAe6XZ+VSAfXAiKSFxly4yDKX+grZe1tSCbnL9o+jttkEfslgv5lb53CXuqkY
 O72o/vZwcJxVoqLvT2lta9ddPazG7P7xmgmvffsAPJ4bVOv8g6JiJjffiiAvLJI3O2m0Oiq0Y
 7Z+10kIiBFMZZ0XiIPd2VOjLO37iLw+3i82IQFygPYcb/0ErYuIF9E8X46ZZdQNu/uQBQZ7xb
 bypdmmUmJHJ/13FTBl4d+O406Qu22oqyHz0/CQxKlrOrzLQuwoTRCBYS7Myn8VoOrZoIlPElH
 LS2l2P+BYh3chsZ1L8ezpY9pqsb4DIwkXnV7yk4jfDuaKRKiJIfhZRWJnQdnvntYSvzybWqdk
 RUltVn4YN/IOXLZ7MsAmRqp/r8DsJKtsNLMrchhsY8Xl26eYa6vPNpI0e04Ao1ZRHpfQGtc9e
 Agl5xbQ6VMggF+6UGf6mULSwRvmi/8ISBeI9BpHNxUjGP3+W8tBoaUNXml0d0zBkPZzLsmje1
 Bm2R88CUVMpH6Nzy1rTMVANcDWYi4TTHW2AeYLTygFYTR8eMIAzOc/ryY+RHgNwiNDF4bl8yE
 PS6gR44YMQPEvypUKnC6+co2M9RBcfvaFO85x98TazJVUHcaK9g+/Npzsq/6bDvKRjAV81Pj2
 jT0GFFpVccMO+Y=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.04.22 um 18:32 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> On Sat, Apr 30, 2022 at 12:32:44PM +0200, Ren=C3=A9 Scharfe wrote:
>> e900d494dc (diff: add an API for deferred freeing, 2021-02-11) added a
>> way to allow reusing diffopts: the no_free bit.  244c27242f (diff.[ch]:
>> have diff_free() call clear_pathspec(opts.pathspec), 2022-02-16) made
>> that mechanism mandatory.
>>
>> git format-patch only sets no_free when --output is given, causing it t=
o
>> forget pathspecs after the first commit.  Set no_free unconditionally
>> instead.
>
> I remember when I saw the first commit long ago, and thought; well that =
is
> very round about way to reintroduce the UNLEAK removal that might have m=
ade
> it visible.
>
> Haven't looked too closely, but considering that we were warned[1] the
> interface was hard to use and might cause problems later and it did.
>
> wouldn't it a better and more secure solution to UNLEAK and remove all t=
his
> code, at least until it could be refactored cleanly, of course?

Silently self-destructing pathspecs are a safety hazard indeed.

no_free also affects freeing ignore_regex and parseopts, and even
closing the output file.  I don't know about the file, but leaking the
first two is harmless.  So removing the flag is safe as long as we make
sure the output file is closed as needed.

A safe diff_free() would only be called a particular diffopt once, when
it's no longer needed.  It could check for reuse by setting a flag the
first time, like in the patch below.  1426 tests in 163 test scripts
fail for me with it applied on top of the regression fixes from this
thread.

Removing the diff_free() calls from diff.c::diff_flush() and
log-tree.c::log_tree_commit() reduces this to just one or two in t7527
(seems to be flaky).  Perhaps this is still salvageable?

>
> Carlo
>
> [1] https://lore.kernel.org/git/YCUFNVj7qlt9wzlX@coredump.intra.peff.net=
/


=2D--
 diff.c | 3 +++
 diff.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/diff.c b/diff.c
index ef7159968b..01296829b5 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -6458,10 +6458,13 @@ void diff_free(struct diff_options *options)
 	if (options->no_free)
 		return;

+	if (options->is_dead)
+		BUG("double diff_free() on %p", (void *)options);
 	diff_free_file(options);
 	diff_free_ignore_regex(options);
 	clear_pathspec(&options->pathspec);
 	FREE_AND_NULL(options->parseopts);
+	options->is_dead =3D 1;
 }

 void diff_flush(struct diff_options *options)
diff --git a/diff.h b/diff.h
index 8ae18e5ab1..c31d32ba19 100644
=2D-- a/diff.h
+++ b/diff.h
@@ -398,6 +398,7 @@ struct diff_options {
 	struct strmap *additional_path_headers;

 	int no_free;
+	int is_dead;
 };

 unsigned diff_filter_bit(char status);
=2D-
2.35.3

