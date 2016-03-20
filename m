From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2] Add the tag.gpgsign option to sign all created tags
Date: Sun, 20 Mar 2016 16:38:34 +0000
Message-ID: <56EED20A.3000407@ramsayjones.plus.com>
References: <20160319182310.GA23124@spk-laptop>
 <20160320042912.GD18312@sigill.intra.peff.net>
 <20160320150703.GB5139@spk-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Laurent Arnoud <laurent@spkdev.net>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 17:38:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahgNH-0000Al-G5
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 17:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbcCTQij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 12:38:39 -0400
Received: from avasout03.plus.net ([84.93.230.244]:42698 "EHLO
	avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbcCTQii (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 12:38:38 -0400
Received: from [10.0.2.15] ([80.189.40.55])
	by avasout03 with smtp
	id YGea1s0021BQLD401Geb2W; Sun, 20 Mar 2016 16:38:36 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=X8+vUzne c=1 sm=1 tr=0
 a=LVbmpxbf7ppclCt3pfQTng==:117 a=LVbmpxbf7ppclCt3pfQTng==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=oYItyEeNAAAA:8 a=PKzvZo6CAAAA:8 a=6yiTBuE1COltYWqqL60A:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160320150703.GB5139@spk-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289366>



On 20/03/16 15:07, Laurent Arnoud wrote:
> The `tag.gpgsign` config option allows to sign all
> commits automatically.
  ^^^^^^^
presumably you meant tags.

> 
> Support `--no-sign` option to countermand configuration `tag.gpgsign`.
> 
> Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
> Reviewed-by: Jeff King <peff@peff.net>
> ---
>  Documentation/config.txt  |  3 +++
>  Documentation/git-tag.txt |  4 ++++
>  builtin/tag.c             | 21 ++++++++++++++++-----
>  3 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2cd6bdd..076c68a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2729,6 +2729,9 @@ submodule.<name>.ignore::
>  	"--ignore-submodules" option. The 'git submodule' commands are not
>  	affected by this setting.
>  
> +tag.gpgSign::
> +	A boolean to specify whether all tags created should be GPG signed.
> +
>  tag.sort::
>  	This variable controls the sort ordering of tags when displayed by
>  	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index abab481..757baa1 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -64,6 +64,10 @@ OPTIONS
>  --sign::
>  	Make a GPG-signed tag, using the default e-mail address's key.
>  
> +--no-sign::
> +	Countermand `tag.gpgSign` configuration variable that is
> +	set to force each and every tag to be signed.
> +

I assume that, after setting tag.gpgsign in the config, this is the
only way to get a lightweight tag. Maybe here, or above in config.txt,
this could be stated more obviously? dunno.

[Also, don't we normally describe --[no]-sign options together?]

ATB,
Ramsay Jones
