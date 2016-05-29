From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v3 2/3] perf: make the tests work in worktrees
Date: Sun, 29 May 2016 18:43:41 +0200
Message-ID: <574B1C3D.3000706@web.de>
References: <cover.1462955446.git.johannes.schindelin@gmx.de>
 <cover.1463145936.git.johannes.schindelin@gmx.de>
 <0f0bc7ac7b6eebed22b05c277cf7352122d164d2.1463145936.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 18:44:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b73op-0000fo-6f
	for gcvg-git-2@plane.gmane.org; Sun, 29 May 2016 18:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbcE2Qn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 12:43:59 -0400
Received: from mout.web.de ([212.227.15.14]:61440 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750AbcE2Qn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2016 12:43:58 -0400
Received: from [192.168.178.36] ([79.213.127.144]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LecN4-1brx6L237G-00qQwo; Sun, 29 May 2016 18:43:47
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <0f0bc7ac7b6eebed22b05c277cf7352122d164d2.1463145936.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K0:in9Xp4pSHIcWMpabo5Mcp/ZUBzHDPxIUcxNtvX54TSwGM0LqKPy
 crf8zpbhvmuX363Ry0D5WQ2sJhNGg2anJHB90l4JL78YH/EY8cDlymrkEn4bnmI3u2BiT0m
 sAe3NDe9EnbnTOSN0FpR2Q2iUIuh1B+1sOtpoKI62Q0XsZzy26A2Dgc2/akqKVK1BcbMXpY
 zoVdmOjYaTM+Y/KY9nKfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cFf00k+tUOE=:RErxHlRG6uosQmFwD327dx
 vmeQr9cm9CTLmodxPcGMDB3codFA0pv0heh3JKQprUn5kUkxqc8zDT3jVr+DBxOyS9pva0c24
 zOWa5h+qw0QHEsr2cXiOfNThJScSx9mI+Thr5s/jHxhXzKxbRn40/5M/3pqQ63dZioUhfXMDL
 2DvVDXt2VNOMFTSBUCQwPABVCagiCLIabJ4ypFNQXs/d1c1Y+k7td3blIlZad0VrhG8CExVTs
 MRIYyn9ZBkCo3nREJ7nArYrAd+B4gu10LmPXPbQcntE0JrZgudS547MF+tdRXRoqy/faydKuD
 EDCp2/g9a6td+3QBMw7qH8Va2iqAG+EFVSvIhAtIi4zWR38N+V4dFGQXX2p1DRpb+VMA0Razu
 E3A9bZlRwVwzc9icsrBitWnwUQF7DTk9Lyo6L7vPTwfuSjPItZsKyjHJ/tmps2ju97x+AtvjG
 5Ge8W6OSxNPR/9M8xZEsCFAH4MkI5x7+Q70qDePtHhKePsCaU+onu2Jm+xQriFU3s1qs2gSGI
 DNqZBXxFBRO0vonXohWr9m1ULqtpqVqAa80i6yQUnvIByZaWNvVy65+5CBzoYhgBhuJHN8dTZ
 C8hEKSRD2Qy0QzxbANwSIACR1lu5W8t++ceB37qZia0wOVy3L3t9LbgYsa+r9DfBD5APbQzT8
 h8BSUtXeZ9BfUguOS3gRRUj83uY2AiArHv+rCMokk06iFncrDwm2WWC/ll+v5YrBlbvFfIoJm
 ufhIiIpi/v279UtIQmjtYTGzGlDLvv2NNAeCXf2jaLSNCP+U8p8GW1CNbu3hyrXdgN1ZVhNK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295835>

Am 13.05.2016 um 15:25 schrieb Johannes Schindelin:
> This patch makes perf-lib.sh more robust so that it can run correctly
> even inside a worktree. For example, it assumed that $GIT_DIR/objects is
> the objects directory (which is not the case for worktrees) and it used
> the commondir file verbatim, even if it contained a relative path.
> 
> Furthermore, the setup code expected `git rev-parse --git-dir` to spit
> out a relative path, which is also not true for worktrees. Let's just
> change the code to accept both relative and absolute paths, by avoiding
> the `cd` into the copied working directory.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   t/perf/perf-lib.sh | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 9fa0706..5ef1744 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -80,22 +80,22 @@ test_perf_create_repo_from () {
>   	error "bug in the test script: not 2 parameters to test-create-repo"
>   	repo="$1"
>   	source="$2"
> -	source_git=$source/$(cd "$source" && git rev-parse --git-dir)
> +	source_git="$(git -C "$source" rev-parse --git-dir)"
> +	objects_dir="$(git -C "$source" rev-parse --git-path objects)"
>   	mkdir -p "$repo/.git"
>   	(
> -		cd "$repo/.git" &&
> -		{ cp -Rl "$source_git/objects" . 2>/dev/null ||
> -			cp -R "$source_git/objects" .; } &&
> +		{ cp -Rl "$objects_dir" "$repo/.git/" 2>/dev/null ||
> +			cp -R "$objects_dir" "$repo/.git/"; } &&
>   		for stuff in "$source_git"/*; do
>   			case "$stuff" in
> -				*/objects|*/hooks|*/config)
> +				*/objects|*/hooks|*/config|*/commondir)
>   					;;
>   				*)
> -					cp -R "$stuff" . || exit 1
> +					cp -R "$stuff" "$repo/.git/" || exit 1
>   					;;
>   			esac
>   		done &&
> -		cd .. &&
> +		cd "$repo" &&
>   		git init -q && {
>   			test_have_prereq SYMLINKS ||
>   			git config core.symlinks false
> 

This breaks perf for the non-worktree case:

lsr@debian:~/src/git/t/perf$ make
rm -rf test-results
./run
=== Running 12 tests in this tree ===
cp: cannot stat '.git/objects': No such file or directory
error: failed to copy repository '/home/lsr/src/git/t/..' to '/tmp/trash directory.p0000-perf-lib-sanity'
cp: cannot stat '.git/objects': No such file or directory
error: failed to copy repository '/home/lsr/src/git/t/..' to '/tmp/trash directory.p0001-rev-list'
...

Here's a fix:

-- >8 --
Subject: perf: make the tests work without a worktree

In regular repositories $source_git and $objects_dir contain relative
paths based on $source.  Go there to allow cp to resolve them.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/perf/perf-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 5ef1744..1888790 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -84,6 +84,7 @@ test_perf_create_repo_from () {
 	objects_dir="$(git -C "$source" rev-parse --git-path objects)"
 	mkdir -p "$repo/.git"
 	(
+		cd "$source" &&
 		{ cp -Rl "$objects_dir" "$repo/.git/" 2>/dev/null ||
 			cp -R "$objects_dir" "$repo/.git/"; } &&
 		for stuff in "$source_git"/*; do
-- 
2.8.3
