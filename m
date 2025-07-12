Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D315624B
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752345058; cv=none; b=UNxsm/K5QA18rbvJugb/q8m4XCj2uw5n5YGGnPv451AhiBlRBWg+IahV2jo5wPLMiH7HyRwNW5qFWcxSgnb4xn7yXuC3FAaY4nfxx/Y4h1yicJDvD4XZsd8HbjpzajatUlNxPSGtyeVubsGtiN+oumzlytMMF52q8mBSbU2ADQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752345058; c=relaxed/simple;
	bh=K5wI3rjFrTeX2UZ3VbYL1nOV6OAjOO/eMeeH3Yi3N8U=;
	h=From:To:In-Reply-To:References:Subject:MIME-Version:Date:
	 Message-Id:Content-Type; b=SMEOrlxWm/VaCIinURbStMKdCv+kiVzKRinsUcjNSXa5vVQBp1YEtvXeX84TxkzkDX8iBVt6CXaWy7Nw6lCDvIcVrGDBPjDXQ6kN0X4nwXJjj+coInpNc6AkQHRPn92fqyuhvhLBBC1eF+TFSlWNCtjBm3up+1beVeJe3MN8o9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieml.ru; spf=pass smtp.mailfrom=ieml.ru; dkim=pass (1024-bit key) header.d=ieml.ru header.i=@ieml.ru header.b=xGwl+Ybu; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieml.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieml.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieml.ru header.i=@ieml.ru header.b="xGwl+Ybu"
Received: from mail-nwsmtp-mxback-production-main-43.sas.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-43.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:4b9:0:640:6d9e:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id BA84961C31
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 21:25:04 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c23:3223:0:640:8bbc:0 [2a02:6b8:c23:3223:0:640:8bbc:0])
	by mail-nwsmtp-mxback-production-main-43.sas.yp-c.yandex.net (mxback/Yandex) with HTTPS id 2PNOQm8MC4Y0-1ujWZMQc;
	Sat, 12 Jul 2025 21:25:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ieml.ru; s=mail;
	t=1752344704; bh=mxRsK78sHATgUGxrTjk2TqwFdRNJ1nk9vqYq7X9iO1U=;
	h=Message-Id:References:Date:Subject:To:In-Reply-To:From;
	b=xGwl+YbusTOSrlmgCUMRRrmnqQ1aWOA+d2iU5M8k+FqTdRkYTw6TtGiYqkHepHCj+
	 +vcBVMnUjh4rLGVtAuAq9OqWrZKQ6Pbs3yuz+CD0lfyGo+ga8/ReQEkcPUDJoxQkJb
	 kBdNk/SGJ7z4V0hcHK2+bLp9ap8SHUirE9IX1y5Y=
Authentication-Results: mail-nwsmtp-mxback-production-main-43.sas.yp-c.yandex.net; dkim=pass header.i=@ieml.ru
Received: by znolar4klagewshm.sas.yp-c.yandex.net (sendbernar/Yandex) with HTTPS id 6f3051cdd8392a3c04d62c86fc9fe4d1;
	Sat, 12 Jul 2025 21:25:03 +0300
From: =?utf-8?B?0JDQt9Cw0YIg0KPRgdC80LDQvdC+0LI=?= <usmanov@ieml.ru>
To: git@vger.kernel.org
In-Reply-To: <8795721752334860@mail-sendbernar-production-main-77.vla.yp-c.yandex.net>
References: <1615371752315594@mail-sendbernar-production-main-92.sas.yp-c.yandex.net> <f636840b-ec66-4059-9d0c-3cca07d42007@gmail.com> <8795721752334860@mail-sendbernar-production-main-77.vla.yp-c.yandex.net>
Subject: Re: git 2.50 and 2.50.1 src fails to compile in rhel 6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Sat, 12 Jul 2025 21:25:03 +0300
Message-Id: <1737451752344703@znolar4klagewshm.sas.yp-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8

