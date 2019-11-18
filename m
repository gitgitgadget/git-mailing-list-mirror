Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BC9A1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 18:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfKRS7P (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 13:59:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:39483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfKRS7P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 13:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574103548;
        bh=H0Xk+9bYJOTaSZCvvBqJSMKAlLldXMF66MeL6oQoSG8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bPnBqiySX0T71JAYLI9YrZbYTWC+WrSou9Hto6HUGCcy+KGnsP7X1R+MRAzd2n8PT
         o59bzsufssYJsDlFTBGIpKIqY0LzecyW3AUZyTD3BTVttYPzSMmsxK0eceFpI9nezp
         fYnw/Vuus/gvWmvvFtHKkI/agDyg2vaXnDklw+8A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXFx-1ibR0I0cdd-00DY2I; Mon, 18
 Nov 2019 19:53:59 +0100
Date:   Mon, 18 Nov 2019 19:53:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] build-in add -i: implement all commands in the main
 loop
In-Reply-To: <xmqqlfsd3omz.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911181940020.46@tvgsbejvaqbjf.bet>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com> <xmqqlfsd3omz.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WgD1McLYuOfOLJN0OWm+Xn4+DOvjloY6VycEp61J99a3vfjy+GG
 L05Cs1A7Tw617dTjVFNV7DS8e06z6ONIWRNS4oLqeAp6geLf/yDiS1Wj9Dy4ATA+ynhKZKH
 2j0VNJbxphhtDb8OMKQI4QTsLXHX+jax35lJuSsCf4I+Fxdx0KLyC5Z/a4lqW/67HG9tBxS
 qOS9NMXc17k6SfUdAQT9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1vYiLAIUCSs=:bgje4P8a3ERPr8U3by1BS/
 bPNdPRE4z0kJ/kEHW9B0PLFPQby6cKANdOux2a+dUAL0LSJAhN2006yX56jP9fnLQuUMw0lFF
 SlfZtHbsnSDjZ37LXU7Exd0fNg1benh0uILKpDCS0Yf6bWgvi/CvvFgKFmPluLNxoXRYcx99b
 snRidTA/3o/NmfwHtwEJF7+z/f+S3x5f2MyhwTRr7XKudv8uAYMbnKC3rYl7stLYc62oRQ4Zw
 IwR5UKj1AvhaJKcMkJfVoZ5eFucD+zPrwPuueBnV3gEnP/4gJwD7HVsXYYpfOWo12A7l/GFQj
 AfTdddu6wbnNlsVuTP6Re8nXOkvcbQRTlMw5RSJ8r6Z/mwFBsIV1CZc7cLc2GpBCim+/H+Ejp
 bp7l2RFwIo5DdM8lx0JTtEb5RnEJA020+1yurU+VqP+a1RKOfmwZW3uVjdzOo6DWA6/g5MP4u
 q7Dr8kbmmaYdTq3n2lErUvXCKOqA1VivCj3bzv1ADOnm9oJ4neqxPic9Lv3l7oR/7Xxw/bxNJ
 cx+43OLUIfJMk4RJYnIKjU7kOiuCy+75I5FHehAOFAhvWpbvplxQqF4JGXh9tumvZySy4Gs8I
 7dH6S6P+0q3Vt11mgCxTj95fRFZNACvEQyR1v431zoj47Zp5+02kQ83z+VKmvuZO5iJPyd2oF
 aWmnwo7aDIuC88Ss54kPAVLqeW8EAmf8V++DpmpdOMehOCq2+90+J1Y5ttYejAF3OVG0vm8Yv
 McQs0t9Ii1D8ZXhRvCzcXnXnDCP91Re5hJmce88fHkIyaFDo4hTpeFRPMuZ9MxgGHf/071U9V
 jcCqgbo9tmsKYUCcC+NTk853KfdEBUyT+oRI63DZ90fNvaLT6nWedZLhCBiIHD5rdyUwl9YzC
 4YQPplCe9ARSgu2xFuE4zA8pNB8vO/V5p9RQLbcTOVVj/dxiQpyB5as6lpqcEPvcuoA1dR3WQ
 PQqVZ/3JNfRgY+dEaWuMjAuKjr/Yx1RNvL1e0fsIUAdZ7U/r5W3yDKEPCFsKCSEFr7i2Fx8lM
 ya1MbqIfAX0V4/ZlDuqR9xJSlMdu3B51OuAzHcjjpFFoz73lnn0mJYA+jDsTeUMtCBKSvRNTu
 6t+d8KYlmt0k9Y97LO4tmLfOehpz/r5Uz7yMufYJ6QQ6GyGYVZBYKa718lvMv6M/Nn23L8jxk
 y5O9k4CnV7G+9zohzii+FL0opo7y7CazXQcptMhVNbuLG7lXhmTFsyU8olGx7QY3qbL4+HJmU
 kxr7XeMgyMoCn84SGRnofeUeLdY3LDE/0TvE3X47BGP4sMxqwVx2j1wiA1Cg=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 18 Nov 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > ... there is so little overlap between the git add --patch part
