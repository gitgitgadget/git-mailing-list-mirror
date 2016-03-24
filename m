From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetools: implemented new mergetool file for ExamDiff
Date: Thu, 24 Mar 2016 00:44:04 -0700
Message-ID: <20160324074404.GA30574@gmail.com>
References: <xmqqpoulex0b.fsf@gitster.mtv.corp.google.com>
 <1458773745-783-1-git-send-email-jacob.nisnevich@gmail.com>
 <1458773745-783-2-git-send-email-jacob.nisnevich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jacob Nisnevich <jacob.nisnevich@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 08:44:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aizwO-00066C-3Z
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 08:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652AbcCXHoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 03:44:12 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35345 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608AbcCXHoK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 03:44:10 -0400
Received: by mail-pa0-f50.google.com with SMTP id td3so15717861pab.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 00:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DVNU7wZH6qSsfJvpskha97tPfkGXkrNxbWOCxtOl5jw=;
        b=Cq6dgmBFXwEnWi7oDtqqD2CNT9Krdx+v0lNqhs4QuFIV4jRnsvaqu0rPBl7gpM89sw
         UFVtUnEMJDXIi1qe/xKXEPMNarXIpY5sQrrdL0Y5xlVNvOHUHNDS+BjCRHtiz9AzW03/
         4gQE72V8kKryeEGy8tCpUqvwOyzGOAjW4Ha0XX93xhnpY7e0w2OZrjDpv3ev4UgtVUFI
         A+9ynkYmXnmXJAQDFmop2UdrmiMVaqyHP5RFBcepmqu4BDHoi3sbNmZCYtNeD4pNTr7i
         7qLwLmoB3PxDRxFMgNKQTQTYKHrmKcPSvU25cEAN9Xdc5C7m3jSRPBcFpYYN5DTUvOHh
         qPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DVNU7wZH6qSsfJvpskha97tPfkGXkrNxbWOCxtOl5jw=;
        b=b4+ZVmVe3ZPhugEPJedb208IBRwYR7FuOxL/NvfwxDSmdfl9g4kkv1ZyuyyuAv60Qn
         f2T5Xq0eTML7ODlH+w8QMDzSqIYM/um+xHOQF5ljSPNshe6mMA88Uu53hN6VYLXUiC11
         16YtQr0r0/IUeE3PvWZMk9cqXcXiRwAFF/MIrpQ9ACvgWL6I3cOZRRtwmRWC1T4YU0ge
         jEbaFYL1achCnzQT+11gpgvkdelQZQ8aG0RFk8oemWiSZS/Ypl4ZrRr2SF8El72ETvxY
         l+r+8OGBwfLnouEKcG/kk2rD7oiO7yrhLzMAogGVUDIyW0x9864RswXUmv7YO+BZOMo8
         DPjA==
X-Gm-Message-State: AD7BkJIfNo0ZERVJt1L25mh7hFoPG7GA7ejSNpEw2xD6xFxwP3O7KGT54KHvb1i9nIzcGQ==
X-Received: by 10.66.233.131 with SMTP id tw3mr10703435pac.89.1458805448389;
        Thu, 24 Mar 2016 00:44:08 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id 62sm8552292pfk.83.2016.03.24.00.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2016 00:44:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1458773745-783-2-git-send-email-jacob.nisnevich@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289721>

On Wed, Mar 23, 2016 at 03:55:45PM -0700, Jacob Nisnevich wrote:
> Signed-off-by: Jacob Nisnevich <jacob.nisnevich@gmail.com>
> ---

Please write commit message in an imperative tone.
e.g. "mergetools: add support for ExamDiff" might be a good summary.


>  mergetools/examdiff           | 20 ++++++++++++++++++++
>  mergetools/mergetools_helpers | 24 ++++++++++++++++++++++++
>  mergetools/winmerge           | 23 +++--------------------
>  3 files changed, 47 insertions(+), 20 deletions(-)
>  create mode 100644 mergetools/examdiff
>  create mode 100644 mergetools/mergetools_helpers


