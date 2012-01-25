From: Jehan Bing <jehan@orb.com>
Subject: Re: [PATCH] submodule add: fix breakage when re-adding a deep submodule
Date: Tue, 24 Jan 2012 17:48:46 -0800
Message-ID: <4F1F5F7E.2000506@orb.com>
References: <jfmvpp$4v7$1@dough.gmane.org> <4F1F1E5F.2030509@web.de> <4F1F2784.1020904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 02:49:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpryv-0007yP-VX
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 02:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab2AYBs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 20:48:57 -0500
Received: from lo.gmane.org ([80.91.229.12]:56188 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754694Ab2AYBs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 20:48:56 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rpryp-0007x8-4A
	for git@vger.kernel.org; Wed, 25 Jan 2012 02:48:55 +0100
Received: from 173-167-111-189-sfba.hfc.comcastbusiness.net ([173.167.111.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 02:48:55 +0100
Received: from jehan by 173-167-111-189-sfba.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 02:48:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 173-167-111-189-sfba.hfc.comcastbusiness.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4F1F2784.1020904@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189092>

On 2012-01-24 13:49, Jens Lehmann wrote:
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3adab93..9bb2e13 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -131,6 +131,7 @@ module_clone()
>   	gitdir=
>   	gitdir_base=
>   	name=$(module_name "$path" 2>/dev/null)
> +	test -n "$name" || name="$path"
>   	base_path=$(dirname "$path")
>
>   	gitdir=$(git rev-parse --git-dir)

That fixed my problem. Thanks Jens.

	Jehan
