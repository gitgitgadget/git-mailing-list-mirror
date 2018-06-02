Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5A041F403
	for <e@80x24.org>; Sat,  2 Jun 2018 22:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeFBWuS (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 18:50:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52048 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeFBWuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 18:50:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id r15-v6so8976133wmc.1
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 15:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tJ1a/KUm64KyXLK6dQ/A6FjyOwhnwIk/5T2q0zkJfQI=;
        b=fEBE7VqCYO/40tEGf0qvh9w0jkjPfQdKg/6LSF5HpONJHSb17B8yOL0bVhp9/FDok8
         v3je4vwwBwOma+bWM0+P61fSvnIUFkfdpVmRF3sQOsleYK4S7CBd5wqgCyenP/MdERcN
         lATcLARkrNbhBdY7MuTk62hETf7HfefJjAJX5QL+FdU91wEyWtjhsrxE5CptdFknbh4t
         aemO9gpBPECxRPTZrURDLcAAWk1hUc0dnEPV7/X2VOEw1LvA3lY5GA9l/1lFLHAkeJGr
         PC5WCTaNcM3M3h2DRkH7ASQddBA5PyjFDsKctGRjtPdO3eNB86Md8XD1z+VIcqeFt9MZ
         frHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=tJ1a/KUm64KyXLK6dQ/A6FjyOwhnwIk/5T2q0zkJfQI=;
        b=rAVPhPmBgbcS+yFjhZFtiYiJPITYL1ThC6g76Bo72H2PIpvSXjywuvEFVjASk8e3M2
         SqG2hOH8slZISC/TMLetM6fFnEziUJBgZjYVEY2vRyq9e6cwg/lgJnHXaEJbKMhcK37V
         bIpH06tXLLjpWWhaq4zn5WCjHFYLpKAvJqT70NRI5vSLTD7GN69FG+P5QdVoBPGbvKME
         /mumkyT9WSc3CP8GEDd7wvERP/w11qWF+8n7oHnWNDRJ6eYauAUv/oCw3FCxOge9UPKq
         2NuPzVRfaqp1CvSKfCrCGo6uCWfJ2huYJndXnKSeEW9aDDFYwzbCRyKdK0Afv7yqdzLu
         R3SQ==
X-Gm-Message-State: APt69E3UwAy5NO93vgPiz8TvxthG1GtV5h71JYuaN5Hjn3Kuy7CGwGTI
        WERxzklbW9BGM26IqNXnCbc=
X-Google-Smtp-Source: ADUXVKIY+4kWZ63uDpjYs3EEhWNjP+ldfmu4L6i9ub65dCmxxI41nuuF5YkoTQ0v84JpSLTVyUcOJg==
X-Received: by 2002:a1c:3710:: with SMTP id e16-v6mr1812218wma.58.1527979815858;
        Sat, 02 Jun 2018 15:50:15 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abri112.neoplus.adsl.tpnet.pl. [83.8.102.112])
        by smtp.gmail.com with ESMTPSA id b204-v6sm4829503wmh.22.2018.06.02.15.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Jun 2018 15:50:13 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 11/20] commit-graph: verify root tree OIDs
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-12-dstolee@microsoft.com>
        <86zi0gvl1h.fsf@gmail.com>
        <d59f5723-7fb6-56d6-af2b-b8263cfdf354@gmail.com>
Date:   Sun, 03 Jun 2018 00:50:10 +0200
In-Reply-To: <d59f5723-7fb6-56d6-af2b-b8263cfdf354@gmail.com> (Derrick
        Stolee's message of "Thu, 31 May 2018 09:16:59 -0400")
Message-ID: <86zi0cpzvh.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 5/30/2018 6:24 PM, Jakub Narebski wrote:

[...]
>> NOTE: we will be checking Commit Data chunk; I think it would be good
>> idea to verify that size of Commit Data chunk matches (N * (H + 16) byte=
s)
>> that format gives us, so that we don't accidentally red outside of
>> memory if something got screwed up (like number of commits being wrong,
>> or file truncated).
>
> This is actually how we calculate 'num_commits' during
> load_commit_graph_one():
>
> =C2=A0=C2=A0=C2=A0 if (last_chunk_id =3D=3D GRAPH_CHUNKID_OIDLOOKUP)
> =C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 graph->num_commits =3D (chunk_offse=
t - last_chunk_offset)
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 / graph-=
>hash_len;
> =C2=A0=C2=A0=C2=A0 }
>
> So, if the chunk doesn't match N*(H+16), we detect this because
> FANOUT[255] !=3D N.
>
> (There is one caveat here: (chunk_offset - last_chunk_offset) may not
> be a multiple of hash_len, and "accidentally" truncate to N in the
> division. I'll add more careful checks for this.)

I have thought for some reason that number of commits N was stored
somewhere directly in the commit-graph header.

Anyway we have three places that we can calculate (or simply read in
case of OID Fanour chunk) the number of commits:
 - FANOUT[255] =3D=3D N
 - OID Lookup size =3D (N * H bytes)
   - N =3D (OID Lookup size) / hash_len
   - (OID Lookup size) % hash_len =3D=3D 0
 - Commit Data size =3D (N * (H + 16) bytes)
   - N =3D (Commir Data size) / (hash_len + 16)
   - (Commir Data size) % (hash_len + 16) =3D=3D 0

>
> We also check out-of-bounds offsets in that method.

Good.

Best,
--=20
Jakub Nar=C4=99bski
