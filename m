Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBE461F46C
	for <e@80x24.org>; Thu,  9 Aug 2018 19:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeHIWSZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 18:18:25 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44051 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeHIWSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 18:18:25 -0400
Received: by mail-yw1-f67.google.com with SMTP id l9-v6so6238456ywc.11
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfngHhAKKK15vHT8CndCTPiVWpq2eTNa14+kr6AjXtc=;
        b=qD/h8scnqq6MfAwVQFF8te8sPnOdxCR6/S5c3NAYNdil+NB3YA5jVA++F7k1xTnIDB
         RUus4fnCl0PheC5tdKbORhXCPxnju1BqKFbYg2/1+w86HBzSw7szm+zyTZPPdPpIqyG2
         xoC2pxlEn3XghbL5E+FgTf3zDqOO9+eXT0CEMc3L5MmA4mwcB8/QLQ4WxjalGIykhz8W
         Y3nANQREzChV/ngRc/wH3b4Z/Nwp9n5wlaDIINhNznXCyJErVFUTJgfACLD9gwRUw2Q0
         v/RBjxx1jcWBF+XT5QJSHpGRt7DsnUcVPIw64EP9oavwEHKQ9l+NFkxKk3m+Slc1f2xJ
         xESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfngHhAKKK15vHT8CndCTPiVWpq2eTNa14+kr6AjXtc=;
        b=otmbO5ZNJo7D8GxVQtkhnhxO5pHTV1AbGeORJcrqWXUmXHqNn2ZOUpS7o+m32L3M01
         v7jjXlz8Sa5miKDgp9U6y+do1/cXx/pTqXgKuG6n3r44iL9vyO6KgI4cN/ju0dZf0MjB
         HS0rh1NBpke3oG2c+zHptSvIjFfKdQBFr5sd+z7jVKpbHpgrtJmwoXSxC2+im9S8TFJe
         kdUtNwsObSvlmaM2KmW1SKgJNJYDIeZPJJmBtRjqLpfRSwUfNNSz4QKhLUSiU6PXULm1
         bMUe5tgOAzLfvUHyu/UyBjxvYWExdhxl6/vOAQeh7AI+rDHlmxm3PQdu0LGPoVc4K8jy
         thag==
X-Gm-Message-State: AOUpUlFmqGh9h2WmvBWvUmAsVPoMwpdTmYqpMC+UO3QiEm/qZK1DJGgn
        U3r+mkWWVDVy+Sarx+srk8o0si6fbpqf0ebKbTirDC4xUZQ=
X-Google-Smtp-Source: AA+uWPzXiuOit+5G7VMJGpfH6Ub96N7DZrpFNgLj7CrM+/dJ8VGstYUd38Fkpe0gf29u60u0jzosL5P0NIcKMqVDlVY=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr1932021ywh.238.1533844324318;
 Thu, 09 Aug 2018 12:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180724044051.GA208393@aiede.svl.corp.google.com>
 <20180806222551.132628-1-sbeller@google.com> <20180806231843.GA4117@aiede.svl.corp.google.com>
In-Reply-To: <20180806231843.GA4117@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Aug 2018 12:51:53 -0700
Message-ID: <CAGZ79kby35z6pQb9DN+SvF6jA1aPMKmxyrtHM7kiwGjwD3abPA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/diff-options: explain different diff algorithms
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 4:18 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

> > +DIFF ALGORITHMS
> > +---------------
>
> Please add some introductory words about what the headings refer to.

ok.

>
> > +the shortest output.
>
> Trivia: the `minimal` variant of Myers doesn't guarantee shortest
> output, either: what it minimizes is the number of lines marked as
> added or removed.  If you want to minimize context lines too, then
> that would be a new variant. ;-)

... and take line length into account. ;-)

It minimizes the edit distance in terms of lines, i.e. in a context-less diff
we get the lowest number of lines possible.

> > +This algorithm finds the longest common substring and recursively
> > +diffs the content before and after the longest common substring.
>
> optional: may be worth a short aside in the text about the distinction
> between LCS and LCS. ;-)
>
> It would be especially useful here, since the alphabet used in these
> strings is *lines* instead of characters, so the first-time reader
> could probably use some help in building their intuition.

That makes sense.

>
> > +This is often the fastest, but in corner cases (when there are
> > +many common substrings of the same length) it produces bad
>
> Can you clarify what "bad" means?  E.g. would "unexpected", or "poorly
> aligned", match what you mean?

I'll just go with unexpected.

> > +results as seen in:
> > +
> > +     seq 1 100 >one
> > +     echo 99 > two
> > +     seq 1 2 98 >>two
> > +     git diff --no-index --histogram one two
