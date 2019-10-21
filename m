Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 027D01F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 20:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbfJUU0v (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 16:26:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:44061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729388AbfJUU0v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 16:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571689603;
        bh=G1ZCrB+m456GrbaSxeB5Xy24lOPEz5h88/6Zfq+zPIw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OVgyyBDdJbgD+Y6bnx29L1ECBrCff05IYzsvrTlMOOiqFwJ/w3xICYJpy9WvH3uxW
         m1xBUsVYanKV97YRojPG9yTb/i/N4urA4PkdtSxDesluX08d5TxBQShU0yO/hG7nPb
         gz0amrfCIZsMupamA1cn25eP5Uzp5PmZ27C1TNu8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mkpex-1hbFtt2xJv-00mNUZ; Mon, 21
 Oct 2019 22:26:42 +0200
Date:   Mon, 21 Oct 2019 22:26:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] git_path(): handle `.lock` files correctly
In-Reply-To: <xmqq1rva7sp7.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910212157350.46@tvgsbejvaqbjf.bet>
References: <pull.401.git.1571209637.gitgitgadget@gmail.com> <pull.401.v2.git.1571350077.gitgitgadget@gmail.com> <93dba5a3a38d75ba79329383a1d50419a1990c8d.1571350077.git.gitgitgadget@gmail.com> <xmqq1rva7sp7.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fuDdoa8mrjIuDeFANUGgMV8e95cFFvRJoikybm1jJ0ZGiB4+GzU
 AeoSYckIL1U+FbyxWuCSgkYEmJua8U8vUNDVsV0yMyXFa4fn45FXoTzGLFTqpn0fsns98Wa
 poFublEpERWZR6tYrr/9PplFiEWzf9SixNiYjgEl85S/axIVy4CchpyAxIveuf6+AQgqFog
 1BULqEefrdPLt1xMb7FGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kZxfX3hMKJ8=:W/P/tFYe+qDH+EjuyOxecZ
 7cFgIn4qK+Thz54FK1WlOJrXxgLa3db0cVMybc1F6mJoCZ9wIsUnMhWPynC75la8lTHBOzbmB
 RKK/1Yu7GhB9Y/XEeQW4ORZHML7udWWOBnUUVLiTUttJw8sVR4AP28ibl2BGr0mzzu3pPBiv4
 P+NKN6OR9WQm+YDeKXH62FDZhqt93vm/XauLJq6q9jHaMuFT9IOJUZiaT/XbPgxfabzENgMMv
 cSyWN9czmBBZJT8auI7RCcEEVEGoiXAv0/N7diUyvg+OKsXMEgdRfvqna7LxDE4+HTvqOpnaT
 SHqX5BGGE6kz8wM9fQwGs+p5VwaiB+vMYtSn1W2Ld/1PX2WV0HuXuHyqoaMH5MSGXwDXc/SjS
 b+vj2S3L9f8p6ppPdz7eLt3LKJc2OWaIPOOZkAPX1nKxrk0MZfCh+lm5Uvnv83v7TMWQu1EYu
 gOT4c8dtFxZ2WxQbzSXD1TmaficUHtqWQFzrfb+Lt7IyIa/CDCq6gLRrvnYAOsFzzlJRZRHt6
 B/3UGP92UgHY/t+qmECceI1oCwJwYdKlMKMAeHWN6sdjlegBDLCddJmfRBpKWlV5Ci77pmx4q
 FOyt1W8IrwjsWS/3nesJaK9Pk5rq8T3SbkrO67FO1bnNtkU9B5aEyDuZaDwXteU5eb1cHKWtd
 NDfN34uFHfoiZW5aqzyL4CUQpzxOaK1+V2WUC8V+NlDIDZOlYdjhixxO+d4isUeq+c0NhPykC
 +BBcVAYn7avDSIoc4NkDNTi59IkNHNC2ZNQhOx//BJOtSdisg9TtoclJVQBQxx7qLLWtPZqNx
 oN0mBYOcCVtzCX/taGDuZmRk4N0AZY+KFrIm7PaYNgr9Po2m6iYJrEU8Z+DDCs8BLOojIf4rm
 CN70GP7jY1LLPNM2/ibD5ennvN69XcwzIhS5I0HLnY8XAylnETvxUUurSH4/WhRECkLLe6MC9
 CdjE2yTMRfw9RxqPyX3xxw42sx1dns76kLXT6yW1RQnoUmzLxi3I/6JspW4DO3obSLFASvmYR
 1urJbujIlAjq4BcEgKKtCqSoNRnZTHFDNG0O20y2mUM6p5ue30n+QAMwb3SfJWJvcRSvWmynu
 SyPfuiJfGk5MxId6hUfGoxJt+X3sj1y+N0EB+hK+ae38grzkzwR++skdQf4s0eFNBzGABIKg8
 Ds2tJtDsEvJEM3rjf8xD7heebio2gU2pFiuPVRmevz/BYOKOiWqAJdfX+1RNeVn4/iH5ZV8dd
 JKMtV8ORKpnZXkJwma8JtMmZ36hnKHeUEHeEZdZmHRWq1W0YwcmWbWPSEgBU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 18 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Ever since worktrees were introduced, the `git_path()` function _reall=
y_
> > needed to be called e.g. to get at the path to `logs/HEAD` (`HEAD` is
> > specific to the worktree). However, the wrong path is returned for
> > `logs/HEAD.lock`.
> >
> > This does not matter as long as the Git executable is doing the asking=
,
> > as the path for that `index.lock` file is constructed from
> > `git_path("index")` by appending the `.lock` suffix.
>
> Is this still git_path("index") or is it now HEAD?

Darn. It is "logs/HEAD", of course.

> > Side note: Git GUI _does_ ask for `index.lock`, but that is already
> > resolved correctly.
>
> Is that s/but/and/?

