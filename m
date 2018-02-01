Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A925C1F576
	for <e@80x24.org>; Thu,  1 Feb 2018 09:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeBAJ7V (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 04:59:21 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39506 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeBAJ7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 04:59:20 -0500
Received: by mail-pg0-f65.google.com with SMTP id w17so12139124pgv.6
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 01:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DNjNQfNltsz5sivzUUbpZD/o7W1eMIj3Tkpjp6NZmRc=;
        b=MyEMMfyvFThhsHst49pWhTsbfNUL0b6F9laBsVSMdYswzxdoxvqDUtdz4tumVXtbZh
         Duhq6jNFlrfCQycjntaBS1olrKciWN27RIAhcSZl4QeGH792gL7UFxu13IWxq1t0MiU/
         FAaFnL+fah3m2QAvp2975daWaFFOiLDJ6Ei88a7UhWsPTp7GHpJJXt38kJHhZPCwaRkU
         u0boaTacT1fBITvir2TEDdAhF0rdSY7TJPAg+ZK6ilHb+FH+1YcWS2t3kTN341gziT+u
         oLobZ4gan/zqlWjjxe/suju9WuYkedSd0ftRlFo4qaYGIlsPlRo+ANTJWCAj0WryxIqY
         1n3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DNjNQfNltsz5sivzUUbpZD/o7W1eMIj3Tkpjp6NZmRc=;
        b=hb943Xaiid8vqXikc588cbmtL0fi1FrdB2Jrc8ZmVyOcZWK5Q74hIxs4azQYbMZgwp
         VdDsp081LRpb/uMGRAn+DjrA49DxAmaW+hOHvh6bro7y5MoO/qEEpi6YNNZx2jtRWW71
         kEGkZ1vijJxJ+PgXc6KKJ9tPP+wpRZ82LgWLxose2O2ka/UtNrKX12Zbz+AHJC6jLpcU
         h3IHJkCqWQyqUiD2jqZv9UE8UoWt0cdAfXJOTtw/k3lZOd9YCxmiEt9tgQ04iL13BaCU
         5scow0ASjf4YjYuxJvl3Tjaa2KzeUgedBYyvCmzHKE/E396l3+7q6bLMmab8qX7qtrqh
         fn3A==
X-Gm-Message-State: AKwxytfxqdj5duVQr64R5a+8ED/cfFRBcpfFTo8GPjSC15lNOk/FilKS
        u6jqbDxAZcfFqOc1O8tT1TqgxQ==
X-Google-Smtp-Source: AH8x227NNIid7e89EEYx5tFNB3hKguHCwXQSIYAcncmvUig4Jywr5AlmSv1eWaOuZT2FOxxj3Y0N5Q==
X-Received: by 10.99.44.209 with SMTP id s200mr2228007pgs.407.1517479160053;
        Thu, 01 Feb 2018 01:59:20 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id v11sm28670180pgf.83.2018.02.01.01.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2018 01:59:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Feb 2018 16:59:15 +0700
Date:   Thu, 1 Feb 2018 16:59:15 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>, tim@tim-landscheidt.de
Subject: Re: [PATCH] gitignore.txt: elaborate shell glob syntax
Message-ID: <20180201095914.GA6939@ash>
References: <20180126095520.919-1-pclouds@gmail.com>
 <20180131093051.15525-1-pclouds@gmail.com>
 <20180131093051.15525-3-pclouds@gmail.com>
 <xmqqh8r1r4u1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh8r1r4u1.fsf@gitster-ct.c.googlers.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 03:22:46PM -0800, Junio C Hamano wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

Argh.. stray patches strike again. It's not supposed to be in this
thread but in

https://public-inbox.org/git/%3C20180130101351.GA761@ash%3E/

> 
> >     `.gitignore` file).
> >  
> > - - Otherwise, Git treats the pattern as a shell glob suitable
> > -   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
> > -   wildcards in the pattern will not match a / in the pathname.
> > -   For example, "Documentation/{asterisk}.html" matches
> > -   "Documentation/git.html" but not "Documentation/ppc/ppc.html"
> > -   or "tools/perf/Documentation/perf.html".
> > + - Otherwise, Git treats the pattern as a shell glob: '{asterisk}'
> > +   matches anything except '/', '?' matches any one character except
> > +   '/' and '[]' matches one character in a selected range. See
> > +   fnmatch(3) and the FNM_PATHNAME flag for a more accurate
> > +   description.
> 
> Where the original did not quote single letters at all, this uses a
> pair of single quotes.  Did you make sure it renders well in HTML
> and manpage already or should I do that for you before applying?

I didn't. I thought I didn't add any weird symbols. I was wrong. These
are now wrapped as "`stuff`" to be displayed the same way as in nearby
paragraphs. Verified both man and HTML pages are rendered well.

> I think what you wrote is accurate enough already, and those who
> want to go to fnmatch(3) would do so not for accuracy but for
> authority ;-) Perhaps s/accurate/detailed/?

Well there are rooms for guessing, for example "matches anything" does
not tell you straight that it can match multiple characters. Anyway
fixed too.

-- 8< --
Subject: [PATCH v2] gitignore.txt: elaborate shell glob syntax

`fnmatch(3)` is a great mention if the intended audience is
programmers. For normal users it's probably better to spell out what
a shell glob is.

This paragraph is updated to roughly tell (or remind) what the main
wildcards are supposed to do. All the details are still hidden away
behind the `fnmatch(3)` wall because bringing the whole specification
here may be too much.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/gitignore.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 63260f0056..ff5d7f9ed6 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -102,12 +102,11 @@ PATTERN FORMAT
    (relative to the toplevel of the work tree if not from a
    `.gitignore` file).
 
- - Otherwise, Git treats the pattern as a shell glob suitable
-   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
-   wildcards in the pattern will not match a / in the pathname.
-   For example, "Documentation/{asterisk}.html" matches
-   "Documentation/git.html" but not "Documentation/ppc/ppc.html"
-   or "tools/perf/Documentation/perf.html".
+ - Otherwise, Git treats the pattern as a shell glob: "`*`" matches
+   anything except "`/`", "`?`" matches any one character except "`/`"
+   and "`[]`" matches one character in a selected range. See
+   fnmatch(3) and the FNM_PATHNAME flag for a more detailed
+   description.
 
  - A leading slash matches the beginning of the pathname.
    For example, "/{asterisk}.c" matches "cat-file.c" but not
-- 
2.16.1.205.g271f633410

-- 8< --
