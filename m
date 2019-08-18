Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE3441F461
	for <e@80x24.org>; Sun, 18 Aug 2019 02:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfHRCsC (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 22:48:02 -0400
Received: from mx0b-00256a01.pphosted.com ([67.231.153.242]:61480 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726208AbfHRCsB (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 17 Aug 2019 22:48:01 -0400
Received: from pps.filterd (m0119692.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7I2ldpp119170
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 22:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=uijPdVTGV+Xy69cCV3r721XJOTip68Mh3dpMo0QMR/w=;
 b=UqfO361cXHX5dGKYpTXnKY5fu3WRajhcbD2p+fjac1zvSm9/JcFMEir0O7JWkdp03OAP
 RqEQ4sCi7EyvPHrLROrIHcgRrMqCJ22kN4E7UIi0IiBlkq56o4b0Ises8JHV4lN8Z+zU
 TGT0VGkrGnPIhCL58btU7PRline8RB7gSVuV+gJ/ZMZrF2R/O3NMs29G8a9gCx1xXrpz
 SEfX6hTHeIeIbGPqPDKdgQAiiD40bTdH0YexdrQcswiAuB0pDBqOVANNF0dvJkKiZ0Pr
 VV+T1o8d4Kp/GMSyD2Y22NnfoyGlp7OVafx68NR8ZVNOPXgl4gKN9M+QGNC7xASy8AQo yg== 
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by mx0b-00256a01.pphosted.com with ESMTP id 2uebeasssy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 22:48:00 -0400
Received: by mail-io1-f69.google.com with SMTP id p2so23697iod.2
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 19:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uijPdVTGV+Xy69cCV3r721XJOTip68Mh3dpMo0QMR/w=;
        b=NHgy6XtIOxlSqNPqDRUG1pz1UlXIwYadmblQPNndUKYRO09pSGE0mUbKrkZ0nckC46
         lFVsdp+cT38/9HmbuY9fFQ0i1i957xPhxxj+6euaJyomAZMU3wTKC1QT4nRyTRUobjux
         bZuAQbkY6VcYnMFsCwH5xnJLyJzpjaS0tu9emM8T6rXdkUY/kdRBS+3iCe+gODep/moW
         xjjcAePZfiMH+TVGPXrVy1ZNZvr12TomEl02Rkn7W2ldK3LH1GZIIYhvqX5o62f4N57U
         x1V5PBoe37mMkflSKqnseIZIEXc9JOYV8Kgowzo63HqwunPiX0NlkcysnodTthmDHYp1
         5PRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uijPdVTGV+Xy69cCV3r721XJOTip68Mh3dpMo0QMR/w=;
        b=AnfqlEy+SwlrwjFWdUlrmxAANgjFs81cyJXyHPYFSYNa4TyxWc6+TShgAiHMcft0OQ
         Nhyad9/SzTKJAAuo5NGFisoWPdOx/ALMtTUOg+wqao1bFWBrP4rZSav7pHznDtcumKs2
         DSyfaymbw/7NvDD2MaLTPd9WCEFXxUoxd7u4E1T4v1SWv76MMJW20nib9dO9/j54FdHV
         ZKzSGCBQk0irrRdeuCCz9Gz9qTK2SU3Kcc0usJeyYi+FJgCdiB4NRII6oSJPafzTK1D8
         HCRwB93XdkcdVpw81XSUvPgodb+mEofMHmwpXFCWam7kXV8FYJe8Ysj/WY2zPCrEpsaF
         F+Lw==
X-Gm-Message-State: APjAAAWYXtV5NNfiTJw/kfj3rc/EBC+HtCskxn7/7wmdgm0w7xSb8H3e
        Xh/zj//KpTRhyx+nE8l9AdbHLYsk3jprRIo1efHdN7MCD7ZC2qcLnJ4mTEGLXWeHObIotILOWZd
        liE75JSZM78w=
X-Received: by 2002:a5d:83cd:: with SMTP id u13mr18651232ior.297.1566096479522;
        Sat, 17 Aug 2019 19:47:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzKKevynJKvOH3SUQxH+AyutKeLJkq0IvSWkd/qb2qytzfxn+eEo407ybUXkLM6sxUxKb/CTQ==
X-Received: by 2002:a5d:83cd:: with SMTP id u13mr18651223ior.297.1566096479315;
        Sat, 17 Aug 2019 19:47:59 -0700 (PDT)
Received: from LykOS.localdomain ([8.25.222.2])
        by smtp.gmail.com with ESMTPSA id k26sm7386366ios.38.2019.08.17.19.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 19:47:59 -0700 (PDT)
Date:   Sat, 17 Aug 2019 22:47:57 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Dhaval Patel <drdhaval2785@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git diff autocomplete
Message-ID: <20190818024757.765fx3tdfekseim5@LykOS.localdomain>
References: <CADSGPzV+dfNR=epmz2whKkrpiH=JMUR4gVjpZ+x+kzKrX0kD-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tfgrkoofg5y6o3bf"
Content-Disposition: inline
In-Reply-To: <CADSGPzV+dfNR=epmz2whKkrpiH=JMUR4gVjpZ+x+kzKrX0kD-A@mail.gmail.com>
X-Orig-IP: 209.85.166.69
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=915 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908180029
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tfgrkoofg5y6o3bf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2019 at 08:14:15AM +0530, Dhaval Patel wrote:
> How to reproduce
>=20
> [snip]
> Suggested feature -
>=20
> when I press tab, git diff should autocomplete just like git add.

I think this is somewhat harder of a usecase, as git add generally takes
paths and diff can compare revisions *and* paths. I see that if I do

    git diff -- [TAB]

I get all the paths as an autocomplete option, which I think is desired
behavior.

Thanks,
-Santiago.

--tfgrkoofg5y6o3bf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAl1YvFwACgkQRo8SLOgW
IpUxHQ//ffQLlIP+qBw56wE9E6FEJ/JVw34miLbAp2Ty03dZgeMpsAFAaFZJecOA
RFlL1bsOSdMbqPvFLsG8/DTXrtmnpCQiyRfaRBLjtVFrdwpas+bFeoeGaL5YVsCz
oE5x+t7VlwCV9jiiRm0fbqK9BPjPj7k0JIg1cWsh3s5+iwf9cBmnNNPNN92eX4Zj
XpmRUJakRDvULXE9EfqaWq5NxB/b0WW3vr4SwA97iBW3f1YOvKLihq+J04lriaD2
uRXCctWr2IF/F9rL+D8uWZFJGGRufcUt8u3h7/1SojmJt4rMWSOBwNTmXBvjXyEM
gw4UpufJyRwNFkNGmtCl5SncIrwfoC/a9ihxWtmTbX0IOZP00C0a4kcyE+hp858M
G67IJemwx0NtHQUYZpaS7sIow8oi0cNbam3vOQkvoKvGY9zOLmKvoiTfQtMVCZSh
PhiLUF85vhNsOrMR/vqEqsJabnhyVwoz8wxdAEaiXHzrXfdd29dSyeEUgyBzF1VJ
/i4uFISHPPdc3FpzTQavauMoZAR0zffLeNvxf7U3uStny1VRPls69T0XJ7Sc3l35
pSIuMiZTOPs0XNo5pPMNFW6N5hO1TkEF4l+kWwhQksuQGELZ54XdlSDrTtXGJPQf
3AK67o5Be6OtBjetf/tPxt/5RA8yMUl4Ux49i0skasFBcuctu/o=
=NRMB
-----END PGP SIGNATURE-----

--tfgrkoofg5y6o3bf--
