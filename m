From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/3] Introduce a perf test for interactive rebase
Date: Wed, 11 May 2016 10:31:17 +0200 (CEST)
Message-ID: <cover.1462955446.git.johannes.schindelin@gmx.de>
References: <cover.1462894344.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 10:32:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0PZW-0003vK-K5
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 10:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbcEKIcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 04:32:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:54979 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbcEKIcb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 04:32:31 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MId0S-1b2bQI0fI8-002CtO; Wed, 11 May 2016 10:32:26
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462894344.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:jcTSMQq30gy7o/MsuoTxTbV6/AZ/N5sFl/IxyK3fz4m9xX0pCKL
 PlTiUrS7wZh8onnBYjIeWVCgzMxIBfqVLRGmKLVh5Q+706J1BQKGxDKZYPUp3HfS2/fK/Xg
 t+FwxXHsO4pBO/XDv3dHtGxr/CRg4FQoSZhBk2qedJArgKzi7ks03sQQ3zIWfBnVVY8it2l
 /0YPjNfk1zuHAXvBjcILA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7FGvhdIo9MA=:FAkyY5ooLf1KREjaHxp2J0
 fVdGizXe7CSN07kXsGoSekMrq4bh1vINTqeyhFzw54MrqnIzgaLX/miHGfsGVyx71PfK1c/ld
 RdhbUJMUHSpM2Vp7z9YFKeu3x6fNwegJFmBmBqfHLY/2UQajA6tfx+glrsF5uwWwIdrGY1PGn
 qmp/hb2t+fd3pn0a09aMSkDUYbySut5iDQpMp/ehZbCRBojIzBWbJsWT0fGaqcjvpq9ADbq5Z
 wEXm+xNw3rEQORLQkUyOTASJ5jCWOvCAxOKUtYqNQPyBx4bdZcoJu9ASEcE5fVFt8HW5d58xC
 ZizrLxxvgJtv8RJah7pVUW7Jb2hhzmWqdBDYUrGem0SbT+6ucwpqSlR9s3qp71cXyNjvIQGNU
 xytKWiFhnddBtATfUxa9f3Hwxw1f+gaLIOc3C0OxRtzxaOo1Gb/glbN7yzwHajpDQ1MRSHtsj
 ano9fxuc2whETmZBKcFEMa2Xm+IOdRFGzRQLrZAomrnuAbFHPa+1vW7E0DNY5N79Tmf1gwcQC
 beLtIjelSR39qJNN8E01xr7lfXiEEcIjvsp/F5OwYzKoALFe0V/NWS6wvVW1fG8gvx8bbOQko
 Rx5gg4t9yYinjPM4DDZPlP6GaG3Yv9itzE7VyydvvEx3k2XpbLonwc5pPj1Wi1B3cZCCbHSIp
 FGvMfXpqxS28Y+gDxLl3YWQRbYQs/K5SiMKlUk4zw1qOjfsQWFTXKONxwSF9SjuNV7BC5t2mT
 7KuCgLlHPfRRlI4F8AApOLVk2CO1dUxUr1iuutRPg5Ug1jyvgbokaYQsiUTsHQKQP8lc4IJa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294237>

This is the second preparatory patch series for my rebase--helper work
(i.e. moving parts of the interactive rebase into a builtin).

It simply introduces a perf test (and ensures that it runs in my
environment) so as to better determine how much the performance changes,
really.


Johannes Schindelin (3):
  perf: let's disable symlinks when they are not available
  perf: make the tests work in worktrees
  Add a perf test for rebase -i

 t/perf/p3404-rebase-interactive.sh | 31 +++++++++++++++++++++++++++++++
 t/perf/perf-lib.sh                 | 18 +++++++++++-------
 2 files changed, 42 insertions(+), 7 deletions(-)
 create mode 100755 t/perf/p3404-rebase-interactive.sh

Published-As: https://github.com/dscho/git/releases/tag/perf-rebase-i-v2
Interdiff vs v1:

 diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
 index e5682f7..cb88b08 100644
 --- a/t/perf/perf-lib.sh
 +++ b/t/perf/perf-lib.sh
 @@ -81,7 +81,7 @@ test_perf_create_repo_from () {
  	repo="$1"
  	source="$2"
  	source_git="$(cd "$source" && git rev-parse --git-dir)"
 -	objects_dir="$(git rev-parse --git-path objects)"
 +	objects_dir="$(cd "$source" && git rev-parse --git-path objects)"
  	mkdir -p "$repo/.git"
  	(
  		{ cp -Rl "$objects_dir" "$repo/.git/" 2>/dev/null ||
 @@ -97,10 +97,10 @@ test_perf_create_repo_from () {
  		done &&
  		cd "$repo" &&
  		git init -q &&
 -		if test_have_prereq MINGW
 -		then
 +		git init -q && {
 +			test_have_prereq SYMLINKS ||
  			git config core.symlinks false
 -		fi &&
 +		} &&
  		mv .git/hooks .git/hooks-disabled 2>/dev/null
  	) || error "failed to copy repository '$source' to '$repo'"
  }

-- 
2.8.2.465.gb077790
