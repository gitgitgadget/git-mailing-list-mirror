Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328BF1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 17:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbdGaRnU (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 13:43:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37865 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGaRnA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 13:43:00 -0400
Received: by mail-pf0-f193.google.com with SMTP id 72so6545137pfl.4
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+8xCKMExGaJo3gaj+qrL7+u2dsAGpBD5Pq1NZ9Zv9lQ=;
        b=k8uOClbJlIH+67QbBWhGuV84+qvwhlR5Wp++NyWpSn6+Ngvdi2TKodK0GdhT/O6fgI
         MXk1i1r9OMv6T5ZJRNai5pkYxYyZAiwNZA0YR4CNztgpqbPrTP3YK6xIsnfq7+/bbysK
         fSok0OF2SCt297lz1+uNFJG9g0Xtp7ToPalLCmjBJkO7vuv0rPqhYLq3a2y7NDKMQZf3
         J8hR6A+6Cr8Rb6EFKlZbhFjR9l5zMe0WpIck71ZenK8mvQRajTx8Mz0rkX9yxcCg+X0t
         F7dLbUieB8iUeV2M/DPAqZTuJpHa3dezj+chXcZzbgFpyggouFJag32HDkbMmU+Wel8j
         DloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+8xCKMExGaJo3gaj+qrL7+u2dsAGpBD5Pq1NZ9Zv9lQ=;
        b=GuDSzks13EjFqBSzsOoIOHZtZvsWE/dDZuajT0TkaOMOc/AqJzzRrysAmHP2bj/1RN
         xeObhyBgz9r7kOW7DDccs5hCUpFvnsHhOBgSYHK5+KMCYS5FkgjUerjoWMcmN7hbFrLk
         VQ564B+28tkp7Zar0kfqIvF/49I1mzzdlOLtqlcLDVaXkmPr7pc7V1ctK9E/KS7HZbLE
         Y0O3KF3g7bjebAWUHkXz2UFmGwK2nFfbAGuMIiwo0YDuNxF9WzbxTv9I4vlE84vrDhuj
         WUcITHlCWXXef10b9y9bjRZuHlRnTbLBp73LXxKKFSYfDBYHLmMlEggs91ZLoQM0xZ9K
         IXJw==
X-Gm-Message-State: AIVw110QrudaQES58rQG2HsomCzx9Cop+77zUce9prK3FdeqT1IPtk0x
        JZPuyw9kkwC+c6aEnn9dzuPkF+n+TQ==
X-Received: by 10.84.224.77 with SMTP id a13mr3056705plt.43.1501522980128;
 Mon, 31 Jul 2017 10:43:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Mon, 31 Jul 2017 10:42:59 -0700 (PDT)
In-Reply-To: <20170731034507.2fdjnvgzzt4rgvas@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com> <cover.1500321657.git.martin.agren@gmail.com>
 <fa91f778e1acff812ddadb313e9979c470edc43b.1500321658.git.martin.agren@gmail.com>
 <20170731034507.2fdjnvgzzt4rgvas@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 31 Jul 2017 19:42:59 +0200
Message-ID: <CAN0heSr0RFAuRhw9UQaewWWtHv7=EMXqHyMBOD7ARrpM=P1-Qw@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] git.c: ignore pager.* when launching builtin as
 dashed external
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31 July 2017 at 05:45, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 17, 2017 at 10:10:52PM +0200, Martin =C3=85gren wrote:
>
>> One could address this in run_argv(), by making the second call to
>> execv_dashed_external() conditional on "!is_builtin()" whereas a builtin
>> would be started as "git foo". (Possibly after unrolling and cleaning up
>> the "while (1)"-loop.) That seems like the wrong fix for this particular
>> issue, but might be a wanted change on its own -- or maybe not --, since
>> it would mean one could relay, e.g., "-c baz" to "git -c baz foo" (but
>> only for builtins...).
>
> We shouldn't need to relay them. They get added to the environment by
> the initial "git" invocation, and then are available everywhere (in
> fact, it would be wrong to relay them for multi-valued config).

Thanks for explaining. I did some very sloppy reading of the comment
in git.c that we "cannot take flags in between the 'git' and the
'xxxx'" which I somehow misunderstood completely as "we cannot pass
that sort of information to git-xxxx". Silly. Thanks for taking the
time to explain what I should have found out myself...

So yeah, I meant the above and not this:

> Or did
> you mean that we could potentially allow:
>
>   [alias]
>   foo =3D "-c baz some-builtin"
>
> That's interesting, but I think the fact that it only works with
> builtins makes it a bad idea. And you can always do:
>
>   [alias]
>   foo =3D "!git -c baz some-builtin"
>
> which is equivalent.
