Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 889F92018A
	for <e@80x24.org>; Fri,  1 Jul 2016 17:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbcGARHO (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 13:07:14 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33122 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbcGARHM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 13:07:12 -0400
Received: by mail-io0-f175.google.com with SMTP id t74so105645196ioi.0
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 10:07:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FVCzUvqVs8BCYpd4/AxLEikgkWcy4QZZm2u+vU3jmB4=;
        b=Yo5+WrsAj8ZA3FhWo8ZrFeRJEA8CiXLt3yGIVro3oN0RKVP/by8E3GEJYYwdwOYDTU
         RJpmOzDZlnEZxOHjmMPdHK5SKfJa9N5mvDVahAkG7GX6/kvMqfkFGSzmEYoXlpgf4ARf
         3qzJg0yVXDaukR/5cRkYa7jxMYlqQWMzdC/g+LXrV9G+0Vzi/ZrElAv7jQQJXMWlB3uB
         05owBDud/wwnrTOLLL9PIzDUIn0MiYJ/dglf5fyFFNCIFFJZ/1xKmWmNf8eJlPfoaDYt
         jeo2gKLPxad1m2ttiC0CeYRFY92QIX1fhxn4rj55u16qdue7hoLzoETcWKTTEUNcREtz
         TyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FVCzUvqVs8BCYpd4/AxLEikgkWcy4QZZm2u+vU3jmB4=;
        b=D7hovRm4BLcguPB6DXKL4Ntl/7X+GkIb3JCWCfqjflf6KAGX8F47005+ZfCrNSFSf/
         5hKlIs6eg+soh6se3JXM4bJcXB9iePe2MzJCkEEWtVXEtU69+QG8x13hxkdxuSrQslD1
         rHIPC6Kx1Y451XMIIey9CmUpCAdTlvp668gpbGhWHsf7M3o+e3/Kq9qVaydYi6TM5lfL
         qu0kpEoRu/I9RkwTDsadud0kGl4byKdGUtugYWQwQ+WDxeKxifY8iMCKoVbFeoBXmmiO
         H7lIB17hsevJJewchEU7cZtjy5f9CYX8esPRaXe0uEc82AKNoXGjGa/0LQsTk6DT2Yap
         p0nQ==
X-Gm-Message-State: ALyK8tJ2ylx28jSnrIZCAfi29PM9sLHRTbVcyszNBwpBK1/zFPmXPm4dLGGScpWsiRehhCKgFwS287YQs19iIzgs
X-Received: by 10.107.186.196 with SMTP id k187mr21954225iof.173.1467392831356;
 Fri, 01 Jul 2016 10:07:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Fri, 1 Jul 2016 10:07:10 -0700 (PDT)
In-Reply-To: <20160701070902.GF5358@sigill.intra.peff.net>
References: <20160630005951.7408-1-sbeller@google.com> <20160701070902.GF5358@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 1 Jul 2016 10:07:10 -0700
Message-ID: <CAGZ79kY7j3r5b0rz=Lb6Ec2s2f8=UBb-hTtZw0H09KM_9H+7=Q@mail.gmail.com>
Subject: Re: [RFC PATCHv1 0/4] Push options in C Git
To:	Jeff King <peff@peff.net>
Cc:	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 1, 2016 at 12:09 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 29, 2016 at 05:59:47PM -0700, Stefan Beller wrote:
>
>> Allow a user to pass information along a push to the pre/post-receive hook
>> on the remote.
>
> Seems like a reasonable thing to want, and related to:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/285124
>
> which was specifically interested in making "--quiet" and "--force"
> available, but stopped short of arbitrary data. (It looks like that
> topic got overlooked, and Dennis never prodded again).

Doh! I should have searched for such a topic. :/
I looked at the patches and they differ conceptually in what goes over the wire.

In Dennis series that is a hook_options=<string> in the capability
selection line,
that is after the first update line, i.e. the hook options are
restricted to not contain
white spaces and be of length < ~60k characters IIUC (reserve about 4k for the
update, ref and other selected capabilities)

In this proposal we only indicate that we want to transmit options in the
negotiation phase, and then after the update transmission is done, you can
have as many packets as you want excluding flush packets (the flush packet
indicates we're done transmitting these push/hook options)

So I might be biased by my code, but I'd claim that is more future proof.

>
>> When using a remote that is more than just a plain Git host (e.g. Gerrit,
>> Git{hub/lab}, etc) this may become more obvious: The (server backend specific)
>> push options can instruct the server to:
>> * open a pull request
>
> I know this is just a "for example", but I don't know if we would ever
> support opening a pull request directly via push, if only because a good
> pull request has actual parameters that the user needs to fill out (like
> the cover letter message).

Sure, just an example! You could have

    "git push --read-push-option-from-file=coverletter.html".

as this really only disallows flush packets (i.e. anything goes,
including images)
and the server must be smart enough to interpret the file.

>
> So you'd probably want some client tool to help the user figure out what
> to put in the PR, and of course that already exists, because GitHub has
> an HTTP API that it can talk to. Shoe-horning it into Git doesn't buy
> much.

Let's say the example was bad. the reality is that Dennis and I implemented
a needed feature independently of each other and you have the
out-of-the-box-Github-does-HTTP-too solution. So I think we'd want
*something* in Git to have information in the receiving hooks available?

It seems to me there are many other Git-wrappers, such as the repo tool
or git-review[2], and most of them start with the premise: "Git doesn't support
X yet, so while they take their time to figure out how to do it
properly upstream,
we'll just use this hacky script" and then eventually you end up with an xml
parsing beast with thousands lines of python code (The story of the repo
tool and submodules).

[1] https://code.google.com/p/git-repo/
[2] http://linux.die.net/man/1/git-review

>
> I'm not sure if your other examples would be better served by just using
> an HTTP API or not.

The decision for the HTTP API would be the decision for a wrapper tool.
And all these wrapper tools differ, so it is not easy to switch from one to
another, on the other hand, if you know Git well enough you can easily adapt
to other work flows as it is not a new tool, but just a new command line option
or so?

> I think Gerrit is funny in this regard because it
> eschews branches entirely. E.g., in a GitHub PR, you push to branch
> "foo", and then you open a PR using "foo" as the source.

Once upon a time you could also open a pull request using the sha1?
(I did that once and then was asked to do some fixes before pulling and
I had to abandon and reopen a proper branch PR)

> But with
> Gerrit, you push to the magic refs/for/master, and you have no real way
> to cross-reference that submission later.

What do you mean by cross reference?

I could ask you to look at https://gerrit-review.googlesource.com/#/c/79354/
and in the upper right corner you'll find a download button that let's you copy
"git fetch <URL> refs/changes/54/79354/3 && git checkout FETCH_HEAD".
That allows you to inspect that thing alone later (or any of the
revisions as the
structure is  refs/changes/<2 digit sharding>/<change id>/<revision count>
"revision" translates to the concept of resending a patch series v2,v3 here)

Alternatively I could ask you to look for a "Change-Id" that is a hash in the
footer of a commit, so you can find it in the Git-history or on the review site.

Gerrits flaws are off topic to this series though (maybe?)

>
> Whereas in Dennis's patches, it was about specific information directly
> related to the act of pushing.

But does it cover all the informations related to pushing? like

  "I am a bot, down-prioritize me, please"
  "I am a bot, therefore I do not care about the internal replication
on the server"

The last one is interesting as it is very specific to our servers. So you could
argue we'd want to roll our own fork of Git that also covers such a hook option,
but I think it is easier for both the Git community as well as us here to allow
Git transmit free form text and the server can decide how to act upon it?

>
>> * When pushing to Gerrit you can already attach some of this information by
>>   adding a '%' followed by the parameter to the ref, i.e. when interacting with
>>   Gerrit it is possible to do things like[1]:
>>
>>     git push origin HEAD:refs/for/master%draft%topic=example%cc=jon.doe@example.org
>>
>>   This is not appealing to our users as it looks like hacks upon hacks to make
>>   it work. It would read better if it was spelled as:
>
> Heh. It _is_ hacks upon hacks, isn't it? ;)

I do not disagree. Now is the time to do it right, but we like the
convenience of having just
one tool (Git) that can do it all for us. We don't want to write yet
another wrapper script that
does the HTTP API thing. ;)


I might have missed the point of this email completely as I seem to
try to defend the
patch series (and Gerrit a bit). So do you think the functionality of
this series is overkill
and we'd rather go with Dennis series?

I just think that is not future proof on the wire as it restricts what
you can put on the wire
as well as not future proof as it specifies what you options you can
select over the wire.

Gits spirit (Oh no, not this discussion!) is to allow a broad range of
uses and work flows.
It doesn't hinder you from shooting into your feet if that's what
you're into, and
that is what this series does precisely.

>
> -Peff

Thanks,
Stefan
