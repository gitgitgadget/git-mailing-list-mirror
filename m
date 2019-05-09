Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 839881F45F
	for <e@80x24.org>; Thu,  9 May 2019 18:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfEISAb (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 14:00:31 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46575 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfEISAb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 14:00:31 -0400
Received: by mail-pf1-f202.google.com with SMTP id a141so2096619pfa.13
        for <git@vger.kernel.org>; Thu, 09 May 2019 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=lZmNgah7ZiHwZu0VOztyTEEez+7Zf2eSwCoqx6cVSBM=;
        b=K+BcddSYZ7pOLqnJyiAUD08nkPn3+GLhSMTnAItnoVwTR8X3uSNESszmpQRsmZA8w3
         uHdvpGjBTXQ8DwGeSQu+kqv5e8zc322ruDuSAU2XDCVNmDg4HThQKLzqgIvrCGELTL54
         B87aH2863KeohHq4J8CRnpzsYjRQwU+TTWJ4zhANH5CBfIPJQbOQmJOYce+yUhTxpVYE
         k4Bfibm43PojPyyLaE7Vxkgagq7tihYOTsLbHC21IIwhmS9zYxVtiu6tPOMTOT1CqdmZ
         V58KNJwyvvLZJEcedcvhBoZX87FBZ3rELP4wS0jG2WfmWqx7Aiv4OZm66A0DwkFMDnvY
         gViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=lZmNgah7ZiHwZu0VOztyTEEez+7Zf2eSwCoqx6cVSBM=;
        b=NJDIYODsYhMz7aeRE1TL/bkLeJmC999tc4Gl3fM1BJMNh6Zq/q52F5RONELtMhO8wq
         HZJnoUaGbhKLrIT0qwEB1Wd5jq+AJyildX///Z4hn2Tm7cBjGqmU4R0FiSfsuufP1nTu
         QTnnJ9GfBSvjXSD6tO2mnRlLQ2T1Ir7OFyR5hnPsP8lq2JwxTjCyMc9PZCCYT1xaBqN4
         F/QU8LvIOx6SgP856EKEqxnF6VlSUoDnMernkTBnJ0rxvSp2ecebocWUuMOxRfZRhKOT
         Jrk9wQGGMxmnhcSSzDwN2MoERQ7R7H+u5wraPzZY+wJWDQEN3X9CngaQo+D+MWrugWVk
         O03A==
X-Gm-Message-State: APjAAAXP5qw4V4W8qn6bosQX0N+Ae8RSzo/pLaOHfID5A+Wh92CNUZmw
        OwC+8dSfLGwihNKJgL9nW2kTCXfVsFlC1FRj4obt
X-Google-Smtp-Source: APXvYqyY5p8TxZefoWTVuRVS9vUZxDFIzxAtwDfYMy5m6tPgdKzPLacDY8z2T2CuQjgc85u1pl/INWvDX/78viNSslKG
X-Received: by 2002:a63:295:: with SMTP id 143mr7359126pgc.279.1557424830177;
 Thu, 09 May 2019 11:00:30 -0700 (PDT)
Date:   Thu,  9 May 2019 11:00:22 -0700
In-Reply-To: <A0ADEE11-E3E1-4DE0-81BA-40771C783E4E@comcast.net>
Message-Id: <20190509180022.91700-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <A0ADEE11-E3E1-4DE0-81BA-40771C783E4E@comcast.net>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: Re: Proposal: object negotiation for partial clones
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@comcast.net
Cc:     jonathantanmy@google.com, matvore@google.com, git@vger.kernel.org,
        jrn@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > On 2019/05/07, at 11:34, Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > To get an enumeration of available objects, don't you need to use only
> > "blob:none"? Combining filters (once that's implemented) will get all
> > objects only up to a certain depth.
> >
> > Combining "tree:<n>" and "blob:none" would allow us to reduce the numbe=
r
> > of trees transmitted, but I would imagine that the savings would be
> > significant only for very large repositories. Do you have a specific us=
e
> > case in mind that isn't solved by "blob:none"?
>=20
> I am interested in supporting large repositories. The savings seem to be =
larger than one may expect. I tried the following command on two huge repos=
 to find out how much it costs to fetch =E2=80=9Cblob:none=E2=80=9D for a s=
ingle commit:
>=20
> $ git rev-list --objects --filter=3Dblob:none HEAD: | xargs -n 2 bash -c =
'git cat-file -s $1' | awk '{ total +=3D $1; print total }'
>=20
> Note the =E2=80=9C:=E2=80=9D after HEAD - this limits it to the current c=
ommit.
>=20
> And the results were:
>  - Linux: 2 684 054 bytes
>  - Chromium: > 16 139 570 bytes (then I got tired of waiting for it to fi=
nish)

Thanks for the numbers. Let me think about it some more, but I'm still
reluctant to introduce multiple filter support in the protocol and the
implementation for the following reasons:

- For large projects like Linux and Chromium, it may be reasonable to
  expect that an infrequent checkout would result in a few-megabyte
  download.
- (After some in-office discussion) It may be possible to mitigate much
  of that by sending root trees that we have as "have" (e.g. by
  consulting the reflog), and that wouldn't need any protocol change.
- Supporting any combination of filter means that we have more to
  implement and test, especially if we want to support more filters in
  the future. In particular, the different filters (e.g. blob, tree)
  have different code paths now in Git. One way to solve it would be to
  combine everything into one monolith, but I would like to avoid it if
  possible (after having to deal with revision walking a few times...)
