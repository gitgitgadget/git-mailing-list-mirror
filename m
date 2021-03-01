Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F069C433E6
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 23:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0DD60249
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 23:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345725AbhCAXdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 18:33:02 -0500
Received: from mout.gmx.net ([212.227.15.15]:55985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234734AbhCAWmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 17:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614638410;
        bh=CJYktdAxgRqrqnB50bhQuFkRmBtSX1KHcKuaxYw15UQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XAn2aHp5XQtufVdOzIIGvaB950LVsJCWG/ql5sKEwvSexZ+YOvfENOQ1PIwxNC7la
         l0+gm2rrBBiuLQ60ad++BoVxil/3Crq5yGkSoxxFYscirt4tWhCHno8Zen8fsH55MS
         MzZ5xPUh3rnLZnfUXF6l/bVlGdb0EH2n53tPwvFM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.162.2] ([89.1.214.35]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2W5-1lgWzd0fX5-00kAnP; Mon, 01
 Mar 2021 23:40:10 +0100
Date:   Mon, 1 Mar 2021 23:40:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>
cc:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5] builtin/clone.c: add --reject-shallow option
In-Reply-To: <697bdaee7a5d11eb919e0026b95c99cc@oschina.cn>
Message-ID: <nycvar.QRO.7.76.6.2103012338100.57@tvgsbejvaqbjf.bet>
References: <pull.865.v4.git.1613891147977.gitgitgadget@gmail.com>,  <pull.865.v5.git.1614535588332.gitgitgadget@gmail.com> <697bdaee7a5d11eb919e0026b95c99cc@oschina.cn>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1658749060-1614638410=:57"
X-Provags-ID: V03:K1:tkfVdopu77IBuwZidT0bjBEwikhm8gZoxOEJs6N2trahC0NraTe
 efRgXCqt/f1V8xKmDyoITt2lKKTeuToxt1/figdj3XI1Z+7eqUl8hM3w4/LLopZz2HynWSD
 40OvBAD6Wub0sVLlJzdxZFRWjGHx/wZbQUP1JyRV4bwhR6s2kOz7ZTAbQJGzgZy3wJPwlO6
 E3PpSXnzyT8iSYFEhG99w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JjvjAtgwHYU=:S7zARWn6C3s3fMvhOGrGmt
 yS4GsHFJCvLwIJ3UpquCtKSOr9YUO3nTTJkVZz/sy2fqJCUcwrv4gRpAZCTOydyCd/UV6Jnvy
 3ZsW26ZCZiz3qhhtV+BIWUpNce2ZUfnd37XqHEqZdqlXXpl+RCLzdeUECLr80o2LCAbXjSctA
 UkLSAo9qRll+jQXL5jVrcYfiYuDze7AUPcR+JNe1v50UAOudyYB7BgwJH6C7alw103Z8nP5/R
 WyfUDo/DRpD9cL2/+86WJvBol0U2/kCEtmvXFwBhZxsDN1Aw99tE1NQEQ3DnjGGObBnedRcSy
 kd2CLcqNrjO/+/Mm21uYU672qrxuF3KGKbPqrOjFpsxV9jEy3P8wJmcZSJ8yA49RysGZwgrPz
 TVIDKwqxV0b+mnlcsTMsDLUt/91F2XALAdio2TGYj6xfEpXccZ3I0xVMx7DGfcPaSV9Hf+riR
 mQgPF8yw9t7wu1EcgCyKy9O6Tu6bAO93MKA4yHWvZHzlUcXF8LjDm5AauN4yR8xxn7NfqYhyw
 ZYQTXKZfKVIR94rDy4akObJh2b8EhaLbfO3VzzLbFlGCqHejAqhwnMwTaHtQj59CcAJagLKsM
 eHc/GPyaPnifI8VaNrbk2d1qq63QHjqKmI+vjVIaSXtV45PPXdY9wY6UvzQ1cHh4jXLbsVbaY
 SGDGCPZ10ZMnBpPDffVJDwRyjRI5wt05UPcVHJMVISLZpY0lBeP+XyOvw0/adW5B5c6bMcmdF
 wwJIXKj02OIOvPdzSOUiU9/zeOTZOPZVwx0O6I2oH02caMG8SwGiaU2z7mFQtV3gk0oacTUDu
 Kx22VUQ5oCspA3W9xXKRfMZ2rYzBuBBJ+S5Egg1vCESN8pbra4VQLWhXv5nZvSOBjXhJxCtW7
 d98APisb+Cg3k2nxSWTZ0YKI9KPA1K5VJvFqMZLkg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1658749060-1614638410=:57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 1 Mar 2021, lilinchao@oschina.cn wrote:

