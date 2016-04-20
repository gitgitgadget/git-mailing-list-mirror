From: Stefan Beller <sbeller@google.com>
Subject: Re: bug: git submodule add fails when .git is a symlink
Date: Wed, 20 Apr 2016 10:31:47 -0700
Message-ID: <CAGZ79kZ2A6c9H7C4xPXJ1Lmh1TaVy+VgcjxvKrgcJb0-4LRvhA@mail.gmail.com>
References: <20160301204218.GA4083@kitenet.net>
	<CAGZ79kY6Lf6u0=s8J_cqRNFsry4nu2SdL0GZ2gkFsu6gBrB65Q@mail.gmail.com>
	<xmqq8u217tqa.fsf@gitster.mtv.corp.google.com>
	<20160301231720.GB3731@kitenet.net>
	<20160302084904.GA30295@sigill.intra.peff.net>
	<CAGZ79kbpyu34kz7gRgro-HZqNvpmRoCsyQatZRbxP19bk1gkfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joey Hess <id@joeyh.name>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 19:31:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asvyj-00018X-BQ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 19:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbcDTRbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 13:31:49 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35367 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbcDTRbs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 13:31:48 -0400
Received: by mail-io0-f178.google.com with SMTP id g185so59763958ioa.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=opNkYuEcuglBR7CxI8T+/ylwBMM+r22v+PmS75SvAc4=;
        b=E0Uu8zddexV5Exe6baznoNf4kPgOFgUaN+PcqECbzYb3sFe98k9wg/p3FZoFN5xUaJ
         QX0yGeiqjeZDA4VMMWjOk6mNAYjPOSWiVUT/UhvLch0L6xs92zFoo1D3hbm8fIKdSqh7
         Jmsq5BW57K++TntdiqZHYojUFAdQnwAX+LvGlsQHUgvaZwVDEO6IwzoXdtkyhwT7PCCS
         37JJHBopYQVKqalv/wU+Eq1gjvyap1Lrl4RyOpWxOdvoMYx76GgLGYQWyhn2SGdcIT1g
         GlQm16qbk2awRj3T++HE/YHRMECXIR3Kur5p/UK/8sy40emfkyq3V6r0gi/0Hh2F8khz
         nymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=opNkYuEcuglBR7CxI8T+/ylwBMM+r22v+PmS75SvAc4=;
        b=OLAx+3SoS5tgcN2u/XBASykP0wXM04xpN+JVQhmQ8F/UM1FiZVlccHSLJ9hzbF/DhL
         +gu57PI1VFeAYmBufx0euMubVdvn2P3iV3spLWHerk74iPPtfK+FOlQ7fSWEHhiB4RIr
         0jsoSwJUogLLqZQD/blPFKDJWHGp3pOyosevo65iVnKXLbaBnau+i+5KsfFmQPv9PhpO
         Lg/A4rsTovAXQCdi+W3cWo/BKexOlM0I8iwk9YVN8wW2DE3JUcIHaN4P9ncO23+udXRq
         Zgzv6jHukUrFTazW8yVmlzXOPLmX38h17g6b/N2MEyg/pK/VspwuimsdyLcFSoRGQ4cF
         0iCw==
X-Gm-Message-State: AOPr4FVP4ZA6V00mcyRtz+pQJmK2/bd1aw4Y6N5GsGkFoQSKGNTk4kLreudaPJHmMkIFut49cJDJzR5aPZOjODkN
X-Received: by 10.107.161.68 with SMTP id k65mr13023728ioe.110.1461173507265;
 Wed, 20 Apr 2016 10:31:47 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 20 Apr 2016 10:31:47 -0700 (PDT)
In-Reply-To: <CAGZ79kbpyu34kz7gRgro-HZqNvpmRoCsyQatZRbxP19bk1gkfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292047>

On Wed, Apr 20, 2016 at 9:41 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Mar 2, 2016 at 12:49 AM, Jeff King <peff@peff.net> wrote:
>> On Tue, Mar 01, 2016 at 07:17:20PM -0400, Joey Hess wrote:
>>
>>> Junio C Hamano wrote:
>>> > A more pertinent question may be which version of Git did the above
>>> > ever work, I guess.  We fairly liberally chdir around and I do not
>>> > think we deliberately avoid assuming that "cd .git && cd .." might
>>> > not come back to the original directory, for example, so I wouldn't
>>> > be surprised if it never worked.
>>>
>>> IIRC git used symlinks for .git in submodules before version 1.7.8, so I
>>> guess that older versions supported that pretty well.
>>>
>>> This one case is the only time I've seen a symlink for .git present a
>>> problem so far.
>>
>> Fortunately you provided a simple reproduction case, so it is easy to
>> bisect. It did work in v1.7.8, and broke in d75219b (submodules: always
>> use a relative path from gitdir to work tree, 2012-03-04). Not
>> surprising, I guess. It presumably worked before only because we were
>> using absolute paths.
>
> So I was looking into this bug again, as it was linked from another bug report.
>
> fatal: Could not chdir to '../../../sub': No such file or directory
>
> sounds like a path issue with the prefix thing.
>
> Using the " echo "gitdir: ../gitdir/.git" > .git" workaround does still work,
> I'll see if there is another way to fix it with actual links.

So I debugged into that using a test case

test_expect_success 'submodules are not confused by linked gitdir' '
        git init gitdir &&
        mkdir worktree &&
        (
                cd worktree &&
                #echo "gitdir: ../gitdir/.git" >.git &&
                ln -s ../gitdir/.git .git &&
                test_pause &&
                git submodule add ../ sub &&
                test_pause
        ) &&
        test_pause &&
        git status
'

My observation: the error comes up in `git submodule add`,
which consists of 2 parts: the cloning and then the checkout.
The cloning works fine using the new "submodule--helper update-clone",
the checkout however breaks. So in your original test case you can go
into the submodule and run

    git checkout -f -q

and you'll get the error message

    fatal: Could not chdir to '../../../sub': No such file or directory

Looking at sub/.git:

    $ cat .git
    gitdir: ../.git/modules/sub
    $ ls ../.git/modules/sub
    HEAD  branches config description  hooks  info  logs objects
packed-refs  ref

so that gitlink of the submodule works just fine. The problem is `git checkout`
or any other core command (I tested with `git status`) doesn't like
the gitlink pointing to a directory which is symlinked.

I think the issue is a wrongly configured "core.worktree"
in gitdir/.git/modules/sub/config which contains the "../../../sub".

So I think the fix needs to be in the vicinity of
builtin/submodule--helper.c:module_clone
near the end of the function, where core.worktree is set.

Thanks,
Stefan


>
>
>>
>> -Peff
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
