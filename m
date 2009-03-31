From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/8] mergetool: use tabs consistently
Date: Mon, 30 Mar 2009 23:36:14 -0700
Message-ID: <20090331063613.GA20690@gmail.com>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com> <1238389428-69328-2-git-send-email-davvid@gmail.com> <7vzlf3flim.fsf@gitster.siamese.dyndns.org> <20090330213530.GA7091@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 08:37:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoXbe-00029w-EW
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 08:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbZCaGgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 02:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754750AbZCaGgW
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 02:36:22 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:38493 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600AbZCaGgW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 02:36:22 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1557640wah.21
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 23:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NlhArbP186LZZQ7KjH3yJkXNWHhrHqBfaNKjsSf8mYE=;
        b=tboFhHm1uUND9XeyA7AG1QOsRMyJyr4xeKxy21PXX8CzOoywBnrf149q8VQ40JApxp
         HXU92t6Rms52ZDf0w5jbamFfG7lSkpjZ2AriCkVVDXdf8utz1A9hso7WrQOExze5GrZo
         Z0MtFicI2PETknh2zC3Ax+hfWvqF1eo5ndyEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=el/ZD1DfB6z1F4Wrz6o3fxp0pua6675MI5jqGboPT06HgPI5CP+p0aTBAmrAlQWFbW
         KM+wj74ZnaM+qKqQcUX726ba3opKjQT6cfUsh90YlfKJiJsKaaPW2SRavhUnaGjvOqEV
         kJYBDzBa/NtWUT5Ridp7uoKSNYQO4ij2lmAcs=
Received: by 10.115.107.5 with SMTP id j5mr4139562wam.158.1238481380038;
        Mon, 30 Mar 2009 23:36:20 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n30sm5285846wag.56.2009.03.30.23.36.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 23:36:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090330213530.GA7091@hashpling.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115225>

On  0, Charles Bailey <charles@hashpling.org> wrote:
> On Mon, Mar 30, 2009 at 01:44:01AM -0700, Junio C Hamano wrote:
> 
> I don't much like [1/8] though. I'm all in favour of consistency, but
> this patch touches most of the lines in git-mergetool and tries to go
> the opposite way to the consistency drive that we were trying to
> introduce gradually (i.e. only through lines materially affected by
> subsequent patches) in:

Sounds good.  I'll re-roll and give the refactoring another go.

I think we can definitely do better, and more importantly, I
think we can decouple things by using less globals.

Junio, did you have any comments about patch v2
"difftool: add support for difftool.prompt config variable"?

This series was based on top of that patch so I'm wondering if I
should do that again.


> 
> commit 0eea345111a9b9fea4dd2841b80bc7d62964e812
> Author: Charles Bailey <charles@hashpling.org>
> Date:   Thu Nov 13 12:41:13 2008 +0000
> 
>     Fix some tab/space inconsistencies in git-mergetool.sh
> 
> If you'd gone the other way the patch to consistency would only affect
> 23 lines rather than 347 lines and all bar 3 of these lines you
> subsequently remove from git-mergetool.sh in later patches anyway.
> 
> [2/8] - looks good.
> 
> [3/8] - no mergetool impact.
> 
> [4/8] - Hmmm, OK. Even so at this point, I'm getting slightly iffy
> feelings about the whole init_merge_tool_path sets a variable needed
> by the calling script. I know it's only scripting and not programming,
> but it seemed less bad to set (global) variables in sh functions when
> they were all in the same sh script.
> 
> [5/8] - no mergtool impact.
> 
> [6/8] - ditto
> 
> [7/8] - OK, here's where my uneasiness about global script variables
> vs. parameters really gets going. Why is merge_tool a parameter when
> it's setup once and doesn't change in the invocation of a script, yet
> base_present is a script global but can vary between sets of paths to
> be merged?
> 
> I fully appreciate that this is just inheriting the way things are
> and that they weren't beautiful before, but it somehow seems even
> worse when the variables are set in one script and used from a
> function in a separate sourced script. We're definitely setting up a
> very strong coupling between the two scripts which will make it harder
> to change either in the future.
> 
> [8/8] - no mergetool impact here.
> 
> On the plus side, I really like the introduction and function of the
> run_mergetool function. It's exactly the split that will make
> extending mergetool resolves of file vs. symlink vs. directory easier
> in the future. I have a similar split in some slow brewing patches
> myself.
> 
> I think that [1/8] is the only patch that I'd relucatant to ack, as it
> seems like unnecessary churn and change of direction. Here's a sample
> patch for consistency 'the other way'. As I mentioned before, the
> first to hunks are made redundant by your subsequent changes anyway,
> so I only counted 3 lines that are currently inconsistent in
> git-mergetool as it stands at the moment.
> 
> Sample patch fixing consistent whitespace 'the other way'.
> ---
>  git-mergetool.sh |   46 +++++++++++++++++++++++-----------------------
>  1 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 87fa88a..1588b5f 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -344,29 +344,29 @@ valid_custom_tool()
>  }
>  
>  valid_tool() {
> -	case "$1" in
> -		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
> -			;; # happy
> -		*)
> -			if ! valid_custom_tool "$1"; then
> -				return 1
> -			fi
> -			;;
> -	esac
> +    case "$1" in
> +	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
> +	    ;; # happy
> +	*)
> +	    if ! valid_custom_tool "$1"; then
> +		return 1
> +	    fi
> +	    ;;
> +    esac
>  }
>  
>  init_merge_tool_path() {
> -	merge_tool_path=`git config mergetool.$1.path`
> -	if test -z "$merge_tool_path" ; then
> -		case "$1" in
> -			emerge)
> -				merge_tool_path=emacs
> -				;;
> -			*)
> -				merge_tool_path=$1
> -				;;
> -		esac
> -	fi
> +    merge_tool_path=`git config mergetool.$1.path`
> +    if test -z "$merge_tool_path" ; then
> +	case "$1" in
> +	    emerge)
> +		merge_tool_path=emacs
> +		;;
> +	    *)
> +		merge_tool_path=$1
> +		;;
> +	esac
> +    fi
>  }
>  
>  prompt_after_failed_merge() {
> @@ -389,9 +389,9 @@ prompt_after_failed_merge() {
>  if test -z "$merge_tool"; then
>      merge_tool=`git config merge.tool`
>      if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
> -	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
> -	    echo >&2 "Resetting to default..."
> -	    unset merge_tool
> +	echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
> +	echo >&2 "Resetting to default..."
> +	unset merge_tool
>      fi
>  fi
>  
> -- 
> 1.6.2.323.geaf6e
> 
> -- 
> Charles Bailey
> http://ccgi.hashpling.plus.com/blog/

-- 
		David
