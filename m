Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A592E1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 19:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756213AbeASTzT (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 14:55:19 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33624 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756284AbeASTzR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 14:55:17 -0500
Received: by mail-yw0-f195.google.com with SMTP id x24so1061139ywj.0
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 11:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=RrvYu6NS0NfEukbBQNYdf/ScykxkP2JHMy6t7Q7+RbA=;
        b=uqKT/jcFPQpII7rB63fY0XbRMXZTAGRdtqicxPBzrCDtP++FoOj5FHazNLvQRlInph
         UtRdzu3C3rqtbv52wspWiIJQGJJJFLwxIKcPSo4vUEVpM/+KIeLYDduykkM7YgjvIqTe
         lo83TYE1CI2MbiC7Gt748vMnmnWAopPD0CTMhmKPn0m9lVvm4VECDRNRXy7btTzVs/0n
         ENbM+jHdbxdlaEGHmSZEXJwAmpyN5Y8n4eYYdXtPV0sfqwYWNHLBlnROHU1mUJl2+Cdv
         ZxXWbChItSFhGqdsEKj6qo0EmHo4jggNs8H0Wz/LmnNX6f3xkpfY5YqBapkvI+B+sxpD
         uNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=RrvYu6NS0NfEukbBQNYdf/ScykxkP2JHMy6t7Q7+RbA=;
        b=siZhaM9PCl3KOXgdEmpRKVTVd2w2TmbQWyIm1bBJoZMMqDxdLHRJa8lgoVTgMKx7ye
         ry95LpbE6NnJqGtPaF/o2eabYumVQbJ3ppm+fhCriaBTAMXNlE9wC5Ej6V9DOWSI2tS/
         f0lbLs0zGkoeXlvS8UHW2C1GCZ/6hvCtv+UcB9jkrlqrl/DscrkAMrMFIah4pK7bsWov
         QZ7s/irna8Y13V8zSMVC8fioUPetapopMgzXPAl7XmC5BUxMcStF/kPBlTRWEzqwW/Sm
         IkbqPt2lSegoqRlXTfD4CkCQgmsdkWG/MY7n/ZZvMG2OjoNIyO+OE92HrclafMtseNjO
         crew==
X-Gm-Message-State: AKwxytfGbd00/ZTq57OyONA9RG89mCp1Lc4pq60JsAcY1/KxTpYJzGl1
        wizxda+n3OHOvzdcoXr4up858PCJFayTA0twPd/trA==
X-Google-Smtp-Source: ACJfBou0743enX60fdlp2UW9evJbJMIgmWAP1fsOJVP2QPj39iioSkfyU5ziuiIzL303/CsZPkBoOQ33m/23cXldZVE=
X-Received: by 10.13.220.3 with SMTP id f3mr10457423ywe.288.1516391716600;
 Fri, 19 Jan 2018 11:55:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.210.209 with HTTP; Fri, 19 Jan 2018 11:55:15 -0800 (PST)
In-Reply-To: <20180119173406.13324-6-randall.s.becker@rogers.com>
References: <20180119173406.13324-1-randall.s.becker@rogers.com> <20180119173406.13324-6-randall.s.becker@rogers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 19 Jan 2018 11:55:15 -0800
Message-ID: <CAGZ79kYft+6k3YjyMn32-gJwFEwCpEYKJ=WnksqJdQaozm5PQw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] Force test suite traps to be cleared for NonStop ksh
To:     randall.s.becker@rogers.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 9:34 AM,  <randall.s.becker@rogers.com> wrote:
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> * t/lib-git-daemon.sh: fix incompatibilities with ksh traps not being
>   cleared automatically on platform.

Which platform? Do we need to guard it for other platforms?
(I guess we don't we have traps in some other places and it is
POSIX)

>  This caused tests to seem to fail
>   while actually succeeding.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  t/lib-git-daemon.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
> index 987d40680..955beecd9 100644
> --- a/t/lib-git-daemon.sh
> +++ b/t/lib-git-daemon.sh
> @@ -68,6 +68,7 @@ start_git_daemon() {
>                 test_skip_or_die $GIT_TEST_GIT_DAEMON \
>                         "git daemon failed to start"
>         fi
> +       trap '' EXIT
>  }
>
>  stop_git_daemon() {
> @@ -89,4 +90,6 @@ stop_git_daemon() {
>         fi
>         GIT_DAEMON_PID=
>         rm -f git_daemon_output
> +
> +       trap '' EXIT
>  }
> --
> 2.16.0.31.gf1a482c
>