I was able to apply the patch  sane-ctype.h  make did proceed until it stumbled  again, this time probably related to that path to random.h file I substituted earlier. Any thoughts?
git-2.50.1# make -j 4
GIT_VERSION=2.50.1
    * new build flags
    * new link flags
    CC base85.o
    * new prefix flags
    CC bisect.o
    CC blame.o
    CC blob.o
    CC bloom.o
    CC branch.o
    CC bulk-checkin.o
    CC bundle-uri.o
    CC bundle.o
    CC cache-tree.o
    CC cbtree.o
    CC chdir-notify.o
    CC checkout.o
    CC chunk-format.o
    CC color.o
    CC column.o
    CC combine-diff.o
    CC commit-graph.o
    CC commit-reach.o
    CC commit.o
    CC common-exit.o
    CC common-init.o
    CC compat/nonblock.o
    CC compat/obstack.o
    CC compat/open.o
    CC compat/terminal.o
    CC compiler-tricks/not-constant.o
    CC config.o
    CC connect.o
    CC connected.o
    CC convert.o
    CC copy.o
    CC credential.o
    CC csum-file.o
    CC ctype.o
    CC date.o
    CC decorate.o
    CC delta-islands.o
    CC diagnose.o
    CC diff-delta.o
    CC diff-merges.o
    CC diff-lib.o
    CC diff-no-index.o
    CC diff.o
    CC diffcore-break.o
    CC diffcore-delta.o
    CC diffcore-order.o
    CC diffcore-pickaxe.o
    CC diffcore-rename.o
    CC diffcore-rotate.o
    CC dir-iterator.o
    CC dir.o
    CC editor.o
    CC entry.o
    CC environment.o
    CC ewah/bitmap.o
    CC ewah/ewah_bitmap.o
    CC ewah/ewah_io.o
    CC ewah/ewah_rlw.o
    CC exec-cmd.o
    CC fetch-negotiator.o
    CC fetch-pack.o
    CC fmt-merge-msg.o
    CC fsck.o
    CC fsmonitor.o
    CC fsmonitor-ipc.o
    CC fsmonitor-settings.o
    CC gettext.o
    CC git-zlib.o
    CC gpg-interface.o
    CC graph.o
    CC grep.o
    CC hash-lookup.o
    CC hash.o
    CC hashmap.o
    GEN command-list.h
    CC hex.o
    CC hex-ll.o
    CC hook.o
    CC ident.o
    CC json-writer.o
    CC kwset.o
    CC levenshtein.o
    CC line-log.o
    CC line-range.o
    CC linear-assignment.o
    CC list-objects-filter-options.o
    CC list-objects-filter.o
    CC list-objects.o
    CC lockfile.o
    CC log-tree.o
    CC loose.o
    CC ls-refs.o
    CC mailinfo.o
    CC mailmap.o
    CC match-trees.o
    CC mem-pool.o
    CC merge-blobs.o
    CC merge-ll.o
    CC merge-ort.o
    CC merge-ort-wrappers.o
    CC merge.o
    CC midx.o
    CC midx-write.o
    CC name-hash.o
    CC negotiator/default.o
    CC negotiator/noop.o
    CC negotiator/skipping.o
    CC notes-cache.o
    CC notes-merge.o
    CC notes-utils.o
    CC notes.o
    CC object-file-convert.o
    CC object-file.o
    CC object-name.o
    CC object-store.o
    CC object.o
    CC oid-array.o
    CC oidmap.o
    CC oidset.o
    CC oidtree.o
    CC pack-bitmap-write.o
    CC pack-bitmap.o
    CC pack-check.o
    CC pack-mtimes.o
    CC pack-objects.o
    CC pack-revindex.o
    CC pack-write.o
    CC packfile.o
    CC pager.o
    CC parallel-checkout.o
    CC parse.o
    CC parse-options-cb.o
    CC parse-options.o
    CC patch-delta.o
    CC patch-ids.o
    CC path.o
    CC path-walk.o
    CC pathspec.o
    CC pkt-line.o
    CC preload-index.o
    CC pretty.o
    CC prio-queue.o
    CC progress.o
    CC promisor-remote.o
    CC prompt.o
    CC protocol.o
    CC protocol-caps.o
    CC prune-packed.o
    CC pseudo-merge.o
    CC quote.o
    CC range-diff.o
    CC reachable.o
    CC read-cache.o
    CC rebase-interactive.o
    CC rebase.o
    CC ref-filter.o
    CC reflog-walk.o
    CC reflog.o
    CC refs.o
    CC refs/debug.o
    CC refs/files-backend.o
    CC refs/reftable-backend.o
    CC refs/iterator.o
    CC refs/packed-backend.o
    CC refs/ref-cache.o
    CC refspec.o
    CC remote.o
    CC replace-object.o
    CC repo-settings.o
    CC repository.o
    CC rerere.o
    CC reset.o
    CC resolve-undo.o
    CC revision.o
    CC run-command.o
    CC send-pack.o
    CC sequencer.o
    CC serve.o
    CC server-info.o
    CC setup.o
    CC shallow.o
    CC sideband.o
    CC sigchain.o
    CC sparse-index.o
    CC split-index.o
    CC stable-qsort.o
    CC statinfo.o
    CC strbuf.o
    CC streaming.o
    CC string-list.o
    CC strmap.o
    CC strvec.o
    CC sub-process.o
    CC submodule-config.o
    CC submodule.o
    CC symlinks.o
    CC tag.o
    CC tempfile.o
    CC thread-utils.o
    CC tmp-objdir.o
    CC trace.o
    CC trace2.o
    CC trace2/tr2_cfg.o
    CC trace2/tr2_cmd_name.o
    CC trace2/tr2_ctr.o
    CC trace2/tr2_dst.o
    CC trace2/tr2_sid.o
    CC trace2/tr2_sysenv.o
    CC trace2/tr2_tbuf.o
    CC trace2/tr2_tgt_event.o
    CC trace2/tr2_tgt_normal.o
    CC trace2/tr2_tgt_perf.o
    CC trace2/tr2_tls.o
    CC trace2/tr2_tmr.o
    CC trailer.o
    CC transport-helper.o
    CC transport.o
    CC tree-diff.o
    CC tree-walk.o
    CC tree.o
    CC unpack-trees.o
    CC upload-pack.o
    CC url.o
    CC urlmatch.o
    CC usage.o
    CC userdiff.o
    CC utf8.o
    CC varint.o
    CC versioncmp.o
    CC walker.o
    CC wildmatch.o
    CC worktree.o
    CC wrapper.o
    CC write-or-die.o
    CC ws.o
