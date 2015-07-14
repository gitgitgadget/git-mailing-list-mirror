From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] gitk: Add a "Copy commit summary" command
Date: Tue, 14 Jul 2015 13:34:16 -0700
Message-ID: <CAGZ79kaB-vrarcCztD_7x5M1_dHWwMy=6vQ5EHHsWTJTWEyhOA@mail.gmail.com>
References: <1436892150-24267-1-git-send-email-dev+git@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
To: dev+git@drbeat.li
X-From: git-owner@vger.kernel.org Tue Jul 14 22:34:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF6uE-00069D-Ij
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 22:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbbGNUeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 16:34:18 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35684 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbbGNUeR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 16:34:17 -0400
Received: by ykdu72 with SMTP id u72so18803554ykd.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=u7IvlulWx5qUkRFSZr1pbQ5y1anzeaaGtYEnAbVVVPE=;
        b=jkr2DY6gry+cZy9Hzsdou3V/qFQF/MRbSH/Dndepl0hlfPipt2bnHFnlIzw61JAp3E
         FuGdFxrSWlX6Jr124lxRi2I+M5HGVn8Up7SNkFad22YsbpHrJrw8CAd7ziCRo6m1qJ+e
         XLJt3JoecJWlAl2Ds+QuqHy9IKULh9++D8bcwjZ5ufDwOf7OmqiDSqjVm0H1egmcVl5y
         logB+eB5YYnLTp4RRkIziP1YhkPRehIb5l48+AHGjFxjbuiLq6tlknVJgfqllpOs2ZcH
         gdLGk0UUiR+VUmHsUshmfqfxh8tQgr6vXxhuxkTjkMIxJ5AuXxVAnryk5tP0IoUb/tbt
         2Pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=u7IvlulWx5qUkRFSZr1pbQ5y1anzeaaGtYEnAbVVVPE=;
        b=fQldhmyWI4rKXrqAw8LnkomIz0qsK9S9/6DNBzUIQX7mNvQR3OUVrlsfNaYgu2UNeV
         VzuPeWE+MlooDXqk6VjuCxgD2gUwBOMrc+H4Wq3dM+m+H9mToCbFOgGok5SF+BobzIXz
         qtt8a8QuDaEiw7Cv928v1UEmZSpEtxMuCrWxA+WUjUUfQdG5IlFl51jNVPbuGPDOfurQ
         5Z+z8KIWadCoXDTa4DKGeowQEYyttbFTnGbeiYXbHx2u/qyQsqJunnGJclnYMt/v3Jwo
         b3NiSNoV6lxJnybowEKBKkUsbrg9ADE5OERhy8UtUc123AixE5zNFmnhS3v9pFfHVjlJ
         XWsA==
X-Gm-Message-State: ALoCoQlD4YvwhchMJRlSfCgh80MRwf8NZQsKBiolC/2JKgiKYm2L3/v92KOU4k5HAucd6PvZrnBT
X-Received: by 10.170.117.210 with SMTP id j201mr689425ykb.56.1436906056801;
 Tue, 14 Jul 2015 13:34:16 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Tue, 14 Jul 2015 13:34:16 -0700 (PDT)
In-Reply-To: <1436892150-24267-1-git-send-email-dev+git@drbeat.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273974>

On Tue, Jul 14, 2015 at 9:42 AM,  <dev+git@drbeat.li> wrote:
> From: Beat Bolli <dev+git@drbeat.li>
>
> When referencing earlier commits in new commit messages or other text,
> one of the established formats is
>
>     commit <abbrev-sha> ("<summary>", <author-date>)

That sounds like I would use it a lot! Thanks :)

>
> Add a "Copy commit summary" command to the context menu that puts this
> text for the currently selected commit on the clipboard. This makes it
> easy for our users to create well-formatted commit references.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> Cc: Paul Mackerras <paulus@samba.org>
> ---
>  gitk-git/gitk | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 9a2daf3..0612331 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2617,6 +2617,7 @@ proc makewindow {} {
>         {mc "Diff selected -> this" command {diffvssel 1}}
>         {mc "Make patch" command mkpatch}
>         {mc "Create tag" command mktag}
> +       {mc "Copy commit summary" command copysummary}
>         {mc "Write commit to file" command writecommit}
>         {mc "Create new branch" command mkbranch}
>         {mc "Cherry-pick this commit" command cherrypick}
> @@ -9341,6 +9342,19 @@ proc mktaggo {} {
>      mktagcan
>  }
>
> +proc copysummary {} {
> +    global rowmenuid commitinfo
> +
> +    set id [string range $rowmenuid 0 7]
> +    set info $commitinfo($rowmenuid)
> +    set commit [lindex $info 0]
> +    set date [formatdate [lindex $info 2]]
> +    set summary "[mc "commit"] $id (\"$commit\", $date)"
> +
> +    clipboard clear
> +    clipboard append $summary
> +}
> +
>  proc writecommit {} {
>      global rowmenuid wrcomtop commitinfo wrcomcmd NS
>
> --
> 2.1.4
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
