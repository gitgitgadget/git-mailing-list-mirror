Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A86C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 11:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E1320782
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 11:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Y0aurez7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgJGLuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 07:50:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:34933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbgJGLuj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 07:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602071437;
        bh=yHsFOrJUfdCu+hM90tDtHQxXXPNGWDowqKtyG2kIIjc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Y0aurez75zYsZMjktihbzrlnLtDIkMD+JglN7KP5j+a9VpH2rWAQnhg3Zsi9XIgez
         iorchETk5qi9Pihg6FmA9HjQniF/7tOOIajyb92J3qKsoEpufolQQ51YqfeiO9cGtO
         IYgEPnA/N+mErBstwMR9T2g/uY7ZHAvh0neUEzGE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.215.4]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGNC-1k839H27DK-00JGL5; Wed, 07
 Oct 2020 13:50:37 +0200
Date:   Wed, 7 Oct 2020 08:44:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] compat/mingw.h: drop extern from function declaration
In-Reply-To: <9e5a8625cab217bd6aaba68da081bc801354b903.1602059508.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010070844340.50@tvgsbejvaqbjf.bet>
References: <9e5a8625cab217bd6aaba68da081bc801354b903.1602059508.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+Yet0loXgVxDAzPgQWw4hX5RoHyKRrfalIJA6B4Uu8/m0s7ed/V
 +weRTIyePmQCVMB6NCCmv6OtBBeHHCRhX4tWeeoX1DUf/2woyyQqi0GGXqmE3E+6wEOAg/2
 1EAS3RYdLElPuVv0h5v/64WSb0k2YwnN81qB0Q9rNfCT7RWD8kgeH/YCMhPUdxCo0SQUgRR
 6bsSoQM3XGEDNnoGpMgGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L8OQXEGj0jQ=:5nio2+KvjWymEPHMPfZfh6
 9C1fikyQylXt3lRK3qU4l0EjGcfaUDL1BWmjh3QHsEWSWJpxPBWs7uNGxpOPLZGSwxrSuCpTV
 P8BBpe0x0A/girWhZV6QO1Oafadx6zqHWHNOaVXV/NsipQSUtBdz9XsIrXv4eU5emxwoaR4Wh
 fluVekOhh96GUi1bmM0De7JYY+bYRyCTwO5EWSJnyhni7pB8lx/q2V0H+XYQUn/+QYYg2haB6
 cV3HvTHn66gA/osR9pPZ5vUtwB5/V8Ab3EN2oiq47E0Kw/KIkXz0+nmQiwVPX+sdpRMnYcqpm
 +Qlebp92xTK6ah6ujmX49s7OJnw4lJ9zFxp9xPJf3XlDZc2ioRA5qz18ramGndMsBcu8ESZWv
 wauPisDx7N9XMwcUmSmyRhm53khd4Gfjh2HsRz4GnZjAD69m5HntuDfKun2+bhwUVIuqTQ8qQ
 kmziLwyjZMIsKez5bXmkKuhbd+IyUOkI1k3NtLWyMrNpPwJ+mYMNskbGd/LSn8Gowlp04J6fl
 8ePwR/iJR3IYxSNaysFBtsNnFCGAP9fpPJXDOgIRIQEFp7PyDTmHclsTkavSvpzj7Sbwl4Rsj
 OemtU6CSc5JDe63Xd+ayFbIOPcw4+BFVYIpkmdyEhHetpKT7XhkapRmNG9Nw2uPG5B20NKnDJ
 sKdoR+xISOklq0n/b34SDS0esintv0VzYIZzNivuJfjkdB/3bsc0FFbH3K/P5x1b8V+BFvk9n
 pmOM8ut2LDtSQKe0/TkoXQho4Y4PNcYkX5M+5PPxZUKm7+kI5fza9SKGovqpJazIdTGoSuyMk
 zzrSS0LcwiXG07/ZPBIy2u7Ep8OmdKYjX82UdB8xQcVWKydwg/b7/WsUTOKJ9/DgQLEoVECGl
 EsTBMfrmTBQOns6rTgRw4pRTWp91JfoF12awF2nFi4O5YMTfex0oRtG3R/L/j1hW5nFOUw2rW
 Fw+RIcxqrOmIoKEL0PSFsV0Cq5m6B1pylvhfIup164yJW9rK5QXS2Ty0brZzZTzSg/vIj9SVa
 4DkSvy/VzjZuqR+Ib9HHllNM0I2QaRCWtAfpX6RoCTCt7do0qRBmDRo5aM++iGIhZnV1AiziH
 lzZe871+HorO4IQhF723KcvnIPRtFxVbpHGlsx0Z5a0Gj0IpUXKhWY6bw/JcT05346W4cDeRr
 0OuipycW+DaR0sagD+H1vB7+7awfH0i20k74to881DZAsFc+WCIKYRFR8lhSb7ABohxaKysVI
 TT/TUNLTjAADi30nLc+kiu/i8hgBruG3WOtzoHA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Wed, 7 Oct 2020, Denton Liu wrote:

> In 554544276a (*.[ch]: remove extern from function declarations using
> spatch, 2019-04-29), `extern` on function declarations were declared to
> be redundant and thus removed from the codebase. An `extern` was
> accidentally reintroduced in 08809c09aa (mingw: add a helper function to
> attach GDB to the current process, 2020-02-13).
>
> Remove this spurious `extern`.

ACK!

Thanks,
Dscho

>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> Notes:
>     This patch is based on 554544276a, formerly 'js/mingw-open-in-gdb'.
>
>  compat/mingw.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 88c07c4520..5c34547539 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -599,7 +599,7 @@ int main(int argc, const char **argv);
>   * Call this function to open a new MinTTY (this assumes you are in Git=
 for
>   * Windows' SDK) with a GDB that attaches to the current process right =
away.
>   */
> -extern void open_in_gdb(void);
> +void open_in_gdb(void);
>
>  /*
>   * Used by Pthread API implementation for Windows
> --
> 2.28.0.942.g77c4c6094c
>
>
