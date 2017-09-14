Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02F2020A21
	for <e@80x24.org>; Thu, 14 Sep 2017 20:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdINUXw (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 16:23:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:53255 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751363AbdINUXv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 16:23:51 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Likl3-1dIQyM3brx-00cvZN; Thu, 14
 Sep 2017 22:23:40 +0200
Date:   Thu, 14 Sep 2017 22:23:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael Haggerty <mhagger@alum.mit.edu>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/20] Read `packed-refs` using mmap()
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
Message-ID: <alpine.DEB.2.21.1.1709142101560.4132@virtualbox>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mK963s2pzZ4WiobOO82bqHv+6ln+icILilyyslZjwcDOoM5EQ8Y
 wF5gv8sB5WOnntuUJ0RKVoZlRcFbZxAqek3gw7i3SBWn24/qEWGq2ehJhgd+Zvwqs/3VTC5
 wBUp6rMcySWQJX0jX2vJOMMUMq+nGoxra4s/w3B6yFKiV6/nh0tGa4CpQ7JNaIhS0GXux91
 1gUrRYcFfx+tsDeX43Tzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fN/P26rpi/0=:gxkZaRAQ5HcvccJNig7o7z
 qNyhC53K0HtJw6un1ff85dJDaJrJ87obFgIXuF7zX7j4wtiKLao9jKaxl1/2/xQ7o3dj9TqB8
 QJHLSIRHVds61kHiSuB7Iz1CaSGG4U0lXZapNVDZRv7OtxIdsMBgixhkWHxZEI9oiXDjwu7ZI
 ICImZolXuP3nOxmGHbyTilIxUh2FNJo74xk4l0nsP0vXo//AB3XDioYPnMwAJjqQgX/M/+CBn
 Jp0/PUGbChEyEheJg0fgt9lMyv5vTx3VgWuQvB5NKBE+H5C07BRww7xstf3Tht26adfkptvPi
 icjrecG8/jNNNWt7iSOYEjX2j8dho3WUFAF0GUf4J93q3ND0mZ4hEs0pGuR3/2PIbRoPtzmp+
 y7h08bIWKHdTgeBvhkBnOvEsF17XivPIWJxQhjpENJPlPN0pIGgIAimfwW0z+9zOTgPhrspOg
 7kGxZuwXS4yNi6+Js0hRqaw8EzDD6N/FfF8/uNbf8nZEbR8DgfSXl8A257dIG2N3xG23kD2h/
 qh9NwLWOE9nkfGtvh0ykFoo3pVp492v7+bpGblatPH9mYmM+np27HuwhJsYSk1RMzOkWOSkk4
 xRFET0tx148PnCAXSnTkupg0pE/zQMc9fmSViyEq5/+ZMclJptXu+NvXGNC/b2DDptHNqusSO
 2URW0vNLJwkl1+8Yh3qvVgvkbYMOw/UGNWknhqJlSIe4Ooc2vkD7BOFwUXKzX3tsA7kYJg+uG
 c5RebdZnQol3nubRLLKMBUrw5/0TLxSmuIf+lxg0amEfgS/3UqGdToS1BCKEMssc3KMy7tE1W
 0QgsSNtxzJrofA9uBx7zRdLYJOkUFwzMaui1KO9ImB+MKUefqY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Wed, 13 Sep 2017, Michael Haggerty wrote:

> * `mmap()` the whole file rather than `read()`ing it.

On Windows, a memory-mapped file cannot be renamed. As a consequence, the
following tests fail on `pu`:

t1400-update-ref.sh
t1404-update-ref-errors.sh
t1405-main-ref-store.sh
t1408-packed-refs.sh
t1410-reflog.sh
t1430-bad-ref-name.sh
t1450-fsck.sh
t1507-rev-parse-upstream.sh
t2018-checkout-branch.sh
t2020-checkout-detach.sh
t2024-checkout-dwim.sh
t3200-branch.sh
t3204-branch-name-interpretation.sh
t3210-pack-refs.sh
t3211-peel-ref.sh
t3306-notes-prune.sh
t3400-rebase.sh
t3404-rebase-interactive.sh
t3420-rebase-autostash.sh
t3903-stash.sh
t3905-stash-include-untracked.sh
t4151-am-abort.sh
t5304-prune.sh
t5312-prune-corruption.sh
t5400-send-pack.sh
t5404-tracking-branches.sh
t5500-fetch-pack.sh
t5505-remote.sh
t5510-fetch.sh
t5514-fetch-multiple.sh
t5515-fetch-merge-logic.sh
t5516-fetch-push.sh
t5520-pull.sh
t5533-push-cas.sh
t5572-pull-submodule.sh
t5600-clone-fail-cleanup.sh
t5607-clone-bundle.sh
t6016-rev-list-graph-simplify-history.sh
t6030-bisect-porcelain.sh
t6032-merge-large-rename.sh
t6040-tracking-info.sh
t6050-replace.sh
t6500-gc.sh
t6501-freshen-objects.sh
t7003-filter-branch.sh
t7004-tag.sh
t7102-reset.sh
t7201-co.sh
t7406-submodule-update.sh
t7504-commit-msg-hook.sh
t7701-repack-unpack-unreachable.sh
t9300-fast-import.sh
t9902-completion.sh
t9903-bash-prompt.sh

This diff:

-- snip --
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f9c5e771bdd..ee8b3603624 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1306,13 +1308,13 @@ static int packed_transaction_finish(struct
ref_store *ref_store,
 	char *packed_refs_path;
 
 	packed_refs_path = get_locked_file_path(&refs->lock);
+	clear_snapshot(refs);
 	if (rename_tempfile(&refs->tempfile, packed_refs_path)) {
 		strbuf_addf(err, "error replacing %s: %s",
 			    refs->path, strerror(errno));
 		goto cleanup;
 	}
 
-	clear_snapshot(refs);
 	ret = 0;
 
 cleanup:
-- snap --

reduces the failed tests to

t1410-reflog.counts.sh
t3210-pack-refs.counts.sh
t3211-peel-ref.counts.sh
t5505-remote.counts.sh
t5510-fetch.counts.sh
t5600-clone-fail-cleanup.counts.sh

However, much as I tried to wrap my head around it, I could not even start
to come up with a solution for e.g. the t1410 regression. The failure
happens in `git branch -d one/two`.

The culprit: there is yet another unreleased snapshot while we try to
finish the transaction.

It is the snapshot of the main_worktree_ref_store as acquired by
add_head_info() (which is called from get_main_worktree(), which in turn
was called from get_worktrees(), in turn having been called from
find_shared_symref() that was called from delete_branches()), and it seems
to me that there was never any plan to have that released, including its
snapshot.

And the snapshot gets initialized upon add_head_info() calling
refs_resolve_ref_unsafe().

Further down in the delete_branches() function, however, we call
delete_ref() which in turn wants to overwrite the packed-refs file via an
atomic rename. That rename fails now because there is still that main
worktree's ref_store that has the snapshot mmap()ed .

I imagine that the rest of the test failures stems from the same root
cause.

Do you have any idea how to ensure that all mmap()ed packed refs are
released before attempting to finish a transaction?

Ciao,
Dscho
