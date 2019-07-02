Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705201F461
	for <e@80x24.org>; Tue,  2 Jul 2019 13:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfGBNwC (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 09:52:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:38681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGBNwC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 09:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562075513;
        bh=LNmHbDcRIfAfFdEQtSLlgK/w0NH6nm6KttWeJlfkjpU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZU55+wkQ2p5EJvJ16bsFlPM433tHGsLWzvOgQ2XJC6lOl7LdeRWdYQAq/lHIka4Ga
         p5PRd7slPF8gjQqfi8rEI5QX9vxlg7DNV5pjEQH6uSsnHjv9wTw5KBFHSn4XhJfOsD
         QeOOe8lZHjy+1nmI3nyWHLOsO8HPYYx7ICCTUDTk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8e5P-1iTy4A2OZ9-00wF7W; Tue, 02
 Jul 2019 15:51:53 +0200
Date:   Tue, 2 Jul 2019 15:51:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: enforce atomic in
 push_refs_with_push
In-Reply-To: <20190702005340.66615-1-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1907021540330.48@tvgsbejvaqbjf.bet>
References: <20190702005340.66615-1-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BO0Mn7VX9qzHKRbbx12Nil6qbDIVYzRHYvyVX3wFbQ4omXjOjVG
 l7MKmTX5RwIVVNyBrjMrYqYp93eRjBktcUHoSGtivom+NaIos8moOSBjNelRhm+XJ7CPFrB
 x0Cd3K7aF5urMcBp+kIron3XSPuV2Dtm/VbzQTOOSQkp3dxjI9uyc+92qKZ3/uJRpSBZo5E
 EUJm5iNx7z7PKcg2wGz3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Mprv2b3iQc=:DJnkbb44XzSlpQebKpyc1t
 LPdPMWI+KhatIlNw0rYd0H+wJ0F1jFXYtr8T1arofdLHnge0VoCPDdBps/lt9alfPiKpaUPAo
 dtghZDE09muLHhcKvgqhavXBV35h9Ws94YBdFP5kqJiKSN/rI35+yp7Mg9TR/TNBjQbOOtL4K
 dKOLSnA2uKzOSZo1Aa0A68MfQr+0HASSedCFodh93+7QTfgLFzuKznfCEB7s9li7HCwmUZsaI
 ItU8+r1+ipqmHlqEib6VJjUEk0PCiIUkwzVg4KuuFlLSTP54Q5T/ftz3oYB4uUa1cD5IVG0xg
 xTZ/2BPV5m9BFUzZJx/9YPf8UKiidDROS/Ov8oyJu3fuAORV8QZWiBU5S0gJ5LBezSUbX5h2a
 h+T3sz6AE1MK9JBqywdNBd/S++GERBNJ4bz/wHfDU4+pEGb+nK37mWgJPy3WAS/WoenaD1PH2
 kMoY58r7frHkRC58AsLujgk0vUQFFt5pBVt8V22u5ezpb/h9d+qA6TB375pdo5d4P4hu/AVms
 Kb7wg1kohrWwYdnDg81YsSXkP02LhSQSNWWybe2DqI7U4WsQpGFUMrL/aTADKFtMzjBXIfpIe
 3H7XWHBymrZbePFtLHQfO8SobSe6DMpD6o+D+W7X67zyotF3HWSbfRe/zNBeWtoNxFxkVID77
 VcGNpe/U/OuNJKEAbU+KZuUgKJN8lbkvNEU6uiz31YPZ+CzRbsQmX3ihTVJ4xpBitknUaPZTg
 +GNqlK0euE3xWdM5RQC/9Pdh2c/J2vXS4CatRaA1/iQRQvQFeTXlD3vCX7u9T9PSeJ07zgvsx
 QjWEzHWUiVIfQ56ftpM0ibOLMEnZgFbZTNIoABNkKu85kUx1QG7dQ7uWJ7Wbmk/yUa/5R6is/
 ilwKpTGinAENRyfag/SxxbsJoMq0XcY7K7Yr4RAmTDs2MIJYcDDK8b0lYIl2yN1OjgShdYVN8
 OxdvDREp+TjQnVNWOvOISisY0me0f9ZBGuVLzXFZjNAjh5TjCH9X7HC+japlzBIMX8MA+WDjg
 tJiCViKvDpbs6+j13WIlHC6UJ8OjQKjSBZo1K601Qe5k8h6fEFfsKZwi9xSySS/Vc3Mpp+ek0
 u8Em5WKXwiEyS7n+T+fW+EoAU/gNOjaZi69
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Mon, 1 Jul 2019, Emily Shaffer wrote:

> Teach transport-helper how to notice if skipping a ref during push would
> violate atomicity on the client side. We notice that a ref would be
> rejected, and choose not to send it, but don't notice that if the client
> has asked for --atomic we are violating atomicity if all the other
> pushes we are sending would succeed. Asking the server end to uphold
> atomicity wouldn't work here as the server doesn't have any idea that we
> tried to update a ref that's broken.

Makes sense.

> The added test-case is a succinct way to reproduce this issue that fails
> today. The same steps work fine when we aren't using a transport-helper
> to get to the upstream, i.e. when we've added a local repository as a
> remote:
>
>   git remote add ~/upstream upstream
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  t/t5541-http-push-smart.sh | 58 ++++++++++++++++++++++++++++++++++++++
>  transport-helper.c         |  6 ++++
>  transport.c                | 15 +++++++++-
>  3 files changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> index 8ef8763e06..b57f6d480f 100755
> --- a/t/t5541-http-push-smart.sh
> +++ b/t/t5541-http-push-smart.sh
> @@ -177,6 +177,64 @@ test_expect_success 'push (chunked)' '
>  	 test $HEAD =3D $(git rev-parse --verify HEAD))
>  '
>
> +test_expect_success 'push --atomic also prevents branch creation' '
> +	# Make up/master
> +	d=3D$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
> +	git init --bare "$d" &&
> +	git --git-dir=3D"$d" config http.receivepack true &&

