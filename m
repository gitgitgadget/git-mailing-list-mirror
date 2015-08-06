From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/4] submodule: implement `module_name` as a builtin
 helper
Date: Thu, 6 Aug 2015 21:49:28 +0200
Message-ID: <55C3BA48.6050600@web.de>
References: <1438882524-21215-1-git-send-email-sbeller@google.com>
 <1438882524-21215-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 21:49:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNRAh-0001R3-3p
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 21:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbbHFTtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 15:49:42 -0400
Received: from mout.web.de ([212.227.17.11]:59071 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390AbbHFTtk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 15:49:40 -0400
Received: from [192.168.178.41] ([79.211.102.26]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lw0ht-1Ymk1z1icX-017nWN; Thu, 06 Aug 2015 21:49:34
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <1438882524-21215-2-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:jDiEAuf6Ekto+Qzw+mz5qDJGo44rBUTgu3X5cched6lcIeQYcKL
 7HazXnpCJw4sjoMU7l3QAHjRRJICcNuGSIC6kXu5EIE3qbR49fin+w6vaIwwpV1sj/PIIQl
 4VPbmPhNHpZtD3J7ai8xlxSDdQ7Yh/NUlvM1RnB8pcQjIzujf7XrfLnYyWf6MQfNDL5OpIE
 n/oQSZ6eUBANNC+cMkNVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2nK+1f1cCR0=:3dFpuJwArt3G2w3svmPZhk
 tPsh7FvsOvQtUiWEqrriHMMDaUe/whPwi6peq0T12p8OOHqWDdlDHe7EmOLSkawZhI3VhNAMx
 PRvuZ9/46kU8KLL/qQzDtR2/nPkLUHVhr3/y7Bf7uyKOW46b/6VW07oE3Vao+tWfM6GqQbLlX
 V4zU41/5eYLlX3i849b0M9IwLqXveRHGEDD9uAay1xTnh7jgEJD7M9oSZJU3pj7qx6WjhIbI6
 F5SlUVQegljzdiGPpYJPL8RHjDSyJGS01skNgF4qz05yCAvTQirvyTHo9331LxxhVGziuXAWn
 Ne3wBlPVLEh+USmsXCXQfGZSKlaLsL83fnBcMA5kYrILKv7lS2N6jBq+fBGzfvzX011jlRehh
 K5szZudkUGLeh5NFEyZUuiCnS05Z4togG7926lVEjuaUhx2K9p8k+yYGYwLKWz3KWW4pRefmC
 bpSsA7uXaiF5pt0Wi8xJaEQymH/YqiyEiUzfaqCMPz92YGW+JM0ETdCBCP4vTPBt99Ha2Iwyz
 VC9+4OVj6q/0rwbnhqoRRCBV1FV453Mct6qBDUnOaCIUu+U80/Q2FmLg7q74gFBLyJ0KjkPX5
 QxK+qF63FMTzMYYqRPyN6Ti+tnXA12w9YlrPDooTy9fWJ2LNc8QnoTVXuULEvfCiz8ymD7IqL
 xVAqDym6FpWnlNNVQayckUAcWsLbHrevPlHX9FacUBOjUV2i/cEWNsr+NGn/XlerO8b0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275439>

Am 06.08.2015 um 19:35 schrieb Stefan Beller:
> This implements the helper `module_name` in C instead of shell,
> yielding a nice performance boost.
>
> Before this patch, I measured a time (best out of three):
>
>    $ time ./t7400-submodule-basic.sh  >/dev/null
>      real	0m11.066s
>      user	0m3.348s
>      sys	0m8.534s
>
> With this patch applied I measured (also best out of three)
>
>    $ time ./t7400-submodule-basic.sh  >/dev/null
>      real	0m10.063s
>      user	0m3.044s
>      sys	0m7.487s
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Please see my comments in the other thread concerning this patch.

And wouldn't it make more sense to keep this patch together with
the "submodule: implement `module_list` as a builtin helper" in
its own "submodule-helper" series and have the following three
patches in a separate "parallel fetch for submodules" series?

>   builtin/submodule--helper.c | 23 +++++++++++++++++++++++
>   git-submodule.sh            | 32 +++++++-------------------------
>   submodule.c                 | 18 +++++++++++++-----
>   submodule.h                 |  1 +
>   4 files changed, 44 insertions(+), 30 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index cb18ddf..3713c4c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -5,6 +5,8 @@
>   #include "pathspec.h"
>   #include "dir.h"
>   #include "utf8.h"
> +#include "submodule.h"
> +#include "string-list.h"
>
>   static char *ps_matched;
>   static const struct cache_entry **ce_entries;
> @@ -98,6 +100,24 @@ static int module_list(int argc, const char **argv, const char *prefix)
>   	return 0;
>   }
>
> +static int module_name(int argc, const char **argv, const char *prefix)
> +{
> +	const char *name;
> +
> +	if (argc != 1)
> +		usage("git submodule--helper module_name <path>\n");
> +
> +	gitmodules_config();
> +	name = submodule_name_for_path(argv[0]);
> +
> +	if (name)
> +		printf("%s\n", name);
> +	else
> +		die("No submodule mapping found in .gitmodules for path '%s'", argv[0]);
> +
> +	return 0;
> +}
> +
>   int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>   {
>   	if (argc < 2)
> @@ -106,6 +126,9 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>   	if (!strcmp(argv[1], "module_list"))
>   		return module_list(argc - 1, argv + 1, prefix);
>
> +	if (!strcmp(argv[1], "module_name"))
> +		return module_name(argc - 2, argv + 2, prefix);
> +
>   usage:
>   	usage("git submodule--helper module_list\n");
>   }
> diff --git a/git-submodule.sh b/git-submodule.sh
> index af9ecef..e6ff38d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -178,24 +178,6 @@ get_submodule_config () {
>   	printf '%s' "${value:-$default}"
>   }
>
> -
> -#
> -# Map submodule path to submodule name
> -#
> -# $1 = path
> -#
> -module_name()
> -{
> -	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
> -	sm_path="$1"
> -	re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
> -	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
> -		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
> -	test -z "$name" &&
> -	die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$sm_path'")"
> -	printf '%s\n' "$name"
> -}
> -
>   #
>   # Clone a submodule
>   #
> @@ -498,7 +480,7 @@ cmd_foreach()
>   		then
>   			displaypath=$(relative_path "$sm_path")
>   			say "$(eval_gettext "Entering '\$prefix\$displaypath'")"
> -			name=$(module_name "$sm_path")
> +			name=$(git submodule--helper module_name "$sm_path")
>   			(
>   				prefix="$prefix$sm_path/"
>   				clear_local_git_env
> @@ -554,7 +536,7 @@ cmd_init()
>   	while read mode sha1 stage sm_path
>   	do
>   		die_if_unmatched "$mode"
> -		name=$(module_name "$sm_path") || exit
> +		name=$(git submodule--helper module_name "$sm_path") || exit
>
>   		displaypath=$(relative_path "$sm_path")
>
> @@ -636,7 +618,7 @@ cmd_deinit()
>   	while read mode sha1 stage sm_path
>   	do
>   		die_if_unmatched "$mode"
> -		name=$(module_name "$sm_path") || exit
> +		name=$(git submodule--helper module_name "$sm_path") || exit
>
>   		displaypath=$(relative_path "$sm_path")
>
> @@ -758,7 +740,7 @@ cmd_update()
>   			echo >&2 "Skipping unmerged submodule $prefix$sm_path"
>   			continue
>   		fi
> -		name=$(module_name "$sm_path") || exit
> +		name=$(git submodule--helper module_name "$sm_path") || exit
>   		url=$(git config submodule."$name".url)
>   		branch=$(get_submodule_config "$name" branch master)
>   		if ! test -z "$update"
> @@ -1022,7 +1004,7 @@ cmd_summary() {
>   			# Respect the ignore setting for --for-status.
>   			if test -n "$for_status"
>   			then
> -				name=$(module_name "$sm_path")
> +				name=$(git submodule--helper module_name "$sm_path")
>   				ignore_config=$(get_submodule_config "$name" ignore none)
>   				test $status != A && test $ignore_config = all && continue
>   			fi
> @@ -1184,7 +1166,7 @@ cmd_status()
>   	while read mode sha1 stage sm_path
>   	do
>   		die_if_unmatched "$mode"
> -		name=$(module_name "$sm_path") || exit
> +		name=$(git submodule--helper module_name "$sm_path") || exit
>   		url=$(git config submodule."$name".url)
>   		displaypath=$(relative_path "$prefix$sm_path")
>   		if test "$stage" = U
> @@ -1261,7 +1243,7 @@ cmd_sync()
>   	while read mode sha1 stage sm_path
>   	do
>   		die_if_unmatched "$mode"
> -		name=$(module_name "$sm_path")
> +		name=$(git submodule--helper module_name "$sm_path")
>   		url=$(git config -f .gitmodules --get submodule."$name".url)
>
>   		# Possibly a url relative to parent
> diff --git a/submodule.c b/submodule.c
> index 15e90d1..872967f 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -686,6 +686,16 @@ static void calculate_changed_submodule_paths(void)
>   	initialized_fetch_ref_tips = 0;
>   }
>
> +const char* submodule_name_for_path(const char* path)
> +{
> +	struct string_list_item *item;
> +	item = unsorted_string_list_lookup(&config_name_for_path, path);
> +	if (item)
> +		return item->util;
> +	else
> +		return NULL;
> +}
> +
>   int fetch_populated_submodules(const struct argv_array *options,
>   			       const char *prefix, int command_line_option,
>   			       int quiet)
> @@ -693,7 +703,7 @@ int fetch_populated_submodules(const struct argv_array *options,
>   	int i, result = 0;
>   	struct child_process cp = CHILD_PROCESS_INIT;
>   	struct argv_array argv = ARGV_ARRAY_INIT;
> -	struct string_list_item *name_for_path;
> +	const char *name_for_path;
>   	const char *work_tree = get_git_work_tree();
>   	if (!work_tree)
>   		goto out;
> @@ -723,10 +733,8 @@ int fetch_populated_submodules(const struct argv_array *options,
>   		if (!S_ISGITLINK(ce->ce_mode))
>   			continue;
>
> -		name = ce->name;
> -		name_for_path = unsorted_string_list_lookup(&config_name_for_path, ce->name);
> -		if (name_for_path)
> -			name = name_for_path->util;
> +		name_for_path = submodule_name_for_path(ce->name);
> +		name =  name_for_path ? name_for_path : ce->name;
>
>   		default_argv = "yes";
>   		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
> diff --git a/submodule.h b/submodule.h
> index 7beec48..e3dd854 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -41,5 +41,6 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
>   		struct string_list *needs_pushing);
>   int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
>   void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
> +const char* submodule_name_for_path(const char* path);
>
>   #endif
>
