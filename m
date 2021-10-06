Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3495C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9507C60F5D
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbhJFUev (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:34:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:56357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229737AbhJFUeu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 16:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633552368;
        bh=3zN/GNowWxkVEO8IGMXf0Kbx8JkGsaUZQViUg08bEc0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RKYk5uASD5wPBmhl35MsGhJPYTHgMdGlI8AbUH5eZPe6A4AP5eV1ep9LxJWTYyEa6
         zrOB3igqefT8jioi0S/Tmi9RBmvJTuQQtcKRw8Z/9TWKHvD4L3rid74ZWCxvBsM35f
         44bmqD5FmOU4cAGrNXp+v0FarsJfo0rikBaCHmmc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.23.42] ([46.183.103.8]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbBu-1moMlU3WUQ-00safX; Wed, 06
 Oct 2021 22:32:48 +0200
Date:   Wed, 6 Oct 2021 22:32:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 04/15] scalar: 'register' sets recommended config and
 starts maintenance
In-Reply-To: <CABPp-BG_wupp1o5bBSYOJSvF3eJjf=TbX0RBHqqKuD+3F8s6hw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110062211500.395@tvgsbejvaqbjf.bet>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com> <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com> <bbbc4c3339043bcd718dd2defcbaaaac2092227a.1631630356.git.gitgitgadget@gmail.com>
 <CABPp-BG_wupp1o5bBSYOJSvF3eJjf=TbX0RBHqqKuD+3F8s6hw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Lnp3TkImKNZiyrDta7PdIobT4lLr6SaqFWT/fJUrhVL1WydC9gx
 E7QmTqxZHfH7lhRJxdt1DGuxcQZWHQZI4ZiJ3NddxBlRVmOGr57liP60DVF2lXRajLKc3KQ
 N3PhtmO1FrgJenvCq9wE/cXf+R+moz+/r4Xnp+J/CsCux76t9nbZDzGWdECNtWcxhbCtLdB
 3UenoGVDfmp92wkrn9KeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EDIFLr8/y1I=:wK3L5e3FLIpvAfbe5cp+Ml
 0hkP8F1rLdq/J0C0PztekAkPL9OtOgigkPVW3Xg+S3qh7/jKaGfTImrF1vV/5fN5pztMLqTSb
 2FzQOILaHsy3pefeS9+ImhPdUQE8ebLk2aKAlSVV+dIsWPjGVY9KIOw0erSRCgPPJ0ChWlgTN
 TKwHd9uJZus78s2ZuwljcUEqm/rxyFsAlCK0DGxd33meu8bihPhAfvzZ3LvBPAYLsw6f67Ii1
 ddK8yQQnuWe20zGKc65MZgLW1wCscwxLQNqK2hOfm+f58Db4HQvjs0WW59HfPLfYTZ76DP7zB
 nGT9S6IW4QnFdGnIAXiphadIUTmsHs7Qu+yhblRA9XF/PsU1mDEH7rKy10QPj20xZyDU+BvGY
 e1oHVhfct9Sf2UOFL2hBRpXzwPLHCJUony5aUCBrFVDJKOZ+RcmCKK5RF/03vJEhDuJKMaPIJ
 AvWDSdiHtwmPx7oTsChb2Xu/UURdAGqnOWAufxiNrjeuree77Z1P/1q+sZviMPITD3k2cYl4E
 mfhF07sn8SIaluvnkf5m4RHG9ljO6or2zW5VKih9tAubdqjjBh/qFF+VITc4CDHgC20d9CTvF
 LJ5s2E1K7QrNcTMAT5o7XxcA54zVAfnAI1WheX2DOl2qdSxb37eI5HlQOFgQsacxU3FhVxUn9
 GgQseSkyMBez7oxq2PGJiIf/lahwvaz6F1cAXk6H+oyhyBoFctFC+30NMzLE5dQN0+NpGYtpQ
 PtOsPj30JBAKygak2A+ODhoy6HcPwe/reyKx13d9h4GfqvnJhCLydrKWYy5YR9JVBqcQb4vyd
 n+yYHLIHGlyXeEoGsUw870xCeX8AJ4zHM64uZW7deIXo9HuNn3+DgobmEM9j4njr1ch1Ie+vz
 amtEdL18vhUyhXnJGinWTKxFSCNa4nMDO5jHKHqJmeYo0pX2VQn3d5L8ie0Dtdw5lyGlD5pDV
 S3w9z6mAy1wtYpy1mRc6w8yQQUbGGdhaMhHLsnHqQfrssnEPQbknCAglJntme4jWfe1Lg3sBg
 yAWvo89Nx1FR12/yP1yojlx8Vh80/icqmSOThGZScHdLzXUA59KwIzI983LIs3UYTZmQnB1Dc
 ri6EOypjXfGTm8M66XG2q5X1P9mDxutAFlu
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 27 Sep 2021, Elijah Newren wrote:

