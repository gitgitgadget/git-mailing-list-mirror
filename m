Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA10C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 12:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79A2610FD
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 12:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbhHYMQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 08:16:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:43691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240605AbhHYMQL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 08:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629893687;
        bh=gs6d2LuJLzjthbzKkC89n05UTaUlS6BrOVcQxtdW0JI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Dx3Br+8BFNrzbyfVJ6YPJC9fpAdAywiL3TQMDEdIGDzgL3fwgyWKdWS9umcCX7u2R
         3mt/+zebXuk2A9kD604Sl7TwHEco9GsknbmPKaj2OvNiXNH4W82aH1MG1LdITJzwZ5
         oH/sz3Tk5aNJ8u8GzxfKs36Ee6l6uioPh3XMFmsA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRR0-1mSnyF2RCe-00TowH; Wed, 25
 Aug 2021 14:14:47 +0200
Date:   Wed, 25 Aug 2021 14:14:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?Q?Tr=E1=BA=A7n_Ng=E1=BB=8Dc_Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/1] ci: new github-action for git-l10n code review
In-Reply-To: <CANYiYbE6=+jbhea71r7Swqc012EOpaNiRequTeZQqfWnnB8gNw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108251316540.55@tvgsbejvaqbjf.bet>
References: <20210822161325.22038-1-worldhello.net@gmail.com> <20210822161325.22038-2-worldhello.net@gmail.com> <nycvar.QRO.7.76.6.2108232232460.55@tvgsbejvaqbjf.bet> <CANYiYbE6=+jbhea71r7Swqc012EOpaNiRequTeZQqfWnnB8gNw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1639975475-1629893687=:55"
X-Provags-ID: V03:K1:3p0xpft64VWCzP9jOL8X3b+IGqrINw5HzQ5fAOFOGQaXBLEnvqp
 jsEcXa3bEKTY6plcg11RSVgS+Vsyb1W/7iecFayGu/VuKrPbAVR7plJBfz/aylk38GWHPnw
 Vv5a1ARQoH+EXSS7QDDy7hVlX20LPjn7afarWr4WNoUJLdv7RCxImmz90P/scc19r+cVBJD
 RiwAoJa8fQiFh6MVA+yMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fm0D04fMmpc=:evdLJbajYepvkp0KdGmM4v
 Tcp5IoKAYEKm2Y18mncvZUq6G25eWs7rikvwZf8owk6JjP3aEfsAeLe4Is3DovOd83XQQcSp0
 PzGHNR0J4Ip7ziV3ZudboEWV/g0NaQ+ZrlENVHuEzybF4X9tPxw3DYWD/B7fwa1uASsemLypq
 F4ruPu29iRQm5IS6seO4CXrbSz3Eq7YmvfIPFWo9XJUFLXpheyG7wKEx46mSJx2iRXLXYuwpe
 Xc7aDIqmlvKHQHFHWAGYdmylr8W0E8kvIZsc3oqGNKcL37e/zzn4Ng8ITBN5PA+7xf45/tdUu
 37V+DU1v3L80hSl1PJs7BhnONSWM1Me0mstpinmWHUxT90wjksQ5+VZT7vl4B8NVU7BMbxPYJ
 VU+L4A9FHOwIf5Iah5M9NEvz3BMULA1mJlurMjAEC618X6lmE7oL8n4GwKLuEf1w/o2+0ucBm
 YXaklgSUcg6CEO+CJzeqm9F81dDvr5hNdph7bnuOWTZDVvxGH1DqByjo+DOst+IvG559eWB0p
 CKEydsgomRJoajughhrqCiOr8rH7/YWBjWaGQggfxmTbQq2LpRM9kF8BoUtNDQfbHO/x5gvTP
 bH9jFUpkSwu8W/QJwlgdwMpeZABG+awtqtQwHAIjtA1gMTNypdYOPLeCJ6G/B9/ZRYlEGGqcR
 Mm4b0s9xQDdKdfeWl/Ud/WH/kKlIUoW505po5Achk0J0Zj5OaNBgXx9CeGbOY/NRpffZVeglA
 0dW9VPqRbCezeZpPMRZITIyPZchvjY0odElli0pqQ88YLxIYpjCd0gIiF/doFEisxnU0iytgr
 idhjgBRtlU0+tK6pP8bTObFBiV39cLxOIENOzKv/M7S6hRcT29QYNd4B++vv7WHNhebIzuI2B
 J4tZMNt6xA57r7kLtI9VKS3ijWNnB+E+9qbWObO9mpYjpP4oaEes+wiKdjKfJXoAypvQM9L8t
 yqB83JEvJrgrr+aI0p6k2HUh7GLt/J5y7WcZ4BSOd/j672hQH029dtWYhj1MrZBSc3wEmWFNa
 0kpHBSXrlLvl5hcrUdli9utiHssdqgPs7JWTiqcEwPmi2AtAVYBo35Y+AnjyDMStYI6uVgsxx
 Q9y0Ajdwll6HLxYftb908tU2BsKuCXGnibw1rQaknjc76SoTp7md7NwIg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1639975475-1629893687=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Xin,

