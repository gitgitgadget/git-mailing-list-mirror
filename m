From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Documentation/submodule: Fix submodule.<name> -> .<path>
 typos
Date: Fri, 28 Mar 2014 00:15:00 +0100
Message-ID: <5334B0F4.60103@web.de>
References: <f86f6b48f1c840d50d00c591a296821e0a18ee0d.1395954229.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 00:15:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTJW8-0007G7-Om
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 00:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214AbaC0XPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 19:15:17 -0400
Received: from mout.web.de ([212.227.15.14]:62583 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757102AbaC0XPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 19:15:16 -0400
Received: from [192.168.178.41] ([84.132.148.44]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M6V1T-1XIf0f2ujb-00yQd3; Fri, 28 Mar 2014 00:15:02
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <f86f6b48f1c840d50d00c591a296821e0a18ee0d.1395954229.git.wking@tremily.us>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:F6rM2NyT7h5wFfe/7B0xJ+k59KYqCAahbxeWE4ZPUwHmrKX1JOL
 TtDuV7ZoAnFX2ERucIy4XXyE9NyBqZURLk/kwyulcCkjx8F8KnFl7ddmKLipzqPn8UdS2lY
 PIFXFJfL8MlwryaK9u+POGy0m7T8ZxPr7mUUrZknYXgG2mnvHtGoNfFdGec2pYVrvCEc3uY
 TiCiITaDqOeP33/PoSdQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245338>

Am 27.03.2014 22:06, schrieb W. Trevor King:
> The transition from submodule.<path>.* to submodule.<name>.* happened
> in 73b0898d (Teach "git submodule add" the --name option, 2012-09-30),
> which landed in v1.8.1-rc0 on 2012-12-03.

Nope, the distinction between path and name is way older (AFAIK it
is there from day one). That was just the point in time where you
could choose a different name without editing .gitmodules. And the
fact that the name is initialized with the path confused a lot of
people.

>  The first
> submodule.<path>.branch reference landed a short time later in
> b9289227 (submodule add: If --branch is given, record it in
> .gitmodules, 2012-12-19), and I was probably just not aware of
> 73b0898d.  The second submodule.<path>.branch reference landed in
> 23d25e48 (submodule: explicit local branch creation in module_clone,
> 2014-01-26), and is just a copy paste error.  This commit updates both
> references to the current submodule.<name>.branch.
> 
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
> This patch is against master, because 23d25e48 hasn't landed in maint
> yet.  If you want, I can split this into two patches, one against
> maint fixing the b9289227 typo and another against master fixing the
> 23d25e48 typo.

This fixes the only two usages of 'submodule.<path>.*' in the
Documentation I can see in current master.

>  Documentation/git-submodule.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 46c1eeb..77588b0 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -162,7 +162,7 @@ update::
>  +
>  For updates that clone missing submodules, checkout-mode updates will
>  create submodules with detached HEADs; all other modes will create
> -submodules with a local branch named after `submodule.<path>.branch`.
> +submodules with a local branch named after `submodule.<name>.branch`.
>  +
>  For updates that do not clone missing submodules, the submodule's HEAD
>  is only touched when the remote reference does not match the
> @@ -247,7 +247,7 @@ OPTIONS
>  -b::
>  --branch::
>  	Branch of repository to add as submodule.
> -	The name of the branch is recorded as `submodule.<path>.branch` in
> +	The name of the branch is recorded as `submodule.<name>.branch` in
>  	`.gitmodules` for `update --remote`.
>  
>  -f::
> 
