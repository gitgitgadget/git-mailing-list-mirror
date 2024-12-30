Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34349173
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735516840; cv=none; b=EtE5XZbtIxMMpz+eDd5U9vmbsqOM7deFTr8nJBX2ipJPuwTXjuUvbNxPYWHja20jUXcZYmGB0t7jigzuV2uXblBwEuqX5mVluqGiPWJ1O8eAhlARM1Kwu9n1MbmA4IDYI+hXghlRCfYV8IhfZnZqNdaet2oZgBesIw8CEHUV4nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735516840; c=relaxed/simple;
	bh=5lbi47rVoAXpetlKvdYok/GWKbZZA1cy6NlCSKoJcd4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=PY14igPWHntWJUojCoh5R5Mmzcfx5crCjV93KGw6hpnwQqrV/tp3Ad8O4fUvwhtZxS9EY5xJaADyEDMe7JKAHHf4cvxe+e/XqKphokMb9oBJ/aDlBKPjQR7qMBOF1yF1oAR8/FMx06iqdDn5WZqdqDyILxK23J4m8/IIq46EYQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G26S83BB reason="signature verification failed"; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G26S83BB"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso6717789f8f.0
        for <git@vger.kernel.org>; Sun, 29 Dec 2024 16:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735516836; x=1736121636; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l6UyXXMrosVXnisIYg3TSsprmOJSAqxmlAYZAgeXKWY=;
        b=G26S83BBTeYP51e7Zn0XeDUPLct68E4dUz1Oz8OUwH92uTdeXIqKmUrwkWzAkIjkjM
         iepr7p0wHgiyTkhHgXwvLEsivns7AU/ftRK73vxUD/A6akSlOHW0OM0jJkTZcYPO33k7
         BUihJR9/kpdw7s8ecSk1GG+v71JGOFPSDrDyzsfuT9TnsWUde3FB/b/DSUxTQ2Qa1+AO
         xZ9oJ/uh1j9f5/yFlNOLVFWcHFcU9ip6ht4/RhITmpNmgRcZeSAM+rEVK/XqXbmvhaMP
         DjT6cRb27PzhB54L8tK2keFELyUNyW5caL3ucDNXjv8M+WGd78cUjFf5xYxoqrNc8Uar
         aO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735516836; x=1736121636;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6UyXXMrosVXnisIYg3TSsprmOJSAqxmlAYZAgeXKWY=;
        b=OvjBm53j3IXrUxCL4Zas81tRAC2xZmvRvpkYiA4fhKWrPAowjyVv8DvQuXUvrE/JH0
         eimYx5HzKAfWa/waBFgbGkSLmSvVgHMGB05YLzqfvQ4wfomU16oRh1iGKcGpkq57053/
         cogmO8vtWzx4UA0NlST2+Sme+/T4jdm1m0D7uBhuwsGKK4gzvV2ztUFY9WfGfpuZbwP8
         s5qWcoQi65jPjBemusC9+o8tRPy5XjcHlM1SV4fwCywblvPK69Ru5RxXM92PhNABcCgW
         b7WOj0E7pwqeeME+Sg+lTD5s/D36yYvL1wnmhxDNvJZdEUWIjudYqbpWSTdKsxyUCYjK
         ilkg==
X-Gm-Message-State: AOJu0Yyo73ECQrAOewxTluTRuqvr1gqVNG1u0u8SZtdkG/kSFsnCR59/
	qXst3TADX/iqH94r48K16MeG9uxl4X//NZPIhaEBZtJbc7+1cMpOYPI0mw==
X-Gm-Gg: ASbGncvRMN2Ew19KsCXTkprAuplRnptigxbZwXTQ7DHGwNBJjdFNx3LCUNtniIbEc7g
	azfkKH1W/+ENpQ2KOPwd9spWuyZeqr9R7Wp620ZjOdYyHKKpbUiPp5sBZa3U85xGlmXE0XrQIYO
	QHzYPAlyC1y7UOWRuOb8ivHEEOpeFk0zj8jdQryaWTpoTeY2KRjy3TOX54nwuVb+bomzB4vjejC
	FqeB5+75xfq/ar7UHNuT7umEeoen4c+El+VTnQEg39E5HDOTiWNw+t2PA==
X-Google-Smtp-Source: AGHT+IGCFhlAu6k/+56XQWPhICmADpC44zfhhyS8mWFowsP597LuuKreZpB8XAD7rodE2RJCfRNihw==
X-Received: by 2002:a5d:6d8b:0:b0:385:eb7c:5d0f with SMTP id ffacd0b85a97d-38a221f2fdemr31578718f8f.26.1735516835294;
        Sun, 29 Dec 2024 16:00:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364b053e91sm404492085e9.1.2024.12.29.16.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2024 16:00:34 -0800 (PST)
