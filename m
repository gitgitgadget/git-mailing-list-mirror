Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A08C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 09:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65CE20730
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 09:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="E4LPSJoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgAQJpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:45:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:39677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgAQJpT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 04:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579254317;
        bh=gA1zR0erMD6IKfwSsFHrGr0JSpfzUs++YzsJsbKLBxg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=E4LPSJoEmsxUOpJMZH0nRFXEUjo+up+HadxSJU0nlifBCai7t4viA54xaa1aR+CoM
         GYrsBnqGAhEt3D5C97gfiXh1TTXovw8hlPrJtYhaBK7mPaK2YM+5/6Q9UBthdscKX7
         cMmGj+ZKP3JKOrkDovdCtx17/MwQy+7KsCV8B1Cc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9kM-1irLyz1ICK-00GWrq; Fri, 17
 Jan 2020 10:45:17 +0100
Date:   Fri, 17 Jan 2020 10:45:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bert Wesarg <bert.wesarg@googlemail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote: rename also remotes in the branch.<name>.pushRemote
 config
In-Reply-To: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com>
Message-ID: <nycvar.QRO.7.76.6.2001171043550.46@tvgsbejvaqbjf.bet>
References: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ixoc2G2501qRXGLmKsWl0QpkAPiJyhxlOSeAAEfb5x1x4Ax7TGi
 JzViVAijnja39QTubeZqhSH4y2SefFK9213ouSr0goUIuqnn/nOa3EwhRXrY7Qcuhfh43Hu
 HCLoN+L8rheS7/oLG6rhTyU5nF+z60H/NhB1vrDu6oQVnI3wGS7GrOGhJMvWDWVNJmNoOk6
 sN3pB66GsnrkywQ/NNkwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uJXWEOZwe3w=:24bKW8IJIz42ZRWoNIQWPe
 G7aNDCJ4WWzgWJgNYKy7ORmz6A6awV4FfprX1bmDzME+ZPJ1sGgT6KjoKRUX9XnUCaG9pz833
 pRVNC8oOT3bAesX0bnZ4VKYMc0X0BqANLRN+dyIN5jLyCU9ZzSZv+RRr9InpO1aPGXr4UCIam
 tN1BqRMPjYW3P2t6rJipcI37SQUYAZERxCgbOkYPsBZhTmtzZgNk7K5Pq1KxqOg8FCmH6ezD2
 M43FkXkzEEvY7O1ZvzPpzogqg0ihQloeS5mV+QhS08zXroWeHa0LusQtTEG1YUU921nwZmQL8
 odPrsOonC90lz7a2ehrLtc8SK/977h1t+6XNqBLCLJ6l8124Q6Sk9qpbUm2ptNMhS9sQpHy9e
 te5f2CuSRIK/1TU0ef5Lp7AzCRS9CNCw6UxElQLANP5nzuCA2iyEdp+HT/qoKuTEjTuhqyJvC
 KOOY7CmUh2t3sAfjJg4mMCS7ELFDAd6pDfy12FFev/B/5HpaZwKnnY4cwmsgFStLl5BUb9Tzs
 hNgPNA31a8a7Be5EDC7y1eJcU71cpuzFFy3DfC51f+qfGTNI2BSZg4xL5PTvLa6wwWqk2F3wl
 l3JYZ8g6LRnWukM2JRYlodBhjqmv/NK1e7Nlgg72kczO2woo2uWVPPj++Zpn8Tby0B5pE9z/i
 SpLdGxeH3Hy8ZH/i6tuCn+IQYgDkLOPU5odFrVU6OFMHaeaVfeFMBjYHja+WXKyVWkIgpTG5o
 oh/BYpp6e6TMqL+9ol7ywdGO1PBAjZVdWf8V/KyYI17eVZyO6hALyLpOQ0AOfkQxZS8RtsRep
 HYkS4ts4JYEiIca+te4RWfi+Na1HoGdFb31DpuBm0uLzSyKDoIt+VeBA+d6sXF1KlaQjvK8d/
 5TCVtw4biROGv9YvUaGiXPNSgGq6oP1zYzGXXpG03Bv3l5aHNGAYpWgonHfwuuq3vAfGTrN/E
 ZSwyXwJd4fo3TYA5emzpVeddiOR1yER7CYGD1f6vMtr7tI/uIjmXLhy2iUtoNAZCe07sdzwNc
 sYCNLmCjegRIyAENh4fkH0GuLf+Dvl8cQUc3xf9EDmkgJYncaY7gN/1fxPCZ8htmwRLMDLiP0
 d9GrqluXzL1uk3x2e4eYcCxUPJo7AFTEmHqNpQ4pUlj/CSodXt5saQF6NB1841vCnU9nYymCQ
 wVb0s+i4m5alntzjAFPxoNqvuuMj5QaGkI2cb/pJl7X4Xuyvsx2N8VqyW2KThKgJZzIjHrd1M
 khdk3RDiHAHX8IDo3DoIENtFoQTU8AdZpkwrLWbQzRTRp17B1zSW9x4oWNBQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bert,

