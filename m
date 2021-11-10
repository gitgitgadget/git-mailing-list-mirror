Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65BBC433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C5C60240
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhKJTCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 14:02:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:48661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234622AbhKJTBL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 14:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636570694;
        bh=RAwQ+331/+2sqRaCezKtEDJUZrlg7yvGT7YI34DQ7PE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kQOFRAizikzefChf6H/C1wN+w2TLRmcZRFndevksgOTmsQndhvx/AfNAqbwREbgy+
         v8GyPxwM4yghCbVkbKe9aiQDddzN3z39d5gFkDtKwqY+xz4gNagPfGKvDxOX9gEvFX
         rqx1ws85Ya8sjQXQyZbWfBfMoqOyYCATbNRxMAfk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPog5-1n7kyT0z5f-00Mp7j; Wed, 10
 Nov 2021 19:58:14 +0100
Date:   Wed, 10 Nov 2021 19:58:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] maintenance: disable cron on macOS
In-Reply-To: <pull.1075.git.1636569360002.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111101953300.21127@tvgsbejvaqbjf.bet>
References: <pull.1075.git.1636569360002.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kbqbDW+2iYr5n0qUV/2ID9b0pCnk/VYY8k1hpc5xdU0y02aKLsR
 dvMVyoUKxNqzBYUiCdZnKAqUzl4FkXqAoB4Ijq0mzy6Y3s+OnnfefE2uJO/UId+34AvLajG
 9RTAHcasj7roXP756F5Dp53+5u+yG69lRPbgo+qNzhtt4UvWK/o08ERhxAHWoH6vok3j1jn
 difk97MXP18kpEdswPUIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5PXK6gsWbJ0=:V/bnCKJeyd1+gL8Bf6zGJj
 SSAYA9ECfCzoH0QJn8xOW3kgo4PrXTj4pZeqQyDocCM7likjuSSDdeE5PGWCnq4UexYO9zeNL
 ZYqwRPaw7qO3UozRIEkO6uTrscG9GeS1/4/G7EeutBDy7rdGkARnc6/SJDh9xdkQmsJlaxJ9J
 2OGGk+kVXAxKJrYuZLQAWAMHon/eKZI22p8pjDBajbMXlHkIuD8+fWdm+zeguucwdDw5w+Y/Q
 /IeaV7mI0Uoin5g/tnioRHor+hD34/qxVuPwOWJqQLbr8b+spmZ1v/86lknx3KBn3HqYODpgj
 MZuNSLh8k3JteTja+j6vJVogt6+IKHiaWBjD0GPBpZP6n6I3C/0O+cpVKdMBwqMA1bxFBY3k1
 tSNrAPrjRx/MC94BFPpJmhkcYIXPEw6sFYhEl8wBNgN5/4b/eNP2+QbUh4G28OdOIXKcOS30Y
 ZGFQ6pj+17lwIw9mVmnDb1uqwGv/40fsfWA4od/MHRYZ+MiU+kUAYaIKb1TOpTpaGgYCvgL/K
 lbib1HdRduTa/fVIWFe+/YvkF2m7QnX1DsExHFx3B37mXFAVdZLkFf+uZ7Ue/Q6g3dtnE4zdo
 ApEhfAbAup9hmAALBoVjyaUoPSYaQsv2EeLXdsfLdbkmodDSIZdP+4vOvG2EPq0dy3vA50wSy
 tB866ouVddnP8nz4ISlhBai5Wrhg6ScvVoL0ETTXTkJ14EOwnttIHsxMhySV2t69QNmC5UfPE
 lk3MRmMVfg1Ddh9WtA73dEL/aBkM5UkA0f5FRJiGZhLeSkBF0JcLUgN+kVnf9vXe30rjJmjWu
 T0aTFzxYP5Uzp/XpZ77S5GqdGIIZhsNSVHdv5PaBAboQw2TNkhDJe8J43R1Pajo9Hb2tqj1DH
 1NTiRUqOaNUIMVV3eFlB92DBbSrC9xQgVKyH8Yolssc2Lt3Yf67olnmwb2JlZ6Rgk4W4hzWjs
 cefpd5b8ywOxwWAHfnLo1iadxW0E9/FeDGWwZiqOii9plVZHsJMEUQrI6tlBDAfSM6D69Xdxa
 fYQm+YLVF/AyEI+XlJ2YZdVk2DYplMp9pftqrbsoOkAFAHXkBaD1hGZUA7V8B1bkEyV5T8UPK
 zziR7237L0bO6E=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Wed, 10 Nov 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> In eba1ba9 (maintenance: `git maintenance run` learned
> `--scheduler=3D<scheduler>`, 2021-09-04), we introduced the ability to
> specify a scheduler explicitly. This led to some extra checks around
> whether an alternative scheduler was available. This added the
> functionality of removing background maintenance from schedulers other
> than the one selected.
>
> On macOS, cron is technically available, but running 'crontab' triggers
> a UI prompt asking for special permissions. This is the major reason why
> launchctl is used as the default scheduler. The is_crontab_available()
> method triggers this UI prompt, causing user disruption.
>
> Remove this disruption by using an #ifdef to prevent running crontab
> this way on macOS. This has the unfortunate downside that if a user
> manually selects cron via the '--scheduler' option, then adjusting the
> scheduler later will not remove the schedule from cron. The
> '--scheduler' option ignores the is_available checks, which is how we
> can get into this situation.
>
> Extract the new check_crontab_process() method to avoid making the
> 'child' variable unused on macOS. The method is marked MAYBE_UNUSED
> because it has no callers on macOS.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     [For 2.34.0 Release] maintenance: disable cron on macOS
>
>     This one is really tricky because we can't notice anything is wrong
>     without running git maintenance start or git maintenance stop
>     interactively on macOS. The tests pass just fine because the UI aler=
t
>     gets automatically ignored during the test suite.
>
>     This is a bit of a half-fix: it avoids the UI alert, but has a corne=
r
>     case of not un-doing the cron schedule if a user manages to select i=
t
>     (under suitable permissions such that it succeeds). For the purpose =
of
>     the timing of the release, I think this is an appropriate hedge.