Message-Id: <pull.1860.git.git.1735516831782.gitgitgadget@gmail.com>
From: "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Dec 2024 00:00:31 +0000
Subject: [PATCH] completion: repair config completion for Zsh
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
    "D. Ben Knoble" <ben.knoble+github@gmail.com>

From: "D. Ben Knoble" <ben.knoble+github@gmail.com>

Commit 1e0ee4087e (completion: add and use
__git_compute_first_level_config_vars_for_section, 2024-02-10) uses an
indirect variable syntax that is only valid for Bash, but the Zsh
completion code relies on the Bash completion code to function. Zsh
supports a different indirect variable expansion using ${(P)var}, but in
`emulate ksh` mode does not support Bash's ${!var}.

This manifests as completing strange config options like
"__git_first_level_config_vars_for_section_remote" as a choice for the
command line

    git config set remote.

Using Zsh's C-x ? _complete_debug widget with the cursor at the end of
that command line captures a trace, in which we see

    +__git_complete_config_variable_name:7> __git_compute_first_level_config_vars_for_section remote
     +__git_compute_first_level_config_vars_for_section:7> local section=remote
     +__git_compute_first_level_config_vars_for_section:7> __git_compute_config_vars
      +__git_compute_config_vars:7> test -n $'add.ignoreErrors\nadvice.addEmbeddedRepo\nadvice.addEmptyPathspec\nadvice.addIgnoredFile\nadvice.amWorkDir\nadvice.ambiguousFetchRefspec\nadvice.checkoutAmbiguousRemoteBranchName\nadvice.commitBeforeMerge\nadvice.detachedHead\nadvice.diverging\nadvice.fetchShowForcedUpdates\nadvice.forceDeleteBranch\nadvice.graftFileDeprecated\nadvice.ignoredHook\nadvice.implicitIdentity\nadvice.mergeConflict\nadvice.nestedTag\nadvice.objectNameWarning\nadvice.pushAlreadyExists\nadvice.pushFetchFirst\nadvice.pushNeedsForce\nadvice.pushNonFFCurrent\nadvice.pushNonFFMatching\nadvice.pushNonFastForward\nadvice.pushRefNeedsUpdate\nadvice.pushUnqualifiedRefName\nadvice.pushUpdateRejected\nadvice.rebaseTodoError\nadvice.refSyntax\nadvice.resetNoRefresh\nadvice.resolveConflict\nadvice.rmHints\nadvice.sequencerInUse\nadvice.setUpstreamFailure\nadvice.skippedCherryPicks\nadvice.sparseIndexExpanded\nadvice.statusAheadBehindWarning\nadvice.statusHints\nadvice.statusUoption\nadvice.submoduleAlternateErrorStrategyDie\nadvice.submoduleMergeConflict\nadvice.submodulesNotUpdated\nadvice.suggestDetachingHead\nadvice.updateSparsePath\nadvice.waitingForEditor\nadvice.worktreeAddOrphan\nalias.\nam.keepcr\nam.threeWay\napply.ignoreWhitespace\napply.whitespace\nattr.tree\nauthor.email\nauthor.name\nbitmapPseudoMerge.\nblame.blankBoundary\nblame.coloring\nblame.date\nblame.ignoreRevsFile\nblame.markIgnoredLines\nblame.markUnblamableLines\nblame.showEmail\nblame.showRoot\nbranch.\nbranch.autoSetupMerge\nbranch.autoSetupRebase\nbranch.sort\nbrowser.\nbundle.\nbundle.heuristic\nbundle.mode\nbundle.version\ncheckout.defaultRemote\ncheckout.guess\ncheckout.thresholdForParallelism\ncheckout.workers\nclean.requireForce\ncolor.advice\ncolor.advice.hint\ncolor.blame.highlightRecent\ncolor.blame.repeatedLines\ncolor.branch\ncolor.branch.current\ncolor.branch.local\ncolor.branch.plain\ncolor.branch.remote\ncolor.branch.reset\ncolor.branch.upstream\ncolor.branch.worktree\ncolor.decorate.HEAD\ncolor.decorate.branch\ncolor.decorate.grafted\ncolor.decorate.remoteBranch\ncolor.decorate.stash\ncolor.decorate.tag\ncolor.diff\ncolor.diff.commit\ncolor.diff.context\ncolor.diff.contextBold\ncolor.diff.contextDimmed\ncolor.diff.frag\ncolor.diff.func\ncolor.diff.meta\ncolor.diff.new\ncolor.diff.newBold\ncolor.diff.newDimmed\ncolor.diff.newMoved\ncolor.diff.newMovedAlternative\ncolor.diff.newMovedAlternativeDimmed\ncolor.diff.newMovedDimmed\ncolor.diff.old\ncolor.diff.oldBold\ncolor.diff.oldDimmed\ncolor.diff.oldMoved\ncolor.diff.oldMovedAlternative\ncolor.diff.oldMovedAlternativeDimmed\ncolor.diff.oldMovedDimmed\ncolor.diff.plain\ncolor.diff.whitespace\ncolor.grep\ncolor.grep.column\ncolor.grep.context\ncolor.grep.filename\ncolor.grep.function\ncolor.grep.lineNumber\ncolor.grep.match\ncolor.grep.matchContext\ncolor.grep.matchSelected\ncolor.grep.selected\ncolor.grep.separator\ncolor.interactive\ncolor.interactive.error\ncolor.interactive.header\ncolor.interactive.help\ncolor.interactive.plain\ncolor.interactive.prompt\ncolor.interactive.reset\ncolor.pager\ncolor.push\ncolor.push.error\ncolor.remote\ncolor.remote.error\ncolor.remote.hint\ncolor.remote.success\ncolor.remote.warning\ncolor.showBranch\ncolor.status\ncolor.status.added\ncolor.status.branch\ncolor.status.changed\ncolor.status.header\ncolor.status.localBranch\ncolor.status.noBranch\ncolor.status.remoteBranch\ncolor.status.unmerged\ncolor.status.untracked\ncolor.status.updated\ncolor.transport\ncolor.transport.rejected\ncolor.ui\ncolumn.branch\ncolumn.clean\ncolumn.status\ncolumn.tag\ncolumn.ui\ncommit.cleanup\ncommit.gpgSign\ncommit.status\ncommit.template\ncommit.verbose\ncommitGraph.changedPathsVersion\ncommitGraph.generationVersion\ncommitGraph.maxNewFilters\ncommitGraph.readChangedPaths\ncommitter.email\ncommitter.name\ncompletion.commands\ncore.abbrev\ncore.alternateRefsCommand\ncore.alternateRefsPrefixes\ncore.askPass\ncore.attributesFile\ncore.autocrlf\ncore.bare\ncore.bigFileThreshold\ncore.checkRoundtripEncoding\ncore.checkStat\ncore.commentChar\ncore.commentString\ncore.commitGraph\ncore.compression\ncore.createObject\ncore.deltaBaseCacheLimit\ncore.editor\ncore.eol\ncore.excludesFile\ncore.fileMode\ncore.filesRefLockTimeout\ncore.fsmonitor\ncore.fsmonitorHookVersion\ncore.fsync\ncore.fsyncMethod\ncore.fsyncObjectFiles\ncore.gitProxy\ncore.hideDotFiles\ncore.hooksPath\ncore.ignoreCase\ncore.ignoreStat\ncore.logAllRefUpdates\ncore.looseCompression\ncore.maxTreeDepth\ncore.multiPackIndex\ncore.notesRef\ncore.packedGitLimit\ncore.packedGitWindowSize\ncore.packedRefsTimeout\ncore.pager\ncore.precomposeUnicode\ncore.preferSymlinkRefs\ncore.preloadIndex\ncore.protectHFS\ncore.protectNTFS\ncore.quotePath\ncore.repositoryFormatVersion\ncore.restrictinheritedhandles\ncore.safecrlf\ncore.sharedRepository\ncore.sparseCheckout\ncore.sparseCheckoutCone\ncore.splitIndex\ncore.sshCommand\ncore.symlinks\ncore.trustctime\ncore.unsetenvvars\ncore.untrackedCache\ncore.useReplaceRefs\ncore.warnAmbiguousRefs\ncore.whitespace\ncore.worktree\ncredential.\ncredential.helper\ncredential.interactive\ncredential.useHttpPath\ncredential.username\ncredentialCache.ignoreSIGHUP\ncredentialStore.lockTimeoutMS\ndiff.\ndiff.algorithm\ndiff.autoRefreshIndex\ndiff.colorMoved\ndiff.colorMovedWS\ndiff.context\ndiff.dirstat\ndiff.dstPrefix\ndiff.external\ndiff.guitool\ndiff.ignoreSubmodules\ndiff.indentHeuristic\ndiff.interHunkContext\ndiff.mnemonicPrefix\ndiff.noPrefix\ndiff.orderFile\ndiff.relative\ndiff.renameLimit\ndiff.renames\ndiff.srcPrefix\ndiff.statGraphWidth\ndiff.statNameWidth\ndiff.submodule\ndiff.suppressBlankEmpty\ndiff.tool\ndiff.trustExitCode\ndiff.wordRegex\ndiff.wsErrorHighlight\ndifftool.\ndifftool.guiDefault\ndifftool.prompt\ndifftool.trustExitCode\nextensions.compatObjectFormat\nextensions.objectFormat\nextensions.refStorage\nextensions.worktreeConfig\nfastimport.unpackLimit\nfeature.\nfeature.experimental\nfeature.manyFiles\nfetch.all\nfetch.bundleCreationToken\nfetch.bundleURI\nfetch.fsck.\nfetch.fsck.skipList\nfetch.fsckObjects\nfetch.negotiationAlgorithm\nfetch.output\nfetch.parallel\nfetch.prune\nfetch.pruneTags\nfetch.recurseSubmodules\nfetch.showForcedUpdates\nfetch.unpackLimit\nfetch.writeCommitGraph\nfilter.\nformat.attach\nformat.cc\nformat.coverFromDescription\nformat.coverLetter\nformat.encodeEmailHeaders\nformat.filenameMaxLength\nformat.forceInBodyFrom\nformat.from\nformat.headers\nformat.mboxrd\nformat.noprefix\nformat.notes\nformat.numbered\nformat.outputDirectory\nformat.pretty\nformat.signOff\nformat.signature\nformat.signatureFile\nformat.subjectPrefix\nformat.suffix\nformat.thread\nformat.to\nformat.useAutoBase\nfsck.badDate\nfsck.badDateOverflow\nfsck.badEmail\nfsck.badFilemode\nfsck.badName\nfsck.badObjectSha1\nfsck.badParentSha1\nfsck.badRefFiletype\nfsck.badRefName\nfsck.badTagName\nfsck.badTimezone\nfsck.badTree\nfsck.badTreeSha1\nfsck.badType\nfsck.duplicateEntries\nfsck.emptyName\nfsck.extraHeaderEntry\nfsck.fullPathname\nfsck.gitattributesBlob\nfsck.gitattributesLarge\nfsck.gitattributesLineLength\nfsck.gitattributesMissing\nfsck.gitattributesSymlink\nfsck.gitignoreSymlink\nfsck.gitmodulesBlob\nfsck.gitmodulesLarge\nfsck.gitmodulesMissing\nfsck.gitmodulesName\nfsck.gitmodulesParse\nfsck.gitmodulesPath\nfsck.gitmodulesSymlink\nfsck.gitmodulesUpdate\nfsck.gitmodulesUrl\nfsck.hasDot\nfsck.hasDotdot\nfsck.hasDotgit\nfsck.largePathname\nfsck.mailmapSymlink\nfsck.missingAuthor\nfsck.missingCommitter\nfsck.missingEmail\nfsck.missingNameBeforeEmail\nfsck.missingObject\nfsck.missingSpaceBeforeDate\nfsck.missingSpaceBeforeEmail\nfsck.missingTag\nfsck.missingTagEntry\nfsck.missingTaggerEntry\nfsck.missingTree\nfsck.missingType\nfsck.missingTypeEntry\nfsck.multipleAuthors\nfsck.nulInCommit\nfsck.nulInHeader\nfsck.nullSha1\nfsck.skipList\nfsck.treeNotSorted\nfsck.unknownType\nfsck.unterminatedHeader\nfsck.zeroPaddedDate\nfsck.zeroPaddedFilemode\nfsmonitor.allowRemote\nfsmonitor.socketDir\ngc.\ngc.aggressiveDepth\ngc.aggressiveWindow\ngc.auto\ngc.autoDetach\ngc.autoPackLimit\ngc.bigPackThreshold\ngc.cruftPacks\ngc.logExpiry\ngc.maxCruftSize\ngc.packRefs\ngc.pruneExpire\ngc.recentObjectsHook\ngc.reflogExpire\ngc.reflogExpireUnreachable\ngc.repackFilter\ngc.repackFilterTo\ngc.rerereResolved\ngc.rerereUnresolved\ngc.worktreePruneExpire\ngc.writeCommitGraph\ngitcvs.allBinary\ngitcvs.commitMsgAnnotation\ngitcvs.dbDriver\ngitcvs.dbName\ngitcvs.dbPass\ngitcvs.dbTableNamePrefix\ngitcvs.dbUser\ngitcvs.enabled\ngitcvs.logFile\ngitcvs.usecrlfattr\ngitweb.avatar\ngitweb.blame\ngitweb.category\ngitweb.description\ngitweb.grep\ngitweb.highlight\ngitweb.owner\ngitweb.patches\ngitweb.pickaxe\ngitweb.remote_heads\ngitweb.showSizes\ngitweb.snapshot\ngitweb.url\ngpg.\ngpg.format\ngpg.minTrustLevel\ngpg.program\ngpg.ssh.allowedSignersFile\ngpg.ssh.defaultKeyCommand\ngpg.ssh.revocationFile\ngrep.column\ngrep.extendedRegexp\ngrep.fallbackToNoIndex\ngrep.fullName\ngrep.lineNumber\ngrep.patternType\ngrep.threads\ngui.blamehistoryctx\ngui.commitMsgWidth\ngui.copyBlameThreshold\ngui.diffContext\ngui.displayUntracked\ngui.encoding\ngui.fastCopyBlame\ngui.matchTrackingBranch\ngui.newBranchTemplate\ngui.pruneDuringFetch\ngui.spellingDictionary\ngui.trustmtime\nguitool.\nhelp.autoCorrect\nhelp.browser\nhelp.format\nhelp.htmlPath\nhttp.\nhttp.cookieFile\nhttp.curloptResolve\nhttp.delegation\nhttp.emptyAuth\nhttp.extraHeader\nhttp.followRedirects\nhttp.lowSpeedLimit\nhttp.lowSpeedTime\nhttp.maxRequests\nhttp.minSessions\nhttp.noEPSV\nhttp.pinnedPubkey\nhttp.postBuffer\nhttp.proactiveAuth\nhttp.proxy\nhttp.proxyAuthMethod\nhttp.proxySSLCAInfo\nhttp.proxySSLCert\nhttp.proxySSLCertPasswordProtected\nhttp.proxySSLKey\nhttp.saveCookies\nhttp.schannelCheckRevoke\nhttp.schannelUseSSLCAInfo\nhttp.sslBackend\nhttp.sslCAInfo\nhttp.sslCAPath\nhttp.sslCert\nhttp.sslCertPasswordProtected\nhttp.sslCipherList\nhttp.sslKey\nhttp.sslTry\nhttp.sslVerify\nhttp.sslVersion\nhttp.userAgent\nhttp.version\ni18n.commitEncoding\ni18n.logOutputEncoding\nimap.authMethod\nimap.folder\nimap.host\nimap.pass\nimap.port\nimap.preformattedHTML\nimap.sslverify\nimap.tunnel\nimap.user\ninclude.path\nincludeIf.\nindex.recordEndOfIndexEntries\nindex.recordOffsetTable\nindex.skipHash\nindex.sparse\nindex.threads\nindex.version\ninstaweb.browser\ninstaweb.httpd\ninstaweb.local\ninstaweb.modulePath\ninstaweb.port\ninteractive.diffFilter\ninteractive.singleKey\nlog.abbrevCommit\nlog.date\nlog.decorate\nlog.diffMerges\nlog.excludeDecoration\nlog.follow\nlog.graphColors\nlog.initialDecorationSet\nlog.mailmap\nlog.showRoot\nlog.showSignature\nlsrefs.unborn\nmailinfo.scissors\nmailmap.blob\nmailmap.file\nmaintenance.\nmaintenance.auto\nmaintenance.autoDetach\nmaintenance.commit-graph.auto\nmaintenance.incremental-repack.auto\nmaintenance.loose-objects.auto\nmaintenance.strategy\nman.\nman.viewer\nmerge.\nmerge.autoStash\nmerge.branchdesc\nmerge.conflictStyle\nmerge.defaultToUpstream\nmerge.directoryRenames\nmerge.ff\nmerge.guitool\nmerge.log\nmerge.renameLimit\nmerge.renames\nmerge.renormalize\nmerge.stat\nmerge.suppressDest\nmerge.tool\nmerge.verbosity\nmerge.verifySignatures\nmergetool.\nmergetool.guiDefault\nmergetool.hideResolved\nmergetool.keepBackup\nmergetool.keepTemporaries\nmergetool.meld.hasOutput\nmergetool.meld.useAutoMerge\nmergetool.prompt\nmergetool.writeToTemp\nnotes.\nnotes.displayRef\nnotes.mergeStrategy\nnotes.rewrite.\nnotes.rewriteMode\nnotes.rewriteRef\npack.allowPackReuse\npack.compression\npack.deltaCacheLimit\npack.deltaCacheSize\npack.depth\npack.indexVersion\npack.island\npack.islandCore\npack.packSizeLimit\npack.preferBitmapTips\npack.readReverseIndex\npack.threads\npack.useBitmapBoundaryTraversal\npack.useBitmaps\npack.useSparse\npack.window\npack.windowMemory\npack.writeBitmapHashCache\npack.writeBitmapLookupTable\npack.writeReverseIndex\npager.\npretty.\npromisor.quiet\nprotocol.\nprotocol.allow\nprotocol.version\npull.ff\npull.octopus\npull.rebase\npull.twohead\npush.autoSetupRemote\npush.default\npush.followTags\npush.gpgSign\npush.negotiate\npush.pushOption\npush.recurseSubmodules\npush.useBitmaps\npush.useForceIfIncludes\nrebase.abbreviateCommands\nrebase.autoSquash\nrebase.autoStash\nrebase.backend\nrebase.forkPoint\nrebase.instructionFormat\nrebase.maxLabelLength\nrebase.missingCommitsCheck\nrebase.rebaseMerges\nrebase.rescheduleFailedExec\nrebase.stat\nrebase.updateRefs\nreceive.advertiseAtomic\nreceive.advertisePushOptions\nreceive.autogc\nreceive.certNonceSeed\nreceive.certNonceSlop\nreceive.denyCurrentBranch\nreceive.denyDeleteCurrent\nreceive.denyDeletes\nreceive.denyNonFastForwards\nreceive.fsck.badDate\nreceive.fsck.badDateOverflow\nreceive.fsck.badEmail\nreceive.fsck.badFilemode\nreceive.fsck.badName\nreceive.fsck.badObjectSha1\nreceive.fsck.badParentSha1\nreceive.fsck.badRefFiletype\nreceive.fsck.badRefName\nreceive.fsck.badTagName\nreceive.fsck.badTimezone\nreceive.fsck.badTree\nreceive.fsck.badTreeSha1\nreceive.fsck.badType\nreceive.fsck.duplicateEntries\nreceive.fsck.emptyName\nreceive.fsck.extraHeaderEntry\nreceive.fsck.fullPathname\nreceive.fsck.gitattributesBlob\nreceive.fsck.gitattributesLarge\nreceive.fsck.gitattributesLineLength\nreceive.fsck.gitattributesMissing\nreceive.fsck.gitattributesSymlink\nreceive.fsck.gitignoreSymlink\nreceive.fsck.gitmodulesBlob\nreceive.fsck.gitmodulesLarge\nreceive.fsck.gitmodulesMissing\nreceive.fsck.gitmodulesName\nreceive.fsck.gitmodulesParse\nreceive.fsck.gitmodulesPath\nreceive.fsck.gitmodulesSymlink\nreceive.fsck.gitmodulesUpdate\nreceive.fsck.gitmodulesUrl\nreceive.fsck.hasDot\nreceive.fsck.hasDotdot\nreceive.fsck.hasDotgit\nreceive.fsck.largePathname\nreceive.fsck.mailmapSymlink\nreceive.fsck.missingAuthor\nreceive.fsck.missingCommitter\nreceive.fsck.missingEmail\nreceive.fsck.missingNameBeforeEmail\nreceive.fsck.missingObject\nreceive.fsck.missingSpaceBeforeDate\nreceive.fsck.missingSpaceBeforeEmail\nreceive.fsck.missingTag\nreceive.fsck.missingTagEntry\nreceive.fsck.missingTaggerEntry\nreceive.fsck.missingTree\nreceive.fsck.missingType\nreceive.fsck.missingTypeEntry\nreceive.fsck.multipleAuthors\nreceive.fsck.nulInCommit\nreceive.fsck.nulInHeader\nreceive.fsck.nullSha1\nreceive.fsck.skipList\nreceive.fsck.treeNotSorted\nreceive.fsck.unknownType\nreceive.fsck.unterminatedHeader\nreceive.fsck.zeroPaddedDate\nreceive.fsck.zeroPaddedFilemode\nreceive.fsckObjects\nreceive.hideRefs\nreceive.keepAlive\nreceive.maxInputSize\nreceive.procReceiveRefs\nreceive.shallowUpdate\nreceive.unpackLimit\nreceive.updateServerInfo\nreftable.blockSize\nreftable.geometricFactor\nreftable.indexObjects\nreftable.lockTimeout\nreftable.restartInterval\nremote.\nremote.pushDefault\nremotes.\nrepack.cruftDepth\nrepack.cruftThreads\nrepack.cruftWindow\nrepack.cruftWindowMemory\nrepack.packKeptObjects\nrepack.updateServerInfo\nrepack.useDeltaBaseOffset\nrepack.useDeltaIslands\nrepack.writeBitmaps\nrerere.autoUpdate\nrerere.enabled\nrevert.reference\nsafe.bareRepository\nsafe.directory\nsendemail.\nsendemail.aliasFileType\nsendemail.aliasesFile\nsendemail.annotate\nsendemail.bcc\nsendemail.cc\nsendemail.ccCmd\nsendemail.chainReplyTo\nsendemail.confirm\nsendemail.envelopeSender\nsendemail.forbidSendmailVariables\nsendemail.from\nsendemail.headerCmd\nsendemail.identity\nsendemail.mailmap\nsendemail.mailmap.blob\nsendemail.mailmap.file\nsendemail.multiEdit\nsendemail.signedOffByCc\nsendemail.smtpBatchSize\nsendemail.smtpDomain\nsendemail.smtpEncryption\nsendemail.smtpPass\nsendemail.smtpReloginDelay\nsendemail.smtpSSLCertPath\nsendemail.smtpServer\nsendemail.smtpServerOption\nsendemail.smtpServerPort\nsendemail.smtpUser\nsendemail.suppressCc\nsendemail.suppressFrom\nsendemail.thread\nsendemail.to\nsendemail.toCmd\nsendemail.transferEncoding\nsendemail.validate\nsendemail.xmailer\nsequence.editor\nshowBranch.default\nsparse.expectFilesOutsideOfPatterns\nsplitIndex.maxPercentChange\nsplitIndex.sharedIndexExpire\nssh.variant\nstash.showIncludeUntracked\nstash.showPatch\nstash.showStat\nstatus.aheadBehind\nstatus.branch\nstatus.displayCommentPrefix\nstatus.relativePaths\nstatus.renameLimit\nstatus.renames\nstatus.short\nstatus.showStash\nstatus.showUntrackedFiles\nstatus.submoduleSummary\nsubmodule.\nsubmodule.active\nsubmodule.alternateErrorStrategy\nsubmodule.alternateLocation\nsubmodule.fetchJobs\nsubmodule.propagateBranches\nsubmodule.recurse\ntag.forceSignAnnotated\ntag.gpgSign\ntag.sort\ntar.umask\ntrace2.configParams\ntrace2.destinationDebug\ntrace2.envVars\ntrace2.eventBrief\ntrace2.eventNesting\ntrace2.eventTarget\ntrace2.maxFiles\ntrace2.normalBrief\ntrace2.normalTarget\ntrace2.perfBrief\ntrace2.perfTarget\ntransfer.advertiseObjectInfo\ntransfer.advertiseSID\ntransfer.bundleURI\ntransfer.credentialsInUrl\ntransfer.fsckObjects\ntransfer.hideRefs\ntransfer.unpackLimit\nuploadarchive.allowUnreachable\nuploadpack.allowAnySHA1InWant\nuploadpack.allowFilter\nuploadpack.allowReachableSHA1InWant\nuploadpack.allowRefInWant\nuploadpack.allowTipSHA1InWant\nuploadpack.hideRefs\nuploadpack.keepAlive\nuploadpack.packObjectsHook\nuploadpackfilter.\nuploadpackfilter.allow\nuploadpackfilter.tree.maxDepth\nurl.\nuser.email\nuser.name\nuser.signingKey\nuser.useConfigOnly\nversionsort.suffix\nweb.browser\nworktree.guessRemote'
     +__git_compute_first_level_config_vars_for_section:7> local this_section=__git_first_level_config_vars_for_section_remote
     +__git_compute_first_level_config_vars_for_section:7> test -n __git_first_level_config_vars_for_section_remote
    +__git_complete_config_variable_name:7> local this_section=__git_first_level_config_vars_for_section_remote
    +__git_complete_config_variable_name:7> __gitcomp_nl_append __git_first_level_config_vars_for_section_remote remote. '' ' '
     +__gitcomp_nl_append:7> __gitcomp_nl __git_first_level_config_vars_for_section_remote remote. '' ' '
      +__gitcomp_nl:7> emulate -L zsh
      +__gitcomp_nl:7> compset -P '*[=:]'
      +__gitcomp_nl:7> compadd -Q -S ' ' -p remote. -- __git_first_level_config_vars_for_section_remote

