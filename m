Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6D0C433C1
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 05:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87451619BC
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 05:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhCaFFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 01:05:15 -0400
Received: from mout.web.de ([212.227.15.3]:38093 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhCaFE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 01:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617167093;
        bh=/W1vA5ay9e8Kuuf6ZqXwPU8ugeECQgUDAZ90/DnHLaw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Q+ejLJDc/L49sIIDQGiaPfgDt706jYxzwKZwDWc7UD1UBMA8mhg7VKJie4RFhge/Y
         fxoBiWleg+FGeIohbjhEYM7BgOhpfYZdPx6IdF6hXFbNQdwoZ1m1/RV98WMiehcaRv
         blc2YTk7+mQH+wCVZY8ozY2M/bpUmxJVZxW0+GpQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MDg8k-1lOmOh2ucw-00H7ro; Wed, 31
 Mar 2021 07:04:53 +0200
Date:   Wed, 31 Mar 2021 07:04:53 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dmitry Torilov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Dmitry Torilov <d.torilov@gmail.com>
Subject: Re: [PATCH] chore: use prefix from startup_info
Message-ID: <20210331050453.6wigph5flcmmyr3l@tb-raspi4>
References: <pull.922.git.1617057233885.gitgitgadget@gmail.com>
 <xmqqtuotfre5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtuotfre5.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:qz4OzlBrBfFAwuCNo6FYOD6xudX0Gl2+h6Mt+RVFMhhv4n5EBLX
 xabz6PMuaZs6RznOdPQaUXXkQVRyj0ohiZ6Gv4VtawGOFV+4KtCIlIxoRo7xFPX/sLI0cKm
 zpQAfq97tI1Btbx+aoBaUKcew3W0PsWWcfXh3IGWqanwbg/TAxA2VsO6bvP62fmCSe6feMU
 D3YPDHH8Pk9MrCIBjdqSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:elwGRzIw2jA=:aRFdwHQezpgD9+mEPIzjAR
 lPDanqOA1cilpsEsahxZJsvW6D1lYS8OZkrONhrrus7Lm2hlceBauLx2nrZkXFa/rSts6KhRV
 gnwAe8WKXYqBewbDxYQk6HG4zNFUI4f5z+4bHOs9ZhjfX2NVV+YRZ+duG0HL5/zfT5KBRKzf8
 HA/QS8NKIZbhvcF+rQJdO/sgwss67D/1C1P/QvNUXEZiO0399q0qXATVwdxW1XYoFeKqMo33t
 Q4VWY0pC8g84fnonpXXbTqMkFS0olPXLL1RkjQsbDT0PAIz+ZbKCif8Kq5jDdSEAw7C6UT+e+
 ya+RATokmOJrZnS5DP1mBJp8EcSpf7uaS0zRUT79sU2dTgWMcTih3VNRpk51l/X4LxG0OTSr0
 d4q1YZDqwE6a/GKhg+th071SLxePM3FrY/wuG3H2dnF35PlzGakTF6kPEXLLOz9NeEH5ISjDM
 RS7EI8N8Yxp8aWTSA1j8sfmgZIe9A4L11ClH0zuz9HC1m6NpSYfoQlUX5Qs7cgNHhc4qCSeyr
 HYClwwxwEzTfa3wO5eNpfbVw9hUUF5yyJ9RJ0+wrW2xqMtLeJfCItRrZf6MajGkwycl4TumZ6
 S9q8GVo0DcHs/rHxC3tbJeXNgEBCMAmHbUm2hGEXf84Cl54VvTMkeOrjLWfxEs/oU1XCnTSBN
 oR5B2ma3dQPK3h0M3pHWPWsqSQl+FzwTURgIdjrW0p16WPILMk7togULqXjvK8Yp/6ZajivqO
 eHPRi7J+Bo/+qxB7B2o8q+61teoRgDQsb3QO7PdGP7N59YX8D9QXVyf8Mi6IBXSFFnRsMgG+w
 GJMvkatgHdwh2AiJ2tnYFnhHmz+e+Ea6mv5UTzP3gsVFhyVi9ejiJBXEyH7eU6CP6C1VrWD5Z
 ANNpl6Jp3dBhhfCFLncN7Qc1WtGxvR6Szrk4YnXv3KjKZJDKwUKnkq54123UVrkPgB+18vxef
 nXcfuCgjQkmbwws79Y9a0pmvTnMsOD3BSF5oCQE6hD+WRVMPNYeyHSMGivIZ8sOD0gIQjPdYB
 83t5kUTRLRI1o7UOl6wwR2wblmFu0Y0XyQz6dY9iagfMrq6pet2XoRTl3LUOY8HBCPfSGUka1
 NdzMBJTsuYxhEUF70j5GJzrDKNaqTlP+QPW5gyuBh4gTviwQ4XdWPkjYV+L0AaRisgkewLBsq
 X25vg1BaBRDC5F2YxzKjnShqij5ehfCfW/jAwTau9gA2rxmoqZUWpic5WvV6zbcKJUqsM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 04:53:54PM -0700, Junio C Hamano wrote:
> Dmitry, welcome to git development community.
>
> Torsten, you are Cc'ed because I may have spotted a possible bug in
> your recent 5c327502 (MacOS: precompose_argv_prefix(), 2021-02-03).

Thanks Junio, I missed the patch in a moment of weakness.

>
> "Dmitry Torilov via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Subject: Re: [PATCH] chore: use prefix from startup_info
>
> s/chore/git.c:/ perhaps.  Otherwise the subject is perfect, which is
> rare for new contributors.
>
> > From: Dmitry Torilov <d.torilov@gmail.com>
> >
> > trace.h: update trace_repo_setup signature
> > trace.c: update trace_repo_setup implementation
> > git.c: update trace_repo_setup usage
>
> Unlike some GNU projects, we do not write summary of what the patch
> does to the code in the log message.  What we do is to explain what
> problem the current codebase has, why it is a problem worth fixing,
> and justify why the approach the patch chose to solve the problem
> is a good one.  See Documentation/SubmittingPatches[[describe-changes]]
> and "git log --no-merges origin/master" for recent examples.
>
> > diff --git a/git.c b/git.c
> > index 9bc077a025cb..310cf54e08f6 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -424,6 +424,7 @@ static int run_builtin(struct cmd_struct *p, int a=
rgc, const char **argv)
> >  			prefix =3D setup_git_directory_gently(&nongit_ok);
> >  		}
> >  		prefix =3D precompose_argv_prefix(argc, argv, prefix);
> > +		startup_info->prefix =3D prefix;
> >  		if (use_pager =3D=3D -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTL=
Y) &&
> >  		    !(p->option & DELAY_PAGER_CONFIG))
> >  			use_pager =3D check_pager_config(p->cmd);
> > @@ -432,7 +433,7 @@ static int run_builtin(struct cmd_struct *p, int a=
rgc, const char **argv)
> >
> >  		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
> >  		    startup_info->have_repository) /* get_git_dir() may set up repo=
, avoid that */
> > -			trace_repo_setup(prefix);
> > +			trace_repo_setup();
> >  	}
>
> This turns out to be the ONLY place that trace_repo_setup() is
> called, and the value of prefix here comes from the returned value
> from precompose_argv_prefix() we saw in the previous hunk.  So as
> far as trace_repo_setup() is concerned, taken together with ...
>
> >  	commit_pager_choice();
> >
> > diff --git a/trace.c b/trace.c
> > index f726686fd92f..4c6414683414 100644
> > --- a/trace.c
> > +++ b/trace.c
> > @@ -367,9 +367,9 @@ static const char *quote_crnl(const char *path)
> >  	return new_path.buf;
> >  }
> >
> > -/* FIXME: move prefix to startup_info struct and get rid of this arg =
*/
> > -void trace_repo_setup(const char *prefix)
>
> What is curious is that the caller in git.c this patch changed was
> the only caller back when this FIXME comment was written.  It is
> unclear why the original commit a9ca8a85 (builtins: print setup info
> if repo is found, 2010-11-26) left it unfixed.
>
> > +void trace_repo_setup(void)
> >  {
> > +	const char *prefix =3D startup_info->prefix;
>
> ... this change, the patch is correct.
>
> What is not so clear is if the users of the startup_info->prefix may
> be affected by this change, and if so, does this change introduce a
> bug to them.
>
> We assign to the .prefix member in either setup_git_directory()
> called by the other side of if/else before the precontext of the
> first hunk of this patch, or setup_git_directory_gently() we see in
> the precontext of that hunk.
>
> But then we call precompose_argv_prefix() to munge the prefix value,
> and reassign it to the field.  All the existing users of the
> startup_info->prefix member has been relying on the fact that it is
> the value before "precompose".  With this patch, they see the value
> after "precompose".  I would understand it better if you didn't add
> a new assignment to run_builtin().
>
> Torsten, I _think_ this change actually fixes the bug (or sweeps it
> under the rug) in 5c327502 (MacOS: precompose_argv_prefix(),
> 2021-02-03), where we wanted to precompose not just the argv[] but
> the prefix on macOS.  5c327502 changed the prefix we pass around in
> the callchain as parameter correctly, but as we can see here, a copy
> w/o the precomposition is left in startup_info->prefix to confuse
> codepath that use it (instead of the third parameter given to
> cmd_foo(ac, av, prefix)).
>
> Perhaps the "precompose" call should be moved from git.c to the
> place just before startup_info->prefix is assigned to in
> setup_git_directory_gently(), perhaps like the attached patch,
> to cover this codepath.  I didn't looked at other calls to the
> precompopse added by 5c327502, but I suspect there might need
> similar adjustments.
>
> Thanks.

Please see at the end.

>
>  git.c   | 2 +-
>  setup.c | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git c/git.c w/git.c
> index 9bc077a025..4bd199cc84 100644
> --- c/git.c
> +++ w/git.c
> @@ -423,7 +423,7 @@ static int run_builtin(struct cmd_struct *p, int arg=
c, const char **argv)
>  			int nongit_ok;
>  			prefix =3D setup_git_directory_gently(&nongit_ok);
>  		}
> -		prefix =3D precompose_argv_prefix(argc, argv, prefix);
> +		prefix =3D precompose_argv_prefix(argc, argv, NULL);
>  		if (use_pager =3D=3D -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY)=
 &&