Why not `-C "$d"`? And why not `test_config`?

> +	up=3D"$HTTPD_URL"/smart/atomic-branches.git &&
> +	test_commit atomic1 &&
> +	test_commit atomic2 &&
> +	git push "$up" master &&

It would be more succinct to do a `git clone --bare . "$d"` here, instead
of a `git init --bare` and a `git push` no?

> +	# Make master incompatible with up/master
> +	git reset --hard HEAD^ &&
> +	# Add a new branch
> +	git branch atomic &&
> +	# --atomic should roll back creation of up/atomic
> +	test_must_fail git push --atomic "$up" master atomic &&
> +	git ls-remote "$up" >up-remotes &&
> +	test_must_fail grep atomic up-remotes

Why not `test_must_fail git -C "$d" rev-parse refs/heads/atomic`?

> +'
> +
> +test_expect_success 'push --atomic shows all failed refs' '
> +	# Make up/master, up/allrefs
> +	d=3D$HTTPD_DOCUMENT_ROOT_PATH/atomic-failed-refs.git &&
> +	git init --bare "$d" &&
> +	git --git-dir=3D"$d" config http.receivepack true &&
> +	up=3D"$HTTPD_URL"/smart/atomic-failed-refs.git &&
> +	test_commit allrefs1 &&
> +	test_commit allrefs2 &&
> +	git branch allrefs &&
> +	git push "$up" master allrefs &&
> +	# Make master and allrefs incompatible with up/master, up/allrefs
> +	git checkout allrefs &&
> +	git reset --hard HEAD^ &&
> +	git checkout master &&
> +	git reset --hard HEAD^ &&
> +	# --atomic should complain about both master and allrefs
> +	test_must_fail git push --atomic "$up" master allrefs >&output &&
> +	grep master output &&
> +	grep allrefs output
> +'