On Tue, 24 Aug 2021, Jiang Xin wrote:

> On Tue, Aug 24, 2021 at 5:03 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > It is a good idea to automate this.
> >
> > I am a bit concerned that the `ci-config` approach, even if we use it =
in
> > the Git project itself, is quite cumbersome to use, though. So I hope =
that
> > we can find an alternative solution.
> >
> > One such solution could be to make the `git-po-helper` job contingent =
on
> > part of the repository name. For example:
> >
> >   git-po-helper:
> >     if: endsWith(github.repository, '/git-po')
> >     [...]
> >
> > would skip the job unless the target repository's name is `git-po`.
>
> Yes, this is a solution I also want to try at the very beginning. But
> some l10n team leaders may fork their repositories directly from
> git/git, and name their repo as "{OWNER}/git".  I want to try another
> solution: check existence of file "ci/config/allow-l10n" in branch
> "ci-config" using a GitHub API, instead of cloning the ci-config
> branch and execute the shell script "ci/config/allow-l10n".

I understood that you were trying to imitate what git/git does.

The problem, in git/git as well as in your patch, is that this is highly
cumbersome to use. Yes, it would be better if there was an easier UI to do
what you want to do, but the current reality is: there isn't.

The main reason why it is so cumbersome to use is that your chosen
strategy scatters the CI configuration so much that it puts a mental
burden on the users. I, for one, have no idea what is currently in my
`ci-config` branch. And new users will be forced to struggle to set up
their fork in such a way that the configuration does what they want it to
do.

And in this instance, there is not even any good reason to make it hard on
the users because most will likely not need that new workflow at all. That
workflow is primarily interesting for the l10n maintainers.

To make it easier on the vast majority of contributors, I therefore
suggested to introduce an easy-to-parse condition that lives not only in
the same branch but in the very same file as the workflow _and_ it does
what most users need it to do: cognitive burden penalty averted!

Even better: the condition I suggested can be _easily_ extended by the few
l10n maintainers to include their particular for as target repository.

> > A couple more questions/suggestions are below:
> >
> > > +  git-po-helper:
> > > +    needs: ci-config
> > > +    if: needs.ci-config.outputs.enabled =3D=3D 'yes'
> > > +    runs-on: ubuntu-latest
> > > +    steps:
> > > +    - uses: actions/checkout@v2
> > > +      with:
> > > +        fetch-depth: '0'
> >
> > There is code below to specifically fetch the base commit, but setting=
 the
> > `fetch-depth` to zero means to do a full clone anyway.
> >
> > So maybe the `git fetch` code below should be dropped, or the
> > `fetch-depth` override?
> >
> > Since we cannot know how deep we need to fetch, though, I figure that =
it
> > would be indeed better to have a non-shallow clone (and a code comment
> > would help clarify this).
>
> If we want do a shallow clone, maybe we can try like this:
>
> 1.  Make 'git-po-helper' works with a bare repository, so the initial cl=
one
>     can be a shallow bare repository without checkout.
> 2.  Will get two revisions, base and head revision, when the workflow is
>     triggered. (In patch v1, base and head revision are named as
>     commit_from and commit_to)
> 3. Fetch the base revision and head revision using command:
>     git fetch origin --depth=3D100 <base> <head>
>
> We used a fixed depth 100, because we don't know how many commits
> these two revisions are diverged.

Okay, but you did not use a fixed depth 100: you used depth 0, which turns
off shallow clones in actions/checkout.

> Will feed the result of "git rev-list <base>..<head>" to
> "git-po-helper", if depth 100 is not deep enough, rev-list will fail,
> and should try to
> run "git rev-list <head> -100".
>
> I think the first version of l10n.yml should use a full clone, and try
> to refactor later to use a shallow or partial clone.

Given how often the workflow will run, I am not sure that it is worth the
effort to micro-optimize this. Just use a full clone and you're done.

> >                         [...]
> >                         ;;
> >                 esac
> >
> > But we might not need it anyway. See the comment on the `git fetch`
> > command below.
> >
> > > +          then
> > > +            if ! git rev-parse "$commit_from^{commit}"
> > > +            then
> > > +              git fetch origin $commit_from
> >
> > As pointed out above, we cannot know how many commits we need to fetch=
.
> > Therefore, I would suggest to simply drop this `git fetch`.
>
> v2 renamed $commit_from to $base, and renamed $commit_to to $head.
>
> For a force push, the base commit is missing from the initial clone,

