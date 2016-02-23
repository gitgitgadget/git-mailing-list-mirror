From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] push: shorten "push.default is unset" warning message
Date: Tue, 23 Feb 2016 20:38:27 -0000
Organization: OPDS
Message-ID: <A8668075C5244F34A8C21A22F91ED823@PhilipOakley>
References: <000001530ea408ed-2b71a34a-32bb-434c-bba5-fdac28193e9c-000000@eu-west-1.amazonses.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 21:38:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYJj6-0007VG-Cc
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 21:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbcBWUi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 15:38:28 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:21615 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752099AbcBWUi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 15:38:28 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BqGQDDwsxWPHIrBlxeGQEBAgsBAgEBAQEBgwpSbYdQsQlsgxQHFw6FHkQBAwEBgU5NAQEBAQEBBwEBAQFBJRtBAQQNAYNoBgEFCAEBLhYIAQEsAgMFAgEDFQwlFAEEGAIGBwMUBgEHCwgCAQIDAQwEiAEKtFGIVgEBARyGEoQ6g3o5gy2BDwWHVoVUOIklAYFDhBOJY0qMS4VyiFeCZRmBSDwuAYEJgz+DbAEBAQ
X-IPAS-Result: A2BqGQDDwsxWPHIrBlxeGQEBAgsBAgEBAQEBgwpSbYdQsQlsgxQHFw6FHkQBAwEBgU5NAQEBAQEBBwEBAQFBJRtBAQQNAYNoBgEFCAEBLhYIAQEsAgMFAgEDFQwlFAEEGAIGBwMUBgEHCwgCAQIDAQwEiAEKtFGIVgEBARyGEoQ6g3o5gy2BDwWHVoVUOIklAYFDhBOJY0qMS4VyiFeCZRmBSDwuAYEJgz+DbAEBAQ
X-IronPort-AV: E=Sophos;i="5.22,491,1449532800"; 
   d="scan'208";a="620677698"
Received: from host-92-6-43-114.as43234.net (HELO PhilipOakley) ([92.6.43.114])
  by out1.ip03ir2.opaltelecom.net with SMTP; 23 Feb 2016 21:16:59 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287112>

From: "Matthieu Moy" <Matthieu.Moy@imag.fr>
> From: Matthieu Moy <matthieu.moy@imag.fr>
>
> The warning was purposely long, both to explain the situation properly
> and to give a strong incentive to set push.default explicitly. This was
> important before the 2.0 transition, and remained important for a while
> after, so that new users get push.default explicitly in their
> configuration and do not experience inconsistent behavior if they ever
> used an older version of Git.
>
> The warning has been there since version 1.8.0 (Oct 2012), hence we can
> expect the vast majority of current Git users to have been exposed to
> it, and most of them have already set push.default explicitly. The
> switch from 'matching' to 'simple' was planned for 2.0 (May 2014), but
> actually happened only for 2.3 (Feb 2015).
>
> The warning is mostly seen by beginners, who have not set their
> push.default configuration (yet). For many of them, the warning is
> confusing because it talks about concepts that they have not learned and
> asks them a choice that they are not able to make yet. See for example
>
> 
> http://stackoverflow.com/questions/13148066/warning-push-default-is-unset-its-implicit-value-is-changing-in-git-2-0
>

Shouldn't this also update the 'push' man page to state what the new default 
is. @gerry's comment to the top answer 
http://stackoverflow.com/a/13148313/717355 highlights that the word 'simple' 
is not even mentioned in the 'push' man page.


> (1260 votes for the question, 1824 for the answer as of writing)
>
> Shorten the warning and mention only the way to remove the warning
> without changing the behavior. Keep a pointer to the documentation so
> that people willing to learn can still find the alternative behaviors
> easily.
>
> Eventually, the warning should be removed completely, but this can wait
> a couple more releases or years.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> builtin/push.c | 20 +++-----------------
> 1 file changed, 3 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 960ffc3..00eba2f 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -205,26 +205,12 @@ static void setup_push_current(struct remote 
> *remote, struct branch *branch)
> }
>
> static char warn_unspecified_push_default_msg[] =
> -N_("push.default is unset; its implicit value has changed in\n"
> -   "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
> -   "and maintain the traditional behavior, use:\n"
> -   "\n"
> -   "  git config --global push.default matching\n"
> -   "\n"
> -   "To squelch this message and adopt the new behavior now, use:\n"
> +N_("push.default is unset; its default value has changed in Git 2.0 
> from\n"
> +   "'matching' to 'simple'. To squelch this message and adopt the new 
> behavior, use:\n"
>    "\n"
>    "  git config --global push.default simple\n"
>    "\n"
> -   "When push.default is set to 'matching', git will push local 
> branches\n"
> -   "to the remote branches that already exist with the same name.\n"
> -   "\n"
> -   "Since Git 2.0, Git defaults to the more conservative 'simple'\n"
> -   "behavior, which only pushes the current branch to the 
> corresponding\n"
> -   "remote branch that 'git pull' uses to update the current branch.\n"
> -   "\n"
> -   "See 'git help config' and search for 'push.default' for further 
> information.\n"
> -   "(the 'simple' mode was introduced in Git 1.7.11. Use the similar 
> mode\n"
> -   "'current' instead of 'simple' if you sometimes use older versions of 
> Git)");
> +   "See 'git help config' and search for 'push.default' for further 
> information.");
>
> static void warn_unspecified_push_default_configuration(void)
> {
>
> --
> https://github.com/git/git/pull/201
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