This patch is doing two things.
It's probably worth breaking this patch up into two parts.

Patch 1 can add add the new helper function and update
winmerge to use it.

Patch 2 can add the new examdiff helper.


> diff --git a/mergetools/examdiff b/mergetools/examdiff
> new file mode 100644
> index 0000000..c5edd0e
> --- /dev/null
> +++ b/mergetools/examdiff
> @@ -0,0 +1,20 @@
> +. "$MERGE_TOOLS_DIR/mergetools_helpers"
> +
> +diff_cmd () {
> +	"$merge_tool_path" "$LOCAL" "$REMOTE" -nh
> +}
> +
> +merge_cmd () {
> +	touch "$BACKUP"
> +	if $base_present
> +	then
> +		"$merge_tool_path" -merge "$LOCAL" "$BASE" "$REMOTE" -o:"$MERGED" -nh
> +	else
> +		"$merge_tool_path" -merge "$LOCAL" "$REMOTE" -o:"$MERGED" -nh
> +	fi
> +	check_unchanged
> +}
> +
> +translate_merge_tool_path() {
> +	mergetool_find_win32_cmd "ExamDiff.com" "ExamDiff Pro"
> +}
> diff --git a/mergetools/mergetools_helpers b/mergetools/mergetools_helpers
> new file mode 100644
> index 0000000..46ae2d8
> --- /dev/null
> +++ b/mergetools/mergetools_helpers


We can probably do this without introducing a new file.  One
possible home for this is with the rest of the "default"
definitions of the functions in git-mergetool--lib.sh's
setup_tool() function.

But, that hints that we expect tools to override it.

A better place would be as a normal function inside
git-mergetool--lib.sh, which more strongly hints that we do not
expect tools to override mergetool_find_win32_cmd().


> @@ -0,0 +1,24 @@
> +mergetool_find_win32_cmd () {
> +	executable=$1
> +	folder=$2
> +
> +	# Use executable.com if it exists in $PATH
> +	if type -p $executable >/dev/null 2>&1
> +	then
> +		printf $executable


It might nut hurt to write this as,

		printf '%s' "$executable"


For consistency and future-proofing.


> +		return
> +	fi
> +
> +	# Look for executable in the typical locations
> +	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
> +		cut -d '=' -f 2- | sort -u)
> +	do
> +		if test -n "$directory" && test -x "$directory/$folder/$executable"
> +		then
> +			printf '%s' "$directory/$folder/$executable"
> +			return
> +		fi
> +	done
> +
> +	printf $executable
> +}
> diff --git a/mergetools/winmerge b/mergetools/winmerge
> index 74a66d4..c785be8 100644
> --- a/mergetools/winmerge
> +++ b/mergetools/winmerge
> @@ -1,3 +1,5 @@
> +. "$MERGE_TOOLS_DIR/mergetools_helpers"
> +


If we move the definition into mergetool--lib then we do not
need to dot-include any files here -- it'll simply be present
and available.


>  diff_cmd () {
>  	"$merge_tool_path" -u -e "$LOCAL" "$REMOTE"
>  	return 0
> @@ -13,24 +15,5 @@ merge_cmd () {
>  }
>  
>  translate_merge_tool_path() {
> -	# Use WinMergeU.exe if it exists in $PATH
> -	if type -p WinMergeU.exe >/dev/null 2>&1
> -	then
> -		printf WinMergeU.exe
> -		return
> -	fi
> -
> -	# Look for WinMergeU.exe in the typical locations
> -	winmerge_exe="WinMerge/WinMergeU.exe"
> -	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
> -		cut -d '=' -f 2- | sort -u)
> -	do
> -		if test -n "$directory" && test -x "$directory/$winmerge_exe"
> -		then
> -			printf '%s' "$directory/$winmerge_exe"
> -			return
> -		fi
> -	done
> -
> -	printf WinMergeU.exe
> +	mergetool_find_win32_cmd "WinMergeU.exe" "WinMerge"
>  }
> -- 
> 1.9.1
> 
-- 
David