Ah, that's the point I was missing.

> and the missing revision can be only accessed (fetched) using a full
> SHA. For a "pull_request_target" event, the "head" revision is also
> missing, because "pull_request_target" only the base commit is
> checkout.

If you truly want to optimize the fetch (which I don't think is worth the
effort, as I mentioned above), you could also start with a shallow clone,
then call

	git config remote.origin.promisor true
	git config remote.origin.partialCloneFilter blob:none
	rm .git/shallow

Subsequent Git operations should transparently fetch whatever is missing.

But again, this strikes me as seriously premature optimization.

> > > +            fi
> > > +          fi
> > > +        fi
> > > +        exit_code=3D0
> > > +        git-po-helper check-commits --github-action -- \
> > > +          $commit_from..$commit_to >git-po-helper.out 2>&1 ||
> >
> > What does the `--github-action` option do? Might be good to document t=
his
> > here.
>
> The option "--github-action" will enable "--no-gpg" and
> "--no-gettext-back-compatible" options. To make the workflow
> "l10n.yml" stable, I introduced the "--github-action" option. You can
> see I introduced another option "--github-action-event=3D<push |
> pull_request_event>", and the boolean option "--github-action" can be
> omitted.

Okay, I take your word for it.

> > > +        exit_code=3D$?
> > > +        echo "::set-output name=3Dexit_code::$exit_code"
> > > +        has_error_msg=3D
> > > +        has_warning_msg=3D
> > > +        if test $exit_code -ne 0
> > > +        then
> > > +          has_error_msg=3Dyes
> >
> > Do we really need this `has_error_msg` variable? It would be much easi=
er
> > to test the condition `env.ERROR_MSG !=3D ''` in subsequent steps, and=
 that
> > would already do the job, without having to go through output variable=
s.
>
> "env.ERROR_MSG" is an environment variable which contains multiple
> lines.  Shell script like `if test ${{ env.ERROR_MSG }} !=3D ""` may
> break.

They won't, if you use `if test "$ERROR_MSG" !=3D ""`, which is more
canonical anyway.

> > Third, can `git-po-helper` be convinced _not_ to print color codes? Th=
e
> > output was redirected into a file, after all, and it does not go to a
> > terminal...
>
> "git-po-helper" uses the package "logrus" for logging. The default
> format of "logrus=E2=80=9D to write log to file is for machines, not use=
r
> friendly. The only way is provide an additional option "ForceColor" to
> it. So I must clear the color code from the output file, if I want to
> create a comment for pull request. But the ansi colors are nice to
> display in the report of the action workflow.

Ah. That makes sense. Maybe it would be useful information for the commit
message?

> > > +            echo "EOF" >>$GITHUB_ENV
> > > +          fi
> > > +        fi
> > > +        if grep -q -e "^level=3Dwarning" -e WARNING git-po-helper.o=
ut
> > > +        then
> > > +          has_warning_msg=3Dyes
> > > +          if test "${{ github.event_name }}" =3D "pull_request"
> > > +          then
> > > +            echo "WARNING_MSG<<EOF" >>$GITHUB_ENV
> > > +            grep -v -e "^level=3Derror" -e ERROR git-po-helper.out =
|
> > > +              perl -pe 's/\e\[[0-9;]*m//g' >>$GITHUB_ENV
> > > +            echo "EOF" >>$GITHUB_ENV
> > > +          fi
> > > +        fi
> > > +        echo "::set-output name=3Dhas_error_msg::$has_error_msg"
> > > +        echo "::set-output name=3Dhas_warning_msg::$has_warning_msg=
"
> > > +    - name: Report errors in comment for pull request
> > > +      uses: mshick/add-pr-comment@v1
> > > +      if: steps.check-commits.outputs.has_error_msg =3D=3D 'yes' &&=
 github.event_name =3D=3D 'pull_request'
> > > +      continue-on-error: true
> > > +      with:
> > > +        repo-token: ${{ secrets.GITHUB_TOKEN }}
> >
> > This requires the `GITHUB_TOKEN` to have write permissions, which I wo=
uld
> > highly recommend not to require.
>
> The action "mshick/add-pr-comment@v1" needs this token. See:
> https://github.com/mshick/add-pr-comment .

Yes, I am fully aware.

What I tried to point out is that the `GITHUB_TOKEN` you receive _may_
have write permissions (it used to be the default), but these days you can
configure it to be read-only, as a repository admin. For details, see
https://github.blog/changelog/2021-04-20-github-actions-control-permission=
s-for-github_token/#setting-the-default-permissions-for-the-organization-o=
r-repository

