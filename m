Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D28CA202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 18:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdKSSMD (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 13:12:03 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:41363 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdKSSMC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 13:12:02 -0500
Received: by mail-qk0-f178.google.com with SMTP id f63so4998944qke.8
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 10:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=P5jivl5CHQVY6g9EHA0Qxh6q9dNS8Ubkb/DsVsLn+Tg=;
        b=iSBPIY1U+GajtfUpD9gjuO4fO9PvF+eKh1iNtrCKd49JhAuBnyNocLukAFwvwvWJb9
         1yamj5lRN+XDz0dkELd18+IutQeVmtzICMntIiFGl5S7a2AHxfPqHDvbO98hcUmYEVK4
         RKwoy8SVRoAfzhgqwBXyQqxy1XeQURE+c7Hv6VVoJitYTdiEwhYkwMEUU3yZKK6V/K3h
         ppTKNNWdCGSnmutTAlWUmXa6/lSkMjnuB8PNXqMK7KLk+iu9vwY+pru9CEx/0eL/mllG
         uRrDBiE8YUpLnNNb1IhJi0LbTDbB5anTJ3Bhl9plqOlLPr9doMN/jMw5Tq8Z5rdBnPgd
         MpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=P5jivl5CHQVY6g9EHA0Qxh6q9dNS8Ubkb/DsVsLn+Tg=;
        b=OFMGTL9DYNMMdxUFDsm9OA9RawFK0vPsWLwOpA3yLXsEymLMSLvZl81mxNboUW2kFM
         4UY3Mfg7OBH+uQkGkslVJ91QYi74fUP/Saoo0WF1R5UIfDEoOb7s8d3E7GXJb259+FuO
         ZgNk8DF2WX/LZuIzkoA+0GaEgxqBHJkiUjiOIgQnDr4UkBJFwM6cVgqlaSPHHGHQOXxz
         wXBNiioR08pwbybaUdCD8MKy5Ns1K7CaoZIyNo4dS1ixYPRdCdNQ8FRK7AYIlQ7cWsq2
         UivuPKUFb1DRaC5yWj63OTqL5/fLMRKWAOkPs3oNISoWqNW9h8YYWNMnQGnuNh1H7jHh
         R3sQ==
X-Gm-Message-State: AJaThX5850WUZSgkuDdsCkplSl2PrI3Y/A3XTajmDn07UTWzVz+2dPfU
        mx6NJQbkZeNNoymUgAybCZxYdU3voywcAmxuJvE=
X-Google-Smtp-Source: AGs4zMZxIyYXRGn4QPAwN4oCrMkzsb2Hzj66IUH5A3/cAUpiBDg/AYhhyPNTFY/pdwfydw9Fwrf15kMlQEi0CCCi6UM=
X-Received: by 10.55.114.69 with SMTP id n66mr17115502qkc.306.1511115121444;
 Sun, 19 Nov 2017 10:12:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sun, 19 Nov 2017 10:12:00 -0800 (PST)
In-Reply-To: <C47F730C-18AE-411E-AC57-2DA8625451C4@icloud.com>
References: <C47F730C-18AE-411E-AC57-2DA8625451C4@icloud.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Nov 2017 13:12:00 -0500
X-Google-Sender-Auth: vW0ab0sfEtO-bXdu4tw0b53bmCY
Message-ID: <CAPig+cRxB5xiyeCWKTB3O1zeH50pobjBH8oyQt75FkC09_4_dw@mail.gmail.com>
Subject: Re: Why gc --auto is called so rarely?
To:     Ilya Kantor <ilya.a.kantor@icloud.com>
Cc:     =?UTF-8?B?0JzQvtC5INCl0L7RgNCy0LDRgtC40Y8=?= <iliakan@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 19, 2017 at 12:04 PM, Ilya Kantor <ilya.a.kantor@icloud.com> wrote:
> P.S. The old gmane discussion referenced by some previous posts on this subject is lost.

You can find old gmane conversations at https://public-inbox.org/git/
by searching for "gmane:<id>" in the search field, where <id> is the
gmane ID number of the message.
