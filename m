Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E5852037F
	for <e@80x24.org>; Mon, 22 Apr 2019 14:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfDVOwn (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 10:52:43 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:38118 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726132AbfDVOwm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Apr 2019 10:52:42 -0400
Received: from pps.filterd (m0142701.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3MEqf4w193434
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 10:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=FfdN6Pc2OADMKf5WFiiioETfnhx10gRdpFzL4YVmqdE=;
 b=wBw0QFbmeuYlrhxiFPv+WMNLwegmoHmbXQf5/xc5VX3UR8tE+KSXxYzSP4VgylFaRxG6
 rDjtJ0y5vC/RIpkO8mwFGmz3fBUpditfRGZJw/gY9/EFjyCxduQR12g01+6yD+6XObjF
 3O59vO6pmNEFk4DUrHIs4gZ+pNxkn4Ns7dLzUZttRLRr3rxiEVNU75WwxGGCsGxp7B+v
 9gFt4LWDrXl/FrsYRowreAn/lLUe2i9botMFfbPUZs2ssfGa/d0zix7BxWaZHurfmXdh
 zmvN8RTKQ8YkAnjMaHzyMEsWch7qHH9bCX64SokjfGRHORNs7fdE+ygaQmByna/QiDS/ zw== 
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by mx0b-00256a01.pphosted.com with ESMTP id 2s0h06amy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 10:52:41 -0400
Received: by mail-ot1-f72.google.com with SMTP id c26so7502325otr.23
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FfdN6Pc2OADMKf5WFiiioETfnhx10gRdpFzL4YVmqdE=;
        b=CmYdI59FmQFaraxsGK/yzdUXhTgvljKBlyaRk88NiZcPKMWqUTNDzFcy5M1tOUe4I6
         HV8q/F+WoThK4rT1BljT3E2iynUiAJSxdiq164e5H1cpb9qNQuC56D2uT9TYeIExcS2c
         bjBj81VbpQ0sKQZ00fgkW6JyRj1BGKsxdE5hN0gSN80Ca62S8rEac9FTzOYgv9DgszMX
         KHOni53N/omJWPIWeOdwF2zqjHniFkhD0rUP3tBU34PkvPbfV3/R7GIwhRpG1bejCnWc
         HG8ajbkCCp9TPaxFG2TPQoYUYaiI7/YIoqEvJINReCJhZnsBhyFnh+GxltlnY3YEvVvG
         LsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FfdN6Pc2OADMKf5WFiiioETfnhx10gRdpFzL4YVmqdE=;
        b=D2s9k9EPbzJyG0TvJgV/gCJ88tMplnbsfcAt4jCtuYxVOzCCfd0hiUN0ouKwFm8Vlb
         43OTH7pG1lVvDQsxCwJ1TVnz3GoKIYOQBXSW3QFystgKFMeUVnjMjcemraBsLHYW+msK
         nljwfhp3D9vmoDJzl3mDWSSAl2Ye+XT1oypmvX34cIIWWq8pk6hQuVgcU2ZiTQ0GRxbS
         ro5lO4hw6RJTmqIxpi8P2OkiZR5yrmb7M8g7K6L+QfMux8vbbb/hb4v8KpksQF+xFeRD
         G9WllqFc6CQDIcozW6DO4ZwYgLcqaIcowXEN4aJndOPyzCtUVzPvPHPYIxvKF8IPJBwt
         Sa1w==
X-Gm-Message-State: APjAAAW3F9eP18Th3x0+ed3WeD7faQ2shximnVkOJVxTLSFr1T9s0XU3
        v2/VYKcDL2K2isaFzHvgwepZ3Ec/2sn2oSUbRehISoINa9ohpZmoSX8tvoKx6PnqmL6OU8xGE5O
        bbqwiOSd+fME=
X-Received: by 2002:aca:af56:: with SMTP id y83mr10327932oie.17.1555944760201;
        Mon, 22 Apr 2019 07:52:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWFEgk5jgbhXjB60chC/mnFxyAF+rX/uCjwH5x2z5CehBcctzyXTzgMiYCr0iAvYLNfvwwGg==
X-Received: by 2002:aca:af56:: with SMTP id y83mr10327924oie.17.1555944760000;
        Mon, 22 Apr 2019 07:52:40 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-140.natpool.nyu.edu. [216.165.95.140])
        by smtp.gmail.com with ESMTPSA id s124sm5742011oia.24.2019.04.22.07.52.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Apr 2019 07:52:39 -0700 (PDT)
Date:   Mon, 22 Apr 2019 10:52:38 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #04; Mon, 22)
Message-ID: <20190422145237.v5xjelebyjxb3uko@LykOS.localdomain>
References: <xmqqd0le8t9l.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lu7pcvene4aylaht"
Content-Disposition: inline
In-Reply-To: <xmqqd0le8t9l.fsf@gitster-ct.c.googlers.com>
X-Orig-IP: 209.85.210.72
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=957 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904220113
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lu7pcvene4aylaht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 03:10:30PM +0900, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>=20
> You can find the changes described here in the integration branches
> of the repositories listed at

Hi,

This is the second what's cooking that's gone by without mention of the
RFC patch regarding verify_tag[1]. Is this due to lack of interest or is
this an error on my side (f.e., did I forget to send something?).

Thanks!
-Santiago

[1] https://public-inbox.org/git/20190412201609.hivppg2l37b6pzze@LykOS.loca=
ldomain/

--lu7pcvene4aylaht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAly91TUACgkQRo8SLOgW
IpUxjw/+Pi0bQRgyWb7RNWXlVLYmRI2xVGk97nb4RMAkRnXiBWJKcC24eyy5KxxB
mCLPzjMLJbXx4WvdwFxEXSF5EmUhxPRHYDD8ESh6N0lKiu+RFgdzr1DnH5kzt6Mx
6MuXjn8KUcVZ/dmM2z5Uw7G0qx6V+R0BJpeuQCemOoorF6meuGiPwPpSS+uC7sJx
Dyldni9rbUNsMSzxSwv0Ap1fWmcx38lxIk9V7lvu1QpUUuzmfoWdeypIoQoJYirT
D4K7etTN+nTymacFL5wFVBUPwSt+yeR9EaFTqAnhCFpjEUn+o5RzpImZWSN4ejLT
dXD+K35huvbitK1EqwVOUcIas53yu7Q9AY9/J6YLyjlOD8MxHch1kN4TAiZAU0Ic
qWFbHBNzcKDddCdwSW99iSjsTWiPJAxFScFhgK53+3saTYzivlrQt4mAG/rDnpNS
aZKodztEG7v+GWuDCPOHi2Bxcqr7OX5yjhy5JLD8LHShyRYKyWd3GxOAjHsZg+Gq
qqGUPTbn2sqSqRW+c3KNr2DEtDm8PtpjS/SkejIdwcD5ZvGzD47z5dK4+zYfsFtt
I6l2KNh1eDk5/bJlOvDW0u5e3O+OhNizjvC201tIX95mxLhC03vYxRNvuEwletJG
1itT/49yROax3uH8Mx7BwXkdrzhG2h/oTewhaTM21JWqakY98ms=
=+qdp
-----END PGP SIGNATURE-----

--lu7pcvene4aylaht--
