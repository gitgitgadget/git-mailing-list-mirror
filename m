From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 0/3] Introduce a perf test for interactive rebase
Date: Fri, 13 May 2016 15:25:46 +0200 (CEST)
Message-ID: <cover.1463145936.git.johannes.schindelin@gmx.de>
References: <cover.1462955446.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 15:26:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1D6M-0008PO-Dk
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 15:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbcEMNZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 09:25:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:54272 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbcEMNZx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 09:25:53 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lkzph-1bYtDx0Bcb-00als9; Fri, 13 May 2016 15:25:44
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462955446.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:k1AETsE5H10k8sfRvxqRaesZyGCZC5d7S31s4pn4SOhJwfXKEJf
 kOjmiEpyRelimrXs7Fkppt5JB/PtuHHu1RJsDJ/YxAF7RcLxEMIWS5Cyj56x99Biai1k6tb
 i9aOnZiKtoN1RXc70UEQrnKDYINY61GXaJ1G5rQNQYDBTIVU6789RWUklCka176hZkF/GtR
 Aq/I5b8JVnGVUkFHTMcdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U9y3oHnk6P4=:CuIw7duln7Cx2PB2taespV
 NOMkeuBBJp/dd+lix0i9RQ7B+SA6q0Bw0zn5Le3sCBwcYnkTY3K2kcD+qKAH1GH6bmKu9mTTr
 x8aCvf6VCFh0yaIJXeSiIMfRor38l75GqVCMjshaKDI2gxxUnmorQGPZeDebqRTAjISnsM88D
 pQMK25kbUVhvgiOUwEJAbfz6sb/INbjqjzwtW7PUn1BV/fRoLe0etg168r/AaYs3u0Ky/3q+0
 QEsxNpysQ9Eo74X8GXDwP5aLUJEzC+qWh/h+GG4uXL9SkECi+AyrPVUYxMM5W9YXrAhM0Aotl
 OL7pAoSD0wWbi6EQvZJeagcbwJVTt/YGfFialf+2ugC3WoPJsTbrVaHG73J+PAAczuCMkr3bk
 chNvqI8cJn5wU7Sx1D6aqZyNCIz/v6/y/jkkAGm/BUteb9HU6Ywp7r5i1sokKq0bpqDoZrZOH
 XfBQxbKs1hCxeNlahdHoTJ+NGi63mCXVHHm8I6MHe3vBc7rsnW5o59xLrc6Bb+kf/iDZhdKqx
 o2j7CLyBfxbeMDYepy+4wcS8x8JUrLywTJrtoUKji+Ib7KQwPIw+BG6P8Uf8+mkS5KSV4NJD+
 l+y7zR5kr2OlYwk6byPja+Ol3FlNlwTR1nWPm6tvV1l5oE0AW7Cyjgq1V8oy/l5rhLMJXTvv8
 IODqNGysHRWfjakAYbY6Z1cKUK5MuI/OElH5CRdjCLA4bH/AdA/GwZ1WDO71cRIDhDijrCczI
 mNIngFq4pJUetgkt4DinBiorlvhzLl5TJ7VxIbosNDem7W35G4JdYjbxqAIWFRJs+gbF07qX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294533>

This is the second preparatory patch series for my rebase--helper work
(i.e. moving parts of the interactive rebase into a builtin).

It simply introduces a perf test (and ensures that it runs in my
environment) so as to better determine how much the performance changes,
really.


Johannes Schindelin (3):
  perf: let's disable symlinks when they are not available
  perf: make the tests work in worktrees
  Add a perf test for rebase -i

 t/perf/p3404-rebase-interactive.sh | 36 ++++++++++++++++++++++++++++++++++++
 t/perf/perf-lib.sh                 | 19 +++++++++++--------
 2 files changed, 47 insertions(+), 8 deletions(-)
 create mode 100755 t/perf/p3404-rebase-interactive.sh

Published-As: https://github.com/dscho/git/releases/tag/perf-rebase-i-v3
Interdiff vs v2:

 diff --git a/t/perf/p3404-rebase-interactive.sh b/t/perf/p3404-rebase-interactive.sh
 index 382163c..88f47de 100755
 --- a/t/perf/p3404-rebase-interactive.sh
 +++ b/t/perf/p3404-rebase-interactive.sh
 @@ -7,9 +7,14 @@ test_perf_default_repo
  
  # This commit merges a sufficiently long topic branch for reasonable
  # performance testing
 -branch_merge=ba5312d
 +branch_merge=ba5312da19c6fdb6c6747d479f58932aae6e900c^{commit}
  export branch_merge
  
 +git rev-parse --verify $branch_merge >/dev/null 2>&1 || {
 +	skip_all='skipping because $branch_merge was not found'
 +	test_done
 +}
 +
  write_script swap-first-two.sh <<\EOF
  case "$1" in
  */COMMIT_EDITMSG)
 diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
 index cb88b08..5ef1744 100644
 --- a/t/perf/perf-lib.sh
 +++ b/t/perf/perf-lib.sh
 @@ -80,8 +80,8 @@ test_perf_create_repo_from () {
  	error "bug in the test script: not 2 parameters to test-create-repo"
  	repo="$1"
  	source="$2"
 -	source_git="$(cd "$source" && git rev-parse --git-dir)"
 -	objects_dir="$(cd "$source" && git rev-parse --git-path objects)"
 +	source_git="$(git -C "$source" rev-parse --git-dir)"
 +	objects_dir="$(git -C "$source" rev-parse --git-path objects)"
  	mkdir -p "$repo/.git"
  	(
  		{ cp -Rl "$objects_dir" "$repo/.git/" 2>/dev/null ||
 @@ -96,7 +96,6 @@ test_perf_create_repo_from () {
  			esac
  		done &&
  		cd "$repo" &&
 -		git init -q &&
  		git init -q && {
  			test_have_prereq SYMLINKS ||
  			git config core.symlinks false

-- 
2.8.2.465.gb077790
