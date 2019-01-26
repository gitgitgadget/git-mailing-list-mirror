Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125491F453
	for <e@80x24.org>; Sat, 26 Jan 2019 22:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfAZWIF (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 17:08:05 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36428 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfAZWIF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 17:08:05 -0500
Received: by mail-ua1-f66.google.com with SMTP id j3so4423061uap.3
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 14:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JaQvykSdNzkGbRrxEaWOW+ofwmC9SmEvrtnh9ZSdSds=;
        b=UafsqSD0TV3MjjMvyJhOcFMH72606+QFD8bWpB0ZP8uHxdqWkJHpb0Rd2VoXn5Ph8K
         BTZOSiChjcDG7I0D5MSLGUEUzNidEjQncLPDnv0t+uswHPHDZAYlGeRkeEnTprTE1j/B
         Tt+Nuw4VTQvlgor6pLgJU3LoYIIUH5iNc8+hy5VxTTq55jHTLN8Oh/J2KrVja0kRGefX
         UcikK1YilZFR+7uh/5yTavYVi10cD4klEJmTmR09+qCkX3XlgHBVO3U693lN+bmQOIFq
         /2MhK0u23AKMiGCiVdg12hyWqhmaGh1hFKK1JXBOWzHhEcwJ6qqwIkxrsb14nboHUyLE
         YydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JaQvykSdNzkGbRrxEaWOW+ofwmC9SmEvrtnh9ZSdSds=;
        b=WtTQ1GE/1m9FFbDqfvi/oX8JwFuo9iOCdha/y53+oc73HpX5XBnv4f515dby/Sr4uB
         AcuQZFsLTgnyDT6HASkBmshvaPcV0ksXLWA4EuCAhzLKzo7BJUfhwMqsNfb2fKzK2Ksz
         sqbbUyrhiZA4RLlFE+I9BVs0vaaNWzY2TDdwNM+GrRPmOnS7uaM4ssR3I6rhUMsaUjF4
         obuTjU+hVCS+I8XYjA3DNrqJJMyYL/DrMWrcNdJ5CVAtIzMkbwZWKHY4z4TqB1QZ1ujh
         iPv0q+98jA0dKOEMaPgtgQKGU/PQOpmmRrPxlr3op/5qfuMWyqB8DuSeFRjYSbD/7N6/
         2dGA==
X-Gm-Message-State: AJcUukdv9bCRtEPk4jpZLMSxxJMhzFjaPszhE3RQrId59ntPfRkPMvV+
        tlxoGXtG//Wttggm1jGse/MDlj95BRMG8g4p8HY=
X-Google-Smtp-Source: ALg8bN7qJxw6hVZnqgpn84SMXur5DTsbVQMR+xDAUpT3oEQ+lvqDqKD4IA+ScyP1EjxW3LRPHFxyZ75MIIcbsl+95tU=
X-Received: by 2002:ab0:216:: with SMTP id 22mr6675693uas.28.1548540484150;
 Sat, 26 Jan 2019 14:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20190124164654.1923-1-newren@gmail.com> <20190125165416.17473-1-newren@gmail.com>
 <2f785c2d-161c-b6a3-7743-b071969d60d7@gmail.com> <CABPp-BHTsZBO11ykfTaZ_dzpvrww5D3A57qBM05EgP_wK-iM9g@mail.gmail.com>
 <CAPig+cRefjWr3gNOfQou9JyW=yfACEvbXPPRzXU+VkJN_gCTzA@mail.gmail.com>
In-Reply-To: <CAPig+cRefjWr3gNOfQou9JyW=yfACEvbXPPRzXU+VkJN_gCTzA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 26 Jan 2019 14:07:52 -0800
Message-ID: <CABPp-BHU9QUQrr9F9ncQSn-yeBhMUZiRO78jzX+C42zrg55tzA@mail.gmail.com>
Subject: Re: [PATCH v2] log,diff-tree: add --combined-with-paths options for
 merges with renames
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 25, 2019 at 11:51 AM Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
>
> On Fri, Jan 25, 2019 at 12:52 PM Elijah Newren <newren@gmail.com> wrote:
> > On Fri, Jan 25, 2019 at 9:41 AM Derrick Stolee <stolee@gmail.com> wrote=
:
> > > On 1/25/2019 11:54 AM, Elijah Newren wrote:
> > > > +     printf "0f9645804ebb04cc3eef91f799eb7fb54d70cefb\0::100644 10=
0644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e=
7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR\0file\twith\=
ttabs\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
> > >
> > > I'm guessing that you use printf here because the
> > > 'cat <<-\EOF' approach doesn't work with the special
> > > tabs? Kudos for putting in the extra effort here for
> > > the special formatting!
> >
> > Yeah, I didn't know how to easily get NUL bytes in the stream without
> > printf, and once I was using printf the EOF HEREDOC no longer had a
> > useful purpose.  In the first testcase, since there were only
> > printable characters in the expected output, a HEREDOC worked well.  I
> > guess I could have just used printf for both testcases, but having the
> > literal output shown where it's possible for a human to read it seemed
> > like an advantage worth capitalizing on.
>
> If the readability of a here-doc is preferred, you should be able to
> achieve the desired result with the q_to_tab() and lf_to_nul()
> functions. For instance:
>
>     q_to_tab <<-\EOF | lf_to_nul >expect &&
>     ...Q...Q...
>     EOF

I like the idea and I tried it out...but it actually looks harder to read t=
o me:

diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 5bccc323f6..ddbd27d16a 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -457,8 +457,8 @@ test_expect_success 'setup for --combined-with-paths' '
 '

 test_expect_success '--combined-all-names and --raw' '
- cat <<-\EOF >expect &&
- ::100644 100644 100644 f00c965d8307308469e537302baa73048488f162
088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7
333b9c62519f285e1854830ade0fe1ef1d40ee1b RR "file\twith\ttabs"
"i\tam\ttabbed" "fickle\tnaming"
+ q_to_tab <<-\EOF >expect &&
+ ::100644 100644 100644 f00c965d8307308469e537302baa73048488f162
088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7
333b9c62519f285e1854830ade0fe1ef1d40ee1b
RRQ"file\twith\ttabs"Q"i\tam\ttabbed"Q"fickle\tnaming"
  EOF
  git diff-tree -c -M --raw --combined-all-names HEAD >actual.tmp &&
  sed 1d <actual.tmp >actual &&
@@ -466,7 +466,13 @@ test_expect_success '--combined-all-names and --raw' '
 '

 test_expect_success '--combined-all-names and --raw -and -z' '
- printf "0f9645804ebb04cc3eef91f799eb7fb54d70cefb\0::100644 100644
100644 f00c965d8307308469e537302baa73048488f162
088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7
333b9c62519f285e1854830ade0fe1ef1d40ee1b
RR\0file\twith\ttabs\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
+ q_to_tab <<-\EOF | lf_to_nul >expect &&
+ 0f9645804ebb04cc3eef91f799eb7fb54d70cefb
+ ::100644 100644 100644 f00c965d8307308469e537302baa73048488f162
088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7
333b9c62519f285e1854830ade0fe1ef1d40ee1b RR
+ fileQwithQtabs
+ iQamQtabbed
+ fickleQnaming
+ EOF
  git diff-tree -c -M --raw --combined-all-names -z HEAD >actual &&
  test_cmp -a expect actual
 '

So I'm going to stick with the original.  Thanks for pointing out
q_to_tab and lf_to_nul, though; they may come in handy in the future.
