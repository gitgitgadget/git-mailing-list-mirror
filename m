From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/7] submodule groups
Date: Thu, 12 May 2016 09:35:43 -0700
Message-ID: <CAGZ79kZHbAiP13rC+VLnFUtoxPZEcyx_wkrxfKb+cGBxQaojZQ@mail.gmail.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<xmqq37pnj04f.fsf@gitster.mtv.corp.google.com>
	<xmqqoa8bgten.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 18:35:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0taW-000598-NB
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 18:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbcELQfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 12:35:45 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36202 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbcELQfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 12:35:44 -0400
Received: by mail-io0-f182.google.com with SMTP id i75so96632409ioa.3
        for <git@vger.kernel.org>; Thu, 12 May 2016 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=011ByLakQqs+qrx79EtQrqQfrnV5vNYmELOQ8trq/eI=;
        b=HnZZny1htIvmTrAEJcLa03Oy/IL263JwRFxSDRwxT2ZLjucYOTg6d8GiY4pys0BlTF
         LfN4hmjsWeRbpuLPHMniJifEctZoSPCPUvG3Ip4cEuxafbhMnVEkqF6ZbjxlzyNK5Nkx
         sgQSqHOHCLk3mMl1wpbkIWBD3XXLnJZPugn0bmjL5DusDvDyGEcgYHqKfFbM7/QjuB9d
         pLuxLRiu0o6uOrcXeFolOTyDyREZf7tfrRTP8wEa55blG7JWqXRk9h6nCzdL0MZK3aOh
         oMbUtOLnuS/17vBg4rmrGfIZPhjxhlPXkbdf/TSapBfz55pfkSBMe1CbMHyu9BCr7HW5
         orfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=011ByLakQqs+qrx79EtQrqQfrnV5vNYmELOQ8trq/eI=;
        b=G/HsDioGuBShd5mpc+lfL7RPfPzLfHPgR5EziMaCNwbo49hAgKYz88yWkGUn9KS3if
         wTXfWlbiqcOwmlUh+Ngmhm1SS2WIydJO/OTjTXeCZiRgMdmIbMmbQSuGwea3keWuF8V7
         WZY9OXV6jnOeZg074Gi3bwB0TyG45Z7rc6YomwyiIgdJdyAKbDVyqaptQ78zfCcibexE
         X84vsJvBNvhyqFAihJXJaiB5S3trDhPL9JUcaYa4IPpWJ1u1retBYXYBcYDckI1ViU8W
         ikU4vjOjAzy2vd3C1Plw2KR10SDlOc+tgTrlK45Dxx3Oyuas9HkQ3EDP1LxERaZh8DBU
         DJ2Q==
X-Gm-Message-State: AOPr4FXUNqwxChRZ/qy+YsFxUEmvjA32NX90vxvunsFcjg4Iw59O6zx0sgeOOP96U4rVKNv2wi3GU2IeIOy7RWBN
X-Received: by 10.36.62.133 with SMTP id s127mr7436643its.98.1463070943553;
 Thu, 12 May 2016 09:35:43 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 12 May 2016 09:35:43 -0700 (PDT)
In-Reply-To: <xmqqoa8bgten.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294417>

On Thu, May 12, 2016 at 8:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> The reason why I suspect that this may not work well with submodule
>> labels is because submodule labels (or any attribute we give via
>> .gitmodules to a submodule) are keyed by a submodule name, which is
>> the primary unchanging key (so that people can "mv" a submodule in
>> the context of the toplevel superproject without losing track of
>> submodule identity), not by paths to submodules, while the "group"
>> thing I want is merely a short-hand for pathspec elements and wants
>> to be keyed by paths.
>>
>> But there may be somebody more clever than I who can come up with a
>> way to unify these two similar concepts without confusing end users.
>
> Thinking about this even more, if there is no requirement that
> labels must be tied to submodule names, we just can scrap the idea
> of "submodule labels" to group things and instead just use "path
> labels", i.e. write the full path to the submodule and assign it a
> label in .gitattributes and use it in place of where we used *label
> in the patch series.  After all, an easy way to choose some among
> many submodules logically is a subset of an easy way to choose some
> among many paths.
>
> The only reason why we added the submodule label to .gitmodules is
> because we viewed it as submodule-specific thing and the "keyed by
> name, not path" came as a consequence, not because any real "we must
> key it by name because..." reason, I would think.
>
> I know this is a huge departure from the design presented both at
> the conceptual level and also at the implementation level, and that
> is one of the reasons why I do not particularly want to like it, but
> on the other hand, I am not bold enough to say that I will have a
> good answer when later somebody asks "Why can we group only
> submodules with labels, but not random group of paths (e.g. 'these
> directories are about documentation')?"  And then, if we add path
> labels to allow expressing groups of paths later, the follow-up
> question would be "When should I use submodule labels and when
> should I use path labels?  I can use path labels to group submodules
> and say 'git submodule update -- :(group=docs)' can't I?".
>
> And that makes me pause and step back from the "submodule labels"
> idea.
>

It sounds better at first (and I haven't thought further).
So if we were to go with this idea:

Label paths (or even pathspecs?) in the .gitattributes file.

I think it is important to keep the property of defining the labeling
in the tree, so you can follow upstream easier.

I tried coming up with an example for labels for generic paths,
but it looks like most of the time it is a substitution for a pathspec,
I did not find a convincing example which makes it easier to use.

`:(group=docs)` in the non submodule case could be expressed
as `Documentation/**`. Well maybe we also want to include README
and some other files which need to stay outside the Documentation
directory, so I can see how it may be useful.

We do not need a special labeling command. We do not
ship with a command which writes the .gitattributes or .gitignore
for you, and labels don't require this. So I could drop the patch
for "submodule add --label".

We can still keep the submodule.defaultGroup. (In the WIP I renamed
it to updateGroup as its only feature is to have it set during clone
and remebered for `git submodule update`)

When we allow labels to be generic path labels instead of submodule
labels, the user might be tempted to ask, why the submodules can
be specified but not the individual paths, i.e.

    git clone --init-submodule="(:group=docs)" ...

may strongly hint at:

    git clone --narrow="(:group=docs)" ...

would only get parts of the repository.

For the submodule case, this may add confusion as the user would
need to configure some properties in the .gitmodules file and some
in the .gitattributes file.

I think I'll try implementing a mock and see how much code it is for
a more fundamental pathspec extension.

Thanks,
Stefan