On Thu, 16 Jan 2020, Bert Wesarg wrote:

> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
> Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/remote.c  | 16 ++++++++++++++--
>  t/t5505-remote.sh |  4 +++-
>  2 files changed, 17 insertions(+), 3 deletions(-)

The patch looks obviously good to me. I would have wished for slightly
more information in the commit message, but it is okay as it is.

Thanks,
Dscho

>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 96bbe828fe..ddceba868a 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -246,7 +246,7 @@ static int add(int argc, const char **argv)
>  }
>
>  struct branch_info {
> -	char *remote_name;
> +	char *remote_name, *push_remote_name;
>  	struct string_list merge;
>  	enum {
>  		NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE, REBASE_MERGES
> @@ -269,13 +269,16 @@ static int config_read_branches(const char *key, c=
onst char *value, void *cb)
>  		char *name;
>  		struct string_list_item *item;
>  		struct branch_info *info;
> -		enum { REMOTE, MERGE, REBASE } type;
> +		enum { REMOTE, PUSH_REMOTE, MERGE, REBASE } type;
>  		size_t key_len;
>
>  		key +=3D 7;
>  		if (strip_suffix(key, ".remote", &key_len)) {
>  			name =3D xmemdupz(key, key_len);
>  			type =3D REMOTE;
> +		} else if (strip_suffix(key, ".pushremote", &key_len)) {
> +			name =3D xmemdupz(key, key_len);
> +			type =3D PUSH_REMOTE;
>  		} else if (strip_suffix(key, ".merge", &key_len)) {
>  			name =3D xmemdupz(key, key_len);
>  			type =3D MERGE;
> @@ -294,6 +297,10 @@ static int config_read_branches(const char *key, co=
nst char *value, void *cb)
>  			if (info->remote_name)
>  				warning(_("more than one %s"), orig_key);
>  			info->remote_name =3D xstrdup(value);
> +		} else if (type =3D=3D PUSH_REMOTE) {
> +			if (info->push_remote_name)
> +				warning(_("more than one %s"), orig_key);
> +			info->push_remote_name =3D xstrdup(value);
>  		} else if (type =3D=3D MERGE) {
>  			char *space =3D strchr(value, ' ');
>  			value =3D abbrev_branch(value);
> @@ -680,6 +687,11 @@ static int mv(int argc, const char **argv)
>  			strbuf_addf(&buf, "branch.%s.remote", item->string);
>  			git_config_set(buf.buf, rename.new_name);
>  		}
> +		if (info->push_remote_name && !strcmp(info->push_remote_name, rename.=
old_name)) {
> +			strbuf_reset(&buf);
> +			strbuf_addf(&buf, "branch.%s.pushremote", item->string);
> +			git_config_set(buf.buf, rename.new_name);
> +		}
>  	}
>
>  	if (!refspec_updated)
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 883b32efa0..59a1681636 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -737,12 +737,14 @@ test_expect_success 'rename a remote' '
>  	git clone one four &&
>  	(
>  		cd four &&
> +		git config branch.master.pushRemote origin &&
>  		git remote rename origin upstream &&
>  		test -z "$(git for-each-ref refs/remotes/origin)" &&
>  		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" =3D "refs/remot=
es/upstream/master" &&
>  		test "$(git rev-parse upstream/master)" =3D "$(git rev-parse master)"=
 &&
>  		test "$(git config remote.upstream.fetch)" =3D "+refs/heads/*:refs/re=
motes/upstream/*" &&
> -		test "$(git config branch.master.remote)" =3D "upstream"
> +		test "$(git config branch.master.remote)" =3D "upstream" &&
> +		test "$(git config branch.master.pushRemote)" =3D "upstream"
>  	)
>  '
>
> --
> 2.24.1.497.g9abd7b20b4.dirty
>
>
