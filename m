Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC6071F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 23:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfDVX0g (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 19:26:36 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:59760 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730735AbfDVX0g (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Apr 2019 19:26:36 -0400
Received: from pps.filterd (m0142700.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3MNMMeD038112
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 19:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=w0Snp5EF/ecnxnA1yKb1R9RHI5ed/m6/jINfWZ/mhl0=;
 b=IyCfvWIXBfRrxkFHVLhsAe75gpvtaqtVzn+Ykul/dYY5xFgRsI7BsFKKB/cWHxPWuavf
 KgXzEeobizsp2+eBB9R+4c4QaQ98E6MxaJKVEH6Y5KNGBTa/Jb+Zk68Tv04/fH40kwES
 mx4yDj8yEJR8I2P0ixkqySh19PH/uabWLRy0GjsIfdjfQvtiAf7jd6isBRrltt7leszz
 Y2VT9OGGZguz3Z3C1oOfdsUmztiYvVK16q9CQl/diye5BVImVg70Oq8HaT5IQcy/hd7B
 gfgmjv2W91r9+CvkLbwNfIiN7BWkHcNIsHKx3BVVIpOTo1fzqsXX0SC8yWL+hrtyh/Cx IQ== 
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by mx0b-00256a01.pphosted.com with ESMTP id 2s1gp8fphh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 19:26:34 -0400
Received: by mail-ot1-f70.google.com with SMTP id n63so8193855ota.2
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 16:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w0Snp5EF/ecnxnA1yKb1R9RHI5ed/m6/jINfWZ/mhl0=;
        b=KGjzVDf3V4+LCDazcNcgQtMDmnXgbg9XrL+fnNhaiRd//ierqqa6ac2rLGIsOOzp/M
         VbS53HQ3viCwCjLIKeNvXGPP7Pz7+6/qBmnLlVRzIlH4olu8kNJ5ITK/Tgf7kpr6EnCB
         1tOwhx23q8zIRIWumPEOLcV+CDaIcC1zOKqCoDwYUlvOou0e1gPOoT+d0U4GsL2uMnqZ
         0y2XtunYExLW+xIGbyTH9WmZZSVxzqdIPY+U1QrhSZYRyXwYsCAFPf9pfRbtRYjIihG2
         tEmMKWstB++Hu9aHSUP60Jqfl3qLIwe9/X0HGvR3PfNGOkQ1OYYVz8F6hvrvQv5XAsnP
         PIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w0Snp5EF/ecnxnA1yKb1R9RHI5ed/m6/jINfWZ/mhl0=;
        b=M/74JyyCl9qTwul4TQIBJXeitMNQ0AKQpYDBGy3Pl4LnzbxbIsyMJDW09NEqzHscqy
         cVU1KKQgZSkzBaIll2a33kV2xI9Pnpan+k+8R6NNvfnNZOENuS4y30Rpj7mCeH99JMcJ
         cBFPyu2kOQwhwIjbrz+wgrlUlPofGt+4QOegujeQPL72vKGjB52sycGJCpdnbGkNbZtT
         cUd1yqxv/0wHkMN4ELCjP97yqW8hOo+6BWHLLQ25+c7ysYAgtZMFrumq2WczrYvCPcEy
         kl7tSRcP91BneUZWeIjmdfmPPZvqKLgOT8DkWvpm/4TsCJFuQzYtcle4NrtCFTOBAlWS
         TwYw==
X-Gm-Message-State: APjAAAWGC5IgtkW6LamqA9g2bBanVLsYbG1houcvBq/CLZeGXkva5bmW
        w7tX9Q/RjhyxoTIZZVquZmN5Vs4f4vi4XZhjbhP6wopAkeCOijmThYPPPc2T1wVXSUCoY1WM5E7
        B6bNFcLcxKwY=
X-Received: by 2002:aca:c386:: with SMTP id t128mr448156oif.116.1555975593359;
        Mon, 22 Apr 2019 16:26:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQr1p3gJMjG4uhdBUkWPrpKSrKYVvCmkLGG9oSGPP1UhV7BcI10SDCCNrH7+l3yqVnkAt8zg==
X-Received: by 2002:aca:c386:: with SMTP id t128mr448150oif.116.1555975593098;
        Mon, 22 Apr 2019 16:26:33 -0700 (PDT)
Received: from LykOS.localdomain (cpe-68-173-125-182.nyc.res.rr.com. [68.173.125.182])
        by smtp.gmail.com with ESMTPSA id k25sm6564834otj.72.2019.04.22.16.26.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Apr 2019 16:26:32 -0700 (PDT)
Date:   Mon, 22 Apr 2019 19:26:29 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.us
Subject: Re: [RFC PATCH] builtin:tag:verify_tag: allow gpg output + pretty
Message-ID: <20190422232627.3mw3rejbjp5tb7zy@LykOS.localdomain>
References: <20190412201432.11328-1-santiago@nyu.edu>
 <20190422152726.GB1633@sigill.intra.peff.net>
 <20190422154655.sxyrkee7rnywoh2w@LykOS.localdomain>
 <20190422160211.GB9680@sigill.intra.peff.net>
 <20190422230701.GD6316@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kfbaqxt6xxudyhjk"
Content-Disposition: inline
In-Reply-To: <20190422230701.GD6316@genre.crustytoothpaste.net>
X-Orig-IP: 209.85.210.70
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=7 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904220175
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kfbaqxt6xxudyhjk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 11:07:01PM +0000, brian m. carlson wrote:
> On Mon, Apr 22, 2019 at 12:02:11PM -0400, Jeff King wrote:
> > On Mon, Apr 22, 2019 at 11:46:56AM -0400, Santiago Torres Arias wrote:
> >=20
> > > I think that would be great, as we could make it simpler for verifiers
> > > to parse gpg output.
> >=20
> > Alternatively, we could make it an option to dump the --status-fd output
> > to stderr (or to a custom fd). That still leaves the caller with the
> > responsibility to parse gpg's output, but at least they're parsing the
> > machine-readable bits and not the regular human-readable stderr.
>=20
> Don't we already have that for verify-tag and verify-commit? I recall
> adding "--raw" for that very reason:
>=20
> genre ok % git verify-tag --raw v2.21.0
> [GNUPG:] NEWSIG
> [GNUPG:] KEYEXPIRED 1442879137
> [GNUPG:] KEYEXPIRED 1505842336
> [GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
> [GNUPG:] KEYEXPIRED 1442879137
> [GNUPG:] SIG_ID NZHib/GfN4TzXBhuI9ABwYXqluE 2019-02-24 1551023739
> [GNUPG:] KEYEXPIRED 1442879137
> [GNUPG:] KEYEXPIRED 1505842336
> [GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
> [GNUPG:] KEYEXPIRED 1442879137
> [GNUPG:] KEYEXPIRED 1505842336
> [GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
> [GNUPG:] EXPKEYSIG B0B5E88696AFE6CB Junio C Hamano <gitster@pobox.com>
> [GNUPG:] KEYEXPIRED 1442879137
> [GNUPG:] KEYEXPIRED 1505842336
> [GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
> [GNUPG:] KEYEXPIRED 1442879137
> [GNUPG:] KEYEXPIRED 1505842336
> [GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
> [GNUPG:] VALIDSIG E1F036B1FEE7221FC778ECEFB0B5E88696AFE6CB 2019-02-24 155=
1023739 0 4 0 1 8 00 96E07AF25771955980DAD10020D04E5A713660A7
> [GNUPG:] KEYEXPIRED 1442879137
> [GNUPG:] KEYEXPIRED 1505842336
> [GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
> [GNUPG:] KEYEXPIRED 1442879137
> [GNUPG:] KEYEXPIRED 1505842336
> [GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
> [GNUPG:] KEYEXPIRED 1442879137
> [GNUPG:] KEYEXPIRED 1505842336
> [GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
> [GNUPG:] TOFU_USER 96E07AF25771955980DAD10020D04E5A713660A7 gitster@pobox=
=2Ecom
> [GNUPG:] TOFU_STATS 2 1 0 auto 1555974073 1555974073 0 0 2 1 0
> [GNUPG:] TOFU_STATS_LONG gitster@pobox.com: Verified 1~signature in the p=
ast 0~seconds.  Encrypted%0A0 messages.
> [GNUPG:] TOFU_USER 96E07AF25771955980DAD10020D04E5A713660A7 jch@google.com
> [GNUPG:] TOFU_STATS 2 1 0 auto 1555974073 1555974073 0 0 2 1 0
> [GNUPG:] TOFU_STATS_LONG jch@google.com: Verified 1~signature in the past=
 0~seconds.  Encrypted 0%0Amessages.
> [GNUPG:] TOFU_USER 96E07AF25771955980DAD10020D04E5A713660A7 junio@pobox.c=
om
> [GNUPG:] TOFU_STATS 2 1 0 auto 1555974073 1555974073 0 0 2 1 0
> [GNUPG:] TOFU_STATS_LONG junio@pobox.com: Verified 1~signature in the pas=
t 0~seconds.  Encrypted%0A0 messages.
> [GNUPG:] VERIFICATION_COMPLIANCE_MODE 23

I think this interface only shows you raw gpg output, but not any
--format=3D specifiers that you may want. The idea would be to support
both. Or am I missing something?

Thanks,
-Santiago.

--kfbaqxt6xxudyhjk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAly+TaMACgkQRo8SLOgW
IpWJERAA1mTxqZuivN2D6/jyD5WujeYiqL/46o/lZdH1NEI/DWT30w87GryAmsNX
IKD24LgXMr0c2py6jUuDjdCx0dmb6xk9B8Jj6nwse89t65GmKFkr1UtGnQmc3wbU
XNdBPG7XGkwbvN9mAMrplUgCzlZMnUKw4X8M/Z5zzhHayVm/Tza4+m8mDVSyD9cp
uq+lfOGLdovMXf/WLHNKBgIjIaTrQT2+MeH5pb9mDNU6pfrtJNa4afs3ztxHuZ32
6ihemqY+AHHQeJHHXNPE5JMzjmkUK0q5LxeHkMCKYEYcCqjpFqox0CM3Bw33EKI5
bYVjSlx2TD66D7+smI8gOwRnGEujOAVS+Nf8IPPcgqovk6LXSC5kRKmawjKuHPTR
g7xqkvxS8f/6YCb5WCsZHcNqocAHyYHQLxKF5pd8iQhk9e4xz0X4XHfMRoxdO9x/
K/IY1s1Id95I0OADU5WmCYDP9V1CsmZEOj83N1BscMlMx0aaXnos+0oYerJAhd2w
rglG9D1FftysKEt8s3sHoJgS/ZeaH2cQFoZCza79UkaDNOvYp/THCujaQS7FdGKP
MNh93coFBQYputCHVJxJzNHGnF12/w8jN53wOFepJXyubJhvKbrn6nk7mNY6ZELm
vB3lllaQX0AauKDgepRafXe7tHcWEu8LUYNL2UMdLkgWH+SKBrw=
=trXv
-----END PGP SIGNATURE-----

--kfbaqxt6xxudyhjk--