We perform the test for __git_compute_config_vars correctly, but the
${!this_section} references are not expanded as expected.

Instead, portably expand indirect references through the new
__git_indirect. Contrary to some versions you might find online [1],
this version avoids echo non-portabilities [2] [3] and correctly quotes
the indirect expansion after eval (so that the result is not split or
globbed before being handed to printf).

[1]: https://unix.stackexchange.com/a/41409/301073
[2]: https://askubuntu.com/questions/715765/mysterious-behavior-of-echo-command#comment1056038_715769
[3]: https://mywiki.wooledge.org/CatEchoLs

The following demo program demonstrates how this works:

    b=1
    indirect() {
      eval printf '%s' "\"\$$1\""
    }
    f() {
      # Comment this out to see that it works for globals, too. Or, use
      # a value with spaces like '2 3 4' to see how it handles those.
      local b=2
      local a=b
      test -n "$(indirect $a)" && echo nice
    }
    f

When placed in a file "demo", then both
    bash -x demo
and
    zsh -xc 'emulate ksh -c ". ./demo"' |& tail
provide traces showing that "$(indirect $a)" produces 2 (or 1, with the
global, or "2 3 4" as a single string, etc.).

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
    completion: repair config completion for Zsh
    
    See commit for details.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1860%2Fbenknoble%2Ffix-zsh-config-completion-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1860/benknoble/fix-zsh-config-completion-v1
