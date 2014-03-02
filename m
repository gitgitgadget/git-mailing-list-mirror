From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: Re: [PATCH] branch.c: change install_branch_config() to use skip_prefix()
Date: Sun, 2 Mar 2014 15:01:02 +0100
Message-ID: <CAL0uuq0Vc7uZdixLV6OciAZWFYcif_WMCNABEvC=6gT5s+mthQ@mail.gmail.com>
References: <1393761147-13590-1-git-send-email-mzguanglin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Guanglin Xu <mzguanglin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 15:01:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK6xU-0006E8-FB
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 15:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbaCBOBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 09:01:05 -0500
Received: from mail-vc0-f180.google.com ([209.85.220.180]:62365 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbaCBOBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 09:01:03 -0500
Received: by mail-vc0-f180.google.com with SMTP id ks9so2614887vcb.11
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 06:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iD5zNBgxI6/moIgJK5KsKRyQIkLZIgsKhFlwDY2lWvs=;
        b=WemI6UdrFBXQJudjqbHFCGIoFuVsaLBFcBhInMuvIxeqyVeswsvGrbXpXZiLIi1aVB
         h3XHfQni846knaEz8+IwLS7G+MDm9XLs0nmpKJ+KMl//kmZ7OfrK26BgfVZjtqaT/mGo
         NvKmvoAPz6gAqeOpYXNijynU5R7c0++fpZEzg6Ktc7eflkDpqTAkMgVtpYYgXgW3x4oT
         k8Iysq5bNyVX0M0b37ltpbVazQ61b88bgGk2kUYtVadBpDLKETPrbvpAoq91zehc49cV
         /eCCv4iSU8gXqaVLnBy21S3EyBetDCKka1Kz2vnOz3UoeHygE3rv1VRv1dDx/MUetYUJ
         1sWA==
X-Received: by 10.220.175.198 with SMTP id bb6mr2217746vcb.31.1393768862835;
 Sun, 02 Mar 2014 06:01:02 -0800 (PST)
Received: by 10.52.73.161 with HTTP; Sun, 2 Mar 2014 06:01:02 -0800 (PST)
In-Reply-To: <1393761147-13590-1-git-send-email-mzguanglin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243148>

The part about this being a GSoC microproject should go below the
three dashes, since it's not information that needs to
 be recorded in the codebase.

On Sun, Mar 2, 2014 at 12:52 PM, Guanglin Xu <mzguanglin@gmail.com> wrote:
> GSoC2014 Microproject: according to the idea#2 for microprojects, change install_branch_config() to use skip_prefix() and make it conform to the usage of previous starts_with().
>
> Signed-off-by: Guanglin Xu <mzguanglin@gmail.com>
> ---
>  branch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..ca4e824 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -50,7 +50,7 @@ static int should_setup_rebase(const char *origin)
>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>  {
>         const char *shortname = remote + 11;
> -       int remote_is_branch = starts_with(remote, "refs/heads/");
> +       int remote_is_branch = (NULL != skip_prefix(remote ,"refs/heads/"));
>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
>
> --
> 1.9.0
>
> Hi,
> I am Guanglin Xu. I plan to apply for GSoC 2014.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
