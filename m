Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D1B1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 17:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410579AbfJRRWo (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 13:22:44 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:1466 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406122AbfJRRWo (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Oct 2019 13:22:44 -0400
Received: from pps.filterd (m0142700.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9IFpicD108848
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 11:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=8WzOh4VxFi+gRpyaJOrI+xwl81ARGu8H2iil3vR4U0Y=;
 b=IRMASetabSmu/GjHAE/fqblY8RHyvO8SlwgXEROQILMaVDtpXbuH5Kzozeh584vjMArJ
 MpKKd/JnGCCiN2xccEOWXIVAzffifzSL/LY6tbWhUTWyYoIKZpJWtbhq09bQubgwQA4W
 k9T/F+3BaDVG/EyBjHG2KqnApIhFAZ39byDtZW5NDVJgCdxNgA/YZABCtgkjK5W+j7Wx
 RdpSOKuXIg3LJjZPOluCH0HTNrGj8Xv96f6+NDkq9BFQpGIpsx+JNaQPFpYbUIWU2J2I
 W6Bd8OWbX6oNm7CcAWuivFPHQavVAr6J+e4QxhHdd0SdiBSfjqldKfHIby+uAvTP9qJf WA== 
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mx0b-00256a01.pphosted.com with ESMTP id 2vq8107q6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 11:54:12 -0400
Received: by mail-qt1-f200.google.com with SMTP id e13so6277639qto.18
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8WzOh4VxFi+gRpyaJOrI+xwl81ARGu8H2iil3vR4U0Y=;
        b=B5P0CS8CKsNBgGRhAuzrX9PTFPMUAoCfIZtNkU05d3+xh5hNaJ248LtYbxm9Lj/ycZ
         LcXOVFxKAhUoazCiYckSPjNEmQAcOOsy0F6qRp3/J5H3exiv7wtIBWrwc3soNSrX9vVz
         tAOY+7KGv8XJbg+N/vwbwoEvBASsS+ap9Ym0Wh+z7ww5ExjWOi0n1z68bGu8zuGmop+o
         TS8grnnF/Auk/MXsDxSLG1whzDjqXOcbk0d2xHxkKCzZcs2QjNApfNg92bqjtHdvNc3R
         IXaZdamejE04wheJDFDk8SMEfQMAJJTLJ48QypQPuqN3LHyHJmKRhZSrw2klkWRIr1WD
         /G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8WzOh4VxFi+gRpyaJOrI+xwl81ARGu8H2iil3vR4U0Y=;
        b=skYMm5zHfN6UiCNyddBIbei6HtCmMaJo2Z3kaitkZMbr9DAzFm9qftu+uw954c3haq
         GTglH9jK+iagWtgBmtYGbycPABR9irsEGRpMPZLjxxJVIHCskpm5kYHjL3+GHZBHckh+
         MASq//S4toj1fpfzKnCbP1zv5wUSE7YAqEmKyxZ5vHX3N8C+rxWpnZ/alHbwY4m+rvuD
         iJvTqTS+f4QzgQrePDxXafd4jKV82SqEQwLFkncmDZ8S3EVeLwONS1nLEjy3MXk2KDkv
         1TF02M6T9rkHrnDdgtMExmPSpq18UCcK8VihSQTwqahqWbrKWZuRfnfjr+Rd+j6/AUT5
         yufg==
X-Gm-Message-State: APjAAAUZky2k4PGx3Ogmqu/qx//ECv9d1IqWUV1xlJ4Hi/IGfwZmIl/S
        zad7dUv9YROTfYnCzbjHaKuupxu+ydzoSGdFigXHmLCwYCEs3Njpl6OIqZ9PEbQ+OeF41Ti5AZB
        BgynGymUbtL0=
X-Received: by 2002:a0c:fa91:: with SMTP id o17mr10671188qvn.142.1571414051274;
        Fri, 18 Oct 2019 08:54:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzpdpx+YqP9G6AgSLbPFZYcnbAE0igK0+Neer7IkNmX+LQFwmzaKk2LqAsNvkoquqj/CkxRZw==
X-Received: by 2002:a0c:fa91:: with SMTP id o17mr10671172qvn.142.1571414051101;
        Fri, 18 Oct 2019 08:54:11 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-130.natpool.nyu.edu. [216.165.95.130])
        by smtp.gmail.com with ESMTPSA id k13sm681936qkg.57.2019.10.18.08.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 08:54:10 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:54:09 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Willy Tarreau <w@1wt.eu>, workflows@vger.kernel.org,
        Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191018155408.dk4tsjrne42ufpvv@LykOS.localdomain>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5sfrrmuyqloyaxm7"
Content-Disposition: inline
In-Reply-To: <56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com>
X-Orig-IP: 209.85.160.200
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=7 clxscore=1011 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=754 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180143
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5sfrrmuyqloyaxm7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Seeing how large this signature is, I have to admit that I am partial to
> Konstantin's suggestion of using minisign. This seems like something
> that could be added to git as an alternative to gpg without too much
> trouble, I think.
>=20
>=20

I wonder how big the pgp payload would be with ed25519 as the underlying
algorithm. AFAICT, the payload of a minisign signature vs a signature
packet have almost the same fields...

--5sfrrmuyqloyaxm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAl2p4CAACgkQRo8SLOgW
IpWCjBAA0Vj5QGil9RloqJJ3wtJwtCnJCmTogWUL1Aoh4fjllBRsl5Zo/MM+ttl8
mLMGtLEpTsLwyVbgtrDNUlttd8RQRfmO5N+/QdowDchWLPt9bdbnZZ3S/PSCFfZs
3jbWxJ/XTg9n5fpu111Vyl9O4A/0ZODqRJHDjvhg6dX04vlIj+s/UYsF/9mBvCEy
kBqzdNgGqZ4nQMrvYQTT6kVA39jeF4PDMzg7hLpSzvXI6jTlEyEEyd9er7y22gdL
a0qTjXVGzc5TvAUjBZ/RMbBa9o+Jkg3WwZwmvGKosScHqPIEpCp2i+iL/NiQnid2
OxwzidTRstzc5gwjHTSaFtEw9i8YqunOZhUpoTS4/AG4RaaepsetDTpUE6Ckax/J
MG6/ZbnfXVwGXmH5aMiuPK/o098r/dcB/3HL5KkMGuo5eF+3H0uFd3ylpBBfuv++
DD+h9bO02I0ktNIj9p99W8Ze/66XSe/9GzOvG9jldDTBBSW92S1M5M+ul3ko4IEt
TL0wEMYPq/81kM3hfpZYbzmL4NcY6jUIc+UvnpwczfhU3DSTA3pS+UpBXO3njuOu
8OtWJm3rcAaJaQ+U3Pzfms4jR0uSNmgdiF/LRgMxnmBu5mQSIKiAFJ7iqIzMJXuA
djhM8UQCu0rQwgFr7SB2ZJRsU+Ec3yTfKGWa1q0gBoz4zdaYfmU=
=zbEw
-----END PGP SIGNATURE-----

--5sfrrmuyqloyaxm7--
