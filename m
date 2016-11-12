Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 148072021E
	for <e@80x24.org>; Sat, 12 Nov 2016 13:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965674AbcKLN6B (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 08:58:01 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37025 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965294AbcKLN6A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 08:58:00 -0500
Received: by mail-wm0-f51.google.com with SMTP id t79so24952798wmt.0
        for <git@vger.kernel.org>; Sat, 12 Nov 2016 05:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Uesd+ey/ekN6dPP7r4e8dhNyTMHUSKTMsRijGzFSIbA=;
        b=LUfL+fVp5XKTk5trXq1Lyghl8w0PsEZ7NG0AbcwvqsyCi6j9iADDv90Z14M3rsYhOD
         vSB3IUbLNZcz5coR4b1cma8rrn6Fte+nFUPruHYBnfyMejFAmRT5lp6c9f5a4KUyrJHv
         l8IeTusCPyH4xrcRyom0T3qy3e3hvcdJK9PET3T63sXGSCKBx5saOIF15rjzbxfOcd/r
         81d/kBT7a3Qo6k2rR6GByUF/ndhH5VagtY1vY+P79/2aK+BD5GL3KNZ4uCw3aFzLTsYg
         T68+zUyua8GK9ZgEu4JxkE6x4+vsl3ipVFXpRz1+9UQutQNjr03wBwiFEFHJynIQ7OvY
         Wa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Uesd+ey/ekN6dPP7r4e8dhNyTMHUSKTMsRijGzFSIbA=;
        b=aXtJXhpWG0X3TT5I+06nccaAVRHL6cF4uZPgBhQ30QuRsTOm81YF7MrIDUugJg1XIc
         sQHXFSpDTRdGRUOD2M8Mklssr79LsF7m/ei46J3peFxFSii8pS6SVcNCnclZw7PhWvH6
         uBrXjVy9h6HLtYgR0jdNQ1SBn4fFZrGTz4NnP6+z5HiMPYrsDkdHdHVtjqjHjUUVtWbt
         Vg9pfPmZjdje86EpHqh3CnhNkuKXbOflbE40DcQVwsP2Oc8DOGN8fRWYf7iz4bnFy4cS
         e+puWyNq2O/m18sd8iBj953g47C8fcK5PVSXcCXWYtYLvEiNMfUoay8xPAgoMIyOHhee
         fKhw==
X-Gm-Message-State: ABUngvfNca9AMhLlelTJ4uT74ABzJg+KzjP9E17bHvcQG1B5LIcIzp0Eba0SCBUaVHfGEg==
X-Received: by 10.194.200.39 with SMTP id jp7mr16215689wjc.64.1478959078916;
        Sat, 12 Nov 2016 05:57:58 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5438.dip0.t-ipconnect.de. [93.219.84.56])
        by smtp.gmail.com with ESMTPSA id za1sm17282602wjb.8.2016.11.12.05.57.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Nov 2016 05:57:58 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC] Add way to make Git credentials accessible from clean/smudge filter
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161111202710.7zpalypsnorqeclq@sigill.intra.peff.net>
Date:   Sat, 12 Nov 2016 14:57:56 +0100
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        git <git@vger.kernel.org>, me@ttaylorr.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <83393B7B-E429-46AE-BFE6-F1D5C2A6D4C5@gmail.com>
References: <4C8C5650-7221-4F62-A9CC-81AE01EF6DC7@gmail.com> <vpqoa1n1qom.fsf@anie.imag.fr> <20161110160809.2gvf67rlnvounulf@sigill.intra.peff.net> <77603924-3552-4146-9C9E-A106CFA96D7A@gmail.com> <20161111093122.osbdwmze5x5t742v@sigill.intra.peff.net> <4060C484-B42E-42AB-BB42-4753373F0E7F@gmail.com> <1478894572.12153.1.camel@kaarsemaker.net> <20161111202710.7zpalypsnorqeclq@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Nov 2016, at 21:27, Jeff King <peff@peff.net> wrote:
>=20
> On Fri, Nov 11, 2016 at 09:02:52PM +0100, Dennis Kaarsemaker wrote:
>=20
>>>> Are you sure about that? If I do:
>>>>=20
>>>> echo url=3Dhttps://example.com/repo.git |
>>>> git credential fill
>>>>=20
>>>> I get prompted for a username and password.
>>>=20
>>>=20
>>> Hm.. either I don't understand you or I expressed myself unclear.=20
>>>=20
>>> Let's say a user runs:
>>>=20
>>> $ git clone https://myrepo.git
>>>=20
>>> If no credential helper is setup, then Git asks the user for =
credentials.
>>> Afterwards Git starts downloading stuff. At some point Git will run =
my
>>> smudge filter on some files and in my case the smudge filter needs =
the
>>> Git credentials. AFAIK, the smudge filter has no way to get the =
credentials=20
>>> from Git at this point - not even by invoking "git credential".=20
>>> Is this correct?
>>=20
>> I think that's correct, but the same argument goes both ways: unless =
I
>> use a credential helper, or explicitely give a filter application my
>> credentials, I don't want a helper to be able to get to those
>> credentials. I'd consider that a security bug.
>=20
> Yeah, agreed. They are logically two separate operations, so I think =
it
> is a feature that they do not implicitly share credentials.
>=20
> I think the only place where we implicitly share credentials is when
> serving an HTTP fetch or push requires multiple HTTP requests. And =
there
> it seems pretty sane to do so.

Agreed. Thanks for your thoughts on this!

- Lars=
