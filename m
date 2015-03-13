From: Duy Nguyen <pclouds@gmail.com>
Subject: Re:
Date: Fri, 13 Mar 2015 09:00:53 +0700
Message-ID: <CACsJy8B3anJdGHpRN4Mr_A3Uhhsth_Uyizd=iM46Jky-ZMjvrQ@mail.gmail.com>
References: <20150313012620.11094.40096@catuvm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: cody.taylor@maternityneighborhood.com
X-From: git-owner@vger.kernel.org Fri Mar 13 03:01:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWEuv-0005Xs-Jn
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 03:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356AbbCMCBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 22:01:33 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34453 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393AbbCMCBc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 22:01:32 -0400
Received: by iecsl2 with SMTP id sl2so74203546iec.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2015 19:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xqNVITUpejhjZMmAnLlbxNafN15PogNbnfGrqSfgF3I=;
        b=IiNtgw21CIy0CFXhaqN4+PQUYlPAEUZS2XyP7SqfwmU9dR1XV/TZ/HCBI2ooez+sb4
         zLO/nRg7nZIV1QbShRwJVc9awD5U93F64lW9YSRqJueRIDluIqtbm0dg96WheiLQI3lG
         1qbLU7mVaGzd9+JssjC/SZ7w8YFpMTjgs00oPpP+Wn2473Luu0eAitbj1b+r7f/KKO/P
         xpgwupQ84hwt9v54jNKuj8mB5PRDFE/Ci1dWN34n8LcyF2vJgdUL4qFDhFCSofll+7kt
         5bLBuujGeJRGxqfPHyeR5SvkmpPQNgrwYLvHEOWF0o2i3jZMv6oelOxg5Ey7w3vjSqtX
         DHSQ==
X-Received: by 10.50.61.34 with SMTP id m2mr80392633igr.20.1426212083877; Thu,
 12 Mar 2015 19:01:23 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Thu, 12 Mar 2015 19:00:53 -0700 (PDT)
In-Reply-To: <20150313012620.11094.40096@catuvm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265389>

On Fri, Mar 13, 2015 at 8:34 AM,  <cody.taylor@maternityneighborhood.com> wrote:
> From 3e4e22e93bf07355b40ba0abcb3a15c4941cfee7 Mon Sep 17 00:00:00 2001
> From: Cody A Taylor <codemister99@yahoo.com>
> Date: Thu, 12 Mar 2015 20:36:44 -0400
> Subject: [PATCH] git prompt: Use toplevel to find untracked files.
>
> The __git_ps1() prompt function would not show an untracked
> state when the current working directory was not a parent of
> the untracked file.
>
> Signed-off-by: Cody A Taylor <codemister99@yahoo.com>
> ---
>  contrib/completion/git-prompt.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 214e859f99e7..f0d8a2669236 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -487,7 +487,8 @@ __git_ps1 ()
>
>                 if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
>                    [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
> -                  git ls-files --others --exclude-standard --error-unmatch -- '*' >/dev/null 2>/dev/null
> +                  git ls-files --others --exclude-standard --error-unmatch -- \
> +                    "$(git rev-parse --show-toplevel)/*" >/dev/null 2>/dev/null

Or make it a bit simpler, just replace '*' with ':/*'.
-- 
Duy
