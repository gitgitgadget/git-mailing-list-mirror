From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 6/6] remote.c: introduce branch.<name>.pushremote
Date: Wed, 20 Mar 2013 21:03:10 +0800
Message-ID: <CALUzUxobybPOqsLgEFVOCK2OLOvyqHtAiuyi8wozOSYeWzkhNg@mail.gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com> <1363783501-27981-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 14:04:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIIgT-0004gq-A1
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 14:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875Ab3CTNDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 09:03:33 -0400
Received: from mail-bk0-f42.google.com ([209.85.214.42]:35804 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab3CTNDc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 09:03:32 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk7so824788bkc.29
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 06:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mXeN9K44ma084SfEnlH3eNuoBrCiQqSMG7f/gMKnJ3E=;
        b=cLG6cESl9ygYzPB1o8OzWiuMnGd6xMK/t9SdLmuCQATCty00T/pr6bOcby4GuqtBG0
         OvptFZ+2i1bIK3+Xu+94B3RucyQE1ksLiglEoAOlchq2Utefmldyv1qu1EAOGEVuimwB
         vQG5Lws7eVrMu+VXbXH5wCNh1hXPCTw5ZoGA4yHRfo8458vUNbOg6oh1wHZQ23WO9BbA
         M+VVcZ9hsZGHxiZQvOwYj74i+UZWClS3911tgZ7SqOyR7NOyfaNVsgyrp5wlVMlV8IaT
         w5Cuj82+VegcYEl37IL5VeVVC0L3GXYgqO5Qb8AUK+ythugky4haAIa15eEEy4jwUJ7M
         8I5w==
X-Received: by 10.112.9.104 with SMTP id y8mr9396370lba.132.1363784611089;
 Wed, 20 Mar 2013 06:03:31 -0700 (PDT)
Received: by 10.114.57.41 with HTTP; Wed, 20 Mar 2013 06:03:10 -0700 (PDT)
In-Reply-To: <1363783501-27981-7-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218605>

On Wed, Mar 20, 2013 at 8:45 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> This new configuration variable overrides `remote.pushdefault` and
> `branch.<name>.remote` for pushes.  In a typical triangular-workflow
> setup, you would want to set `remote.pushdefault` to specify the
> remote to push to for all branches, and use this option to override it
> for a specific branch.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/config.txt | 18 ++++++++++++++----
>  remote.c                 |  3 +++
>  t/t5516-fetch-push.sh    | 15 +++++++++++++++
>  3 files changed, 32 insertions(+), 4 deletions(-)

Shouldn't this patch be squashed into 5/6 because of...

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e813c33..4b9647a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -726,9 +726,18 @@ branch.<name>.remote::
>         When on branch <name>, it tells 'git fetch' and 'git push'
>         which remote to fetch from/push to.  The remote to push to
>         may be overridden with `remote.pushdefault` (for all branches).
> -       If no remote is configured, or if you are not on any branch,
> -       it defaults to `origin` for fetching and `remote.pushdefault`
> -       for pushing.
> +       The remote to push to, for the current branch, may be further
> +       overridden by `branch.<name>.pushremote`.  If no remote is
> +       configured, or if you are not on any branch, it defaults to
> +       `origin` for fetching and `remote.pushdefault` for pushing.
> +

...this? (Since this description was introduced in 5/6)

-- 
Cheers,
Ray Chuan