It sounds better with an "and", you're right.

> > diff --git a/path.c b/path.c
> > index e3da1f3c4e..ff85692b45 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -268,7 +268,7 @@ static int trie_find(struct trie *root, const char=
 *key, match_fn fn,
> >  	int result;
> >  	struct trie *child;
> >
> > -	if (!*key) {
> > +	if (!*key || !strcmp(key, ".lock")) {
>
> We only do strcmp for the tail part at the end of the path, so this
> should probably OK from performance point of view but semantically
> it is not very satisfying to see a special case for a single .suffix
> this deep in the callchain.  I wonder if it is nicer to have the
> higher level callers notice ".lock" or whatever other suffixes they
> care about and ask the lower layer for a key with the suffix
> stripped?

Hmm. The parameter is provided as a `const char *`, so I cannot just
edit it. My first attempt at fixing this resulted in this commit:

=2D- snip --
    path: switch `trie_find()` to a counted string

    Before this patch, the `trie_find()` function would be fed a regular,
    NUL-terminated string.

    However, in the next commit, we want to strip any `.lock` suffix from
    the argument, and the argument is provided as a `const char *` (i.e. w=
e
    do not want to modify it).

    Let's use a string + length pair of parameters instead of a single
    NUL-terminated string to open the door for this kind of manipulation.

    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

diff --git a/path.c b/path.c
index e3da1f3c4e2..b18d552c890 100644
=2D-- a/path.c
+++ b/path.c
@@ -236,7 +236,8 @@ static void *add_to_trie(struct trie *root, const char=
 *key, void *value)
 	return old;
 }

-typedef int (*match_fn)(const char *unmatched, void *data, void *baton);
+typedef int (*match_fn)(const char *unmatched, size_t unmatched_len,
+			void *data, void *baton);

 /*
  * Search a trie for some key.  Find the longest /-or-\0-terminated
@@ -261,22 +262,22 @@ typedef int (*match_fn)(const char *unmatched, void =
*data, void *baton);
  * |-----------------|------------|---------------|--------------|
  *
  */
-static int trie_find(struct trie *root, const char *key, match_fn fn,
-		     void *baton)
+static int trie_find(struct trie *root, const char *key, size_t key_len,
+		     match_fn fn, void *baton)
 {
 	int i;
 	int result;
 	struct trie *child;

-	if (!*key) {
+	if (!key_len) {
 		/* we have reached the end of the key */
 		if (root->value && !root->len)
-			return fn(key, root->value, baton);
+			return fn(key, key_len, root->value, baton);
 		else
 			return -1;
 	}

-	for (i =3D 0; i < root->len; i++) {
+	for (i =3D 0; i < key_len && i < root->len; i++) {
 		/* Partial path normalization: skip consecutive slashes. */
 		if (key[i] =3D=3D '/' && key[i+1] =3D=3D '/') {
 			key++;
@@ -288,24 +289,26 @@ static int trie_find(struct trie *root, const char *=
key, match_fn fn,

 	/* Matched the entire compressed section */
 	key +=3D i;
-	if (!*key)
+	key_len -=3D i;
+
+	if (!key_len)
 		/* End of key */
-		return fn(key, root->value, baton);
+		return fn(key, key_len, root->value, baton);

 	/* Partial path normalization: skip consecutive slashes */
-	while (key[0] =3D=3D '/' && key[1] =3D=3D '/')
-		key++;
+	while (key_len > 0 && key[0] =3D=3D '/' && key[1] =3D=3D '/')
+		key++, key_len--;

-	child =3D root->children[(unsigned char)*key];
+	child =3D root->children[!key_len ? '0' : (unsigned char)*key];
 	if (child)
-		result =3D trie_find(child, key + 1, fn, baton);
+		result =3D trie_find(child, key + 1, key_len - 1, fn, baton);
 	else
 		result =3D -1;

-	if (result >=3D 0 || (*key !=3D '/' && *key !=3D 0))
+	if (result >=3D 0 || (key_len && *key !=3D '/'))
 		return result;
 	if (root->value)
-		return fn(key, root->value, baton);
+		return fn(key, key_len, root->value, baton);
 	else
 		return -1;
 }
@@ -330,17 +333,18 @@ static void init_common_trie(void)
  * Helper function for update_common_dir: returns 1 if the dir
  * prefix is common.
  */
-static int check_common(const char *unmatched, void *value, void *baton)
+static int check_common(const char *unmatched, size_t unmatched_len,
+			void *value, void *baton)
 {
 	struct common_dir *dir =3D value;

 	if (!dir)
 		return 0;

-	if (dir->is_dir && (unmatched[0] =3D=3D 0 || unmatched[0] =3D=3D '/'))
+	if (dir->is_dir && (!unmatched_len || unmatched[0] =3D=3D '/'))
 		return !dir->exclude;

-	if (!dir->is_dir && unmatched[0] =3D=3D 0)
+	if (!dir->is_dir && !unmatched_len)
 		return !dir->exclude;

 	return 0;
@@ -350,8 +354,10 @@ static void update_common_dir(struct strbuf *buf, int=
 git_dir_len,
 			      const char *common_dir)
 {
 	char *base =3D buf->buf + git_dir_len;
+	size_t len =3D strlen(base);
+
 	init_common_trie();
-	if (trie_find(&common_trie, base, check_common, NULL) > 0)
+	if (trie_find(&common_trie, base, len, check_common, NULL) > 0)
 		replace_dir(buf, git_dir_len, common_dir);
 }
=2D- snap --

However, I think this is _really_ ugly and intrusive. The opposite of
what my goals were.

So I think I'll just bite the bullet and use a temporary copy if the
argument ends in `.lock`.

Ciao,
Dscho