>  		    !(p->option & DELAY_PAGER_CONFIG))
>  			use_pager =3D check_pager_config(p->cmd);
> diff --git c/setup.c w/setup.c
> index c04cd25a30..2f6a1f794a 100644
> --- c/setup.c
> +++ w/setup.c
> @@ -1264,6 +1264,13 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
>  		BUG("unhandled setup_git_directory_1() result");
>  	}
>
> +	/*
> +	 * on macOS, prefix derived from the getcwd() may need to be
> +	 * normalized into precomposed form.
> +	 */
> +	if (prefix)
> +		prefix =3D precompose_string_if_needed(prefix);
> +
>  	/*
>  	 * At this point, nongit_ok is stable. If it is non-NULL and points
>  	 * to a non-zero value, then this means that we haven't found a
>

What I tried is to follow that suggestion.
On top of that, we need:
  - precompose_string_if_needed() must be exposed public, and that is done=
 in
    precompose_utf8.[ch] and git-compat-util.h below.
  - setup.c learns to precompose and to set up the prefix, when needed.
  - No change in git.c (yet), because the changes from below causes t3910 =
to fail in
    "git restore -p ."

If I remove the "prefix =3D precompose_string_if_needed(prefix);" in setup=
.c we see
that t3910 passes again.

And here comes the complete patch - it looks nice, but doesn't work.
Sorry guys for being shortish, thanks Dmitry  and Junio for digging.
And that's all I have for today.

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index ec560565a86..cce1d57a464 100644
=2D-- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -60,10 +60,12 @@ void probe_utf8_pathname_composition(void)
 	strbuf_release(&path);
 }

-static inline const char *precompose_string_if_needed(const char *in)
+const char *precompose_string_if_needed(const char *in)
 {
 	size_t inlen;
 	size_t outlen;
+	if (!in)
+		return NULL;
 	if (has_non_ascii(in, (size_t)-1, &inlen)) {
 		iconv_t ic_prec;
 		char *out;
@@ -96,10 +98,7 @@ const char *precompose_argv_prefix(int argc, const char=
 **argv, const char *pref
 		argv[i] =3D precompose_string_if_needed(argv[i]);
 		i++;
 	}
-	if (prefix) {
-		prefix =3D precompose_string_if_needed(prefix);
-	}
-	return prefix;
+	return precompose_string_if_needed(prefix);
 }


diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index d70b84665c6..fea06cf28a5 100644
=2D-- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -29,6 +29,7 @@ typedef struct {
 } PREC_DIR;

 const char *precompose_argv_prefix(int argc, const char **argv, const cha=
r *prefix);
+const char *precompose_string_if_needed(const char *in);
 void probe_utf8_pathname_composition(void);

 PREC_DIR *precompose_utf8_opendir(const char *dirname);
diff --git a/git-compat-util.h b/git-compat-util.h
index 9ddf9d7044b..a508dbe5a35 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -256,6 +256,11 @@ static inline const char *precompose_argv_prefix(int =
argc, const char **argv, co
 {
 	return prefix;
 }
+static inline const char *precompose_string_if_needed(const char *in)
+{
+	return in;
+}
+
 #define probe_utf8_pathname_composition()
 #endif

diff --git a/setup.c b/setup.c
index c04cd25a30d..5b80ccf86a6 100644
=2D-- a/setup.c
+++ b/setup.c
@@ -1279,6 +1279,7 @@ const char *setup_git_directory_gently(int *nongit_o=
k)
 		startup_info->prefix =3D NULL;
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 	} else {
+		prefix =3D precompose_string_if_needed(prefix);
 		startup_info->have_repository =3D 1;
 		startup_info->prefix =3D prefix;
 		if (prefix)
