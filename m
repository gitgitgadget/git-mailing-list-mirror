Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E994AC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 13:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19672063A
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 13:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eZFD2Orf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgAaN4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:56:41 -0500
Received: from mout.gmx.net ([212.227.15.15]:33945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbgAaN4l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 08:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580478997;
        bh=hKkFiYZBTOE+LaF3/3Utq5E2CdhKiPxxt8bmyJQuNTM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eZFD2Orf1mHkOOTZi1i9IO32FjBi4/98osU6Ajk8DJ/l2B46WIr2MLcDK8X0ZKbY6
         mY0PPvAd5ftKaik4cWQBsMyj2zQmQBkqiwk5NcoeVlCrGe6/yUM0KHNWTvA9x4s7Ui
         YVv6+cPQv2bzavYW2Ze5dPkvUFMvZ7CYPv4vobm8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1jG1H41FKt-00IWp3; Fri, 31
 Jan 2020 14:56:37 +0100
Date:   Fri, 31 Jan 2020 14:56:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Masaya Suzuki <masayasuzuki@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: describe Git bundle format
In-Reply-To: <20200130225818.193825-1-masayasuzuki@google.com>
Message-ID: <nycvar.QRO.7.76.6.2001311456220.46@tvgsbejvaqbjf.bet>
References: <20200130225818.193825-1-masayasuzuki@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XMyODFG0v3mtnUHeqNyiHw8pjfheBEiDyxKRn2UvVMnv0PNQRNS
 5734829Qws8aw2N9fJMl/fwIcb6Du7zcJVyrIM/4VPxdkYSKZPGPOvd31ibi5PZGPsa3m1+
 Y7UsMhdpe55KghqfICmKZWa8bA2H0iCqWw87PhK//x+W5gmzQ20DNpHYfcvv23Hr6wEk1vs
 A02Oxok/qfQ2ktbjdVJIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YujymH4aYoQ=:E0yWs20h5J1/G/92cyWgQ7
 cMHc9RggPh8Iie51N1gDMNj7DIllMPckBqu99ADsBrbHnmE7aQi8fmIXOwGonZexw/GotTwn0
 2pfHuN7lCrw3uxPkRAqEmayZkbcbzMP5npEq+Y30hapun9OFMopmsW6tDZ9IhLDvTerGfa4jJ
 zIFGuWunqAVhP+iRWGpQRd0uTSjQKsEGf4cjvAjb6/gqrYX60kqKxhjvx5zL2AO9dOY/BqeG0
 T3UefSxD0X/eQrjrRTvRDwtp+W/Oxn5vjoDLyPmlMqVs1JVpKUCa6h0D5OFpjRyWD/8f8epLY
 fYos0V3YWvJ5RFwIIuZOFIAhgnWYxP/Y5HLfjdb2NMAqWh/o0PUdPAgZlKTDkQoQh8LQjf8t8
 Zz14uBn/RI2qP9VdPFstVWQG3uK1ZDE4n1/szOf7GSe+Nlym8rTpCeO03vt2JaLgfbQGfryzB
 k1Vty5SWTuoofsGsR3MR8btuV/uP6vIjvTcNAfdf8qVE9aaRp1Lja7wfhode+YL+8HpH7EIE+
 egiJrksj8+IsSlLnZoydq7dYF7D6t6JRydRWYLg3Q7HKvQfbPEMuXu+OMTkZkC1r9E4ZTUmP9
 T5V9e4yr7QpN/+S81JPTG/r/gW9ECiLOFqhAKLcdDZiJUvce5xZ4yo/S5qxSvLd/nxv101txW
 zGvStd9IbAu7UfPSByETdQxag8060rwc70tFD6QM+dEURT0h9NwJ531ZXk8K7iQ5RAxca/oao
 CtzNejlzNNatsOdEGnEb2xjBTMJiCdshBnE898nXQKLCMlhQRKeu8iQe+xjcIHqNj7IywWU2F
 6x7u6BRLsev3L8DWsipWzOOb2PxSwwy9/ImC9ucFEbwF7aDto/ZgIZSsLKVq8pSCEgn3uLqAa
 TINvstMKSALlEVBdTf7OJTSgUQ58LQadfXUcFLzS6XnVa6KdS/mci9cLNn1nIjZNgCfMGv4bS
 aIHw7nqtRzU2felk+sTVb/7vaSjOjBxunSVM2Sz9lk8RHTGuCwNoSUJAKPAWs4s7L0jyXiq3I
 gafnXluSM3xExwzd1MWBWjK57PNMwXIvgsGIlPtgzUsJSoloaYWPVGtwt1pW6XmNrgCu4oUFp
 kZ974wM1n0LuyXvF6GhZ+q+MnbC9mCCvhIkBYwsHBJp/KYupHdflxYj5oy3lDA7Q4JXj32Mnz
 2FBOpbQi4ISW2SkDiN/Mn30rSk+sxxwgAa8qt4p8t40/n5GoA5ewyW386mIVaRDQz36iWkwga
 KVib1VHEQWchntAPt
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 30 Jan 2020, Masaya Suzuki wrote:

> The bundle format was not documented. Describe the format with ABNF and
> explain the meaning of each part.

LGTM,
Dscho

>
> Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> ---
>  Documentation/technical/bundle-format.txt | 40 +++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/technical/bundle-format.txt
>
> diff --git a/Documentation/technical/bundle-format.txt b/Documentation/t=
echnical/bundle-format.txt
> new file mode 100644
> index 0000000000..dbb80225b5
> --- /dev/null
> +++ b/Documentation/technical/bundle-format.txt
> @@ -0,0 +1,40 @@
> +=3D Git bundle v2 format
> +
> +The Git bundle format is a format that represents both refs and Git obj=
ects.
> +
> +=3D=3D Format
> +
> +We will use ABNF notation to define the Git bundle format. See
> +protocol-common.txt for the details.
> +
> +----
> +bundle    =3D signature references pack
> +signature =3D "# v2 git bundle" LF
> +
> +references   =3D *(prerequisite / ref) LF
> +prerequisite =3D "-" obj-id SP comment LF
> +comment      =3D *CHAR
> +ref          =3D obj-id SP refname LF
> +
> +pack         =3D ... ; packfile
> +----
> +
> +=3D=3D Semantics
> +
> +A Git bundle consists of three parts.
> +
> +*   Prerequisites: Optional list of objects that are not included in th=
e bundle
> +    file. A bundle can reference these prerequisite objects (or it can =
reference
> +    the objects reachable from the prerequisite objects). The bundle it=
self
> +    might not contain those objects.
> +*   References: Mapping of ref names to objects.
> +*   Git objects: Commit, tree, blob, and tags. These are included in th=
e pack
> +    format.
> +
> +If a bundle contains prerequisites, it means the bundle has a thin pack=
 and the
> +bundle alone is not enough for resolving all objects. When you read suc=
h
> +bundles, you should have those missing objects beforehand.
> +
> +In the bundle format, there can be a comment following a prerequisite o=
bj-id.
> +This is a comment and it has no specific meaning. When you write a bund=
le, you
> +can put any string here. When you read a bundle, you can ignore this pa=
rt.
> --
> 2.25.0.341.g760bfbb309-goog
>
>
