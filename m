Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224111FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 19:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbdBMTcz (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 14:32:55 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35613 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdBMTcy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 14:32:54 -0500
Received: by mail-vk0-f47.google.com with SMTP id x75so67183326vke.2
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 11:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=882JOqWtAhpYXLPq3dimzdgV1s1iP7VbOtX4SsLIJQs=;
        b=OxpYKpLPLdq8XyDhZt398CgVNm2MA96U64tavtf74qQYXRLkx1/vrpwnvRCNgeSHOq
         6cSu037o3Ui/02ltJW9JvmMMB6ytcd+6qB+l2/lH9HZ4SZNMazlfxzNntJHMsLZw+QM/
         Xe08K/qhab/VvyGyr9tlQ9ikGmQnuf5pDxhG0OFHXUPZoAo1SpXRY5ErdOmbfMEwNKeW
         b15vJc8cj20PPgCqNkMiUIMssT0uqNEi197CWx9H44dLg15mPmYxLl2e2jddrapDzumU
         n4Mnz4Iiw+diTfWUG0IcN+1f4ToQGqyy5G4GIfD+dRiJE78xIcd8xPKQiptt157kU7iG
         YUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=882JOqWtAhpYXLPq3dimzdgV1s1iP7VbOtX4SsLIJQs=;
        b=MbJCeHpHyO42uZRxso5u3wKeNP2sz5bcclSwwnNG/LRAzVINNwVloN1+g37ncRhbvU
         eIHA4/iOwx0oU9RJqLZSo/2l593JwwS+nPbcYiYMjAFwApuGq3KFbpJ7QjBh4tmqKtFF
         r8j4WuEbAxR/QpQ0EKkVMijNYenyDdz5h1qB3yy7rhOSZSPhbz3zYn0a6eGLu9+UJUTE
         0J5ils7rMoMM2Xr9apGqmprJ3QU8ttImscFuQcjImJLmB5pfKSbl0otY0mhWh7EXfEMl
         jxKrbUUox6djt/WcS/8c2awmE0dWKDELpSC0YeqTsV43ikbVpAnYWNvgjZJpw75FJBYT
         5nDA==
X-Gm-Message-State: AMke39nK164O9Rz58wp4TrIFB7EKM1uT3J6wgpbJusy5sts7soC42P//k74d3S+vlQFW3mCad9nHIpa3DEx/YQ==
X-Received: by 10.31.33.200 with SMTP id h191mr12030556vkh.0.1487014373225;
 Mon, 13 Feb 2017 11:32:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.22.131 with HTTP; Mon, 13 Feb 2017 11:32:52 -0800 (PST)
In-Reply-To: <xmqq7f4xk9es.fsf@gitster.mtv.corp.google.com>
References: <20170203025405.8242-13-szeder.dev@gmail.com> <20170206181545.12869-1-szeder.dev@gmail.com>
 <xmqq7f4xk9es.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 13 Feb 2017 20:32:52 +0100
Message-ID: <CAM0VKj=Pai0fL7KtMdv1sg3N2KA1aBafGQ_XzXWKUsBmo62ZoA@mail.gmail.com>
Subject: Re: [PATCH] squash! completion: fill COMPREPLY directly when
 completing refs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2017 at 10:44 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Should I expect a reroll to come, or is this the only fix-up to the
> series that begins at <20170203025405.8242-1-szeder.dev@gmail.com>?
>
> No hurries.

Yes, definitely.

I found a minor bug in the middle of the series, and haven't quite
made up my mind about it and its fix yet.  Perhaps in a day or three.

Regarding the 'strip' -> 'lstrip' 'for-each-ref' format modifier
rename that broke pu: I should keep using 'strip', right?

G=C3=A1bor
