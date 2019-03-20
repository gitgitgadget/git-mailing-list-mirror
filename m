Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA7620248
	for <e@80x24.org>; Wed, 20 Mar 2019 14:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfCTOVE (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 10:21:04 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:54802 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727144AbfCTOVC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Mar 2019 10:21:02 -0400
Received: from pps.filterd (m0142701.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KEBBRr063612
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 10:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=mJTPYZ1ZovFWSUTSCWbWeKlPDGyX3sxOk5jV2al6Fzk=;
 b=XNlEDtON1lKGdsUU9P0LRbX/4YITaniRorsH5hhwqwLAXkMxCcub3UTuharuYFoG7GkV
 7P6aZtDG9jsKpcl03jnnU1amyly7FnJC55Eu+VvrKDzOBX2GPIlLCVwGdScUJeKouehh
 jBocXtbUlAVyWG3KrYlbaeM4+q+y33fB2na6lekIvb3HTL+b9/k97juOsqz+T8V161Jz
 O/m2qEIdGkCueXBfAOqNLiGvnlqq8lii9eGb2+KrVIi+1U0Qg5V9xU4XKUkt88orknLv
 0MXjft7H5ydnWhWMDznHjEtcrWK+yvWEtH4tHZObKiUW95V/CyRleR3PZGkm78LIB3xO mw== 
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by mx0b-00256a01.pphosted.com with ESMTP id 2rb7jna5f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 10:21:00 -0400
Received: by mail-ot1-f71.google.com with SMTP id e12so1271159otl.9
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mJTPYZ1ZovFWSUTSCWbWeKlPDGyX3sxOk5jV2al6Fzk=;
        b=wRhxe+MMZgAOJxnyCuqvBTpWIBb3PnrI0oPn5NN1tosqfUZkcYqLcRMFRqHuWtogP5
         qnAZbGNGUS+ZPAxV2MrDEIQDjzhXJKADDW++QoGKTnKcIQi8UtF6L3lm+iEU18E/R8Yq
         yzeZesiqC2kSvUCOHSRIYmriITYFEoBhVAnEe0yRhseDzbDQ4m8mAbFP6aLulcaSVKg2
         ZNeIjml9oH43/LuHk7qp5iD2fiUUIDW7zDE4LTfItIMMTYwQEas4ASDNjVqNtC8eOnff
         ZPREmcRTcwAq7YiA+R0MCDJgSe991dYgb5v7PjIIemXpb1LE4z+uu81bQWDdfqLzN3uY
         Wehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mJTPYZ1ZovFWSUTSCWbWeKlPDGyX3sxOk5jV2al6Fzk=;
        b=uYc0beJKigiyc+5WgZP/vGuYGk6ZPRV1Go/n/sleNJs/pcmGD/VlGaNwMue1o3w7zN
         8+JB60Pvms7kAqNSG9wEMsbHHp27cZGQoATaNDamZuHneQecr6Kj7zKAsX4BXt5KmkEp
         VvWM44DnB26oMcwKF06svQ+9rjRT/wGpkOf9CzgNpGy228xeSSOJhz6HvjIT7G+KOJdG
         1KLPYz7DxyRLTaDiJdZ3VPIRQlKBW/JdVKxZ/JBHRgdvL/ZS0TX7YEbHnufXS+btC59S
         9R5Hw3InK6MLa97JffMVxMZRuoxvbbvVWXlBaGQFXhIoMf3lYwD3vOkgmcCH5QLKRfOd
         vGtQ==
X-Gm-Message-State: APjAAAXV2+6V5gQp/v0LOFQJyk5SMpo0jcQ8Xd2dnItRcrh+s1ogiEIR
        P1Qs3tjr9GEEXjf3XTK977jliAPl3KOoR8hJRoM91DZzLgzELiKUlV6ott3SNuI2ZEtYoXvjRI2
        QIkRju0tu7gI=
X-Received: by 2002:aca:b444:: with SMTP id d65mr5079429oif.169.1553091659698;
        Wed, 20 Mar 2019 07:20:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwxAovLRzP73Vfbb1FBbxRwjb+4MQLauPfJwErXoAZZpgdxE7iSwfzBtPaZkp7tTP7WOkLJxQ==
X-Received: by 2002:aca:b444:: with SMTP id d65mr5079398oif.169.1553091659142;
        Wed, 20 Mar 2019 07:20:59 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-128.natpool.nyu.edu. [216.165.95.128])
        by smtp.gmail.com with ESMTPSA id x30sm928840ote.11.2019.03.20.07.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 07:20:58 -0700 (PDT)
Date:   Wed, 20 Mar 2019 10:20:57 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Cc:     git@vger.kernel.org
Subject: Re: git tag -v should verify that the tag signer intended the same
 tag name as the user is verifying
Message-ID: <20190320142055.zlh5iby5pxs3fy3r@LykOS.localdomain>
References: <875zsdu41d.fsf@fifthhorseman.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hetd2ugq5xcpd2fl"
Content-Disposition: inline
In-Reply-To: <875zsdu41d.fsf@fifthhorseman.net>
X-Orig-IP: 209.85.210.71
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200110
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hetd2ugq5xcpd2fl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This has been known for a whlie now[1]. The consensus back then was that
this information was up to higher-level integrators to verify using
means like e.g., --format.

This is implemented in for example pacman/devtools here[2]. We published
a paper with a more thorough security model here[3], and there's some
stalled work into implementing this using push certificates...

Thanks,
-Santiago.

[1] https://public-inbox.org/git/xmqqk2hzldx8.fsf@gitster.mtv.corp.google.c=
om/
[2] https://lists.archlinux.org/pipermail/pacman-dev/2017-September/022123.=
html
[3] https://www.usenix.org/conference/usenixsecurity16/technical-sessions/p=
resentation/torres-arias

On Wed, Mar 20, 2019 at 08:24:46AM -0400, Daniel Kahn Gillmor wrote:
> Hi git folks--
>=20
> I understand that git tags can be easily renamed.  for example:
>=20
>     git tag push origin refs/tags/v0.0.3:refs/tags/v2.3.4
>=20
> However, for tags signed with any recent version of git, the tag name is
> also included in the signed material:
>=20
>     0 dkg@test:~$ git tag -v v0.0.3
>     object 8ae6a246bef5b5eb0684e9fc1c933a4f8441dadd
>     type commit
>     tag v0.0.3
>     tagger Daniel Kahn Gillmor <dkg@fifthhorseman.net> 1528706225 +0200
>=20
>     this is my tag message
>     gpg: Signature made Mon 11 Jun 2018 04:37:05 AM EDT
>     gpg:                using Ed25519 key C90E6D36200A1B922A1509E77618196=
529AE5FF8
>     gpg: Good signature from "Daniel Kahn Gillmor <dkg@fifthhorseman.net>=
" [ultimate]
>     Primary key fingerprint: C4BC 2DDB 38CC E964 85EB  E9C2 F206 9117 903=
8 E5C6
>     0 dkg@test:~$
>=20
> But git tag doesn't verify that the internal name is the same as the
> external name (note that it still returns an exit code of zero):
>=20
>     0 dkg@test:~$ git tag -v v2.3.4
>     object 8ae6a246bef5b5eb0684e9fc1c933a4f8441dadd
>     type commit
>     tag v0.0.3
>     tagger Daniel Kahn Gillmor <dkg@fifthhorseman.net> 1528706225 +0200
>=20
>     this is my tag message
>     gpg: Signature made Mon 11 Jun 2018 04:37:05 AM EDT
>     gpg:                using Ed25519 key C90E6D36200A1B922A1509E77618196=
529AE5FF8
>     gpg: Good signature from "Daniel Kahn Gillmor <dkg@fifthhorseman.net>=
" [ultimate]
>     Primary key fingerprint: C4BC 2DDB 38CC E964 85EB  E9C2 F206 9117 903=
8 E5C6
>     0 dkg@test:~$
>=20
> This seems troublesome, as I expect there are many scripts that rely on
> the tag name and the return code of "git tag -v" to assert that this is
> a correct tag.  Anyone in control of the above repository could pass off
> an old tag (or indeed, a tag from an entirely different project that
> happens to be signed by the same author) as whatever version they wanted
> to, and convince automated scripts that work with new versions to
> "upgrade".
>=20
> I think "git tag -v" should be more strict about what it needs to "pass"
> a verification.
>=20
> At a minimum, if the internal tag name (the line matching "^tag " before
> the first blank line) doesn't match the tag name being verified, "git
> tag -v" should report a warning to stderr and return a non-zero error
> code.
>=20
> What do you think?
>=20
> i'm not subscribed to git@vger.kernel.org, so please keep me in Cc on
> this thread, thanks!
>=20
>     --dkg



--hetd2ugq5xcpd2fl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlySTEcACgkQRo8SLOgW
IpVFJQ/9GhiWch4w0hXEmnwGrFYsHdj1/fvwffroO6QrlhDsLFzdac7HwFIjdJYn
eOA3xZkYx6hQiG5adbmbRZ4I/wuYIFc1sDSnNZzf01xXJbT3cYStIQme5cI6bgYm
Tw1ySkpH0glafsE0a3EdYCwEh2M4jMA9J69dGabcqEFiJmvs40Q2NSS6Mf9Io7JQ
5s0FHM1GDTGjE/8pKvtcJC+sK60+GO9pEL3EgvD0kGzWl1M66wlNs/jluaUR+FOC
z2ZV4SJ0uvN7FRo8ev6nTj9bMn1jS2zy0ilu2M7KH8JeP8WlxjPvkEQ0/6QjP/LR
SO4Atfdt7BnTxQ2aYO5EqODfZ1wPTmqhCNG0Z7HnkfkV7eONyFC4omY4bzyXLCVh
Pn6JAylI8MRf3A1nYD39/q+mMaDk9hGAtL67GWDt1fduE03IN7kjFzp+1g/Z9GmC
t6ZkAFH0b+FzvZIEQ/gu8NkL/jn96EbgMRQ4hJyJECLJC4/8yDO8REeDlHJE4OVr
Fs1IsJWiKF/Bh96on/7yEbZs7zgyWJwZhX0T1BWDFXZ1BMpySIHxDYaYwyVRNB+p
2i1r28LGOxtbiRL2HdkJ+aj20XIfCjqn/DVkqnHDsQorc6VVB38OXo9DrbF1wakJ
SdZD7B6uzcbgWtL180P/F0j1lcM7GFWqDcEiXt+6F61DX1O5tmk=
=//dP
-----END PGP SIGNATURE-----

--hetd2ugq5xcpd2fl--
