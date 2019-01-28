Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 525251F453
	for <e@80x24.org>; Mon, 28 Jan 2019 12:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfA1M6I (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 07:58:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:38342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfA1M6I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 07:58:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 633B5AEF5
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 12:58:06 +0000 (UTC)
Subject: Re: Worktree creation race
From:   Marketa Calabkova <mcalabkova@suse.cz>
To:     git@vger.kernel.org
References: <89985b60-4c28-ebf0-64b1-8da75263d745@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=mcalabkova@suse.cz; keydata=
 mQINBFxAkKIBEADv3Kbft8IlLqEpax920pTHwdgFIPkx8YGJY/N03PFCPNKsETMRqSZHzGIe
 Kuro28km4qWUd39FV0BKGDjcC4ykxhkLug/tpd1YDPb5goLPofAfmujoL7PTVjvGtouhxjW/
 q4JU+sSmvhnUGWn8zx9i+Nk3BUA4GVBdMPpXc1UwPnGyruKJ8ZeEH4qCtNZ8hf3r8/brSEaD
 KGxtWrkhw00UVrpZV2+rWcRCzyzXKSU2bb46txXx5skD1rLHtbf9D4/XR+GhXPYqVQ7jSkws
 IR1tBcqkXUUockmF8U5EwZWndWsH4qB/06W3stmkbP7yTTOAyeoUpKm2r4rD3yi7uxhRHDvC
 pUQDLHWd2QqnPtSc5U6WW10yfJPxMh8aXN5a1/tNpWyKI0GtCg5dsOcAKjbtUVIOAqV4Semx
 deZVGWZP4com1Aw1gL95B+XQvEUVv0L3SSl3j3btPEhbfKVd34OiItPVVn/sCKReNaZLL6sb
 wxbkteCfL6kM06JsAPDdgsepKl/pr5stITNA7Tso8nSjAv8z/t1Dnk46ZkxIcM0YjYBQ3IKA
 OAtxqVxcjTrj/FC1EjeI1PVMswdN+nzNBnLzQ2KihhuPxp9g8DFFZsie0/odpU6CynSg8V6x
 lnZ/ogAX3Ss23dCMwcr2iD8sA7lOFPaSqS1/0PgfFCL6A4t5+wARAQABtClNYXJrw6l0YSBD
 YWzDoWJrb3bDoSA8bWNhbGFia292YUBzdXNlLmN6PokCTgQTAQgAOBYhBFbVU8jfbUCf8B6s
 8SHu0+T77enRBQJcQJCiAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJECHu0+T77enR
 Kp0QAI2hUW++KqSBgSGKu/OGPcOl8syIseheewzST2jOJd7C/uZWwL7U4J9YVoYqpFgik5Jw
 EHXIA2YLy1uPTj0KyfaSCQ8oSke73JQTCGJVbHfNJgCnCouSr30O9I+Ck6EyKsr4BSeR1+Rz
 GAsro8d76qIiAAsH/K+igyJZhhSr0kbs/DNaAt8XxJrzJfZ67oW0B++y3P3uhv5mnDT7KB+P
 urS400TIY3hLFtTgXeNh+CCu/zdvW0wl+410uLHWspVNbCDcNbIhT31vS2wes0ZSwpUf+vZf
 WoeAl5Xhw1JsRJn7nwmQVd1RMU1aNndjKsVwIOQTVEQYFBaIn4GrHSXa9+KHcI9BMnnFCW0X
 72nX67Qq1g15ylDd4Vb8C3CPQq9IzB5ISc2WMnkeAgXm9pAYJvLVtg/bkgms4n5MCJlD27ce
 /9kJf5eAt+joILZ7Cw16caVF2xPrqP5g2nN7EGfBkoj1cEOYsK6XizhBj15iqIc8hNdcCGbe
 55lVB5TEkustI0Si0Jy0wako9DBvEr9v7qbjj/mT4Ux6brzz3q3vIXIAgLn/wXB4cOMBKlJ4
 Clu6EI8kKxrGyR6Kb3+8QnARx2o8s6Zl6npWgn9z+xbmk0kyRmM5mwuaB6BUY1O/3OUetVJy
 lGAqTAFr+c1ofYJO9IiLY6LqZA94CAfPv3GpjLqsuQINBFxAkKIBEAC6cF9Nv0EYG+EXPNLO
 iRLIJqFf8vQt6qzax4+/zeGN6sjbo5amMKGpledadAJk4agtKGsfExizzb5dfe5to29A2/4p
 F7gomA3BHrTDVc6jyXePJSqoXYcxoWhIBSLKlgfQzaX40Ax8Mq0MCSrMYuuGtBu6SewhR5g7
 Ei3dDTX8yu0VH8+NjMZ02KCrtvdpy4/BbtuCS4sBP5qnQe0kjVjB61OTlLFaYE5eLlSE5DgM
 zsulfOh6jXRzIatzlrK1oLgk6Xk5yJ4/B0A3WlWI9KKkr6pJPCCtPPqtmdRkvAqTAfoDA0d1
 z8UJ1O1JLAtuSINC1EHbUJfhgebsNh6E5iLfkp47VQrDfeWqFEGvKv8YjMMAeETNquhEMn/p
 aQqX8SOE3QmcVNK3GI7dv9hSCDnbhk5sO7oNRpn3KUEi6LSjoe++icQjbjjLCfjELrUIfX0D
 nf4dt+YrL0UL/GRmKoJXI+3JToIhpTL5DMLfDQJ4VAi+1WMb782d3RTGtfRRENyJyx1l/fMO
 wCaZmDJWT+88ciNiyHwWS62Qc1S9P0t7GAnXrH84iBT3bBMMvODiyQZFGF1F9VH/o6fX+rQ7
 +AF9CPTONhUm9fg6xPUe3ToBxqozhyBlGFrygHBgUjXA4vWmpWTa2jZaUSrYx1FGQVSu4lcG
 eDtOgLyOQe4aHIEXWQARAQABiQI2BBgBCAAgFiEEVtVTyN9tQJ/wHqzxIe7T5Pvt6dEFAlxA
 kKICGwwACgkQIe7T5Pvt6dHNSQ//Z9IocX6YrTHkqKPA2TE2LqVk8AF3LJj+8arZiFg7SSp+
 r6WBcLXXqG5fSIskWkuRj/niiCAa1cM7bovUN4vIip2ZkBGVRwI3WPCavPGDTUUxn4wSddWF
 S7ixtVqgRxcyOfyb1HQDZ8avEPi8dm8zk6nH+ejvCQ7RigDpvoSUkqNiWH5cRA/aZ1oXEfhH
 mrz/FDZ02aKW/cqJhePAsIvzJP8Al0u1WW58ZfusNGfhgTLr3EznY4h2KkfHffjTdaPViYes
 g6/Kl2yzLTwMaUMYOgJ0MAgCIVBswV7dn6/VYTC28ufsOvBdwji1OqwYxl2D1K7Vp7ep+dN7
 vAY0WPUbxFdO98RqxVqL4x7V8cLIlK+xQNepmEQFe6ymeCTS1w5hbI6/RQDc3pSs8dPmZjlV
 4jnNINLk2tZBEUu1G6Gm9UONpdNYhp+84Cjv9KTCJ23p3Ej68ALn8Ahcdu18V1lKO2yeZdwU
 EM4tkFYlQ5dGzZ1EaXeV+yjd4J4REsLdn1jgFmf948M/exHV4D2tAXYMbEvx34xd3GWw4trL
 KDO16svW0bwqlsrMNmoQXgLc7A84n7OnXyF3Lx8+4XwPzNEsD6gcJuKsGYoupkVHn+bTlbXd
 8yEoam/v6jhl1F1e/zax3yW0z5GvCjngRxYXfalFsTAkBBgPshTdbiUUFLEacyE=
Message-ID: <2ee89ff3-e672-e940-f601-aa1d2647756a@suse.cz>
Date:   Mon, 28 Jan 2019 13:58:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <89985b60-4c28-ebf0-64b1-8da75263d745@suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yg3jVot8dd2vfGkP4OHcUBh54S2VERJsq"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yg3jVot8dd2vfGkP4OHcUBh54S2VERJsq
Content-Type: multipart/mixed; boundary="dDuGrNNogTzABdj8k6fTT9pR6AKLT6Jg3";
 protected-headers="v1"
From: Marketa Calabkova <mcalabkova@suse.cz>
To: git@vger.kernel.org
Message-ID: <2ee89ff3-e672-e940-f601-aa1d2647756a@suse.cz>
Subject: Re: Worktree creation race
References: <89985b60-4c28-ebf0-64b1-8da75263d745@suse.cz>
In-Reply-To: <89985b60-4c28-ebf0-64b1-8da75263d745@suse.cz>

--dDuGrNNogTzABdj8k6fTT9pR6AKLT6Jg3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hi,

you have probably overseen my email :) . Please, I would like to get it
fixed.

