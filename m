From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH] Comment private modifier to improve performace.
Date: Sun, 03 Feb 2008 18:03:35 -0200
Message-ID: <47A61E17.7060303@intelinet.com.br>
References: <1201919018-10782-1-git-send-email-rogersoares@intelinet.com.br> <200802030201.10971.robin.rosenberg@dewire.com> <200802030326.40446.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 21:03:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLl3O-0003vE-EU
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 21:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbYBCUCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 15:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbYBCUCM
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 15:02:12 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1308 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752632AbYBCUCK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 15:02:10 -0500
Received: (qmail 87479 invoked by uid 0); 3 Feb 2008 18:04:26 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.57383 secs); 03 Feb 2008 20:04:26 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 3 Feb 2008 20:04:25 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20071129)
In-Reply-To: <200802030326.40446.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72398>

With the else warnings patch I'm ok.

About the discouraged access, I read those warnings as: we are using 
methods that are not part of the eclipse public API and they can change 
in the future. Not depending on internal eclipse API will make egit less 
likely to break with a future eclipse version, which sounds like a good 
thing to me. So, I would keep those.

[]s,
Roger.

--
Robin Rosenberg escreveu:
> We could drop these settings from the projects too. 
>
> -- robin
>   
> ------------------------------------------------------------------------
>
> From a1aed72a122a05d01ed57db5d51b45debeb247b7 Mon Sep 17 00:00:00 2001
> From: Robin Rosenberg <robin.rosenberg@dewire.com>
> Date: Sun, 3 Feb 2008 03:13:44 +0100
> Subject: [PATCH] Make it possible to ignore warnings about discouraged access
>
> By removing the setting from the project the workspace settings
> will be applied (default: Warning)
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  .../.settings/org.eclipse.jdt.core.prefs           |    1 -
>  .../.settings/org.eclipse.jdt.core.prefs           |    1 -
>  .../.settings/org.eclipse.jdt.core.prefs           |    1 -
>  .../.settings/org.eclipse.jdt.core.prefs           |    1 -
>  .../.settings/org.eclipse.jdt.core.prefs           |    1 -
>  5 files changed, 0 insertions(+), 5 deletions(-)
>
> diff --git a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
> index 7a0fbe4..1c978ca 100644
> --- a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
> +++ b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
> @@ -14,7 +14,6 @@ org.eclipse.jdt.core.compiler.problem.autoboxing=warning
>  org.eclipse.jdt.core.compiler.problem.deprecation=warning
>  org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=disabled
>  org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedMethod=disabled
> -org.eclipse.jdt.core.compiler.problem.discouragedReference=warning
>  org.eclipse.jdt.core.compiler.problem.emptyStatement=warning
>  org.eclipse.jdt.core.compiler.problem.enumIdentifier=error
>  org.eclipse.jdt.core.compiler.problem.fallthroughCase=warning
> diff --git a/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs b/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
> index bcde160..2afc050 100644
> --- a/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
> +++ b/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
> @@ -14,7 +14,6 @@ org.eclipse.jdt.core.compiler.problem.autoboxing=warning
>  org.eclipse.jdt.core.compiler.problem.deprecation=warning
>  org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=disabled
>  org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedMethod=disabled
> -org.eclipse.jdt.core.compiler.problem.discouragedReference=warning
>  org.eclipse.jdt.core.compiler.problem.emptyStatement=warning
>  org.eclipse.jdt.core.compiler.problem.enumIdentifier=error
>  org.eclipse.jdt.core.compiler.problem.fallthroughCase=warning
> diff --git a/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs b/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
> index 0a89f52..0da92c7 100644
> --- a/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
> +++ b/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
> @@ -14,7 +14,6 @@ org.eclipse.jdt.core.compiler.problem.autoboxing=warning
>  org.eclipse.jdt.core.compiler.problem.deprecation=warning
>  org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=disabled
>  org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedMethod=disabled
> -org.eclipse.jdt.core.compiler.problem.discouragedReference=warning
>  org.eclipse.jdt.core.compiler.problem.emptyStatement=warning
>  org.eclipse.jdt.core.compiler.problem.enumIdentifier=error
>  org.eclipse.jdt.core.compiler.problem.fallthroughCase=warning
> diff --git a/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs b/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
> index c203c20..9adf651 100644
> --- a/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
> +++ b/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
> @@ -14,7 +14,6 @@ org.eclipse.jdt.core.compiler.problem.autoboxing=warning
>  org.eclipse.jdt.core.compiler.problem.deprecation=warning
>  org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=disabled
>  org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedMethod=disabled
> -org.eclipse.jdt.core.compiler.problem.discouragedReference=warning
>  org.eclipse.jdt.core.compiler.problem.emptyStatement=warning
>  org.eclipse.jdt.core.compiler.problem.enumIdentifier=error
>  org.eclipse.jdt.core.compiler.problem.fallthroughCase=warning
> diff --git a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs b/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
> index b0c694c..faecf76 100644
> --- a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
> +++ b/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
> @@ -14,7 +14,6 @@ org.eclipse.jdt.core.compiler.problem.autoboxing=warning
>  org.eclipse.jdt.core.compiler.problem.deprecation=warning
>  org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=disabled
>  org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedMethod=disabled
> -org.eclipse.jdt.core.compiler.problem.discouragedReference=warning
>  org.eclipse.jdt.core.compiler.problem.emptyStatement=warning
>  org.eclipse.jdt.core.compiler.problem.enumIdentifier=error
>  org.eclipse.jdt.core.compiler.problem.fallthroughCase=warning
>   
> ------------------------------------------------------------------------
>
> From e9f312599eb5941a7bf1acd70c6f0ac9fb1ea889 Mon Sep 17 00:00:00 2001
> From: Robin Rosenberg <robin.rosenberg@dewire.com>
> Date: Sun, 3 Feb 2008 03:19:09 +0100
> Subject: [PATCH] Drop warnings about unnecessary else
>
> Use workspace setting, default ignore.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  .../.settings/org.eclipse.jdt.core.prefs           |    1 -
>  .../.settings/org.eclipse.jdt.core.prefs           |    1 -
>  .../.settings/org.eclipse.jdt.core.prefs           |    1 -
>  .../.settings/org.eclipse.jdt.core.prefs           |    1 -
>  .../.settings/org.eclipse.jdt.core.prefs           |    3 +--
>  5 files changed, 1 insertions(+), 6 deletions(-)
>
> diff --git a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
> index 1c978ca..7279d81 100644
> --- a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
> +++ b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
> @@ -58,7 +58,6 @@ org.eclipse.jdt.core.compiler.problem.typeParameterHiding=warning
>  org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=warning
>  org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
>  org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
> -org.eclipse.jdt.core.compiler.problem.unnecessaryElse=warning
>  org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
>  org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
>  org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=error
> diff --git a/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs b/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
> index 2afc050..2d94530 100644
> --- a/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
> +++ b/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
> @@ -58,7 +58,6 @@ org.eclipse.jdt.core.compiler.problem.typeParameterHiding=warning
>  org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=warning
>  org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
>  org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
> -org.eclipse.jdt.core.compiler.problem.unnecessaryElse=warning
>  org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
>  org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
>  org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=error
> diff --git a/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs b/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
> index 0da92c7..ff09222 100644
> --- a/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
> +++ b/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
> @@ -58,7 +58,6 @@ org.eclipse.jdt.core.compiler.problem.typeParameterHiding=warning
>  org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=warning
>  org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
>  org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
> -org.eclipse.jdt.core.compiler.problem.unnecessaryElse=warning
>  org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
>  org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
>  org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=error
> diff --git a/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs b/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
> index 9adf651..b93093f 100644
> --- a/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
> +++ b/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
> @@ -58,7 +58,6 @@ org.eclipse.jdt.core.compiler.problem.typeParameterHiding=warning
>  org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=warning
>  org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
>  org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
> -org.eclipse.jdt.core.compiler.problem.unnecessaryElse=warning
>  org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
>  org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
>  org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=error
> diff --git a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs b/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
> index faecf76..4a5d15f 100644
> --- a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
> +++ b/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
> @@ -1,4 +1,4 @@
> -#Tue Dec 18 01:35:52 CET 2007
> +#Sun Feb 03 03:16:45 CET 2008
>  eclipse.preferences.version=1
>  org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
>  org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
> @@ -58,7 +58,6 @@ org.eclipse.jdt.core.compiler.problem.typeParameterHiding=warning
>  org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=warning
>  org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
>  org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
> -org.eclipse.jdt.core.compiler.problem.unnecessaryElse=warning
>  org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
>  org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
>  org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=error
>   
