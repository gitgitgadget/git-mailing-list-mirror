Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02BFC20248
	for <e@80x24.org>; Mon, 25 Mar 2019 15:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfCYPcE (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 11:32:04 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:36188 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYPcD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 11:32:03 -0400
Received: by mail-lf1-f48.google.com with SMTP id d18so6332356lfn.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=cehfvDwKHYg0LkKfU5NYVp6Wl31TWKaHnni/1ij8/mM=;
        b=ES/eTy3A0e4Zf/NbfZkDHK6agoyxPn7AAx14M1stj88AOdMgcSyIm5njvBl94QITPo
         hENohIxSCx/5qiyeQyrjg7TWIGF2IqnaIFFxWK1o2yUM7AzZeTatGEP62uj/FtRAVTqy
         KcQkXyl3ZAKJMb1XbG4g7wbR+xf3qrukfU17jg2ygUgPiNBANGceIfndQZRxHo5zDUtd
         vXpzu8uwZLn1GpMYGVURkcy+4YdQXBpN5HgkCPEk0hSzywmNhU2FV7ow5DViZ4q82ZJr
         ruSM2GQTcqGxOCcldKWiMe2Iber9Cn4HnDoMXf5JjAUb6/Jbt+7A1WlRh9T/gayArifM
         WNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=cehfvDwKHYg0LkKfU5NYVp6Wl31TWKaHnni/1ij8/mM=;
        b=uQ051loaKwYz1khdEqzIet7Fk5sdJK5SfgSf/4g1o7FhcUXUo2qXQ4YFwkRNFs0pes
         gZaWEYnX+IsC50ITYQnE3bxDcF2N2Mw6h3mp4a6sGOUJ5ixrkBRDirHb4PP8Nz4qz3un
         npADecEc2/f95CF1bS9k8cw/n3qruWE3s+g2Oi9U938VojBik1BJqjTzkdBWWs+PdvpW
         QDGKORX+iQJr9iJDqigF3sgd9Bw0+nvGsQNA15U8OMuIDZDIccEgiD16UYONv2vKujZp
         tDPhhHxkE/FfvwqKPXHRlVMXgxXnoH9one5LS9xKUotl6uIWYcpuydDdZm/CGCwlKdH3
         lwjg==
X-Gm-Message-State: APjAAAVR6aBkwd3E8NnGfzmsCoY8haJiTbYkw8lq1TFvvX+WLvxYTCDM
        9MGRjKt000niL/QHOj3aq2zAbSzENJtzvZThhhw=
X-Google-Smtp-Source: APXvYqyZTl2ZfaPp2nLYLWR7+xj5uWOU2lJxUavz6+GYbKoibpZ9O5oR7LRbXLgfokIhAG0FDGIM7/zJF5hHCJ8i6kE=
X-Received: by 2002:ac2:4154:: with SMTP id c20mr12363929lfi.74.1553527921618;
 Mon, 25 Mar 2019 08:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com>
 <20190321192928.GA19427@sigill.intra.peff.net> <CAHd499BTACjf91Ohi34ozFQE_NOn-LVf-35t7h4CTtDFoMCpWw@mail.gmail.com>
 <20190325144930.GA19929@sigill.intra.peff.net>
In-Reply-To: <20190325144930.GA19929@sigill.intra.peff.net>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Mon, 25 Mar 2019 10:31:50 -0500
X-Google-Sender-Auth: hx9EeBdYdY32xoFjugB_JMAE1zE
Message-ID: <CAHd499CimFqfa-k6pB3NuMmM6fBUeMCOjs0ZUuGEHCc8Q5eEBg@mail.gmail.com>
Subject: Re: Strange annotated tag issue
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 9:49 AM Jeff King <peff@peff.net> wrote:
> I think "just commits" is too restrictive. linux.git contains a tag of a
> tree, for example (we also have tags pointing to blobs in git.git, but
> they are not annotated).
>
> However, I could see an argument for the git-tag porcelain to notice a
> tag-of-tag and complain. Probably peeling the tag automatically is a bad
> idea, just because it behaved differently for so long. But something
> like might be OK:
>
>   $ git tag -a mytag
>   error: refusing to make a recursive tag
>   hint: The object 'mytag' referred to by your new tag is already a tag.
>   hint:
>   hint: If you meant to create a tag of a tag, use:
>   hint:
>   hint:  git tag -a -f mytag
>   hint:
>   hint: If you meant to tag the object that it points to, use:
>   hint:
>   hint:  git tag -a mytag^{}
>
> It would be a minor annoyance to somebody who frequently makes
> tags-of-tags, but it leaves them with an escape hatch.

I think a warning/error would be perfect. Again, if I had realized the
consequences of my actions years ago when I made this tag, it would
have changed a lot down the line for me. If I had seen that message
before, I think it would have helped a lot. You might even add an
educational bit in there and say "Warning: You are creating an
annotated tag that points to another annotated tag. Annotated tags may
point to more than just commits by design. Refspec tag^{} may be used
to peel the source tag back to the commit it points to". Then follow
with the instructional commands.

I agree with your approach though. Thanks again.
