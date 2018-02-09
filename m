Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 258891F404
	for <e@80x24.org>; Fri,  9 Feb 2018 03:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeBIDQE (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 22:16:04 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46182 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeBIDQC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 22:16:02 -0500
Received: by mail-qk0-f196.google.com with SMTP id d144so1562105qkg.13
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 19:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=T4b52600MzvzlteMNIAqRK3AZ0PuIwXQ6C/CIVQbp14=;
        b=r9hkrHKI28nEWoGMun9kyl74gdgag3YzkC0cuiOnACITs9uQi9ua/MkLaQZ3NnEdk1
         blwEBnAktWtHRDTiVASdj4iaPvE3dtdqoo9scSIQxf+1uSToyBr68oPotQGJEAVhpg8H
         jLqjieqSpRJtA4fMTk1r7MEWf/CwNHgxDge3MelwXkFHjaFpXNHsZ7VSGJwE6IGaHmdb
         TB6iGlni01ycmyfL/C0AP3I3WAqa4RaGycEuOLZ4zmZ1+E5S21hqU53bOga35CsIV4/L
         bGOsWwpcc41Mh4D4DL0AN1syp6lHbCT/IG68uCwEH/UGQvuJ8QCwJMeJ1UZcq10tppKi
         qK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=T4b52600MzvzlteMNIAqRK3AZ0PuIwXQ6C/CIVQbp14=;
        b=D+fhD1836aOp75fPqfy5xD76mZME7LUOJuG2YzqSzk1EIuJyG8pEBvAv3ItmJQk7wu
         +asvnVDzYCzwiQEz6i6z+pHt9sDv8Uzl6D7GrOktJvOJOsGqfYwMd7uf8aR8Yltzpw7D
         Xroyvi8zOZP+BNVCiUQYLUYA934Feh9u7BhhU7+GbI7kjcec51gpn7jXLZDo7AeGzmJH
         SF/ZU1i8UtHtY4ICPzpFyfKkSs87GV60PQGlqhlx7UPktIdCuDoWF5gIbif01/5nxwRV
         uB/kFN26R8O39G0B6fGiEG5HVorfrSeSzbR0af9gxFojCTlQXcQZURiZzukGg/TlEACF
         J0WQ==
X-Gm-Message-State: APf1xPCopIvDlu6Jo1CwmZsoFp2mF3tcg6+ElEO8ZnQvwYgUjBiJAYGe
        K8kC+4lvRT3U5kRD1TdqA4S8/EOvl0tByROUIII=
X-Google-Smtp-Source: AH8x2261DSlpMp7cYS0dynXnQLS8QwWB654hErXn8cQJsU7q4fUe7q4cgTvvEY4pgzB1tLtXV91VcdSD35p91EqFJbw=
X-Received: by 10.55.221.198 with SMTP id u67mr1923509qku.91.1518146161948;
 Thu, 08 Feb 2018 19:16:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.133 with HTTP; Thu, 8 Feb 2018 19:16:01 -0800 (PST)
In-Reply-To: <20180209024235.3431-4-szeder.dev@gmail.com>
References: <20180209024235.3431-1-szeder.dev@gmail.com> <20180209024235.3431-4-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Feb 2018 22:16:01 -0500
X-Google-Sender-Auth: pwNosn6o1TC0MKzbpC5Nnznt2rU
Message-ID: <CAPig+cTtC8WaqJg301WE+EN2RYzka-+pOoJZNZFzjqsHtx+M-Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] t1404: use 'test_must_fail stderr=<file>'
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 9:42 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> Instead of 'test_must_fail git cmd... 2>output.err', which redirects
> the standard error of the 'test_must_fail' helper function as well,
> causing various issues as discussed in the previous patch.

ECANTPARSE: This either wants to say:

    "Instead of <foo>, do <bar>."

or:

    "'test_must_fail ... 2>...', which redirects ...
     causes various issues discussed..."

but fails to say either.

> With this patch t1404 succeeds when run with '-x', even with shells
> not supporting $BASH_XTRACEFD.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