Pull-Request: https://github.com/git/git/pull/1860

 contrib/completion/git-completion.bash | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b3b6aa3bae2..413911be3be 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2737,12 +2737,17 @@ __git_compute_config_vars_all ()
 	__git_config_vars_all="$(git --no-pager help --config)"
 }
 
+__git_indirect()
+{
+	eval printf '%s' "\"\$$1\""
+}
+
 __git_compute_first_level_config_vars_for_section ()
 {
 	local section="$1"
 	__git_compute_config_vars
 	local this_section="__git_first_level_config_vars_for_section_${section}"
-	test -n "${!this_section}" ||
+	test -n "$(__git_indirect "${this_section}")" ||
 	printf -v "__git_first_level_config_vars_for_section_${section}" %s \
 		"$(echo "$__git_config_vars" | awk -F. "/^${section}\.[a-z]/ { print \$2 }")"
 }
@@ -2752,7 +2757,7 @@ __git_compute_second_level_config_vars_for_section ()
 	local section="$1"
 	__git_compute_config_vars_all
 	local this_section="__git_second_level_config_vars_for_section_${section}"
-	test -n "${!this_section}" ||
+	test -n "$(__git_indirect "${this_section}")" ||
 	printf -v "__git_second_level_config_vars_for_section_${section}" %s \
 		"$(echo "$__git_config_vars_all" | awk -F. "/^${section}\.</ { print \$3 }")"
 }
