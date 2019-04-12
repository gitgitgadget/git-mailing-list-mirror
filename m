Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CCA520248
	for <e@80x24.org>; Fri, 12 Apr 2019 20:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfDLUQT (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 16:16:19 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:44192 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726844AbfDLUQS (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 Apr 2019 16:16:18 -0400
Received: from pps.filterd (m0094546.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3CKGD7s126282
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 16:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=ggK4Wi+OJOLGwCr01pydUqE6/Va9fFtPec1AFMiie9Y=;
 b=aPH72Xv7K48FZUCc+gNOX10+A+ATCXttH5fZJNvidpB4e4+ITaaSx2Q2ZFa4KRQ4MJv8
 O9O648kyTtAc6QQJv4IxFmGMqwKKPuuHPj2jMnBU9zF53lqANhXtMKvpO3TdngV3g7J9
 hZjOxXyTONQDzG1oSe2PDtJhH8d6t3c1gG+tzODZmEgtlUhSftPWJWWXzYYxg8zAYUlF
 sequR1KNX9CuFcCDPe/lXch1iL85PbaJ7thwPkpwiXWF7Uy4tXTu2xCjygUW8wFNTAfa
 PIGsJ9JVn+o8+klifIiOLGP7s5BVarRgwcloGNhgKzUN7RavtvmjeDPtPxryhjW7xOg8 vQ== 
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mx0b-00256a01.pphosted.com with ESMTP id 2rtreut2wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 16:16:17 -0400
Received: by mail-qk1-f197.google.com with SMTP id y64so9085801qka.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ggK4Wi+OJOLGwCr01pydUqE6/Va9fFtPec1AFMiie9Y=;
        b=YbXkBWr22M8thsx7ciJfa3DuKJTJ6XZrtKXbsW4UHLsISGhKo00TpFAArnxsVdR6Eb
         pncMpqtHXS4WU7Kr53SLLXLVxxMbIkQ9LUIA8IXx6piT8kt0Thrw5vlEIb3EBTQj3k5k
         S4LZ/ErTVrHe6piQI59Yg1gz9J0S2qNFIhvyT+ejjGja80Zaul0ZW1/n43CBdzxfUzuO
         6/i+jDREANmPCdiGZq9GQAsvTUBZTdqMiUyAayOnhaj/bks0xH/GhYVkhYv7QkraNvm8
         dx9UMt69Ux/VaWsr2WRWgVA5MQXffcYk4I6aRSbLddvyI34b9KMxe+4VNr4HdCy+NTqH
         1CpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ggK4Wi+OJOLGwCr01pydUqE6/Va9fFtPec1AFMiie9Y=;
        b=D824IadswOPyEq5YM2F5wk9Q2rsEnIOaXbzvuLufvgEUpN+38plCOl2pTRY+oBXWye
         P6ZtpMbeCuvbplVp3xq7kpsxGzoagyMrn+uQsrdiTAh1DwYdlaHgz+W8D+OiEye+/yVq
         /KInC8h9luJe0yBuzOxMAcG1QNidIqEp4Z1JQ0/fsngjAZOLNIKVC4KsQFKqPB/Anbsw
         aNNpfH34uuiVKWCiMlYfd0nqHNeq3jAvWw3ky6oUYe7iIi/S6buy9ERlHSgdyCAlLqri
         Nn2ZMdQZFA6UJMYL09ysfCu4rReHMrrm/tVzVrwnMslVlDROnu5m0ysxdvI3xHPdEdo/
         7cSg==
X-Gm-Message-State: APjAAAWQHtT+TjB1ps7/EnnzbexoRDz3p6gMFTDg1dTzGxg+rnJMZMV5
        Ws5+2kRduRulWoDSjwQOUlfoQl2guMR3M1XujMgkxUJNEz3WlcLpTpzylymaT3Ezu8R2W+2SaRK
        /sAPEECmy//k=
X-Received: by 2002:a0c:ba8b:: with SMTP id x11mr47440264qvf.196.1555100171688;
        Fri, 12 Apr 2019 13:16:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy2K44MD3BnZufWh3InpnYvxm1LnJDOZd4GhhbpabuoOhNjWcJ4u3xqXIuGC8bi/fN5A4QfwQ==
X-Received: by 2002:a0c:ba8b:: with SMTP id x11mr47440253qvf.196.1555100171566;
        Fri, 12 Apr 2019 13:16:11 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-150.natpool.nyu.edu. [216.165.95.150])
        by smtp.gmail.com with ESMTPSA id 6sm25513409qtt.8.2019.04.12.13.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 13:16:11 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:16:10 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com
Subject: Re: [RFC PATCH] builtin:tag:verify_tag: allow gpg output + pretty
Message-ID: <20190412201609.hivppg2l37b6pzze@LykOS.localdomain>
References: <20190412201432.11328-1-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3o4f4hiucj3sbjnj"
Content-Disposition: inline
In-Reply-To: <20190412201432.11328-1-santiago@nyu.edu>
X-Orig-IP: 209.85.222.197
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=731 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904120135
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3o4f4hiucj3sbjnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2019 at 04:14:32PM -0400, santiago@nyu.edu wrote:
> From: Santiago Torres <santiago@nyu.edu>
>=20
> On the git tag -v code, there is a guard to suppress gpg output if a
> pretty format is provided. The rationale for this is that the gpg output
> *and* the pretty formats together may conflict with each other. However,
> both outputs are directed to different output streams and, as such,
> they can safely coexist. Drop the guard clause and use
> GPG_VERIFY_VERBOSE regardless of the pretty format

I tried digging for the rationale for this, but I couldn't figure it
out. I noticed that the output of gpg verification is sent to stderr,
while the pretty format goes towards stdout, and they can thus be
multiplexed accordingly.

What do you guys think?

Thanks!
-Santiago.

--3o4f4hiucj3sbjnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlyw8gkACgkQRo8SLOgW
IpUgHxAA2j2yNLVhfQSlu4iOIovtBra4cdYvsHAlYCfgIuEQD5Wj0gEUcz5zdiyl
0Zd92xZ2TL0XgpAmgQSqbO8esT7NOxEj+z/EVDkCZbySiS9I2ONq289K5uzJD+tw
+7e/qQGxsKOezIyu75X5h8lOTk6dTMKhhv8OUh2GpEjzklu2Q5yEOOyY+sB2o8Ij
AVosbuXNJaHlckWxuiNvjiqPFyPCUTcXmljh+sAJ/mT7eo269h5y2dTR4BIViRHJ
/NWMEbS7LBN6hYq5ywwPY6rV1URgdjEnd1iaIu59PDRqmrG36Ek6qXew5JIPOPPc
jK+COyMxQ82j+W+3yR6z04Ou6uc/kHLO5lrxtUQp9hWMkyIIrORo7NJqjXYR9+uq
4UeMQq6XI1NySwORfSnp6ZQBJ9MQfqQ3+ac+lpKDP7Lc4vDLFjlZEBn+J2BroKzO
pwz9U47IECnNpLal2eM4chyP9V7+JTFuuykyv0pKmNAAm/g5n8ViAWqTuuOuPUXK
vKq/L6TMMAYB5bhVGy2ZhmaaxDUFtovEl4cw1lHD2ihrf8pZxsuAHPlXF4LKI2/b
E8kBDRBLfYXkuidCXe4YsWRFcPiotDYtzPHvpH8ZLKpAmz6px9/NqNrACOGR53N3
+yWQib1tOosU4Cur9e1sPj8+/p9z5okoOhcVl9moGuJsPZZN+FE=
=bxqG
-----END PGP SIGNATURE-----

--3o4f4hiucj3sbjnj--
