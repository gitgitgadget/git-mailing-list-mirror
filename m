Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9D2207E4
	for <e@80x24.org>; Thu, 27 Apr 2017 09:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032239AbdD0JTR (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 05:19:17 -0400
Received: from [195.159.176.226] ([195.159.176.226]:41537 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1032206AbdD0JTP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 05:19:15 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1d3fZr-0003SH-4i
        for git@vger.kernel.org; Thu, 27 Apr 2017 11:19:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] git-gui--askpass: generalize the wording
Date:   Thu, 27 Apr 2017 11:19:04 +0200
Message-ID: <f318a3ab-930f-fa58-db3d-d28998371a86@gmail.com>
References: <0102015aa974d7a6-46afa73b-4378-4b01-9db4-723fb9e41d65-000000@eu-west-1.amazonses.com>
 <0102015bae2176a2-8239cc7d-6510-4903-856b-e4fb0ef0cc71-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <0102015bae2176a2-8239cc7d-6510-4903-856b-e4fb0ef0cc71-000000@eu-west-1.amazonses.com>
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+ Pat

On 2017-04-27 08:38, Sebastian Schuberth wrote:

> git-gui--askpass is not only used for SSH authentication, but also for
> HTTPS. In that context it is confusing to only rfer to "OpenSSH", also
> because another SSH client like PuTTY might be in use. So generalize
> wording and also say which parent process, i.e. Git, requires
> authentication.
> 
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>   git-gui/git-gui--askpass | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/git-gui/git-gui--askpass b/git-gui/git-gui--askpass
> index 4277f30..4e3f00d 100755
> --- a/git-gui/git-gui--askpass
> +++ b/git-gui/git-gui--askpass
> @@ -2,7 +2,7 @@
>   # Tcl ignores the next line -*- tcl -*- \
>   exec wish "$0" -- "$@"
>   
> -# This is a trivial implementation of an SSH_ASKPASS handler.
> +# This is a trivial implementation of an GIT_ASKPASS / SSH_ASKPASS handler.
>   # Git-gui uses this script if none are already configured.
>   
>   package require Tk
> @@ -12,7 +12,7 @@ set yesno  0
>   set rc     255
>   
>   if {$argc < 1} {
> -	set prompt "Enter your OpenSSH passphrase:"
> +	set prompt "Enter your password / passphrase:"
>   } else {
>   	set prompt [join $argv " "]
>   	if {[regexp -nocase {\(yes\/no\)\?\s*$} $prompt]} {
> @@ -60,7 +60,7 @@ proc finish {} {
>   	set ::rc 0
>   }
>   
> -wm title . "OpenSSH"
> +wm title . "Git Authentication"
>   tk::PlaceWindow .
>   vwait rc
>   exit $rc
> 


-- 
Sebastian Schuberth