wrapper.c: In function ‘csprng_bytes’:
wrapper.c:782:23: warning: implicit declaration of function ‘getrandom’; did you mean ‘srandom’? [-Wimplicit-function-declaration]
  782 |                 res = getrandom(p, len, 0);
      |                       ^~~~~~~~~
      |                       srandom
    CC wt-status.o
    CC xdiff-interface.o
    CC unix-socket.o
    CC unix-stream-server.o
    CC compat/simple-ipc/ipc-shared.o
    CC compat/simple-ipc/ipc-unix-socket.o
    CC sha1dc_git.o
    CC sha1dc/sha1.o
    CC sha1dc/ubc_check.o
    CC sha256/block/sha256.o
    CC compat/linux/procinfo.o
    CC compat/fopen.o
    CC compat/strlcpy.o
    CC compat/qsort_s.o
    CC xdiff/xdiffi.o
    CC xdiff/xemit.o
    CC xdiff/xhistogram.o
    CC xdiff/xmerge.o
    CC xdiff/xpatience.o
    CC xdiff/xprepare.o
    CC xdiff/xutils.o
    CC reftable/basics.o
    CC reftable/error.o
    CC reftable/block.o
    CC reftable/blocksource.o
    CC reftable/iter.o
    CC reftable/merged.o
    CC reftable/pq.o
    CC reftable/record.o
    CC reftable/stack.o
    CC reftable/system.o
    CC reftable/table.o
    CC reftable/tree.o
    CC reftable/writer.o
    CC http-backend.o
    CC imap-send.o
    CC http.o
    CC sh-i18n--envsubst.o
    CC shell.o
    CC http-walker.o
    CC http-fetch.o
    CC http-push.o
    CC remote-curl.o
    * new script parameters
    * new perl-specific parameters
    GEN git-p4
    GEN git-instaweb
    CC git.o
    CC builtin/add.o
    CC builtin/am.o
    CC builtin/annotate.o
    CC builtin/apply.o
    CC builtin/archive.o
    CC builtin/backfill.o
    CC builtin/bisect.o
    CC builtin/blame.o
    CC builtin/branch.o
    GEN hook-list.h
    CC builtin/bundle.o
    CC builtin/cat-file.o
    CC builtin/check-attr.o
    CC builtin/check-ignore.o
    CC builtin/check-mailmap.o
    CC builtin/check-ref-format.o
    CC builtin/checkout--worker.o
    CC builtin/checkout-index.o
    CC builtin/checkout.o
    CC builtin/clean.o
    CC builtin/clone.o
    CC builtin/column.o
    CC builtin/commit-graph.o
    CC builtin/commit-tree.o
    CC builtin/commit.o
    CC builtin/config.o
    CC builtin/count-objects.o
    CC builtin/credential-cache--daemon.o
    CC builtin/credential-cache.o
    CC builtin/credential-store.o
    CC builtin/credential.o
    CC builtin/describe.o
    CC builtin/diagnose.o
    CC builtin/diff-files.o
    CC builtin/diff-index.o
    CC builtin/diff-pairs.o
    CC builtin/diff-tree.o
    CC builtin/diff.o
    CC builtin/difftool.o
    CC builtin/fast-export.o
    CC builtin/fast-import.o
    CC builtin/fetch-pack.o
    CC builtin/fetch.o
    CC builtin/fmt-merge-msg.o
    CC builtin/for-each-ref.o
    CC builtin/for-each-repo.o
    CC builtin/fsck.o
    CC builtin/fsmonitor--daemon.o
    CC builtin/gc.o
    CC builtin/get-tar-commit-id.o
    CC builtin/grep.o
    CC builtin/hash-object.o
    GEN config-list.h
    CC builtin/hook.o
    CC builtin/index-pack.o
    CC builtin/init-db.o
    CC builtin/interpret-trailers.o
    CC builtin/log.o
    CC builtin/ls-files.o
    CC builtin/ls-remote.o
    CC builtin/ls-tree.o
    CC builtin/mailinfo.o
    CC builtin/mailsplit.o
    CC builtin/merge-base.o
    CC builtin/merge-file.o
    CC builtin/merge-index.o
    CC builtin/merge-ours.o
    CC builtin/merge-recursive.o
    CC builtin/merge-tree.o
    CC builtin/merge.o
    CC builtin/mktag.o
    CC builtin/mktree.o
    CC builtin/multi-pack-index.o
    CC builtin/mv.o
    CC builtin/name-rev.o
    CC builtin/notes.o
    CC builtin/pack-objects.o
    CC builtin/pack-redundant.o
    CC builtin/pack-refs.o
    CC builtin/patch-id.o
    CC builtin/prune-packed.o
    CC builtin/prune.o
    CC builtin/pull.o
    CC builtin/push.o
    CC builtin/range-diff.o
    CC builtin/read-tree.o
    CC builtin/rebase.o
    CC builtin/receive-pack.o
    CC builtin/reflog.o
    CC builtin/refs.o
    CC builtin/remote-ext.o
    CC builtin/remote-fd.o
    CC builtin/remote.o
    CC builtin/repack.o
    CC builtin/replace.o
    CC builtin/replay.o
    CC builtin/rerere.o
    CC builtin/reset.o
    CC builtin/rev-list.o
    CC builtin/rev-parse.o
    CC builtin/revert.o
    CC builtin/rm.o
    CC builtin/send-pack.o
    CC builtin/shortlog.o
    CC builtin/show-branch.o
    CC builtin/show-index.o
    CC builtin/show-ref.o
    CC builtin/sparse-checkout.o
    CC builtin/stash.o
    CC builtin/stripspace.o
    CC builtin/submodule--helper.o
    CC builtin/symbolic-ref.o
    CC builtin/tag.o
    CC builtin/unpack-file.o
    CC builtin/unpack-objects.o
    CC builtin/update-index.o
    CC builtin/update-ref.o
    CC builtin/update-server-info.o
    CC builtin/upload-archive.o
    CC builtin/upload-pack.o
    CC builtin/var.o
    CC builtin/verify-commit.o
    CC builtin/verify-pack.o
    CC builtin/verify-tag.o
    CC builtin/worktree.o
    CC builtin/write-tree.o
    GEN git-mergetool--lib
    GEN git-sh-i18n
    GEN git-sh-setup
    CC scalar.o
    CC daemon.o
    CC common-main.o
    CC abspath.o
    CC add-interactive.o
    CC add-patch.o
    CC advice.o
    CC alias.o
    CC alloc.o
    CC apply.o
    CC archive-tar.o
    CC archive-zip.o
    CC archive.o
    CC attr.o
    CC help.o
    GEN version-def.h
    AR xdiff/lib.a
    AR reftable/libreftable.a
    GEN git-difftool--helper
    GEN git-filter-branch
    GEN git-merge-octopus
    GEN git-merge-one-file
    GEN git-merge-resolve
    GEN git-mergetool
    GEN git-quiltimport
    GEN git-request-pull
    GEN git-submodule
    GEN git-web--browse
    GEN GIT-PERL-HEADER
    CC builtin/bugreport.o
    CC builtin/help.o
    CC version.o
    GEN git-archimport
    GEN git-cvsexportcommit
    GEN git-cvsimport
    GEN git-cvsserver
    GEN git-send-email
    GEN git-svn
    AR libgit.a
    LINK git-http-backend
    LINK git-imap-send
    LINK git-sh-i18n--envsubst
    LINK git-daemon
