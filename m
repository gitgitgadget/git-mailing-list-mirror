Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C490C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 11:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176972083E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 11:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="T5JW+lEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAQLus (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:50:48 -0500
Received: from mout.gmx.net ([212.227.15.19]:59051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgAQLus (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 06:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579261843;
        bh=gFtwapopRRipltfTJQzNCyl4ncaqeEefCOv8QhFngHE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T5JW+lEIAUCSrKG47KW+0TlOv9h+GeK9z8DVPigqCNvCUcLbqQf9s5tMGAoBZV0y0
         vTfIoXKBQkEsUQpjbTLHG8YrlYqa7WJu67XHrXNMkORAbZ2TqGdAF53JwbbIkKkVV/
         OfuterNqI8nkpEc74LdDujWCaYccPbjJL24mPjLY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU5R-1jW8PY1vFL-00ebvr; Fri, 17
 Jan 2020 12:50:43 +0100
Date:   Fri, 17 Jan 2020 12:50:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bert Wesarg <bert.wesarg@googlemail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] remote rename: rename branch.<name>.pushRemote config
 values too
In-Reply-To: <ffc8ffc6ede731b182d32a81d044428566acc625.1579253411.git.bert.wesarg@googlemail.com>
Message-ID: <nycvar.QRO.7.76.6.2001171245300.46@tvgsbejvaqbjf.bet>
References: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com> <ffc8ffc6ede731b182d32a81d044428566acc625.1579253411.git.bert.wesarg@googlemail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:opYouPUWbzyrEbDIyxGJPzRpm6rtdnBpGynAzVuQayTnKykS23Y
 d2yscuhYCf5LaUpiCTJr2P/cNsMczZqKQd9AVTn0vPc0c8jhgS04OPxEso/IWCwMHV50mKN
 pT7GR58V1nn7+cqnlMTtWrNlra1kxmK5ii9v/QRfpVsV1PIBT9xbfhN2shWpQXsap99CXxY
 wFhLmvuSGDO1ZQu7HSlHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:td/7XY2dE58=:JzyqUxQv6qhSpQuP1yP18C
 hCyoV7ogdZCihFWeDs6TCTsWP3s8Q+QcHTYX1Bwf/ttqO8LdpPXjQDFft17n50z2uZZFh4yjl
 1XvjmSdMLnLwxb47cYz0uExsIkKMMg7Mp+Z9L+6JrwThBUOuAxypNEXSrirjpXP0hnJeabusb
 2jmAKFdQPt0MSrYsghXxj9wcZiMUfe2adJ3VincBmecMWAOr8xYKcnZhfL0x9vOu8LZfA/mB1
 4//7T0ar093EWQ8XL9Npltl8GGQkL2OJ2Xp/8a6s/JiL+GBtydNzw7UabPwoRli/QadLN7W/B
 fEcEl7HTqd8IUHhwoW2B8U8KOY7b7pIv2oQXaXwhb1UTCoQZBhyjNcd5yHNvwL6hW+5JZVgRz
 Eusk1W9yZg/50pJIbK2ZYorzWgi4neqw1okioayjD5IIcFfI9768qQqMnsRXmUr6x3xjKF2gJ
 RwTUdToM1BXODUwHFNJwP8SSTFz+o2pDUY49yVScwcgNK3wSmeieEGlyzqHAI5moB/Uk7zEry
 bsXbHIqefnrrgBF+QlDq+uJht7MOM/7COThjK8KJJ5nvw1DXFXMDIZNdE47Z8p3ZYz8TI7eQr
 pVcT/E1r2YYnwvpGnQhKtSwRtQDqzEeNYTuLuM4ynAT4VeQfmp45yarOgHlEGNa1Q6+iNt6hS
 THwUxIB/iU6kMQQRaZT9Vvn2E0cNZNU2Crwrfp8xarNyDWPo5gtXDCV7P71NH/N663uUIAaeD
 OFhK8yy4BTC5Kc7jmCTV03l2o5tXOvfkwOuwBY92YiWzZ/vG9kYbZfTf2hFXFX5l9iefxDfuJ
 6mDAHejWVEO6JS+kisB2g0LHsXEk5gpMd3Mm2BozwrlMJCkBtiytlKZweb8v9PWu7LMYm6ps0
 DS2YVGclwds7omwNyziF2IMA09y9gdSlsLM9WHVWyKB8jg2EMaPxNcvHpqPrBVXCUhhnWym0y
 uDJ6gHSv950hazWf5Fli195HikBcXpAN163ZZiq7HsNqxq99ERSfH1IM+JqHSx4lOgvMDfR6G
 wFYzYLfUNvTsVfd11CIGmoM6ezmIV5YGrxfe2/GtmqJs37h3idgj/5n35y1PlcerzVIIxTV+i
 Fs2qXtGszNHAZQb5R7ZC9TQyqq0Knamm1qaRuigS1afv4qrbBppO9PM0kO8vZEQ1JNGYIJhXq
 bMFSuvN/di/K7dp3vkzJOcKJzhzYiaODjS76b6iz8zeEDoaPM09I7+vcQI3ZI6vAMB6qthsY/
 PP3TLuZ0Fnnrgl6hhLhNku6HRs4vHIRDOJ0yvxDrQVR4U2F1OC1qjhcsKAwM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bert,

On Fri, 17 Jan 2020, Bert Wesarg wrote:

> When renaming a remote with
>
>     git remote rename X Y
>
> Git already renames any config values from
>
>     branch.<name>.remote =3D X
>
> to
>
>     branch.<name>.remote =3D Y
>
> As branch.<name>.pushRemote also names a remote, it now also renames
> these config values from
>
>     branch.<name>.pushRemote =3D X
>
> to
>
>     branch.<name>.pushRemote =3D Y

Should we warn if remote.pushDefault =3D X?

Other than that, I am still okay with the patch (even after the
re-ordering of the enum ;-)

Just one more suggestion:

> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> ---
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/remote.c  | 17 +++++++++++++++--
>  t/t5505-remote.sh |  4 +++-
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 96bbe828fe..a74aac344f 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -251,6 +251,7 @@ struct branch_info {
>  	enum {
>  		NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE, REBASE_MERGES
>  	} rebase;
> +	char *push_remote_name;
>  };
>
>  static struct string_list branch_list =3D STRING_LIST_INIT_NODUP;
> @@ -269,7 +270,7 @@ static int config_read_branches(const char *key, con=
st char *value, void *cb)
>  		char *name;
>  		struct string_list_item *item;
>  		struct branch_info *info;
> -		enum { REMOTE, MERGE, REBASE } type;
> +		enum { REMOTE, MERGE, REBASE, PUSH_REMOTE } type;
>  		size_t key_len;
>
>  		key +=3D 7;
> @@ -282,6 +283,9 @@ static int config_read_branches(const char *key, con=
st char *value, void *cb)
>  		} else if (strip_suffix(key, ".rebase", &key_len)) {
>  			name =3D xmemdupz(key, key_len);
>  			type =3D REBASE;
> +		} else if (strip_suffix(key, ".pushremote", &key_len)) {
> +			name =3D xmemdupz(key, key_len);
> +			type =3D PUSH_REMOTE;
>  		} else
>  			return 0;
>
> @@ -305,7 +309,7 @@ static int config_read_branches(const char *key, con=
st char *value, void *cb)
>  				space =3D strchr(value, ' ');
>  			}
>  			string_list_append(&info->merge, xstrdup(value));
> -		} else {
> +		} else if (type =3D=3D REBASE) {
>  			int v =3D git_parse_maybe_bool(value);
>  			if (v >=3D 0)
>  				info->rebase =3D v;
> @@ -315,6 +319,10 @@ static int config_read_branches(const char *key, co=
nst char *value, void *cb)
>  				info->rebase =3D REBASE_MERGES;
>  			else if (!strcmp(value, "interactive"))
>  				info->rebase =3D INTERACTIVE_REBASE;
> +		} else {
> +			if (info->push_remote_name)
> +				warning(_("more than one %s"), orig_key);
> +			info->push_remote_name =3D xstrdup(value);

It makes me a bit nervous that this is an `else` without an `if (type =3D=
=3D
PUSH_REMOTE)`... Maybe do that, just to be on the safe side, even if
another type is introduced in the future?

Thanks,
Dscho

>  		}
>  	}
>  	return 0;
> @@ -680,6 +688,11 @@ static int mv(int argc, const char **argv)
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
