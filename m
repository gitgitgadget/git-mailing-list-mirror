From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/7] completion: support git-worktree
Date: Wed, 11 May 2016 02:12:34 -0400
Message-ID: <CAPig+cQYbMq08_HuKqC6rwhEZjN+1E8YBk1775k9Xgi+GJ_SRw@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160510141553.22967-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 08:12:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0NNw-0003FC-4L
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 08:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbcEKGMg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 02:12:36 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34286 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbcEKGMf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2016 02:12:35 -0400
Received: by mail-io0-f196.google.com with SMTP id d62so4473819iof.1
        for <git@vger.kernel.org>; Tue, 10 May 2016 23:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=jxsA7OkxnKh0Lq5riZgYvnaWDwxANSPjN4xUV+D3HhU=;
        b=bpxpL6wC/enuh+0U5P71an0GrGbtcoi7Jwbv8iTIWjoFCEd6pCys++CX5Qq+3Cy+q7
         +39dKQ4y03TUVm6qUkvpkxa1DZZiUeVEnv1FGIPwHNpbaeH2bQ27DDOivxj/M26zC+3h
         SXQK273e2wN+OMgX9tzB/GIlf7dUO6z0g+K8bK/VDtWk9PFlOcJQVw2bRt9jzbArQCgy
         Dk8eaOU0m5iOXpziViRD5BlEF2ZUdK8LUmVaBN8XtX+R4KBDeirPcDakVezeMpmSGZbG
         0c+0UJQZxnUP+akJQTgaiQLmFGCIsiL3J4HQ/szgUn/ZvdsTSqvNbgXwd6vIOKlflq10
         XV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=jxsA7OkxnKh0Lq5riZgYvnaWDwxANSPjN4xUV+D3HhU=;
        b=Fdqjzb4/bHHqMbd3T3KVrnqdYlvglnFaaAJPxEvdj4buxpNB5EeAZ0oxyeBV6MkQlA
         4l96sX96jKc1QmQzjEQOyTFPAQBSw7zgcAJRID/1g5um5EEz0XS23vYwJ5W4KWnH2AyH
         yi0szRSgj91gddkMdEbdj1GO8a1WfnkpDtcQIhKLAtfV3lK5yMauhA1hgsnojm0lX44u
         MJrU3Dz46vzrqTlv4oN3xlMXwEqqxZUR37jmzYvfQjQu0K4ofWUwXQ4/E0YzDEc2BdFx
         CZDOuzg6llSlSpfG2gbAOS778FsjUd9DArk6NRN+gASaFdfhSNB3P8cg0OTIBSKUmFaU
         dfxg==
X-Gm-Message-State: AOPr4FWU7vyLyJYGqO8OknC34EefncrfdXVT2HxAFdDu6gCO+VuN0nmblADe7q3gD+QtiiA1T+Pt1+grLcjJzA==
X-Received: by 10.36.55.81 with SMTP id r78mr917198itr.73.1462947154506; Tue,
 10 May 2016 23:12:34 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 10 May 2016 23:12:34 -0700 (PDT)
In-Reply-To: <20160510141553.22967-1-pclouds@gmail.com>
X-Google-Sender-Auth: -QoV0uToeWBijfmOGQq3W6lw998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294228>

On Tue, May 10, 2016 at 10:15 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> completion: support git-worktree

See [1] and, especially, [2] for previous attempts...

[1]: http://thread.gmane.org/gmane.comp.version-control.git/274526
[2]: http://thread.gmane.org/gmane.comp.version-control.git/274526/focu=
s=3D276333

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 3402475..d3ac391 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2595,6 +2595,29 @@ _git_whatchanged ()
>         _git_log
>  }
>
> +_git_worktree ()
> +{
> +       local subcommands=3D"add list prune"
> +       local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
> +       if [ -z "$subcommand" ]; then
> +               __gitcomp "$subcommands"
> +       else
> +               case "$subcommand,$cur" in
> +               add,--*)
> +                       __gitcomp "--detach --force"
> +                       ;;
> +               list,--*)
> +                       __gitcomp "--porcelain"
> +                       ;;
> +               prune,--*)
> +                       __gitcomp "--dry-run --expire --verbose"
> +                       ;;
> +               *)
> +                       ;;
> +               esac
> +       fi
> +}
> +
>  __git_main ()
>  {
>         local i c=3D1 command __git_dir
> --
> 2.8.2.524.g6ff3d78