/usr/local/bin/ld: warning: libssl.so.3, needed by /usr/local/lib/libcurl.so, may conflict with libssl.so.10
/usr/local/bin/ld: warning: libcrypto.so.3, needed by /usr/local/lib/libcurl.so, may conflict with libcrypto.so.10
/usr/local/bin/ld: libgit.a(wrapper.o): in function `csprng_bytes':
/root/git-2.50.1/wrapper.c:782: undefined reference to `getrandom'
/usr/local/bin/ld: /root/git-2.50.1/wrapper.c:782: undefined reference to `getrandom'
/usr/local/bin/ld: /root/git-2.50.1/wrapper.c:782: undefined reference to `getrandom'
/usr/local/bin/ld: libgit.a(wrapper.o): in function `csprng_bytes':
/root/git-2.50.1/wrapper.c:782: undefined reference to `getrandom'
/usr/local/bin/ld: /root/git-2.50.1/wrapper.c:782: undefined reference to `getrandom'
/usr/local/bin/ld: /root/git-2.50.1/wrapper.c:782: undefined reference to `getrandom'
/usr/local/bin/ld: libgit.a(wrapper.o): in function `csprng_bytes':
/root/git-2.50.1/wrapper.c:782: undefined reference to `getrandom'
/usr/local/bin/ld: /root/git-2.50.1/wrapper.c:782: undefined reference to `getrandom'
/usr/local/bin/ld: /root/git-2.50.1/wrapper.c:782: undefined reference to `getrandom'
collect2: error: ld returned 1 exit status
make: *** [Makefile:2895: git-http-backend] Error 1
make: *** Waiting for unfinished jobs....
collect2: error: ld returned 1 exit status
make: *** [Makefile:2895: git-sh-i18n--envsubst] Error 1
/usr/local/bin/ld: libgit.a(wrapper.o): in function `csprng_bytes':
/root/git-2.50.1/wrapper.c:782: undefined reference to `getrandom'
/usr/local/bin/ld: /root/git-2.50.1/wrapper.c:782: undefined reference to `getrandom'
/usr/local/bin/ld: /root/git-2.50.1/wrapper.c:782: undefined reference to `getrandom'
collect2: error: ld returned 1 exit status
make: *** [Makefile:2895: git-daemon] Error 1
collect2: error: ld returned 1 exit status
make: *** [Makefile:2898: git-imap-send] Error 1




 

 > I/m soorry for the noob quesion but how do I get the patched version of the sane-ctype.h? I/m not sure where exactly to apply the patch to. I only see the diff, and not the whole file itself. And what are the chances of this patch being merged to master branch