> >@@ -1440,6 +1444,8 @@ static void receive_shallow_info(struct fetch_pac=
k_args *args,
> > * shallow. In v0, remote refs that reach these objects are
> > * rejected (unless --update-shallow is set); do the same.
> > */
> >+	if (args->remote_shallow)
> >+	die("source repository is shallow, reject to clone.");
>
> I just found that Johannes Schindelin wrote a document 14 year ago
> in Documentation/technical/shallow.txt:
>
> "There are some unfinished ends of the whole shallow business:
>
> A special handling of a shallow upstream is needed. At some stage,
> upload-pack has to check if it sends a shallow commit, and it should
> send that information early (or fail, if the client does not support=C2=
=A0
> shallow repositories). There is no support at all for this in this patch
> series."

Oh wow, what a blast from the past.

I do agree that your patch is an improvement over the current situation.

Thanks,
Johannes

> It seems that my patch can sovle his worry in some degree,
> and maybe we could warn client in fetch-pack stage, if we don't
> choose to reject shallow cloning.
>
> 		if (args->remote_shallow)
> 			die("source repository is shallow, reject to clone.");
> 		else
> 			warning("remote source repository is shallow.");
>
> > prepare_shallow_info(si, shallows);
> > if (si->nr_ours || si->nr_theirs)
> > alternate_shallow_file =3D
> >diff --git a/fetch-pack.h b/fetch-pack.h
> >index 736a3dae467a..6e4f8f0d738c 100644
> >--- a/fetch-pack.h
> >+++ b/fetch-pack.h
> >@@ -39,6 +39,7 @@ struct fetch_pack_args {
> > unsigned self_contained_and_connected:1;
> > unsigned cloning:1;
> > unsigned update_shallow:1;
> >+	unsigned remote_shallow:1;
> > unsigned deepen:1;
> >
> > /*
> >diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> >index 52e5789fb050..6170d0513227 100755
> >--- a/t/t5606-clone-options.sh
> >+++ b/t/t5606-clone-options.sh
> >@@ -5,6 +5,8 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> > export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> >
> > . ./test-lib.sh
> >+. "$TEST_DIRECTORY"/lib-httpd.sh
> >+start_httpd
> >
> > test_expect_success 'setup' '
> >
> >@@ -45,6 +47,51 @@ test_expect_success 'disallows --bare with --separat=
e-git-dir' '
> >
> > '
> >
> >+test_expect_success 'fail to clone http shallow repository' '
> >+	git clone --depth=3D1 --no-local parent shallow-repo &&
> >+	git clone --bare --no-local shallow-repo "$HTTPD_DOCUMENT_ROOT_PATH/r=
epo.git" &&
> >+	test_must_fail git clone --reject-shallow $HTTPD_URL/smart/repo.git o=
ut 2>err &&
> >+	test_i18ngrep -e "source repository is shallow, reject to clone." err
> >+
> >+'
> >+
> >+test_expect_success 'fail to clone shallow repository' '
> >+	rm -rf shallow-repo &&
> >+	git clone --depth=3D1 --no-local parent shallow-repo &&
> >+	test_must_fail git clone --reject-shallow shallow-repo out 2>err &&
> >+	test_i18ngrep -e "source repository is shallow, reject to clone." err
> >+
> >+'
> >+
> >+test_expect_success 'fail to clone non-local shallow repository' '
> >+	rm -rf shallow-repo &&
> >+	git clone --depth=3D1 --no-local parent shallow-repo &&
> >+	test_must_fail git clone --reject-shallow --no-local shallow-repo out=
 2>err &&
> >+	test_i18ngrep -e "source repository is shallow, reject to clone." err
> >+
> >+'
> >+
> >+test_expect_success 'clone shallow repository with --no-reject-shallow=
' '
> >+	rm -rf shallow-repo &&
> >+	git clone --depth=3D1 --no-local parent shallow-repo &&
> >+	git clone --no-reject-shallow --no-local shallow-repo clone-repo
> >+
> >+'
> >+
> >+test_expect_success 'clone normal repository with --reject-shallow' '
> >+	rm -rf clone-repo &&
> >+	git clone --no-local parent normal-repo &&
> >+	git clone --reject-shallow --no-local normal-repo clone-repo
> >+
> >+'
> >+
> >+test_expect_success 'unspecified any configs or options' '
> >+	rm -rf shallow-repo clone-repo &&
> >+	git clone --depth=3D1 --no-local parent shallow-repo &&
> >+	git clone shallow-repo clone-repo
> >+
> >+'
> >+
> > test_expect_success 'uses "origin" for default remote name' '
> >
> > git clone parent clone-default-origin &&
> >diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
> >index 9f555b87ecdf..da10d3f10352 100755
> >--- a/t/t5611-clone-config.sh
> >+++ b/t/t5611-clone-config.sh
> >@@ -95,6 +95,38 @@ test_expect_success 'clone -c remote.<remote>.fetch=
=3D<refspec> --origin=3D<name>' '
> > test_cmp expect actual
> > '
> >
> >+test_expect_success 'clone.rejectshallow=3Dtrue should fail to clone' =
'
> >+	rm -rf child &&
> >+	git clone --depth=3D1 --no-local . child &&
> >+	test_must_fail git -c clone.rejectshallow=3Dtrue clone --no-local chi=
ld out 2>err &&
> >+	test_i18ngrep -e "source repository is shallow, reject to clone." err
> >+'
> >+
> >+test_expect_success 'clone.rejectshallow=3Dfalse should succeed' '
> >+	rm -rf child out &&
> >+	git clone --depth=3D1 --no-local . child &&
> >+	git -c clone.rejectshallow=3Dfalse clone --no-local child out
> >+'
> >+
> >+test_expect_success 'clone.rejectshallow=3Dtrue should succeed with no=
rmal repo' '
> >+	rm -rf child out &&
> >+	git clone --no-local . child &&
> >+	git -c clone.rejectshallow=3Dtrue clone --no-local child out
> >+'
> >+
> >+test_expect_success 'option --reject-shallow override clone.rejectshal=
low' '
> >+	rm -rf child out &&
> >+	git clone --depth=3D1 --no-local . child &&
> >+	test_must_fail git -c clone.rejectshallow=3Dfalse clone --reject-shal=
low --no-local child out 2>err &&
> >+	test_i18ngrep -e "source repository is shallow, reject to clone." err
> >+'
> >+
> >+test_expect_success 'option --no-reject-shallow override clone.rejects=
hallow' '
> >+	rm -rf child out &&
> >+	git clone --depth=3D1 --no-local . child &&
> >+	git -c clone.rejectshallow=3Dtrue clone --no-reject-shallow --no-loca=
l child out
> >+'
> >+
> > test_expect_success MINGW 'clone -c core.hideDotFiles' '
> > test_commit attributes .gitattributes "" &&
> > rm -rf child &&
> >diff --git a/transport-helper.c b/transport-helper.c
> >index 49b7fb4dcb9a..b57b55c8180c 100644
> >--- a/transport-helper.c
> >+++ b/transport-helper.c
> >@@ -265,7 +265,8 @@ static const char *boolean_options[] =3D {
> > TRANS_OPT_THIN,
> > TRANS_OPT_KEEP,
> > TRANS_OPT_FOLLOWTAGS,
> >-	TRANS_OPT_DEEPEN_RELATIVE
> >+	TRANS_OPT_DEEPEN_RELATIVE,
> >+	TRANS_OPT_REJECT_SHALLOW
> > };
> >
> > static int strbuf_set_helper_option(struct helper_data *data,
> >diff --git a/transport.c b/transport.c
> >index b13fab5dc3b1..34fe01221ee0 100644
> >--- a/transport.c
> >+++ b/transport.c
> >@@ -236,6 +236,9 @@ static int set_git_option(struct git_transport_opti=
ons *opts,
> > list_objects_filter_die_if_populated(&opts->filter_options);
> > parse_list_objects_filter(&opts->filter_options, value);
> > return 0;
> >+	} else if (!strcmp(name, TRANS_OPT_REJECT_SHALLOW)) {
> >+	opts->reject_shallow =3D !!value;
> >+	return 0;
> > }
> > return 1;
> > }
> >@@ -370,6 +373,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
> > args.stateless_rpc =3D transport->stateless_rpc;
> > args.server_options =3D transport->server_options;
> > args.negotiation_tips =3D data->options.negotiation_tips;
> >+	args.remote_shallow =3D transport->smart_options->reject_shallow;
> >
> > if (!data->got_remote_heads) {
> > int i;
> >diff --git a/transport.h b/transport.h
> >index 24e15799e714..f6273d268b09 100644
> >--- a/transport.h
> >+++ b/transport.h
> >@@ -14,6 +14,7 @@ struct git_transport_options {
> > unsigned check_self_contained_and_connected : 1;
> > unsigned self_contained_and_connected : 1;
> > unsigned update_shallow : 1;
> >+	unsigned reject_shallow : 1;
> > unsigned deepen_relative : 1;
> >
> > /* see documentation of corresponding flag in fetch-pack.h */
> >@@ -194,6 +195,9 @@ void transport_check_allowed(const char *type);
> > /* Aggressively fetch annotated tags if possible */
> > #define TRANS_OPT_FOLLOWTAGS "followtags"
> >
> >+/* reject shallow repo transport=C2=A0 */
> >+#define TRANS_OPT_REJECT_SHALLOW "rejectshallow"
> >+
> > /* Accept refs that may update .git/shallow without --depth */
> > #define TRANS_OPT_UPDATE_SHALLOW "updateshallow"
> >
> >
> >base-commit: 225365fb5195e804274ab569ac3cc4919451dc7f
> >--
> >gitgitgadget
> >

--8323328-1658749060-1614638410=:57--
