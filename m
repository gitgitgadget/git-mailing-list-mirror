Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0683C1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 15:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbfGYPXv (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 11:23:51 -0400
Received: from mx0b-00256a01.pphosted.com ([67.231.153.242]:43356 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387941AbfGYPXu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Jul 2019 11:23:50 -0400
X-Greylist: delayed 3493 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jul 2019 11:23:49 EDT
Received: from pps.filterd (m0119691.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6PELoLQ150554
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=HV67mlv0vxgmHhUJ+Vnj7hNjte524HR2tPGcY2Drqes=;
 b=hxfQuI9eMMcg4nceH7N+gBCHbntESMd3yRYHb5oDumZn76c+xK0HwX65D1UljwpBJx0o
 yvEuHqx5g9r36dIjkk4kfo1ngYPC3ksMpgpThk6eIAN9PZ6eAn33l/LzpSxVFaAyEgnL
 XLQefCbeXGaff/N0QONnjFI/7lyW/8oTukU/hVDGKXIMVNPCenEqvV5GJDSRniUt8uFb
 p8o+2szjGHPsCP7//g7oqktmtieP56zkHGrjarCXaotqSXSF6bN6Uq/i+VH/sgGjzd9v
 4Hv1A/YKwFenEdXunt5YEIP3mcjmIyEMHT4eZq9eJs4KPPs18/ePcFXOMEfI6KkY1Ga8 ZQ== 
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mx0b-00256a01.pphosted.com with ESMTP id 2txxkdaswj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:25:35 -0400
Received: by mail-qk1-f199.google.com with SMTP id c1so42422971qkl.7
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HV67mlv0vxgmHhUJ+Vnj7hNjte524HR2tPGcY2Drqes=;
        b=SVFomtSb/X4Jc+UM5umAgDxYagMAKX9U+x3G5VCuFJLk/ir4UCsDhsnlMhAMf1lUWK
         ZjN3Tz2O6hxzzePBLS1BRUvhfEh97xZT99jHPFfmFBx+BPdy+7nZUdeVFwV7Fu51EUFI
         rdmmZRLFwg9aNzm0NYI3YWRI5y8cGrCNO5Vy6tYdByHqq9Bxh+GOFkMA2sVTuIt7FRV5
         SujhVkS8zHg/I8oTDAiXXNOvQ0F2xrSnZKyJ0VdmApFTaX1Abw4VO2vklO4AnLphrfGa
         Enz4SRbo9vBsD6H2A2Qza41dwf5UFa9QttDBkiC2e5cIdDJ/CTgParUoNvuR9xKP7L0k
         3GWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HV67mlv0vxgmHhUJ+Vnj7hNjte524HR2tPGcY2Drqes=;
        b=WLfRd/QfORng22DgldRzR4UXAd+g4oragRx5hJesixTqJSwPEIqNR+KDJCTVee+48a
         zBwrLGvr9+xY73oOZ95uYGzJuELr0Ws2KO704TD2lHXQN2WjzVs3nAKosS/Nvrirq1K0
         /i6+c7/5jrRTTZFSbWH5RoFqIpL8IaPR+Tc6JDIzXH4THLvoH/vaRuI6TFwLzeoontry
         r9S0p4Z/suc154eTrOFe6jTZrIXH5NEkpq8LMlG9I+dBYOnpaitO8kJ1LRcY0DacJ6Up
         K3e+zz0dTz2movbnT3Iz8Dxy2BUa1YOcxL8XW9yTp59Focc+ChqH1D0AgpyHpJTNOPza
         1BOw==
X-Gm-Message-State: APjAAAUCn5XZqHbjV0J8WkMjml5dsW0ZOrKrC5WSunbmCUs3jNNXa4CN
        vZwnhXn3MZquibDLiAhjb3beWjioUENe58eSX7KSXbLHG+tdPWFxwNHvSDOvm+Mk6CE5b32C+UE
        YiiHR5udFHJE=
X-Received: by 2002:a37:a7d6:: with SMTP id q205mr56578029qke.44.1564064734936;
        Thu, 25 Jul 2019 07:25:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwV+US8wWAxVloupL2tfH09D4iJHN/PwB9qV+J+8dAOJ7Sp/Ap3rir2neLcsez3wTFgF+McHw==
X-Received: by 2002:a37:a7d6:: with SMTP id q205mr56578011qke.44.1564064734728;
        Thu, 25 Jul 2019 07:25:34 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-168.natpool.nyu.edu. [216.165.95.168])
        by smtp.gmail.com with ESMTPSA id g54sm29273061qtc.61.2019.07.25.07.25.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 07:25:34 -0700 (PDT)
Date:   Thu, 25 Jul 2019 10:25:34 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Ilya Kantor <iliakan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [git for translators] How to always generate conflicts for
 merges?
Message-ID: <20190725142533.5rcwl5frvv3bjx4s@LykOS.localdomain>
References: <C9A27ED4-CBD9-4FCD-B78F-8A1010D24D06@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2pbhcpdiuuj74kkj"
Content-Disposition: inline
In-Reply-To: <C9A27ED4-CBD9-4FCD-B78F-8A1010D24D06@gmail.com>
X-Orig-IP: 209.85.222.199
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=776 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250168
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2pbhcpdiuuj74kkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm not completely sure if this is the best way to achieve this, but I
you could instruct a merge driver to mark all new files as unset.

Cheers!
-Santiago.

On Thu, Jul 25, 2019 at 04:42:48PM +0300, Ilya Kantor wrote:
> Hi,
>=20
> We're using Git to manage translations of an open-source book, and most o=
f time it works well. But there's also a problem.
>=20
> When we pull changes from upstream (English) to translation (e.g. Japanes=
e), git auto-merges them.
>=20
> Sometimes there conflicts, but not all the time.
>=20
> For example, when a new file is added to English, it just gets auto-merge=
d into Japanese.
> But all new changes must be human-controlled, translated.=20
>=20
> Is there a way to force git always generate a conflict, even if changes c=
ould be auto-merged?
>=20
> ----
> Ilya
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__javascript.info&d=
=3DDwIFAg&c=3DslrrB7dE8n7gBJbeO0g-IQ&r=3DyZMPY-APGKyVIX7HgQFZJA&m=3DfywBEjN=
JhlI37lKNhH6u90hEOBCF5PqmRunhDCRO0Fg&s=3DWe1ibeYQn4Z4Gf53M4CUyENq_BHhavulOg=
20KJIRxOg&e=3D=20

--2pbhcpdiuuj74kkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAl05u90ACgkQRo8SLOgW
IpXaMQ/8DaZlK//U7qczcnASo/BDdr46lkE5rJJ3X4Oz/cBVV6aXYdNbXvmqxJpJ
fozkJBzkPNsW1RkaFEjKnPDjbxcQSvlpeD4Ay+2iqtzjhbDdjwnSExQjJ1nOuQOn
9oLmicwBrNIfu8LqKoN7Pne+1VALLc9J/+qpgoPJsR+6FmMrrqHz7GD1xEaWDwta
EkRhlKibk3Xt6PvGyba1U6opqn8nbm5UfS2vDlJRpnEO6cBdeOeT2qMN5vhsDU/Q
A22zJ1NR25z3Pxrj7ejpYRzMCdPN9CxT7Bn9g87nKTTO0ZhSMxeMqdzqCB8yX2NF
Sxc0zEU/KHf9VMgpuOtlQoibx+HqW9rP4GJMzdeJra9uzFivhbAqSoA2pKVjp5Db
qgH+FtTSP+QltG7G0Z099Fbhc3J0ndit0x6AHPuxkwqnMzhrNYqZi4ILmYT9lV8s
YiE+tr2xiByL7SF8X5DTA4O8faJmLHN6MngGgh9TcYCfWcYGleiQyBztnjgWIFzc
3yGjefJjf9WtgvL2n/vQoG9R5xz5wyUED5NUuLV2jgmMUIaPIWZ7Y1oopzARXoYZ
H+BAxbRMhLKG0vJGT29YoNz5wCfOgKDf2+SayUWstl+uLEQJbaIx/QztSeKVJyk+
ZH8i64T+FThm4VOQVjsnAB/S9+QB+RXJMO/W0dtZ4Jcr2tNnZPA=
=XglS
-----END PGP SIGNATURE-----

--2pbhcpdiuuj74kkj--
