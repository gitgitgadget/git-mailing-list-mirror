Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C71F1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 17:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934111AbcLIR2i (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 12:28:38 -0500
Received: from mout.gmx.net ([212.227.17.20]:62962 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932464AbcLIR2h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 12:28:37 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmNHK-1cnuht0bOU-00Zu36; Fri, 09
 Dec 2016 18:28:27 +0100
Date:   Fri, 9 Dec 2016 18:28:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/7] Pie-in-the-sky attempt to fix the early config
In-Reply-To: <20161208172626.3ee2nmgsxsh2vovf@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1612091810500.23160@virtualbox>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <20161208172626.3ee2nmgsxsh2vovf@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:o/FrcK1edAc+nrjvoF0r79jnr9ncQV6Ckso/1jvUXjaPApgXcPJ
 LtzJDbyLubLyB2JWm7+RRcrV9EtNGj0cFVkYG6n2jCHwTQTsyXBqc4K+Lb2NvOqmnXnGAEL
 2q603Vl+7NtcQ0BugSEPn+CqCA06pFUUXavVQ51khXqSAeLabAPW2+fKimlkzHZiaxujHJZ
 si0OneX181NApIF4KL1ww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YXkxGBqKiRs=:dh/ES7nRVJB8ymuSD6G1Am
 8gGl1sUWqAcKRBxvgkKl60u4G4KpOX3fny2JaE1QcppQs/u09PkrTG0wJhm5eEdzWnIK06wdR
 ovZlPi2+iQYRajxw0ibM+sEbqfsVxSotbnpBDvNTqunugs0ztNP3cO4sV6I2q7nUTAOHCtw2e
 o+JoyynUFIeNXByJQoWXcvb5hkyQARKhfPRL3nOejo+R0lFgY/Gp9pX0wQrYzMkYB/PCreYYn
 KWa2rlfhx68eb+weE93OhsXEZWe1V7jDswTvKknBo2Mgp62usFIdQkbilb2GNY5rMkA/XJT8r
 Z4aXVnZFpNZsOYNcg14AEj9KFeIoPnBDnLbBwtmfOWLrGJaE4ej21X6PXWtD7onx6K9kEuckO
 IsKGjh9ASMCnhk+oLHu2O+2DZtN4UsoQvSSwnyaZNYlGPzmWMBbisI5DUS3uZnPa4LgomYNGp
 tXYQctyI6iKgMsGEL7WsYkCWwOwMvQxAence5UVtzQVR+K2+JcCpcqMFthsVTLuBAmj8cmG+k
 BA96kWdqwm/XViKFPlFX/2pPd5hTIr/ZJ8Q4TeFPpnOG/N0d+hAaocT8zCyt8s8vKPg+KGbIa
 CK+Oshv6MK1HCCEJ7Q2WXLBoPALwe8JPqz2yD4ESDxTXv8wi8aRRFugy00JEsP3rEolTo1vkA
 qKZmGAEXA+T9uVtpMLZRBjTRNd3iiQJ4vr0PuH+e8UUBbchBdkaXNDTMtFEZ4L7DZyTW0LUf0
 UJdRDE2WuIg0HAqDqRGVT9SKPVn6j4ZJEXQvbmFSvJpXxqlkGmM4Hci9GDXh3zYHRbTKp3EkV
 pba75yt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 8 Dec 2016, Jeff King wrote:

> On Thu, Dec 08, 2016 at 04:35:56PM +0100, Johannes Schindelin wrote:
> 
> > The idea here is to discover the .git/ directory gently (i.e. without
> > changing the current working directory), and to use it to read the
> > .git/config file early, before we actually called setup_git_directory()
> > (if we ever do that).
> 
> Great. Thanks for taking a stab at this.

Well, I figured that I can go through you to get this integrated into
git.git.

> > Notes:
> > 
> > - I find the diff pretty ugly: I wish there was a more elegant way to
> >   *disable* discovery of .git/ *just* for `init` and `clone`. I
> >   considered a function `about_to_create_git_dir()` that is called in a
> >   hard-coded manner *only* for `init` and `clone`, but that would
> >   introduce another magic side effect, when all I want is to reduce those.
> 
> It looks like a lot of that ugliness comes from passing around the "are
> we OK to peek at git-dir config" flag through the various pager-related
> calls.

Correct.

> I don't think it would be bad to use a global for "we do not want a
> repo".

I would think it would be bad, as the entire reason for this patch series
is that we have global state that gets messed up too early (I am speaking
from the point of view of somebody who patched Git locally so that it does
read config variables *before* launching builtins).

> After all, it's just modifying the _existing_ global for "are we in a
> repo".

No it does not.

The read_early_config() function specifically does not leave any traces in
the global namespace. It calls the git_config_with_options() function
without touching the_config_set.

Of course we could introduce a new config set, just for early use. It
would share all the downsides with the current config set.

I would look more favorably on this idea if we were to teach
the_config_set to record a little bit more about the state from which it
was constructed, and to auto-flush-and-re-read when it detects that, say,
git_dir was changed in the meantime.

> And I do not see that global going away anytime soon.

And that is really, really sad.

> Sometimes it's good to make incremental steps towards an end goal, but
> in this case it seems like we just pay the cost of the step without any
> real plan for reaping the benefit in the long term.

Fine. Let's roll with this for now, then.

I just hope that we do not repeat the "slam the door shut to a better
solution" mistake that led to this situation, as the chdir() way did.

> As an alternative, I also think it would be OK to just always have the
> pager config read from local repo, even for init/clone.

For the purpose of this current discussion, I am utterly uninterested in
the pager config. What I want to use the early config for is substantially
different and more relevant: I need to configure some command to run
before, and after, every single Git command here. And this configuration
needs to be per-repository. And no, I do not want to hardcode anything.

So now the cat is out of the bag, I have ulterior motives.

These motives serve a greater good, though: designing read_early_config()
around a very specific use case will always fall short of a well-designed
read_early_config() that could then be used for any use case that
requires, well, reading the config early.

> In other words, to loosen the idea that git-init can _never_ look in the
> current git-dir, and declare that there is a stage before the command is
> initiated, and during which git may read local-repo config. Aliases
> would fall into this, too, so:
> 
>   git config --local alias.foo init
>   git foo /some/other/dir
> 
> would work (as it must, because we cannot know that "foo" is "init"
> until we read the config!).

True.

But is this a good excuse to just shrug our shoulders and let git-init
(which we do know very well) fall into the same trap?

> > - For the moment, I do not handle dashed invocations of `init` and
> >   `clone` correctly. The real problem is the continued existence of
> >   the dashed git-init and git-clone, of course.
> 
> I assume you mean setting the CREATES_GIT_DIR flag here? I think it
> would apply to the dashed invocations, too. They strip off the "git-"
> and end up in handle_builtin() just like "git clone" does. I didn't test
> it, though.

You are correct. I misread the code to expect it to spawn another instance
of git.exe.

> > - There is still duplicated code. For the sake of this RFC, I did not
> >   address that yet.
> 
> Yeah, I did not read your discover function very carefully. Because I
> think the one thing we really don't want to do here is introduce a
> separate lookup process that is not shared by setup_git_directory(). The
> only sane path, I think, is to refactor setup_git_directory() to build
> on top of discover_git_directory(), which implies that the latter
> handles all of the cases.

This could maybe happen later, but for now I do not concern myself with
building the prefix, as the config machinery does not require that
knowledge.

If we go that route, we should of course cache the cwd, git_dir and prefix
of earlier runs, and avoid the entire discovery if we start from the same
cwd.

> > - The read_early_config() function is called multiple times, re-reading
> >   all the config files and re-discovering the .git/ directory multiple
> >   times, which is quite wasteful. For the sake of this RFC, I did not
> >   address that yet.
> 
> We already have a config-caching system. If we went with a global
> "config_discover_refs",

Why "_refs"?

> then I think the sequence for something like git-init would become:
> 
>   1. When git.c starts, config_discover_refs is set to "true". Pager and
>      alias lookup may look in .git/config if it's available, even if
>      they go through the configset cache.
> 
>   2. As soon as git-init starts, it disables config_discover_refs, and
>      it flushes the config cache. Any configset lookups will now examine
>      the reduced config.
> 
>   3. When git-init has set up the real repo it is operating on, it can
>      reenable config_discover_refs (though it may not even need to; that
>      flag probably wouldn't have any effect once we've entered the
>      repository and have_git_dir() returns true).

That is a bit fiddly, don't you think? The callers have to have very
intimate knowledge of the config reading to remember to set, and re-set,
that global. And to flush when appropriate.

How much nicer would the code be if the call to git_config() would realize
what needs to be done, don't you agree?

Less chance for bugs to be introduced by contributors with flakey
understanding of the config/git_dir machinery, myself included.

> > - t7006 fails and the error message is a bit cryptic (not to mention the
> >   involved function trace, which is mind-boggling for what is supposed
> >   to be a simply, shell script-based test suite). I did not have time to
> >   look into that yet.
> 
> Running t7006 I see a lot of old failures turned into successes, which
> is good (because running from a subdirectory now actually respects local
> pager config). The one failure looks like it is testing the wrong thing.

Yeah, but due to the redirections I was not able to figure out what to
change to "fix" this.

> It is checking that we _don't_ respect a local core.pager in some cases,
> as a proxy for whether or not we are breaking things by doing setup too
> early. But the whole point of your series is to fix that, and respect
> the config without causing the setup breakage. After your patches, the
> proxy behavior and the failure case are disconnected. The test should be
> flipped, and ideally another one added that confirms we didn't actually
> run setup_git_directory(), but I'm not sure how to test that directly.

Some dirty tricks come to mind, but I am not even sure that I want to test
for this. Why exactly do we need to avoid calling setup_git_directory() in
that case?

> > - after discover_git_directory_gently() did its work, the code happily
> >   uses its result *only* for the current read_early_config() run, and
> >   lets setup_git_dir_gently() do the whole work *again*. For the sake of
> >   this RFC, I did not address that yet.
> 
> If caching happens at the config layer, then we'd probably only call
> this once anyway (or if we did call it again after a config flush, it
> would be a good sign that we should compute its value again).

I meant the git_dir, not the config... The git_dir is discovered, but a
subsequent setup_git_dir_gently() discovers it *again*, in a different
way.

Ciao,
Dscho
