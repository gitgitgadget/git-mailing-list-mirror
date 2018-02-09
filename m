Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 153251F404
	for <e@80x24.org>; Fri,  9 Feb 2018 03:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeBIDLO (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 22:11:14 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40728 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbeBIDLN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 22:11:13 -0500
Received: by mail-qk0-f196.google.com with SMTP id e20so8390467qkm.7
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 19:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=7JRbb19wvAg5G/EKAQnSuFkRpUmT5/BXNQ3lieTUTAk=;
        b=feG1lrJAqvuL3WNv0zZtjtd1OHt8LeBHAsB11BKg5X0IoVbnHebuz6eURYhazhD+2M
         0mXp3arLKNUvh6grscK0vScZ3chakC5CZerqjlpHDSy5E+yGYEkIXMJa/DUf6WZiB0s3
         Ru/+JeWdwcmRZc/j5arvOG/GY2/ZOGcpVYO52DSrQGlaSB+bXr8ofaFUXxn2nul1I+NN
         4c36SudejW6S9GUAmwbDCm6dWKC+vrPffdh3pTC5WUvGHmhrowTSV4yGB0krozSeyH66
         LLRR4iEfCuqpRZEcaIAXpBqhBObH7ups+3We2x3p45O6OnEYbojTHaR95pm1B8kYuFgc
         tmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=7JRbb19wvAg5G/EKAQnSuFkRpUmT5/BXNQ3lieTUTAk=;
        b=bMQkrvXyFP0ePfHUF8bNY7uT5ug1jGASwnsTtWvXFaf4Ip5caikdbhMrD1jV838SEi
         OuVqZm7GIBgZRZDOXzJ80XduMbFs2MHRJi6H/UAe7Vq8qKv6wOaVvc3LF+rhONCE68tF
         vkjvoJa3dPp7Cr53NO/2TJJEZf0TK8OL+3IFhQhFhzKa+kk0PdbhqrU1PSTUATh6PwQu
         hjzqjMGKo2iI4Qj8zqY8nZLN0iJ0mt+1jONVnAwSuh2q0jH6IkiDhoEMx9DwL2ewCUEP
         CYNKh7BEQPJuIIuUrQt+ey+ai9CO1K/aLYni3rO20xB333QX1WyFgeEFZRigbc0hCSYv
         gtVw==
X-Gm-Message-State: APf1xPBi93T/PVJlUI86BntNPL7R7pfZTmGCs7MGtLBvaksL1OqG5CTS
        AZeNBqOzMGvEfJk+Vt7kNgAWSTlzxP3x0P+jZgg=
X-Google-Smtp-Source: AH8x227i9U0IqHNKQl9PaGb9EdfyVVsJRRIRlUXL2pyUEEHP50CMeLIbSiNdld2Lv6/Rznh4gun1EzQMKd6qouiAQrY=
X-Received: by 10.55.187.135 with SMTP id l129mr1948135qkf.322.1518145872356;
 Thu, 08 Feb 2018 19:11:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.133 with HTTP; Thu, 8 Feb 2018 19:11:11 -0800 (PST)
In-Reply-To: <20180209024235.3431-3-szeder.dev@gmail.com>
References: <20180209024235.3431-1-szeder.dev@gmail.com> <20180209024235.3431-3-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Feb 2018 22:11:11 -0500
X-Google-Sender-Auth: hzfbZDasMrFSM7fxM2NyaDxbBG0
Message-ID: <CAPig+cRUqwOMuv60FsN7Xm1iqnkBBPRP8wW+JpCXTfi8vOHbew@mail.gmail.com>
Subject: Re: [PATCH 2/3] t: teach 'test_must_fail' to save the command's
 stderr to a file
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
> To check that a git command fails and to inspect its error message we
> usually execute a command like this throughout our test suite:
>
>   test_must_fail git command --option 2>output.err
>
> Note that this command doesn't limit the redirection to the git
> command, but it redirects the standard error of the 'test_must_fail'
> helper function as well.  This is wrong for several reasons:
>
>   [...snip rationale...]
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> diff --git a/t/README b/t/README
> @@ -430,6 +430,10 @@ Don't:
>     use 'test_must_fail git cmd'.  This will signal a failure if git
>     dies in an unexpected way (e.g. segfault).
>
> +   Don't redirect 'test_must_fail's standard error like
> +   'test_must_fail git cmd 2>err'.  Instead, run 'test_must_fail
> +   stderr=3Derr git cmd'.

Perhaps not worth a re-roll, but it might be nice to cite a bit of the
rationale from the commit message for the "don't redirect" rule since
it's not necessarily obvious for readers of t/README why this
limitation exists (and it seems unlikely they would check this commit
message). The rationale here doesn't necessarily need to go into
exquisite detail of the commit message, but could be perhaps as simple
as:

    Don't redirect 'test_must_fail's standard error to a file (e.g.
    'test_must_fail git cmd 2>err') since error output from commands
    run internally by 'test_must_fail' may pollute file "err".
    Instead, run 'test_must_fail stderr=3Derr git cmd'.