I agree.

We can revisit this once v2.34.0 is released, and then determine a better
layer to prevent this, or alternatively warn very loudly about it.

Thanks,
Dscho

>
>     Thanks! -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1075%2=
Fderrickstolee%2Fmaintenance-cron-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1075/derr=
ickstolee/maintenance-cron-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1075
>
>  builtin/gc.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 26709311601..bcef6a4c8da 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1999,15 +1999,11 @@ static int schtasks_update_schedule(int run_main=
tenance, int fd)
>  		return schtasks_remove_tasks();
>  }
>
> -static int is_crontab_available(void)
> +MAYBE_UNUSED
> +static int check_crontab_process(const char *cmd)
>  {
> -	const char *cmd =3D "crontab";
> -	int is_available;
>  	struct child_process child =3D CHILD_PROCESS_INIT;
>
> -	if (get_schedule_cmd(&cmd, &is_available))
> -		return is_available;
> -
>  	strvec_split(&child.args, cmd);
>  	strvec_push(&child.args, "-l");
>  	child.no_stdin =3D 1;
> @@ -2022,6 +2018,25 @@ static int is_crontab_available(void)
>  	return 1;
>  }
>
> +static int is_crontab_available(void)
> +{
> +	const char *cmd =3D "crontab";
> +	int is_available;
> +
> +	if (get_schedule_cmd(&cmd, &is_available))
> +		return is_available;
> +
> +#ifdef __APPLE__
> +	/*
> +	 * macOS has cron, but it requires special permissions and will
> +	 * create a UI alert when attempting to run this command.
> +	 */
> +	return 0;
> +#else
> +	return check_crontab_process(cmd);
> +#endif
> +}
> +
>  #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
>  #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
>
>
> base-commit: 6c220937e2b26d85920bf2d38ff2464a0d57fd6b
> --
> gitgitgadget
>
>