> On Tue, Sep 14, 2021 at 7:39 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> ...
> > +static int set_recommended_config(void)
> > +{
> > +       struct {
> > +               const char *key;
> > +               const char *value;
> > +       } config[] =3D {
> > +               { "am.keepCR", "true" },
> > +               { "core.FSCache", "true" },
> > +               { "core.multiPackIndex", "true" },
> > +               { "core.preloadIndex", "true" },
> > +#ifndef WIN32
> > +               { "core.untrackedCache", "true" },
> > +#else
> > +               /*
> > +                * Unfortunately, Scalar's Functional Tests demonstrat=
ed
> > +                * that the untracked cache feature is unreliable on W=
indows
> > +                * (which is a bummer because that platform would bene=
fit the
> > +                * most from it). For some reason, freshly created fil=
es seem
> > +                * not to update the directory's `lastModified` time
> > +                * immediately, but the untracked cache would need to =
rely on
> > +                * that.
> > +                *
> > +                * Therefore, with a sad heart, we disable this very u=
seful
> > +                * feature on Windows.
> > +                */
> > +               { "core.untrackedCache", "false" },
> > +#endif
>
> Interesting.  (I'm somewhat leery of the untrackedCache just knowing
> that it used to operate despite an exponential number of visits to
> files (exponential in depth of directories) and getting different
> answers with different visits, making me feel like it was black magic
> that it ever worked and wondering what kind of corner case issues
> still lurk with it.  See e.g.
> https://lore.kernel.org/git/CABPp-BFiwzzUgiTj_zu+vF5x20L0=3D1cf25cHwk7KZ=
Qj2YkVzXw@mail.gmail.com/)

The implementation of the untracked cache certainly is quite a challenge
to wrap one's head around, for sure. However, it does manage to speed up
operations substantially (when it works).

The real fun starts when you turn on the FSMonitor, though. Then it is
reliable, all of a sudden! The reason seems to be some sort of delayed
lastModified (AKA mtime) evaluation which is somehow triggered by
FSMonitor ;-)

So in microsoft/git, where we include FSMonitor and turn it on as part of
`scalar clone`, we also enable the untracked cache, for noticeably happier
users.

> > +               { "core.logAllRefUpdates", "true" },
> > +               { "credential.https://dev.azure.com.useHttpPath", "tru=
e" },
>
> Not only opinionated, but special configuration for certain sites?
> I'm not complaining, just slightly surprised.

Yes. I am not aware of other sites where you would want to use different
credentials depending on the URL path, but Azure DevOps definitely is such
a site, and therefore needs `useHttpPath`. Rather than requiring users to
know this, we set it for them.

> > +               { "credential.validate", "false" }, /* GCM4W-only */
> > +               { "gc.auto", "0" },
> > +               { "gui.GCWarning", "false" },
> > +               { "index.threads", "true" },
> > +               { "index.version", "4" },
>
> I take it your users don't make use of jgit?

Nope ;-) I doubt that the features we use to make Git scalable are
implemented in JGit.

> (Users aren't using jgit directly here, at least not to my knowledge,
> but multiple gradle plugins do.)  I tried turning this on a while back,
> and quickly got multiple reports of problems because jgit didn't
> understand the index. I had to turn it off and send out various PSAs on
> how to recover.

TBH it gives me shivers of dread thinking about large
repositories/worktrees being handled within a Java VM. The amount of,
let's call it "non-canonical" code, required by JGit to make it somewhat
performant, is staggering. Just think about the way you have to emulate
mmap()ing part of a packfile and interpreting it as a packed C struct. I
forgot the details, of course, and I am quite glad that I did.

> > +               { "merge.stat", "false" },
> > +               { "merge.renames", "false" },
>
> Is this just historical and not needed anymore, is it here just for a
> little longer and you are planning on transitioning away from this, or
> are you still set on this setting?

It is here mostly for historical reasons.

> > +               { "pack.useBitmaps", "false" },
>
> I don't understand anything bitmap related, but I thought they were
> performance related, so I'm surprised by this one.  Is there a reason
> for this one?  (Is it handled by maintenance instead?)

Again, this is here for historical reasons. Scalar sets this, and my goal
with this patch series is to port it from .NET to C. So I did not question
the reasoning.

My _guess_ however is that bitmaps really only work well when everything
is in one single pack. Which is rather not the case with Scalar
enlistments: they are way too large to be repacked all the time.

> > +               { "pack.useSparse", "true" },
> > +               { "receive.autoGC", "false" },
> > +               { "reset.quiet", "true" },
> > +               { "feature.manyFiles", "false" },
>
> If you simply set core.untrackedCache to false _after_ setting
> feature.manyFiles to true, would it make sense to switch this?  (Or
> does it matter, since you've already individually set all the config
> settings that this one would set?)

Frankly, I was a bit puzzled why `feature.manyFiles` was set to `false`.
The rationale is explained in
https://github.com/microsoft/scalar/commit/2fc84dba9c95:

	The feature.* config settings change the defaults for some other
	config settings. We already monitor config settings pretty carefully,
	so let's disable these.

As to switching this, it shouldn't matter. The idea of `feature.*` is to
set defaults, but not override any explicitly configured settings.

> > +               { "feature.experimental", "false" },
> > +               { "fetch.unpackLimit", "1" },
> > +               { "fetch.writeCommitGraph", "false" },
> > +#ifdef WIN32
> > +               { "http.sslBackend", "schannel" },
> > +#endif
> > +               { "status.aheadBehind", "false" },
> > +               { "commitGraph.generationVersion", "1" },
> > +               { "core.autoCRLF", "false" },
> > +               { "core.safeCRLF", "false" },
> > +               { NULL, NULL },
> > +       };
>
> Are there easy-ish ways for other groups of users to adopt scalar but
> change the list of config settings (e.g. index.version and
> merge.renames) in some common way for all those users?

Not in Scalar.

I would hope, however, that we could figure out ways to make this more
configurable when re-implementing this functionality in core Git. I have a
couple ideas, but nothing fleshed out, and besides, I do not want to think
too far ahead, I already made that mistake and then got bogged down in
discussions about minimal vs non-minimal changes in the top-level Makefile
;-)

So yeah, good point, but it's probably not a good time yet to discuss this
tangent.

Thank you for reviewing,
Dscho