Does anyone has a suggestion what to do with this bug? It looks like a
one-line fix probably in builtin/worktree.c, but I have no idea how to
do it. Sorry.

Thank you,
Marketa

On 15/01/2019 15:03, Marketa Calabkova wrote:
> Hello,
>
> I am writing to report a bug. The original report is from my colleague,=
 I am also providing his suggestions.
>
> There is insufficient locking for worktree addition. Adding worktree ma=
y fail.
>
> The problem is that git reads the directory entries in $GIT_DIR/worktre=
es,=20
> finds a worktree name that does not exist, tries to create it, and if a=
n=20
> error is returned adding the worktree fails. When multiple git processe=
s=20
> do this in parallel only one adds a worktree and the others fail. Git s=
hould=20
> reread the directory and find a new name that does not exist when creat=
ing=20
> the worktree directory fails because another git process already create=
d it.
>
> I suppose adding PID in the tree name would mitigate the issue to the p=
oint it will be very unlikely to encounter.
>
> I need more than the tree in the temporary directory so using the tempo=
rary directory directly as a tree is out of question.
>
> to test:
>
> cd /dev/shm
> mkdir gittest
> cd gittest
> git init gitrepo
> cd gitrepo
> git commit --allow-empty -m Empty
> for n in $(seq 10000) ; do ( tmp=3D$(mktemp -d /dev/shm/gittest/test.XX=
XXXXXXXXX) ; mkdir $tmp/test ; git worktree add --detach $tmp/test ; ) & =
done
>
> (you should see many messages like:=20
> fatal: could not create directory of '.git/worktrees/test284': File exi=
sts)
>
> Greetings,
> Marketa
>
>



