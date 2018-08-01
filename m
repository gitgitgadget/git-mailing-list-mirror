Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A199A1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 01:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732924AbeHADHK (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 23:07:10 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:58152 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731999AbeHADHK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 31 Jul 2018 23:07:10 -0400
X-Greylist: delayed 3509 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Jul 2018 23:07:09 EDT
Received: from pps.filterd (m0142701.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w710Lv1v118016
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 20:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=FBZ0iGsosL0GKHJOVoTzD/r+02vG1FBAh+Yu+Smtyss=;
 b=LXjZvtpaERvpRFLGtP3xMDdS3GhZpmpcJX7AfhJ6mJFed1GhdEFFqrVmRnwZLYSB98n+
 rdiZOZSYkCO2gnh7HgbADc9LUZ0rzUA1tkOXZCAPFSZQntvQSvC3GMOclY/P/DOydmSP
 98XqbfIcR7QLnqErWxN3OCrTT+i26GLU8GK+6g/CwlVj+hiGIQwcu1ymImaoHJGDPjvT
 TjBAoUwYylBuPZ+9EHskX92gg/TQMRkcp2RU8vzTnhbxX88IonHaq76D4ktkZTJVVvQL
 KNsCTAopuB+yEGUENrHFP79ek7bSVYVPVzjhhTALb9Tev/F+Y5NzkbWSt+Fe1EPGrpd6 Pw== 
Received: from mail-qk0-f197.google.com (mail-qk0-f197.google.com [209.85.220.197])
        by mx0b-00256a01.pphosted.com with ESMTP id 2kjugdn8fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 20:25:50 -0400
Received: by mail-qk0-f197.google.com with SMTP id o18-v6so15401558qko.21
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 17:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FBZ0iGsosL0GKHJOVoTzD/r+02vG1FBAh+Yu+Smtyss=;
        b=2LIrYei0OJudYGQLM1qtVU9cLCnI6WdQWiS27umYkInl+oewkSnUVfIc64x/gugMJ7
         K1GzXdIPkIfgqmzPTXkTUF2goT3o+42LS0gv63VN6fUOInTGDKbWD5NVjRx8O6hkx14W
         2LdQtqLpUdVOu7VBP6vpcnL7cKR40dOAT38fzmBSq7GfbGkM53zQ80p9UtK5bdoF+7l4
         y7czqHRzzHU7V6ngfsMSMwVkVp5wzLUiP5ZemJqq4kHyzboWfyv7ZNRtZSoPg7aXN5Af
         IX4FcmFCchFkV+fHsfSfI9HtDUZdaBamGebq3YNniFIUAWtag/skoalf3bk1Y9JcjW3U
         w+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FBZ0iGsosL0GKHJOVoTzD/r+02vG1FBAh+Yu+Smtyss=;
        b=Cgi1tHvvDCRQHl4EO0tbp93JJ1J4UNEpWaMERcG30IIP7ZMW4qoTE3/QiZZJp5k2vl
         0wsu/Q+PA2PrN6mZVW+X9U1zrp8r+CPBUCbFpbAwtf+ZAljVOQ7zk3t6D9VnZRp37D7B
         ZIUapGJXX1SzQwGJY7D9GaiRaf11WAxnEqx7O/U5wzXlbgS1kXiJ1aQP9XPMVWxmEdpM
         Cv4CnIWAEuHasm6WeJDIysoTn9ZA04AsCsRPW9SETVf849Rez+1JeEP/RlG5tT7fQTyh
         KC1li5qi3M3dWl6UCY13FvLWjHkTI0upOPO4EaliMes1fEGwqFyZ41mDOBEQmKGanwka
         6KWg==
X-Gm-Message-State: AOUpUlHZR4cyMh8IhKlZIa+QQe9z1NqbyZgH9eTeysdUykNVNPmzS7IY
        VgotMxku7iwk+P/dHLbXl2hq6tf3nIbUbAQrloqQ8h8qt5RsvJUdZhw0kBqdHz6yAlbhPChKLGQ
        YG223bAfaPK4=
X-Received: by 2002:a0c:f5d3:: with SMTP id q19-v6mr21604945qvm.213.1533083148693;
        Tue, 31 Jul 2018 17:25:48 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpcLy+3Ayv8F1t/i9VtDwpHFg0ihpi7+bt8O20vcBsDgwy8+WyFvBQTj0u1VKS3YPvIGGbAw8Q==
X-Received: by 2002:a0c:f5d3:: with SMTP id q19-v6mr21604936qvm.213.1533083148541;
        Tue, 31 Jul 2018 17:25:48 -0700 (PDT)
Received: from LykOS.localdomain (cpe-68-173-125-182.nyc.res.rr.com. [68.173.125.182])
        by smtp.gmail.com with ESMTPSA id w13-v6sm11655320qtc.88.2018.07.31.17.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 17:25:48 -0700 (PDT)
Date:   Tue, 31 Jul 2018 20:25:47 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>,
        git@vger.kernel.org, Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully
 when signature is not trusted
Message-ID: <20180801002546.du52zkxjupzcw2p6@LykOS.localdomain>
References: <09f9803c-3f4b-a97c-2c59-e9d6b924892f@nic.cz>
 <20180801001942.GC45452@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ihl7lqqteeb5fsfs"
Content-Disposition: inline
In-Reply-To: <20180801001942.GC45452@genre.crustytoothpaste.net>
X-Orig-IP: 209.85.220.197
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=6 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808010003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ihl7lqqteeb5fsfs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 12:19:42AM +0000, brian m. carlson wrote:
> On Tue, Jul 31, 2018 at 10:05:22PM +0200, Vojtech Myslivec wrote:
> > Hello,
> >=20
> > me and my colleague are struggling with automation of verifying git
> > repositories and we have encountered that git verify-commit and
> > verify-tag accepts untrusted signatures and exit successfully.
>=20
> I don't have strong feelings on your change one way or the other, but
> for automation it may be useful to use the --raw flag, which gives you
> the raw gpg output and much greater control.  For example, you can
> require that a subkey is or is not used or require certain algorithms.
>=20
> I will say that most signatures are untrusted in my experience, so
> unless people are using TOFU mode or making local signatures, git will
> exit nonzero for most signatures.  I think the current status is to exit
> on a good signature, even if it isn't necessarily a valid signature.
>=20
> I'm interested to hear others' thoughts on this.

I'd find it odd that we deviate from the gpg behavior, that returns 0
when verifyng an untrusted signatures. Tooling around gpg is generally
difficult for this reason, but using the raw output should be enough to
discard signatures with untrusted keys.

Another alternative is to use a keyring with trusted keys *only* and
disable fetching keys from hkp servers. This way signature verification
should fail.

Thanks,
-Santiago.

> --=20
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204



--ihl7lqqteeb5fsfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAltg/goACgkQRo8SLOgW
IpUMoxAAzeP0i+RrJ9v9Ax6gBMwrJ44KU6ZEhR6erivlnLBeDWMACK8sXYHkA1Ee
DG/wJv06iUsRh0+72+TpI8Y52gjIWlMGhG4k4tWHpqSh/Yf8qCX4I9oGys+hbBjF
a5kBn6NZwnExu6XwQOm8bU64fH1WR8QCPjLGXJnYu2ZAkH2UypO+Vnl5XKZLsp76
vsMKLa7QBuF/zFAi+aazqk3j6N38sU4Qf+BuetNyolnSdKvDXciZhZee0U1AllK5
jX3ajJzhZ3mfiHsywXCsWXSnhOFpfkrBfxiCYi60n50bxdCwBK7oziomwWq9UlBL
bqEJimDQmZ7L6bkFw1qDmkiE6EZhqw2WS7C46+MPBFJn2IyM2RdDO/N/hfHfAzjS
erdmkdrN0NoLzUGtlmWDdPqOe07mbnDJxWFnFAW35EClPI/xaEhXwg47qttj8vaV
CjHRqlUEIXXbVg6OoxGQKqNoH9MS7mo1Ag/EjoyzOyAhvuEy9yJuPe6q6NmbnwXW
choguwRuWZrVv0lsx0BuuKca1/LfyD35TVOrmiCe2D60JteXR5iuZ9b0qVj65uRM
sB4aWU7nykPqv2X3DYkCojttgrdYtzH8yiSS9JRw0Z/YKaNqFCBmx1wZLVR4/bCX
o66txLMKfLUTJ8Z/Xp/nFA0zC0Tpun4JC9Jk6gniKwN+Bs2phLU=
=cu+h
-----END PGP SIGNATURE-----

--ihl7lqqteeb5fsfs--