> > and the rest of git add --interactive that I could put the former
> > into a totally different file: add-patch.c.
>
> We would want to call, after "add -i in C" stabilizes, directly into
> "add -p" machinery from different subcommands such as "reset",
> "checkout", etc., and bypass the rest of "add -i" when we do so.  We
> can credit the lack of overlap to the design that supports such
> usage while it is still in a scripted Porcelain.
>
> Preparing the "add -p" machinery in such a way that "add -i" merely
> is one of the users would make a lot of sense from organizational
> point of view.

If I understand you correctly, you mean that e.g. `git checkout -p` will
call the code from `add-patch.c` directly? That is indeed the case.
Already now, `git checkout -p` calls `run_add_interactive()` (see
https://github.com/git/git/blob/v2.24.0/builtin/checkout.c#L463):

	if (opts->patch_mode) {
		const char *patch_mode;


		if (opts->checkout_index && opts->checkout_worktree)
			patch_mode =3D "--patch=3Dcheckout";
		else if (opts->checkout_index && !opts->checkout_worktree)
			patch_mode =3D "--patch=3Dreset";
		else if (!opts->checkout_index && opts->checkout_worktree)
			patch_mode =3D "--patch=3Dworktree";
		else
			BUG("either flag must have been set, worktree=3D%d, index=3D%d",
			    opts->checkout_worktree, opts->checkout_index);
		return run_add_interactive(revision, patch_mode, &opts->pathspec);
	}

And with the changes in PR #174 (i.e. three patch series later, see
https://github.com/gitgitgadget/git/pull/174/files#diff-1f1eb09e4703764f9f=
9b9f1f1e67eb97R205-R218
for details), this will call `run_add_p()`, i.e. the newly-added code in
`add-patch.c` directly:

		if (!strcmp(patch_mode, "--patch"))
			mode =3D ADD_P_STAGE;
		else if (!strcmp(patch_mode, "--patch=3Dstash"))
			mode =3D ADD_P_STASH;
		else if (!strcmp(patch_mode, "--patch=3Dreset"))
			mode =3D ADD_P_RESET;
		else if (!strcmp(patch_mode, "--patch=3Dcheckout"))
			mode =3D ADD_P_CHECKOUT;
		else if (!strcmp(patch_mode, "--patch=3Dworktree"))
			mode =3D ADD_P_WORKTREE;
		else
			die("'%s' not supported", patch_mode);

		return !!run_add_p(the_repository, mode, revision, pathspec);

Now that I see it, it does not look the most elegant that the
`patch_mode` is a string instead of that enum, but I think that will be
relatively easy to fix once the legacy `git-add--interactive.perl` will
have been decomissioned.

Ciao,
Dscho
