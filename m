From: Vicent Marti <vicent@github.com>
Subject: [ANNOUNCE] libgit2 v0.15.0
Date: Wed, 5 Oct 2011 23:00:28 +0200
Message-ID: <CAFFjANQLFAhQGBFHAASwQWuK8RsCc2Vb+j_C2-=w4GnBQ_b_DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: libgit2@librelist.org, git@vger.kernel.org, git-dev@github.com
X-From: git-owner@vger.kernel.org Wed Oct 05 23:00:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBYaE-0006mP-Bl
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 23:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757970Ab1JEVAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 17:00:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60095 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757872Ab1JEVAt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 17:00:49 -0400
Received: by bkbzt4 with SMTP id zt4so2595929bkb.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 14:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=HKsax//rwwtqGs+pPdIOidbyI3bdqbMJ0sde7pOcpf0=;
        b=OPAQa8P9aW/fS3BvKDjKYfRHHC56wKHOSloVPLXkFLG/JS8DoX5QycuI8YzoEFiIO6
         epYa4NVO7NEvCJPz1HxsJ8mCFLkD3X9C1cHeWlhkDQtNJNDOPZX/UTCNF4XqfizME4jA
         /poOvHVsm+1m/ON7GTjf8ItQAn8q+/6Hby/iQ=
Received: by 10.223.40.214 with SMTP id l22mr4049421fae.93.1317848448047; Wed,
 05 Oct 2011 14:00:48 -0700 (PDT)
Received: by 10.223.73.193 with HTTP; Wed, 5 Oct 2011 14:00:28 -0700 (PDT)
X-Google-Sender-Auth: uCCteGgzCJPVh9su_co2NS_Mhbc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182884>

Hello everyone,

another minor libgit2 release is here. This time with proper
networking support, even on Windows/MSVC.

The release has been tagged at:

 https://github.com/libgit2/libgit2/tree/v0.15.0

A dist package can be found at:

 https://github.com/downloads/libgit2/libgit2/libgit2-0.15.0.tar.gz

Updated documentation can be found at:

  http://libgit2.github.com/libgit2/

The full change log follows after the message.

Cheers,
Vicent

================

libgit2 v0.15.0 "Das Wunderbar Release"

I am aware the codename is not gramatically correct in any language.

Check the COPYING file for the detailed terms on libgit2's license. Check
the AUTHORS file for the full list of guilty parties.

As we slowly stabilize the API, we've dropped 1 function from the library,
and changed the signature of only 5 of them.

In this release of libgit2:

	* `git_blob_rawsize`: Now returns `size_t` instead of int, allowing
	files >4GB in 64 bit systems.

	- `git_commit_message_short`: Please use `git_commit_message`
	to get the full message and decide which is the "short view" according
	to your needs (first line, first 80 chars...)

	+ `git_commit_message_encoding`: Returns the encoding field of a commit
	message, if it exists.

	* `git_commit_create`, `git_commit_create_v`: New argument `encoding`, which
	adds a encoding field to the generated commit object.

	+ `git_config_find_system`: Returns the path to the system's global config
	file (according to the Core Git standards).

	* `git_config_get_XX`, `git_config_set_XX`: the `long` and `int` types have
	been replaced by `int64` and `int32` respectively, to make their meaning more
	obvious.

	+ `git_indexer`: An interface to index Git Packfiles has been added in the
	`git2/indexer.h` header.

	* `git_reflog_entry_XX`: Reflog entries are now returned as `git_oid *` objects
	instead of hexadecimal OIDs.

	+ `git_remote`: More fetch functionality has been added to the `git2/remote.h`
	functionality. Local, Smart HTTP and Git protocols are now supported.

	+ `git_repository_head`: Returns the HEAD of the repository.

	+ `git_repository_config_autoload`: Opens the configuration file of a
repository,
	including the user's and the system's global config files, if they
can be found.

	* `git_signature_now`: Now returns an error code; the signature is stored by
	reference.
