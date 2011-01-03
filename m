From: Jeffrey Phillips Freeman <jeffrey.freeman@syncleus.com>
Subject: Re: [RFC PATCH 3/3] filter-branch: support --submodule-filter
Date: Mon, 03 Jan 2011 18:44:35 -0500
Message-ID: <4D225F63.1040502@syncleus.com>
References: <cover.1293809100.git.trast@student.ethz.ch> <44e6104ba28c80a6befe0f39fa4e2d6eeec56aa9.1293809100.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 04 00:54:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZuE9-0007Om-UC
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 00:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830Ab1ACXyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 18:54:08 -0500
Received: from ambriel.syncleus.com ([74.208.167.238]:42331 "EHLO
	ambriel.syncleus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab1ACXyH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 18:54:07 -0500
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2011 18:54:07 EST
Received: from localhost (localhost [127.0.0.1])
	by ambriel.syncleus.com (Postfix) with ESMTP id 7EFDA180C0E0;
	Mon,  3 Jan 2011 18:44:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=syncleus.com;
	s=syncleus-dkim; t=1294098277;
	bh=tsIqFb3OY09S0CBFtkTnOZDD9SrfYXio9C8RZZcFw0c=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=m8LGZGO1dheDixP/Dvike/bCW0fqNlmHhg+jOQILL9yugkcdP0M0kpIdKCNL9SnjW
	 c4J3pyXlas4OrigGOJnnGKFBQvvkZfCcu77gVxGuxlKKMpNbQhBO7gl8MuMu0wC3ei
	 FhfGiyZj2YEHVElNqKNTTKgaLN+bK6taQxsmLMHk=
X-Virus-Scanned: by Syncleus using ClamAV at ambriel.syncleus.com
Received: from ambriel.syncleus.com ([127.0.0.1])
	by localhost (ambriel.syncleus.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e8g21mQT7raY; Mon,  3 Jan 2011 18:44:35 -0500 (EST)
Received: from [192.168.0.105] (c-68-63-138-197.hsd1.pa.comcast.net [68.63.138.197])
	by ambriel.syncleus.com (Postfix) with ESMTPSA id D8525180C0D9;
	Mon,  3 Jan 2011 18:44:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=syncleus.com;
	s=syncleus-dkim; t=1294098275;
	bh=tsIqFb3OY09S0CBFtkTnOZDD9SrfYXio9C8RZZcFw0c=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=LgmxheOoiJN82Uc4HBL1H/mZt2u+FvIwfkcbKAmYGngSbtrk0XxLc0esfsRoK6dD0
	 jiJTueb0fBhG56HHL7mEXUg9IQXNtQ6sakIlFv6Orw1eaFfBWbn531u+vL3Il7jK7n
	 L7Kf36JtqPpRVs5VMUM6m1cfBqggCapPD6tj4kuY=
DomainKey-Signature: a=rsa-sha1; s=syncleus-dk; d=syncleus.com; c=simple; q=dns;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject:
	references:in-reply-to:content-type:content-transfer-encoding;
	b=A9PfGW8TBDExli4wp9BS+IgkWXDFcJOmReYvpuA8yB38EYeimjT8+KA/4VEyLZqlb
	rIX4QdZqPERjHIeNPlhHHH3jMPIifGMczAfU8aVrkZPZXl8WKUWi9MFy2dMBH5BF2pg
	lUFbqlK6Y7s3vJB4CpaMUZYqVPIFzMluteN7+yU=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <44e6104ba28c80a6befe0f39fa4e2d6eeec56aa9.1293809100.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164463>

So im kinda new with all this so bare with me guys. I wanted to figure 
out how to apply these patches, now i know i can use git to do this with 
its patch command and such. However i was curious does this exist as a 
branch somewhere official or semi-official? I currently seem to be using 
--split-submodule which is itself in a git repo i have (which i want to 
also find its source repo so i can keep up to date with it). So applying 
the patch itself might be somewhat troubling due to conflicts, therefore 
id like to actually merge in a remote branch to keep things easy. So can 
you guys point me to which repo would be best for me to keep up to date 
with this would be?

On 12/31/2010 10:29 AM, Thomas Rast wrote:
> This new filter gets each submodule's current sha1 and path on stdin,
> separated by a tab.  It can then emit a new submodule sha1 and/or
> path, and filter-branch will:
>
> * if the path differs, remove the submodule at the old path;
>
> * add/replace the new sha1 at the new path.
>
> Additionally, returning an empty new sha1 deletes the submodule.
>
> You can tie this together with the last two commits to filter the
> super-project after a subproject filtering as follows:
>
>    ( cd sub1&&  git filter-branch --dump-map map<filters|args>  )
>    ( cd sub2&&  git filter-branch --dump-map map<filters|args>  )
>    cat sub1/map sub2/map>  map
>    git filter-branch --load-map map \
>    	--submodule-filter "map $(cut -f1)" \
> 	<args>
>
> Other use-cases should also be covered since we also pass through the
> path.
>
> Signed-off-by: Thomas Rast<trast@student.ethz.ch>
> ---
>   git-filter-branch.sh |   24 ++++++++++++++++++++++++
>   1 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 9feeb26..4a321c4 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -122,6 +122,7 @@ filter_msg=cat
>   filter_commit=
>   filter_tag_name=
>   filter_subdir=
> +filter_submodule=
>   orig_namespace=refs/original/
>   force=
>   prune_empty=
> @@ -193,6 +194,9 @@ do
>   		filter_subdir="$OPTARG"
>   		remap_to_ancestor=t
>   		;;
> +	--submodule-filter)
> +		filter_submodule="$OPTARG"
> +		;;
>   	--original)
>   		orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/
>   		;;
> @@ -379,6 +383,26 @@ while read commit parents; do
>   	eval "$filter_index"<  /dev/null ||
>   		die "index filter failed: $filter_index"
>
> +	if [ "$filter_submodule" ]; then
> +		git ls-files -s |
> +		grep '^160000' |
> +		while read mode sha1 stage path; do
> +			printf "$sha1\t$path\n" |
> +			{ eval "$filter_submodule" ||
> +				die "submodule filter failed: $filter_submodule"; } |
> +			read newsha1 newpath
> +			if [ -z "$newsha1" ] || [ "$path" != "$newpath" ]; then
> +				git update-index --remove "$path" ||
> +					die "failed to remove submodule $path"
> +			fi
> +			if [ -n "$newsha1" ]&&  [ "$sha1" != "$newsha1" ]; then
> +				git update-index --add --replace --cacheinfo \
> +					160000 "$newsha1" "$newpath" ||
> +					die "failed to add submodule $newpath"
> +			fi
> +		done
> +	fi
> +
>   	parentstr=
>   	for parent in $parents; do
>   		for reparent in $(map "$parent"); do
