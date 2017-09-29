Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A8D42047F
	for <e@80x24.org>; Fri, 29 Sep 2017 11:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbdI2L7K (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 07:59:10 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:53362 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbdI2L7J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 07:59:09 -0400
Received: by mail-it0-f49.google.com with SMTP id 85so1784079ith.2
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 04:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eijFmUrw3Comxg0qhDfsKkX829zgQ2K2EVvoLlvroGY=;
        b=U5/kOXfvkO5JvhkpT7MeJmUtAD4Mzj1fDCkxkgCI69QRmTe0FEKKAWpO/VjtAHuu9f
         0Gj/WWYOOY6IS/jvBE/NOhUHRdQxnTxaHtR6z9QQ40g/P2cFOm/AhmFa4A9xKDFK5fWC
         qxLoTYZHfVloQgJOIVV++H0JKKEcNojJHw5HZWMDJK5bnlDB98AcI9k4+PohcYhIlxDj
         oHGuwfPHsaTMWMSCVpEpnkIZbJq1CA46FcKJbvO39TA7qczkqi0UybTfPOX8e6WkjVYS
         91SuPgdeOBm0Imr8kFmJxyBDPzovBEiyBeLsiQKMOeENQXwHZxR14YF0A2TdzBmGXVlb
         VFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eijFmUrw3Comxg0qhDfsKkX829zgQ2K2EVvoLlvroGY=;
        b=FGS0OpHIs3Qx9nEUM1F3SXBkLmPqKOSv/LtrarH2CVY+GRcbO5B/UY8hEN1BlykJU7
         ovPVoHp+JtC8gF5rTEuaXcGu/655pOZTu5g36ma3g5rL93J3bxr51wHp/cRbNOUL9x2i
         jYPQvn4vup+JOVcYI1p/lg8RWDHflRraoGHFNGgGguEpLUP9qJQndum0Ow21MQwbw49Y
         erI4g9q8U48oamWCAYCjUph/LyCgszeNFKnLeY/7lmGUm4W5YH2hd7dscGWPQZ0rUm2I
         TfjQ/XiUaTjVtXA5lBgqzVga4fgC7r/47G74UA+YhPecaOw6F1/0PBWZPSrTiHCKfRB0
         y+tg==
X-Gm-Message-State: AMCzsaXh2GpIyoFildLUfdfypWwvVDeChNTX8d754TU+jrP7mzK+XBFR
        XF5caNgZlatHQzK5R4jRl75Ijjux9ohSibjKpjTqGw==
X-Google-Smtp-Source: AOwi7QB6EN0aaL9JNXh6oYETfIkW+5uWhD+rLAhNUqJdhNR2AGM/h9ski2SoOXY7nnOCdRj3a3XzsY/YJdAzFIDkGAQ=
X-Received: by 10.36.17.200 with SMTP id 191mr6502980itf.37.1506686348554;
 Fri, 29 Sep 2017 04:59:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.175.10 with HTTP; Fri, 29 Sep 2017 04:58:28 -0700 (PDT)
In-Reply-To: <xmqqh8vmxfoq.fsf@gitster.mtv.corp.google.com>
References: <20170928223134.GA30744@varnish> <xmqqh8vmxfoq.fsf@gitster.mtv.corp.google.com>
From:   Dridi Boukelmoune <dridi.boukelmoune@gmail.com>
Date:   Fri, 29 Sep 2017 13:58:28 +0200
Message-ID: <CAJYncsiou3WjNhvn4YuzjuyqGknSgWmXewFhgD5M1j+Wsmmefw@mail.gmail.com>
Subject: Re: [PATCH] git-sh: Avoid sourcing scripts with git --exec-path
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Thanks for the fast feedback, I'll answer everyone in a single email
if you don't mind.

On Fri, Sep 29, 2017 at 5:48 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
snip
> I wonder if we can make this so intuitive that it doesn't need
> mentioning in CodingGuidelines.  What if the test harness
> t/test-lib.sh were to set a GIT_EXEC_PATH with multiple directories in
> it?  That way, authors of new commands would not have to be careful to
> look out for this issue proactively because the testsuite would catch
> it.

Now that you pointed out that I missed the relevant documentations, I
don't think this belongs in the guidelines at all.

snip
> Do git-mergetool--lib.txt, git-parse-remote.txt, git-sh-i18n.txt,
> and git-sh-setup.txt in Documentation/ need the same treatment?

That is embarrassing, I thought I had done my research properly...

> Summary: I like the goal of this patch but I am nervous about the
> side-effect it introduces of PATH pollution.  Is there a way around
> that?  If there isn't, then this needs a few tweaks and then it should
> be ready to go.

The PATH is already "polluted" when git-* commands are run via git,
and in the context of a script using git-sh-setup I wouldn't consider
that completely irrelevant.

On Fri, Sep 29, 2017 at 5:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> This has been broken for a while, but better late than never to
>> address it.
>
> I am not sure if this is broken in the first place.  We do want to
> make sure that the scripted porcelains will source the shell helper
> library from matching Git release.  The proposed patch goes directly
> against that and I do not see how it could be an improvement.

But the problem is that just by having a GIT_EXEC_PATH you will source
an incorrect file name. If there was something like --exec-dir that
wouldn't take the PATH into account. Before I tried to contribute a
fix, my local patching of git-sh-setup after git-core upgrades was
actually this:

    -. "$(git --exec-path)/git-sh-i18n"
    +. "$(GIT_EXEC_PATH= git --exec-path)/git-sh-i18n"

That's not pretty, but it gives the guarantee to source from matching
Git release. Considering the PATH semantics, this is how I would fix
it after reading your feedback.

On Fri, Sep 29, 2017 at 6:21 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> This has been broken for a while, but better late than never to
>>> address it.
>>
>> I am not sure if this is broken in the first place.  We do want to
>> make sure that the scripted porcelains will source the shell helper
>> library from matching Git release.  The proposed patch goes directly
>> against that and I do not see how it could be an improvement.
>
> It used to be that git allowed setting a colon-separated list of paths
> in GIT_EXEC_PATH.  (Very long ago, I relied on that feature.)  If we
> can restore that functionality without too much cost, then I think
> it's worthwhile.
>
> But the cost in this patch for that is pretty high.  And
>
>         $ git log -S'$(git --exec-path)/'
>
> tells me that colon-separated paths in GIT_EXEC_PATH did not work for
> some use cases as far back as 2006.  Since 2008 the documentation has
> encouraged using "git --exec-path" in a way that does not work with
> colon-separated paths, too.  I hadn't realized it was so long.  Given
> that it hasn't been supported for more than ten years, I was wrong to
> read this as a bug report --- instead, it's a feature request.

Well, from my perspective it's a bug report, upgrading git caused a
regression in my setup. I didn't know I was doing it wrong ;)

snip
> Another possible motivation (the one that led me to use this mechnism
> long ago) is avoiding providing the dashed form git-$cmd in $PATH.  I
> think time has shown that having git-$cmd in $PATH is not too painful.

In my case, yes, I'm maintaining commands but don't really want to
pollute my general-purpose PATH. But I can live with that and use PATH
instead.

On Fri, Sep 29, 2017 at 7:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Dridi Boukelmoune <dridi.boukelmoune@gmail.com> writes:
>
>> For end users making use of a custom exec path many commands will simply
>> fail. Adding git's exec path to the PATH also allows overriding git-sh-*
>> scripts, not just adding commands. One can then patch a script without
>> tainting their system installation of git for example.
>
> I think the first sentence is where you went wrong.  It seems that
> you think this ought to work:
>
>     rm -fr $HOME/random-stuff
>     mkdir $HOME/random-stuff
>     echo "echo happy" >$HOME/random-stuff/git-happy
>     chmod +x $HOME/random-stuff/git-happy
>     GIT_EXEC_PATH=$HOME/random-stuff
>     export GIT_EXEC_PATH
>     # then...
>     git happy

Exactly!

> But that is not the right/officially sanctioned/kosher way to add
> custom git commands (adding your directory that has git-happy in it
> to $PATH is).  GIT_EXEC_PATH is for the git-cmd binaries and scripts
> we ship; it always is used to find non built-in commands, and even
> for built-in commands, the command found via alias look-up is invoked
> that way.

The git(1) manual says:

> This can also be controlled by setting the GIT_EXEC_PATH environment
> variable.

This is why I set up my system like this years ago. The manual could
say when the envvar usage is appropriate.

> By insisting on overriding GIT_EXEC_PATH and not populating with
> the stuff we ship, you'd need a workaround like your patch just to
> make the scripts "work" again.  I have a feeling that even with your

I forgot about that, and I actually had to look at my bashrc to realize that
GIT_EXEC_PATH completely overrides the exec path. I did this, and
forgot about it once I was done:

    export GIT_EXEC_PATH=<my-path>:"$(GIT_EXEC_PATH= git --exec-path)"

So for so while I managed to convince myself that git --exec-path
always includes the local installation path. Today I re-learn.

> patch you wouldn't be able to make non built-in commands, unless you
> copy them (or write a thin wrapper that exec's the real thing).
>
> So, instead of the two GIT_EXEC_PATH steps in the above example,
> you can do
>
>         PATH=$HOME/random-stuff:$PATH
>
> and you'll see "git happy" to work, I would think, without breaking
> other things.

That creates a gap between git-core commands being in libexec outside
of the PATH and my git-* commands having to be in the PATH even though
they aren't meant to be executed directly.

Should I attempt a new patch? I'd make sure to source by neutering
GIT_EXEC_PATH and update the relevant documentation this time.

Thanks for the review, it has been very instructive, even for a simple shell
problem!

Dridi
