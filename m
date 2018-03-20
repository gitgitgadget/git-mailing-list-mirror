Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C321F404
	for <e@80x24.org>; Tue, 20 Mar 2018 03:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeCTDKg (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 23:10:36 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:35525 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeCTDK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 23:10:27 -0400
Received: by mail-ot0-f170.google.com with SMTP id r30-v6so207939otr.2
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 20:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zLEKX0x0QDARY1swTGxsXdHHB6HcM3j5AjVEVPG+gkA=;
        b=K3CfqzQZWcwENG22MT6wQS7CG6lYjzN1s6Nh6GfbF1jHukIfte92wc25o3o8OktoCZ
         P9GHM/qsoJX7Lo6SQNDWlDo8A1eIiP3/UPKuDQ6gy2f+JOwt7TdRtR94n/R6E117FAGc
         o9HGWhyV1Y+SU6RWbADAoJyAz6IXrtNYW+AQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zLEKX0x0QDARY1swTGxsXdHHB6HcM3j5AjVEVPG+gkA=;
        b=PTuXImLhr4JRgoUT/X1Fmctf4XJRYfM8RwfxPX9QkBYT9j67SXAweNjnl7Zh0FDGfc
         L+F4th1PXPfIFcrSsvyaRoeb5F+kiQh1Z/PiBh/wcX9HOLjMgfikEaeBdl1RsBmPxR/a
         ujlWDp6uXKhFW18PGOHFgMKcgyM3Y+lZkoGxTG7Swzu8OV0e0DGlKCj/3csUt2wV27jr
         8aaUh31H6vAUGWWjnPzGx9p75XiMW8RUlIfvyJZIMa6Tgf5e81qv12vdfb7d20EInWt1
         HvNFnTGNa+fbVk1HLxft/I15IVWNONj4m3jKm6JgKrgAcVmaMa5HCpqOsBrXI/9jxZL8
         FaKw==
X-Gm-Message-State: AElRT7ECHc5zfOVVvAgRn/KkDj6QqunAk3myMRcql4tEO5Yud2tw24uD
        UPH2vqyW9loMUS75TGauWtpuwbqOJb/zyZtUziChtf85AAE=
X-Google-Smtp-Source: AG47ELt/932F2eyT3RqzQaB8c7k15pwYrzXxFGB4/Jt8nmlHo9wbMUMqOag1fvHqSFqn+eASDT95jxi0RbpA7v6xqC8=
X-Received: by 2002:a9d:213c:: with SMTP id i57-v6mr7546588otb.85.1521515426757;
 Mon, 19 Mar 2018 20:10:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a69:0:0:0:0:0 with HTTP; Mon, 19 Mar 2018 20:10:26
 -0700 (PDT)
In-Reply-To: <20180320023423.GA10143@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net>
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Mon, 19 Mar 2018 23:10:26 -0400
Message-ID: <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
Subject: Re: .gitattributes override behavior (possible bug, or documentation bug)
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the quick reply!

On Mon, Mar 19, 2018 at 10:34 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 19, 2018 at 09:49:28PM -0400, Dakota Hawkins wrote:
>
>> Summary: Trying to apply attributes to file extensions everywhere
>> except in one directory.
>>
>> .gitattributes:
>>
>>     *.[Pp][Nn][Gg] filter=lfs diff=lfs merge=lfs -text
>>     /.readme-docs/ -filter=lfs -diff=lfs -merge=lfs
>>
>> Make some data:
>>
>>     echo "asldkjfa;sldkjf;alsdjf" > ./.readme-docs/test.png
>>     git add -A
>
> As you noted below, that second line does not match your path, because
> attributes on a directory aren't applied recursively. And it has nothing
> to do with overriding. If you remove the png line entirely, you can see
> that we still do not match it. You need to use "*" to match the paths.

Ah, yes, I see that. Inconsistent with .gitignore (more below), right?

> You may also find that "-diff=lfs" does not do quite what you want.
> There is no way to say "cancel any previous attribute", which I think is
> what you're trying for here. You can only override it with a new value.
> So:
>
>   /.readme-docs/* -diff
>
> says "do not diff this". And:
>
>   /.readme-docs/* diff
>
> says "diff this as text, even if it looks binary".
>
> The best you can probably do is:
>
>   /.readme-docs/* diff=foo
>
> Since you have no diff.foo.* config, that will behave in the default way
> (including respecting the usual "is it binary" checks). So a bit hacky,
> but I think it would work as "ignore prior diff".
>
> And I think filter and merge drivers should work the same.

That's interesting... in this case I was taking my advice on how this
should work from the git-lfs folks. I have promised to share what I
find here with them, so that will help at least :)

I think that makes sense to me -- there would be no good way to tell
it what the default should have been without explicitly telling it
what to use instead.

>> Is this me misunderstanding something in the documentation? I would
>> expect "./.readme-docs/" to match "./.readme-docs/test.png" and
>> override the earlier "*.[Pp][Nn][Gg]" attributes.
>>
>> I have found the following overrides to work in lieu of the directory match:
>>
>>     /.readme-docs/* -filter=lfs -diff=lfs -merge=lfs
>>     /.readme-docs/**/* -filter=lfs -diff=lfs -merge=lfs
>>
>> ...but I don't see a justification in the documentation for this
>> working and the original directory filter not working.
>
> I could not find anything useful in gitattributes(5). There's some old
> discussion here:
>
>   https://public-inbox.org/git/slrnkldd3g.1l4.jan@majutsushi.net/

If I follow that correctly: There's some initial speculation that it
would be OK to apply the attributes recursively, which is then shot
down because it wasn't designed to be recursive (though I don't see a
different, technical reason for that), followed by finding a (this
same?) solution/workaround for the original problem. Is that about
right?

> which makes it clear that attributes aren't recursive, but it's probably
> worth calling out in the documentation. In fact, I think the current
> documentation is a bit misleading in that it says "patterns are matched
> as in .gitignore", which is clearly not the case here.

I was indeed going off of the suggestion to consult the .gitignore
pattern matching documentation.

> I think just "/.readme-docs/**" should be sufficient for your case. You
> could also probably write "*" inside ".readme-docs/.gitattributes",
> which may be simpler (you don't need "**" there because patterns without
> a slash are just matched directly against the basename).

Wouldn't that make the "*" inside ".readme-docs/.gitattributes",
technically recursive when "*" matches a directory? It's always seemed
to me that both were necessary to explicitly match things in a
directory and its subdirectories (example, IIRC: "git ls-files --
.gitattributes" vs "git ls-files -- .gitattributes
**/.gitattributes"). Maybe that example is peculiar in that its a
dotfile and can't have a wildcard before the dot?

I guess my takeaway is that it would be _good_ if the gitattributes
documentation contained the caveat about not matching directories
recursively, but _great_ if gitattributes and gitignore (and whatever
else there is) were consistent.

At any rate, thanks for the great, quick help!

-Dakota