If GITHUB_TOKEN is configured to be read-only (which I, for one, do with
all repositories I can, for security reasons), then `add-pr-comment` might
fail.

This was the case for the `check-whitespace` workflow on
git-for-windows/git, which is why I fixed that workflow in cc00362125c
(ci(check-whitespace): stop requiring a read/write token, 2021-07-14).

It would not make sense to re-introduce the same issue in a new workflow.

> > Instead, it would probably make more sense to keep the output in the l=
ogs
> > of the workflow run.
>
> You can see this nice post from ecco:
> https://github.community/t/github-actions-are-severely-limited-on-prs/18=
179

Oh, I am aware of the problem. Probably a lot more than you think I am.
After all, I introduced the Azure Pipeline definition which offered not
only a very convenient way to get to the logs of failed test cases, but
also had statistics on flaky tests, and allowed monitoring all kinds of
insights.

And GitHub workflows have none of that.

At least at the moment. If you want to investigate a test failure, you
have to open the failed run, but that won't get you to the right spot yet.
Instead, it opens the log of the `prove` run, which only tells you which
test script(s) failed.

What you _then_ have to do is to expand the `ci/print-test-failures.sh`
step (which _succeeded_ and hence it is not expanded by default) and then
you have to click on the magnifying glass symbol (i.e. _not_ use your
browser's "Find" functionality, that won't work) and search for "not ok"
and then skim over all `# known breakage` entries.

So yes, I do know about the (current) limitations of the GitHub workflows
UI ;-)

> For a successful git-l10n workflow, there are no errors, but may have
> warnings for possible typos found in a ".po" file.  There may be lots
> of false positives in these warnings.  If I hide these warnings in the
> log of a workflow, git-l10n contributors may not notice them. So I
> need a way to create comments in pull requests.

Or the workflow runs need to fail, and PRs need to require those runs to
pass.

> See some typical code reviews for git-l10n:
>
> * https://github.com/git-l10n/git-po/pull/541
> * https://github.com/git-l10n/git-po/pull/555

Thank you for linking those! Now that you said it, I thought about a
different strategy we're using in the Git for Windows project (where we
have a scheduled workflow that monitors a few of the 150 components
bundled in Git for Windows' installer, to get notified if there are new
versions, and the workflow needs write permission in order to open new
tickets). We use an environment secret (and environments can be limited
appropriately, e.g. by requiring approvals from a specific team). For
details, see
https://github.com/git-for-windows/git/commit/1abb4477f462c3d155ec68d40c96=
1a5e0604ddf8

I could imagine that you could make your workflow contingent on the
presence of, say, `GIT_PO_HELPER_GITHUB_TOKEN`. That would not only solve
the "read-only token" problem but also the "don't run everywhere, please!"
problem. You (and other l10n maintainers) only have to create a Personal
Access Token with `repo` permission and add it as a secret.

But ideally, you would test whether an environment of a given name exists,
and I am not aware if such a thing is possible yet with GitHub workflows.

Food for thought?

> > > +        repo-token-user-login: 'github-actions[bot]'
> > > +        message: |
> > > +          Errors found by git-po-helper in workflow ${{ github.work=
flow }}:
> > > +          ```
> > > +          ${{ env.ERROR_MSG }}
> > > +          ```
> > > +    - name: Report warnings in comment for pull request
> > > +      uses: mshick/add-pr-comment@v1
> > > +      if: steps.check-commits.outputs.has_warning_msg =3D=3D 'yes' =
&& github.event_name =3D=3D 'pull_request'
> > > +      continue-on-error: true
> > > +      with:
> > > +        repo-token: ${{ secrets.GITHUB_TOKEN }}
> > > +        repo-token-user-login: 'github-actions[bot]'
> > > +        message: |
> > > +          Warnings found by git-po-helper in workflow ${{ github.wo=
rkflow }}:
> > > +          ```
> > > +          ${{ env.WARNING_MSG }}
> > > +          ```
> > > +    - name: Report and quit
> > > +      run: |
> > > +        if test "${{ steps.check-commits.outputs.has_error_msg }}" =
=3D "yes"
> >
> > This would be easier to read and maintain if it was upgraded to an `if=
:`
> > condition:
> >
> >     - name: Report errors
> >       if: step.check-commits.outputs.has_error_msg =3D "yes"
> >       run: |
> >         [...]
> >
> > And then do the same for warnings.
>
> When users check the log of a workflow, they will only expand the
> failed step.  So warnings and errors are reported in one step.

Right. You need to make the step fail that shows the errors/warnings. (In
Git's `main.yml`, we don't...)

Ciao,
Dscho

--8323328-1639975475-1629893687=:55--
