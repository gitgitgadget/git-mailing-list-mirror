Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4268A1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 15:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbfJAPDa (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 11:03:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43278 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfJAPDa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 11:03:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id u3so10139976lfl.10
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 08:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=O/NUSixmhZv1eJmZr4347macQhzc5+d6yySBspsWJXg=;
        b=idJpLIy0Ky5v6OWncOuBb0dXr4NHxMdSs1iz7st9uaFg2iKcb0myZ9vpcLp8upx3ef
         O3z1f9HBX9L+gqT8ulcebDSruJ7bMPvpadgm3rs55WHpqqsq84agZlCGX09e7xkWipGy
         aEi5c28TDbKKHxB+HDHmUNE7o9/Pxzr4W+G/bdl35L1KEDamYQLSZjQWtkm7FlDbMxxQ
         UspoIY42dwjjOWTcgGsyuphucmF3mAmAgWmagb0Rq365HJaCYW8Aszae5J9TqCbvfyiF
         VtYxXPG36JkiqG4mzgStxM1Gjl6hpSBiCuK5ml184roWSShAfKAB8dhTFukqmRiEtHkJ
         +Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=O/NUSixmhZv1eJmZr4347macQhzc5+d6yySBspsWJXg=;
        b=H8xw1YO+srEFPpgXIUm2fyAcdYg/Waa8Ac4cn254P38copbZCATp0mfEtPK2Mj30Zq
         /hWMW6Xl5LWET96m5AAonvi2b4Wp0oGqxkG1gXZ2GevJvQytRzXZdQcO/kdlgvgekcGH
         9YzzYQzDEV0GWZfjoYIAcoMVXklEdxg36rP8axPK6L67C6nUmdteMwOhyNzmrnd94Ccc
         gZdcBxUrl5030Hachyx0QPk8m7pQQ8EYb1Eg+N4KunGyqy1WlMGr3mvXlRdH1P+1v7Uy
         B2YhNsh9ywX1KMU0lYAdrBHC4zV6hFqNBQhe1vz9H4CbvrmJCM5zvHMdTxAhbZLw+0YA
         OOpA==
X-Gm-Message-State: APjAAAVDmVtg8SpIm9OTeSOE+wYaz6ZYFJERzW7XZESR4xK9WOcCnxNB
        MFRQsT7xtsSfYR30lliunO8=
X-Google-Smtp-Source: APXvYqwp5ogNONekfWlikxsTzaj8lkEmGqIOuMEdjxp9cUYtPXgECOoZQYYFZ85uji18wGx49vNr9A==
X-Received: by 2002:ac2:5091:: with SMTP id f17mr15373481lfm.107.1569942206854;
        Tue, 01 Oct 2019 08:03:26 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id y3sm3885906lfh.97.2019.10.01.08.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 08:03:26 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Mike Hommey <mh@glandium.org>, Derrick Stolee <stolee@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garimasigit@gmail.com>
Subject: Re: [DISCUSSION] Growing the Git community
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
        <20190919214023.hu3oznjcrzrsmpso@glandium.org>
        <nycvar.QRO.7.76.6.1909232316300.15067@tvgsbejvaqbjf.bet>
Date:   Tue, 01 Oct 2019 17:03:23 +0200
In-Reply-To: <nycvar.QRO.7.76.6.1909232316300.15067@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Mon, 23 Sep 2019 23:28:05 +0200
        (CEST)")
Message-ID: <865zl8pkxw.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> On Fri, 20 Sep 2019, Mike Hommey wrote:

>> 6. Newcomers don't really have any idea /what/ they could contribute.
>> They either have to come with their own itch to scratch, or read the
>> code to figure out if there's something to fix.
>
> I think this is very related to the "not only open the door, but invite
> contributors in" idea mentioned upthread.
>
> Speaking from my experience as mentor in particular in Outreachy, it is
> often not obvious to old-timers in this here project (including myself!)
> how intimidating even the idea of "scratching your own itch" is, and
> it can be tremendously helpful to even so much as seeing the problem
> stated by somebody else first ("Others agree with me! I need not have
> doubted myself when I ran into this problem, it really is a bug that
> needs to be fixed!").
>
> Additionally, it is no longer all that easy to come up with an "own
> itch" to scratch, as the most common workflows work reasonably well in
> Git. Yet, it seems that some users _still_ want to "give back" by
> contributing patches. Or they just want to see their name in the next
> version's announcement mail.
>
> To address both concerns, I started this little experiment a while ago
> (but announced it only during a Git IRC standup):
> https://github.com/gitgitgadget/git/issues is open, intended to
> accumulate possible project ideas. It seems to work reasonably well,
> there already have been volunteers who picked up on some of those ideas
> I (and Denton) listed.
>
> Hopefully this issue tracker (together with https://crbug.com/git which
> targets users more comfortable with that flavor of issue trackers) will
> help address your bullet point?

It would be nice to have those issue trackers announced more widely (on
the homepage, on the Git Rev News homepage, maybe also in docs e.g.
CONTRIBUTING).

For me, beside being the place where to find out some ideas on how to
contribute, would be having a place to put my ideas that I have not had
time to even start to do, like adding `git gui diff` (e.g. borrowing
from tkdiff) and `git instaweb --serve`.

Best,
--=20
Jakub Nar=C4=99bski