> 
>>> Hello everyone! I'm having trouble compilig git source since version 2.50 , for RHEL 6 (both in redhat 6-6 and 6.10).
>>> the same source compiles fine in RHEL8 (Red Hat Enterprise Linux release 8.10 (Ootpa))
>>> first compiler complans about missing random.h in compat/posix.h ,if you copy missing random.h file to RHEL6 machine to the /usr/include/sys directory then errors change to whole bunch of other errors like
>>> error: expected declaration specifiers or ‘...’ before numeric constant
>>>
>>> 45 | #define toupper(x) sane_case((unsigned char)(x), 0)
>>> both working and non working systems have same gcc 13-4.0 . Last version that compiles in both rhel 6 and rhel 8 is 2.49.1 Any ideas ?
>>
>> There is a patch to fix this issue available at
>> https://lore.kernel.org/git/xmqqtt3j69r8.fsf@gitster.g/
>>
>> Thanks
>>
>> Phillip
>>
>>> git-2.50.1# make -j $(nproc) configure && ./configure && make -j $(nproc) && make -j $(nproc) install && make -j $(nproc) clean
>>> GIT_VERSION=2.50.1
>>> GEN configure
>>> configure: Setting lib to 'lib' (the default)
>>> configure: Will try -pthread then -lpthread to enable POSIX Threads.
>>> configure: CHECKS for site configuration
>>> checking for gcc... /usr/local/gcc-13.4.0/bin/gcc-13.4
>>> checking whether the C compiler works... yes
>>> checking for C compiler default output file name... a.out
>>> checking for suffix of executables...
>>> checking whether we are cross compiling... no
>>> checking for suffix of object files... o
>>> checking whether the compiler supports GNU C... yes
>>> checking whether /usr/local/gcc-13.4.0/bin/gcc-13.4 accepts -g... yes
>>> checking for /usr/local/gcc-13.4.0/bin/gcc-13.4 option to enable C11 features... none needed
>>> checking for stdio.h... yes
>>> checking for stdlib.h... yes
>>> checking for string.h... yes
>>> checking for inttypes.h... yes
>>> checking for stdint.h... yes
>>> checking for strings.h... yes
>>> checking for sys/stat.h... yes
>>> checking for sys/types.h... yes
>>> checking for unistd.h... yes
>>> checking for size_t... yes
>>> checking for working alloca.h... yes
>>> checking for alloca... yes
>>> configure: CHECKS for programs
>>> checking whether the compiler supports GNU C... (cached) yes
>>> checking whether /usr/local/gcc-13.4.0/bin/gcc-13.4 accepts -g... (cached) yes
>>> checking for /usr/local/gcc-13.4.0/bin/gcc-13.4 option to enable C11 features... (cached) none needed
>>> checking for inline... inline
>>> checking if linker supports -R... no
>>> checking if linker supports -Wl,-rpath,... yes
>>> checking for gar... no
>>> checking for ar... ar
>>> checking for gtar... gtar
>>> checking for gnudiff... no
>>> checking for gdiff... no
>>> checking for diff... diff
>>> checking for asciidoc... no
>>> configure: CHECKS for libraries
>>> checking for SHA1_Init in -lcrypto... yes
>>> checking for curl_global_init in -lcurl... yes
>>> checking for curl-config... curl-config
>>> configure: Setting CURL_LDFLAGS to '-L/usr/local/lib -lcurl'
>>> checking for XML_ParserCreate in -lexpat... yes
>>> checking for iconv in -lc... yes
>>> checking for deflateBound in -lz... yes
>>> checking for socket in -lc... yes
>>> checking for inet_ntop... yes
>>> checking for inet_pton... yes
>>> checking for hstrerror... yes
>>> checking for basename in -lc... yes
>>> checking if libc contains libintl... yes
>>> checking for libintl.h... yes
>>> configure: CHECKS for header files
>>> checking for sys/select.h... yes
>>> checking for poll.h... yes
>>> checking for sys/poll.h... yes
>>> checking for inttypes.h... (cached) yes
>>> checking for old iconv()... no
>>> checking whether iconv omits bom for utf-16 and utf-32... no
>>> configure: CHECKS for typedefs, structures, and compiler characteristics
>>> checking for socklen_t... yes
>>> checking for struct itimerval... yes
>>> checking for struct stat.st_mtimespec.tv_nsec... no
>>> checking for struct stat.st_mtim.tv_nsec... yes
>>> checking for struct dirent.d_type... yes
>>> checking for struct passwd.pw_gecos... yes
>>> checking for struct sockaddr_storage... yes
>>> checking for struct addrinfo... yes
>>> checking for getaddrinfo... yes
>>> checking for library containing getaddrinfo... none required
>>> checking how to run the C preprocessor... /usr/local/gcc-13.4.0/bin/gcc-13.4 -E
>>> checking for grep that handles long lines and -e... /bin/grep
>>> checking for egrep... /bin/grep -E
>>> checking whether the platform regex supports REG_STARTEND... yes
>>> checking whether system succeeds to read fopen'ed directory... yes
>>> checking whether snprintf() and/or vsnprintf() return bogus value... no
>>> checking whether the platform uses typical file type bits... yes
>>> configure: CHECKS for library functions
>>> checking for libgen.h... yes
>>> checking for paths.h... yes
>>> checking for libcharset.h... no
>>> checking for strings.h... (cached) yes
>>> checking for locale_charset in -liconv... no
>>> checking for locale_charset in -lcharset... no
>>> checking for sysinfo... yes
>>> checking for clock_gettime... no
>>> checking for CLOCK_MONOTONIC... yes
>>> checking for sync_file_range... yes
>>> checking for library containing sync_file_range... none required
>>> checking for setitimer... yes
>>> checking for library containing setitimer... none required
>>> checking for strcasestr... yes
>>> checking for library containing strcasestr... none required
>>> checking for memmem... yes
>>> checking for library containing memmem... none required
>>> checking for strlcpy... no
>>> checking for uintmax_t... yes
>>> checking for strtoumax... yes
>>> checking for library containing strtoumax... none required
>>> checking for setenv... yes
>>> checking for library containing setenv... none required
>>> checking for unsetenv... yes
>>> checking for library containing unsetenv... none required
>>> checking for mkdtemp... yes
>>> checking for library containing mkdtemp... none required
>>> checking for initgroups... yes
>>> checking for library containing initgroups... none required
>>> checking for getdelim... yes
>>> checking for library containing getdelim... none required
>>> checking for BSD sysctl... no
>>> checking for POSIX Threads with ''... no
>>> checking for POSIX Threads with '-mt'... no
>>> checking for POSIX Threads with '-pthread'... yes
>>> configure: creating ./config.status
>>> config.status: creating config.mak.autogen
>>> config.status: executing config.mak.autogen commands
>>> * new build flags
>>> * new link flags
>>> CC base85.o
>>> CC bisect.o
>>> * new prefix flags
>>> CC blame.o
>>> CC blob.o
>>> CC bloom.o
>>> CC branch.o
>>> CC bulk-checkin.o
>>> CC bundle-uri.o
>>> CC bundle.o
>>> CC cache-tree.o
>>> CC cbtree.o
>>> CC chdir-notify.o
>>> CC checkout.o
>>> CC chunk-format.o
>>> CC color.o
>>> CC column.o
>>> In file included from compat/posix.h:449,
>>> from git-compat-util.h:26,
>>> from checkout.c:3:
>>> compat/../sane-ctype.h:29:60: error: expected expression before ‘]’ token
>>> 29 | #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
>>> | ^
>>> 0)
>>> | ^
>>> make: *** [Makefile:2821: cbtree.o] Error 1
>>> make: *** Waiting for unfinished jobs....
>>> make: *** [Makefile:2821: base85.o] Error 1
>>> make: *** [Makefile:2821: chdir-notify.o] Error 1
>>> make: *** [Makefile:2821: chunk-format.o] Error 1
>>> make: *** [Makefile:2821: blob.o] Error 1
>>> make: *** [Makefile:2821: color.o] Error 1
>>> make: *** [Makefile:2821: checkout.o] Error 1
>>> make: *** [Makefile:2821: column.o] Error 1
>>> make: *** [Makefile:2821: bulk-checkin.o] Error 1
>>> make: *** [Makefile:2821: branch.o] Error 1
>>> make: *** [Makefile:2821: cache-tree.o] Error 1
>>> make: *** [Makefile:2821: bloom.o] Error 1
>>> make: *** [Makefile:2821: bundle-uri.o] Error 1
>>> make: *** [Makefile:2821: bundle.o] Error 1
>>> make: *** [Makefile:2821: bisect.o] Error 1
>>> make: *** [Makefile:2821: blame.o] Error 1