@@ -2907,7 +2912,7 @@ __git_complete_config_variable_name ()
 		local section="${pfx%.*.}"
 		__git_compute_second_level_config_vars_for_section "${section}"
 		local this_section="__git_second_level_config_vars_for_section_${section}"
-		__gitcomp "${!this_section}" "$pfx" "$cur_" "$sfx"
+		__gitcomp "$(__git_indirect "${this_section}")" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	branch.*)
@@ -2917,7 +2922,7 @@ __git_complete_config_variable_name ()
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
 		__git_compute_first_level_config_vars_for_section "${section}"
 		local this_section="__git_first_level_config_vars_for_section_${section}"
-		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
+		__gitcomp_nl_append "$(__git_indirect "${this_section}")" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	pager.*)
@@ -2934,7 +2939,7 @@ __git_complete_config_variable_name ()
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
 		__git_compute_first_level_config_vars_for_section "${section}"
 		local this_section="__git_first_level_config_vars_for_section_${section}"
-		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
+		__gitcomp_nl_append "$(__git_indirect "${this_section}")" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	submodule.*)
@@ -2944,7 +2949,7 @@ __git_complete_config_variable_name ()
 		__gitcomp_nl "$(__git config -f "$(__git rev-parse --show-toplevel)/.gitmodules" --get-regexp 'submodule.*.path' | awk -F. '{print $2}')" "$pfx" "$cur_" "."
 		__git_compute_first_level_config_vars_for_section "${section}"
 		local this_section="__git_first_level_config_vars_for_section_${section}"
-		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
+		__gitcomp_nl_append "$(__git_indirect "${this_section}")" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	*.*)

base-commit: 306ab352f4e98f6809ce52fc4e5d63fb947d0635
-- 
gitgitgadget