I have the impression that the setup these two new test cases perform are
_very_ similar, making it most likely that a combined test case would be
more succinct, yet still complete and easily readable.

> +
> +test_expect_success 'push --atomic indicates collateral failures' '
> +	# Make up/master, up/collateral
> +	d=3D$HTTPD_DOCUMENT_ROOT_PATH/atomic-collateral.git &&
> +	git init --bare "$d" &&
> +	git --git-dir=3D"$d" config http.receivepack true &&
> +	up=3D"$HTTPD_URL"/smart/atomic-collateral.git &&
> +	test_commit collateral1 &&
> +	test_commit collateral2 &&
> +	git branch collateral &&
> +	git push "$up" master collateral &&
> +	# Make master incompatible with up/master
> +	git reset --hard HEAD^ &&
> +	# --atomic should mention collateral was OK but failed anyway
> +	test_must_fail git push --atomic "$up" master collateral >&output &&
> +	grep "master -> master" output &&
> +	grep "collateral -> collateral" output
> +'

Same here.

> +
>  test_expect_success 'push --all can push to empty repo' '
>  	d=3D$HTTPD_DOCUMENT_ROOT_PATH/empty-all.git &&
>  	git init --bare "$d" &&
> diff --git a/transport-helper.c b/transport-helper.c
> index c7e17ec9cb..6b05a88faf 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -853,6 +853,7 @@ static int push_refs_with_push(struct transport *tra=
nsport,
>  {
>  	int force_all =3D flags & TRANSPORT_PUSH_FORCE;
>  	int mirror =3D flags & TRANSPORT_PUSH_MIRROR;
> +	int atomic =3D flags & TRANSPORT_PUSH_ATOMIC;
>  	struct helper_data *data =3D transport->data;
>  	struct strbuf buf =3D STRBUF_INIT;
>  	struct ref *ref;
> @@ -872,6 +873,11 @@ static int push_refs_with_push(struct transport *tr=
ansport,
>  		case REF_STATUS_REJECT_NONFASTFORWARD:
>  		case REF_STATUS_REJECT_STALE:
>  		case REF_STATUS_REJECT_ALREADY_EXISTS:
> +			if (atomic) {
> +				string_list_clear(&cas_options, 0);
> +				return 0;
> +			} else
> +				continue;
>  		case REF_STATUS_UPTODATE:
>  			continue;
>  		default:
> diff --git a/transport.c b/transport.c
> index f1fcd2c4b0..f4d6b38f9d 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1226,10 +1226,23 @@ int transport_push(struct repository *r,
>  		err =3D push_had_errors(remote_refs);
>  		ret =3D push_ret | err;
>
> -		if (!quiet || err)
> +		if ((flags & TRANSPORT_PUSH_ATOMIC) && err) {

This looks funny. And it does so only...

> +			for (struct ref *it =3D remote_refs; it; it =3D it->next)
> +				switch (it->status) {
> +				case REF_STATUS_NONE:
> +				case REF_STATUS_UPTODATE:
> +				case REF_STATUS_OK:
> +					it->status =3D REF_STATUS_ATOMIC_PUSH_FAILED;
> +				default:
> +					continue;
> +				}
> +		}
> +
> +		if (!quiet || err) {

... because a curly was introduced around a single-liner. This adds
unnecessary noise to the patch.

This easily distracts reviewers like myself from more important questions
such as: why was this conditional switch added before this conditional
block, does it intend to influence the printed push status? Ah, yes, of
course, even if `it->status` is changed, it actually modifies the data
to which `remote_refs` points. So yes, this has to be done here.

>  			transport_print_push_status(transport->url, remote_refs,
>  					verbose | porcelain, porcelain,
>  					reject_reasons);
> +		}
>
>  		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
>  			set_upstreams(transport, remote_refs, pretend);
> --

Apart from minor nits, I like it. Thanks,
Dscho

> 2.22.0.410.gd8fdbe21b5-goog
>
>