--dDuGrNNogTzABdj8k6fTT9pR6AKLT6Jg3--

--yg3jVot8dd2vfGkP4OHcUBh54S2VERJsq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEVtVTyN9tQJ/wHqzxIe7T5Pvt6dEFAlxO/F0ACgkQIe7T5Pvt
6dHiww/+KwJaCDELc9Peqgmtm9W1VE/qS//Tqae3KXiUZ3B27jdQH8FmTXX8oJlM
fv6hijLYbMyvZMPSksFrZo8dqmpR/+FIw8Fd81z4nwh3JXtgX0KClYemoLhgYnjy
ckKtUrPTbRo0TzwPESOCC6StQBvgsvY3yEUBNjJLoyAaPBdCdHAoksy4C9fcJVQP
SbNaOflee29Y/DKZtEi3Zg01q1vc29RmU8wPHnkR+9gD4wjIh0XvsQMiKFW0vg2s
26g3Vh5XFoSJ0kdUhBckoDwG1liwXJUr404FNs6WhrbeF9q8Jm9LC5XlkHiLnmlP
1ejnZCNxcjGJZLollKDo/ThoweM3XHHVuIbfYUCTIZOLVozJb9KC7mTaRYAdSh7v
CQwwBnJ08tzNpAivtqOtVteB/x10ISvjtMfe68WnSyoYiHDzKsMnUlR+/UTbgiWC
kP2wArG7YLp8DUtDqvPps/Yd7sWYyAN4E2MFCsajJCCofKEmkEqtAGvbFGaprpW3
UDSwoxr4abhoJMsno3xprj5dB3YPh7sL2AfUvNGiyiWEOWfxmVs2nMOtxnF+wJol
JFJlfhPhIPBvoXJspytEJ1QhMswNceuY45NwyaYNeA0MsXc83uba7SY5BOjLrHYz
G4rv6Dn6OtkZebnG5fdgr2MIy3BMH0bOO+P8/T/fQo5YwTd8Hf8=
=7gQD
-----END PGP SIGNATURE-----

--yg3jVot8dd2vfGkP4OHcUBh54S2VERJsq--
