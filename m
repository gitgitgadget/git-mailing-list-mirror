From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] fetch: add new fetch.default configuration
Date: Sat, 18 May 2013 17:20:22 -0500
Message-ID: <CAMP44s3pZYw87awogjjOdFRP39Ou0=td2erhV2-aC-9_A_Z75A@mail.gmail.com>
References: <1368843536-19781-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mGPMw8NuhJFS0gK2BVutRO=FxX1ss+1o8fnndCc13LWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 00:20:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdpUR-0004sP-9Z
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 00:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab3ERWUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 18:20:25 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:63522 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab3ERWUY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 18:20:24 -0400
Received: by mail-la0-f54.google.com with SMTP id eg20so2758690lab.13
        for <git@vger.kernel.org>; Sat, 18 May 2013 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=z2jWC0qQDCKKW7HUs+nFMKrukWJE5pJwsZmS5Yokcfs=;
        b=TZ7ORIXmvREeePRrt8dOvj8K3PrmwTVKMhHTx8+NqfBEY4uG99D76phtyeX5X/qRog
         BqlSc13HlYPlevBfsSWOYnufqnhzK9qgW/LAZtw3KxliYRMVH4kTFxm9+/K4xFXaeWLt
         rjJzV2o8ygdJSTWI7feDCj3NXyJRP2R1MFop6GKpH1RzHjpJ7BTY1sizq8FeLGsjUDsu
         xLIKPB6zRkZZ5V5XnKlMchPdIp/ZbTiRIGbgHQ1Y6UO+ZGEUIUhCQT0InQsqUhuUbn7F
         YGOngcWhjbVr3TePCy65vllyimgrnCyHn39zpy1yFO8s+Vt4/yj1LMhSs6i0lVhGREKU
         7mCQ==
X-Received: by 10.112.135.70 with SMTP id pq6mr25246332lbb.82.1368915622775;
 Sat, 18 May 2013 15:20:22 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sat, 18 May 2013 15:20:22 -0700 (PDT)
In-Reply-To: <CALkWK0mGPMw8NuhJFS0gK2BVutRO=FxX1ss+1o8fnndCc13LWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224809>

On Sat, May 18, 2013 at 1:43 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>>   % git checkout --set-upstream-to master
>
> What is the problem you're trying to solve: why do you want an
> upstream set to master?

I have explained that multiple times already. I want all my branches
to have an upstream:

% git config --global branch.autosetupmerge always
% git checkout -b topic master
# stuff
% git rebase -i

> Is it only because of rebase?  We should
> probably get rebase.defaultUpstream = @{u}|origin|...

No. I want to set upstream by myself.

This is what I have now:

  fc/branch/fast               27cff17 [master] branch: add show-tracking option
  fc/build/cleanups            85b0869 [master] build: do not install
git-remote-testpy
  fc/comp/files                4edc621 [master] completion: remove
__git_index_file_list_filter()
  fc/comp/ls-remote            0d2d2d7 [master] completion: avoid
ls-remote in certain scenarios
  fc/comp/parse                eb1c813 [master] completion: Use
parse-options raw output for simple long options
  fc/comp/zsh-cleanup          4ad3e4f [master] completion: zsh:
improve bash script loading
  fc/fast-export/cleanup       1714a14 [master] fast-export: refactor
get_tags_and_duplicates()
  fc/fast-export/fast-v2       69b24ba [master] fast-{import,export}:
use get_sha1_hex() directly
  fc/fetch/default             1939536 [master] fetch: add new
fetch.default configuration
  fc/head/v4                   be582cf [master] Add new @ shortcut for HEAD
  fc/ident-fix                 74baf50 [master] ident: don't allow
implicit email addresses
  fc/master                    5d63a6e [master] travis: update test command
  fc/related/v5                fad98e7 [master] contrib: related: fix
parsing of rev-list args
  fc/remote-sync               53a1457 [master] remote: add new sync command
  fc/remote/bzr-debug          bed1b93 [fc/remote/bzr-next]
remote-bzr: add debugging information
  fc/remote/bzr-next           1e52047 [next] remote-bzr: add fallback
check for a partial clone
  fc/remote/hg-extra           080301e [fc/remote/hg-next] remote-hg:
store extra hg information in notes
  fc/remote/hg-gitifyhg-compat c4eb2b9 [fc/remote/hg-notes] compat:
remote-hg: use mercurial's username
  fc/remote/hg-next            062400f [master] remote-hg: remove
files before modifications
  fc/remote/hg-notes           2c38768 [fc/remote/hg-next] remote-hg:
support for notes
  fc/remote/hg-pep             f19bd8b [fc/remote/hg-next] remote-hg:
remove unnecessary global definitions
  fc/run-command/simplify      a320010 [master] run-command: simplify
wait_or_whine
  fc/send-email/series-cc-cmd  2cbe0c3 [master] send-email: add
series-cc-cmd option
  fc/stage/part-1              24c50f8 [master] Add proper 'stage' command
  fc/stage/part-2              c7d0f70 [master] completion: update
--staged options
  fc/stage/part-3              4eaea2f [fc/stage/part-2] completion:
update 'git reset' new stage options
  fc/stage/try-1               a4408b9 [master] tmp
  fc/stage/try-2               b29882d [master] doc: use 'stage' for
common commands
  fc/trivial                   74e1483 [master] remote: trivial style cleanup
* fc/upstream                  1c5f4a5 [master] Add travis configuration
  fc/zsh/fix                   92152c4 [master] completion: trivial fix for zsh
  fc/zsh/sub                   aa1b1cf [master] completion: zsh: custom commands
  master                       de3a5c6 [origin/master] Git 1.8.3-rc3
  next                         75252d8 [origin/next] Sync with 1.8.3-rc3
  old/remote/hg-next-check     d184c81 [master] remote-hg: remove
files before modifications
  stable                       4a9a4f0 [origin/master] Git 1.8.2.2
  tmp                          0294f83 [origin/next] Merge branch
'fc/master' into tmp
  tmp2                         4170e70 [work] Merge branch 'work' into tmp2
  work                         4e7f4b3 [master] tmp

I can do:

% git checkout fc/remote/hg-next
% git rebase -i # rebase to master
% git checkout fc/remote/hg-notes
% git rebase -i # rebase to fc/remote/hg-next
% git checkout fc/remote/hg-gitifyhg-compat
% git rebase -i # rebase to fc/remote/hg-notes

I don't have to think about it. The relationship between branches
makes everything just work.

-- 
Felipe Contreras
