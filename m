Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD10C43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494F920658
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aQGmvMj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbgIHTwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:52:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:45243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730813AbgIHTwe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 15:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599594736;
        bh=Ctq5vaInbs33pGqsyMFwxJzgwrZ0J1HWq+8b3prCr4w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aQGmvMj4vdSf+8SZ5ycVe0YwNkdvQXonS+p04kCX2wKX4eKW5Gp0Ubi88iTGDnFeX
         0dEVW2kfUYkv3gAdNf0/2vzpBWFa0vrNIw4oS8NIu0ky/8OEwZ6TD5xd+KOCCNWL3W
         FFJVTBmy1OcKJzAH8qBN0jaRdY3MuKpjDeL2Ngq8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.21.2] ([89.1.215.189]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42jQ-1kFjf53ftY-0004DF; Tue, 08
 Sep 2020 21:52:16 +0200
Date:   Tue, 8 Sep 2020 21:52:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood123@gmail.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>, phillip.wood@dunelm.org.uk,
        Thomas Sullivan <tom@msbit.com.au>, git@vger.kernel.org
Subject: Re: git add intent-to-add then git add patch no longer allows edit
In-Reply-To: <xmqqsgbsz22t.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009082151520.54@tvgsbejvaqbjf.bet>
References: <C55J4YTSBL48.171K3FSJLUQOA@ziyou.local> <1071d841-a030-30c2-e50e-6d97eb494fea@gmail.com> <nycvar.QRO.7.76.6.2009040831570.56@tvgsbejvaqbjf.bet> <xmqqd02y7rwj.fsf@gitster.c.googlers.com> <a8099cb4-97e0-5596-72a1-10402762015b@gmail.com>
 <xmqqsgbsz22t.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sRIEyUyFVZZ/KoBVN0gdQ+7gqFoV2nR1rGizopWMGtlXwLdiKO+
 ttM+mw9kHccnTdGMdtm+PdFR9t7/j07+Zdt7E2vGs7H4f7oSgYAhNuotybPcfpbMxEhE5g0
 OydYLWQwkVd0QhH9MN5VgOv3adA8KClAao0o5+Uu73OVcEeQHljWWyKldQNSdmeQsJREI/9
 EdavwWdr34horPIzbwPkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QrByI5Rc3Dw=:wPvaS4qVR4oG/auOPoDVFp
 oGqQPUnuypsptFnyLZpFdomRJdlOcNTqzjXbIrD9mRGoJw4RhQtBTA5Flp7RVRiQhOCudjODU
 d0Gb+SbbfGuY+ys8XSML3QGNsCqeR6Ad1k4Mu3tbGSxs0S1zY9RkXt9SrDjAp3LdGS4avr3xT
 CxLjO8MwWIqAvwTmoUSQQHlCrhCcfFUsGA02LSjV9mSYLKSQGH7tgLe218kCFubQJHUk1pJE0
 8M7Zg6lSmsRCVyjXQ9VK0L1pg8eO3DKmGlRIdf0ccDQlSiutmpI0zJhkuVHJzwsOus0cAE/mX
 t3eako86+6TF5f2PzmQgYIaFLSNMPspgbGYrJq9iTv1TeypwXvRUqNu+F9nNnNV+2LXcfL+g5
 kVycTBRhOjyRi98NkDVxEKUnCMQwHhmCIxkyIOXAvrZfTaV1o9s6GozL8DQN9xrXHNf2nLZl2
 JcX+XTF1PawXA5+Z3bIaSev6F4jioZ5TAwhLr5bt7JnJ3gzSWEQ1AjhOXfsK7m2l4cFMFFFAg
 Tm9WJeBfj9Dtk/MwgzAFXr1bO5v5M7aphUy/oj/zUvBKifjuKsPqvHmFD1LXIclRS4IcSYQsj
 5Ji8HOaQB1U89PtWDdQmQghzmf35U4B8J+Gn0ncFN5bEEmYBMyPycQ9Folihr5+rTBCjL72/V
 o4PWzOliRFaN7IyQ+lyWvkLEE0P+7AKtISdCdgFvXe4w89BEkmyH56F8M4PLzCbVV8YqXwFGq
 64TKNBrgZrt9eS1FW/rXAQ8wK42JlV3teydzCCqAKBG7T233w1vq3KzPVK3wwHnnp5oWgUD0G
 ZwG3L73AaIpEEFUIbsYHROJtoc/ZpJnxeUkxUPvxERUDOCX96xbdoZn6H5VTQXx8SDUQ5kVnV
 q70urBAGCVeeWrjocqvF3pLLZkrNwclG1P4c0XkmrPJk9x+55Pr3sz6OHw12VlFdKBu130V+b
 NWmFZnoq/DlEQ58Xv9+kMigJ+/ZiV1uLGERXnj5s/6nmCyt79fIuS8SPtINZkZIGUZ8PB8i4W
 hjcPlEIW4pjtA005tk1tfiBG3rSMpW9qMRKcKE+KSCEtEFQe/X1EMtemqShjOb3mEvtLJS/M9
 yh3So6a/pQ8koqZPPd9Z445moJKS6ZeEAKXwCZjxBOXZHQkujyEMtqSL+9sbBc7v4hoyoMdno
 0J8dya+uDQr6PeQqneedWbuXnFnBkgInOy7G9FXXeWMpZW8UPJEp0mlXBDkB7R+nHNm5135wu
 oaUDWWGd+4n9KqPUaYAzO5xC44n/8wQ6RWJWd9A==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 8 Sep 2020, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >>  If we do not flip the
> >> "use the built-in variant" for those with feature.experimental we
> >> really should do so to widen the canarying population immediately.
> >
> > That's a good idea
>
> Like this?  If the more specific one is specifically set, we do not
> look at experimental bit, but otherwise we use the built-in version.

Looks fine to me,
Dscho

>
>  builtin/add.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index b36a99eb7c..26b6ced09e 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -192,9 +192,15 @@ int run_add_interactive(const char *revision, const=
 char *patch_mode,
>  	int use_builtin_add_i =3D
>  		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
>
> -	if (use_builtin_add_i < 0)
> -		git_config_get_bool("add.interactive.usebuiltin",
> -				    &use_builtin_add_i);
> +	if (use_builtin_add_i < 0) {
> +		int experimental;
> +		if (!git_config_get_bool("add.interactive.usebuiltin",
> +					 &use_builtin_add_i))
> +			; /* ok */
> +		else if (!git_config_get_bool("feature.experimental", &experimental) =
&&
> +			 experimental)
> +			use_builtin_add_i =3D 1;
> +	}
>
>  	if (use_builtin_add_i =3D=3D 1) {
>  		enum add_p_mode mode;
>
