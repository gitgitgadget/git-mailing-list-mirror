Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6858220281
	for <e@80x24.org>; Mon,  2 Oct 2017 23:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbdJBXer (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 19:34:47 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:48814 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbdJBXep (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 19:34:45 -0400
Received: by mail-qt0-f175.google.com with SMTP id d13so9340486qta.5
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 16:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kENI1KybJwcLBqbDNjj0OzsXFMwOBP2nZI7VFkn81/c=;
        b=LF6/i34v3IdoTHSctLwuMnTw00f1RwzElXxHlUs+9+HIdgCQsQiT4Ud+rm2VwY39W3
         Whr0Kc0nIUt84+CZ5tq/u0k9I7hrOYgluWje0+nVS0MCBSWeCp0NgBQeSmL/XFOKuh1t
         Xk5MhxaagXnwJ0XNbPkRx+bGV+21mmW7fNCCWl8UjC2am9v358s1MurSg7LhKgUHykwM
         PqX06bB3xjs8pqv7V4KTw+f+L/6axakecpUWE6mY3WOkvwtHuVrdGnrDNQXVSJdRJRk2
         /qYhaFa56Zl0iFk+MRsQtHNFnzO4UdtXWbmbeNabzrPwYABkt4Wnf2AYI8gi3hD+RtCy
         qgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kENI1KybJwcLBqbDNjj0OzsXFMwOBP2nZI7VFkn81/c=;
        b=izwu429TofYvc5Oot6pA3zwfGFYycJEqpUHvrYKAzYobY5ooRd1dfkdXB44hBFqdTg
         PqBIRch+d97GFKo/ZoUfL9p6rxYzGCUFDhNp7fROdFYr7bz/OyRlHHHd0HMFrDFdVOo5
         zDZ765GoUgRutxBFRCkZvVlgWaPn/xuh9Ys/Qomor7f2QU+enT+viHbjpe0Gdaur4PAm
         fjlUeRX++dMoouLw49+WjPjpf+/C6CP9VoktyUm/nEZ9KJK5j4F7ZNbv8M2lb+IAjqEJ
         1504SwgFqO5bwLwNoq5zr9m5QAEgcXOwzYkdMVE25VA2YM+QKLmSAxiwfAVg8JFalsEf
         r8Zw==
X-Gm-Message-State: AMCzsaXfKKV/kW9jndHJPiwVm9sYumZy6MwFcR/zwrzNm83dI/d9Cx8a
        +eY/PPwK2DQ6WnUUKDlUrPqd8Xkiz1PQgd/DN4bXWA==
X-Google-Smtp-Source: AOwi7QB05unDTagthYH14aUKEI1UkqlhAD75LDjWV4/821XvGgFmK1oqwmrS0ChRgHD9511XKhKhTiAE39UoCnJO9Bs=
X-Received: by 10.237.60.37 with SMTP id t34mr19967162qte.224.1506987285068;
 Mon, 02 Oct 2017 16:34:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Mon, 2 Oct 2017 16:34:44 -0700 (PDT)
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Oct 2017 16:34:44 -0700
Message-ID: <CAGZ79kaoCEzc-2ZV60J2GEfxJwLMNg1fFZctEctMiGMVSU+74g@mail.gmail.com>
Subject: Re: [PATCH 00/24] object_id part 10
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 1, 2017 at 3:08 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> This is the tenth in a series of patches to convert from unsigned char
> [20] to struct object_id.  This series mostly involves changes to the
> refs code.  After these changes, there are almost no references to
> unsigned char in the main refs code.
>
> I've tried to update the code comments as I've touched them, but if I've
> missed any, please point them out.  A big thank-you goes out to Ren=C3=A9
> Scharfe, who did the work to make resolve_ref_unsafe optionally take a
> NULL pointer; this dramatically reduced the size of one of the patches,
> and allowed a few others to be dropped during the rebase.
>
> I apologize for the unintended bounced emails that occurred in late
> August; my mail server (previously hosted at home) got knocked offline
> because I was without Internet for over a week after Hurricane Harvey.
> I've since relocated mail to New York, so that shouldn't happen again.

I hope you are ok. (It's not just mail servers that don't like water, but
other personal belongings, too)

>
> This series is available from the following URL:
> https://github.com/bk2204/git.git object-id-part10
>

The whole series has been
Reviewed-by: Stefan Beller <sbeller@google.com>
