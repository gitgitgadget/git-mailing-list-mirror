Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A43FA1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 22:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbcJKW0R (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 18:26:17 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35400 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbcJKW0P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 18:26:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id s8so1372586pfj.2
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tz5eU1PmTnDjFrSzYI92nFDMUBH+fL4UiVzvttzbjKE=;
        b=F3H7nKJR8am9dkM9vjKYOh1vOdCZD9Uhwlst09HJgRvYLINdxiE+2aPedVJ3AKT82l
         aVcYMFsfM9OtsezhHDnKK93bYZA6EuE1voH94lCUH/ztaqIia6Inmfu+ES56hnyZ3qAp
         uGITlWZLheN3CxEVHgu/Abykp3svnmOKOOfTaXpmV8msQ08eoXaLxF6Y3PLYTgcQUq87
         Y1I4PsILu8JFzE6WG4PJQuneZUWpINR6S3CE1otcsYVUv5IlaFdMKfH+J95AwaHWva9+
         JNXg7i2hsBcX+XlLFDbVeI9qga7NkkTQuaO2IpT8ThwbSnyqsUuvFJpQgpw3nXOqbd7M
         rtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tz5eU1PmTnDjFrSzYI92nFDMUBH+fL4UiVzvttzbjKE=;
        b=dDKZo6TXseiY0gY3NAL99We+0ZC9FZLIk+u2XbjkGgupjfCFOL7k3HjQ0wzFik3fCK
         nPKr7K999cJRtC6i685V1z73EkRsArEMHCfBn5T22zSZHRl/bmtyCejmB1r3fLJdke71
         HghaNmwKLg3nbmlHziC+IIdz72Dg32u8FmG17umdrsSfRpSK+jpwePhiKNNVts1N6eq4
         bCAFF8CeTGBEczGoUlVfbgfBHRt3L6sQ+We9aQu44bzhNXTCzoPJ2XXSnYBs96JtplxV
         d7WZY7r4xM0GV3d3Omlx3LgF0NJO00wkXKGIBvAOzIKV2atifal1myDAMi+DG7+CmSca
         mnMQ==
X-Gm-Message-State: AA6/9Rlb6Q7xY1tBImLGCVbYDz6Bxcnlhk1dSUGssKNDmvEkf7QABygWkxK2KJLPck8s1w==
X-Received: by 10.98.205.207 with SMTP id o198mr365185pfg.114.1476224761882;
        Tue, 11 Oct 2016 15:26:01 -0700 (PDT)
Received: from [10.80.3.199] ([209.37.102.131])
        by smtp.gmail.com with ESMTPSA id e6sm6669561pfb.57.2016.10.11.15.26.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Oct 2016 15:26:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 13/14] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <a80f6399-b344-b979-d849-1dc7f899fabe@web.de>
Date:   Tue, 11 Oct 2016 17:29:07 +0200
Cc:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7ED32498-0757-4499-93AC-DC9116738799@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com> <20161008112530.15506-14-larsxschneider@gmail.com> <e09a63ee-dad2-a8fb-e47f-0559d9507e1c@gmail.com> <a80f6399-b344-b979-d849-1dc7f899fabe@web.de>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Oct 2016, at 07:32, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> On 09.10.16 01:06, Jakub Nar=C4=99bski wrote:
>>> +------------------------
>>>> +packet:          git< status=3Dabort
>>>> +packet:          git< 0000
>>>> +------------------------
>>>> +
>>>> +After the filter has processed a blob it is expected to wait for
>>>> +the next "key=3Dvalue" list containing a command. Git will close
>>>> +the command pipe on exit. The filter is expected to detect EOF
>>>> +and exit gracefully on its own.
>> Any "kill filter" solutions should probably be put here.  I guess
>> that filter exiting means EOF on its standard output when read
>> by Git command, isn't it?
>>=20
> Isn't it that Git closes the command pipe, then filter sees EOF on =
it's stdin
>=20
> and does a graceful exit.

Correct!

- Lars=
