Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7FD20248
	for <e@80x24.org>; Mon,  4 Mar 2019 20:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfCDULc (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 15:11:32 -0500
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:33042 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726308AbfCDULc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Mar 2019 15:11:32 -0500
Received: from pps.filterd (m0094546.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24KBITP082277
        for <git@vger.kernel.org>; Mon, 4 Mar 2019 15:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=0owEJlNNgVibwV3ycYR537DUMm9iYFES9VLCSWTQ754=;
 b=LhwIzsdP0vyHdL+a0nBME8YOxNqS6puIqIwIjHcC95LplKd2NrgmNOR9esJKmyJlq75h
 AIdy/98oLee98SYP2cD4zAHYlFAzClyQTK10zizTyl8wTgqB2rPc3HqvRrWkSN0EbEZi
 CtQcf57dJxeRA5aH0Y74EToukLy/fdDBqpQxX/MGm8ISgWSIZWGSBPYgmZOWS2Ee/H3G
 nlDpc4IqAneZO28OctO1FAzUkjKqAHIJ/u1LNEvLUu4/U9BOtvjTpLTItbLRQOtNO6ZU
 Tf2DvQVfgQHBqryodY+WKosYrE7VKkyBaeJ25dQmbZVu3lL95ov70bGtiHpOtsNj9gPv TA== 
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by mx0b-00256a01.pphosted.com with ESMTP id 2r145m7ne2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 15:11:25 -0500
Received: by mail-oi1-f197.google.com with SMTP id h127so3638986oib.20
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 12:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0owEJlNNgVibwV3ycYR537DUMm9iYFES9VLCSWTQ754=;
        b=wy2hPR6QHsaGgtT+ohpvsAAjzaPW/Dlgcqmo/MAf+iUgOyU2h4HjXD9rQqCI+3ssq6
         BTGZD+3gl4K2A6JUzkLwgR+lnnzujjSN+4vu5kYkNJLSgr7o1cjF9NVApKP9qzH/LAuU
         gGF31Xukjqoq0JNIvtodEo9ubnaTj8g8C0P79NiUw5LQjDvJ9w/ms5tPVfC5Wa9IzcEO
         60Yw+7bIKMOVsnfgig1OAj7C/witPvG/z2kk9jA9I3JtRItgNE+OH2LvftUgNG2WfVCt
         vVevWL2bv3t7t3k/eIp69LQA2n9IHLiEqvLe8kYkqaZhfJ5aJ9Aw+oFItDDsd7fhVihZ
         8KcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0owEJlNNgVibwV3ycYR537DUMm9iYFES9VLCSWTQ754=;
        b=YkB81ZRjhsuVZN/qdpLz8aJDGSEmD8N48r+OwJqq6Bmll3WvkvwPiYqQVaDYdotVJI
         9xIRBhW7BVop/jcU437oXqiWmb0FP5vlGvuF2KbkSFWmebnZaOtiOm60xxJPIekxQg0p
         4f08ReA5ssUaZ2+eZ5teiDzLL7TusfWSbX8Hcp8DQSGDRBgb6oIDeSdJwLET2hHau/Yb
         60paHOzpSFjcWGCD7UoXd9cyCdnMc2mYzG3FA1ucm0RCgc1GbexuxvQlM3wfklQfqGFa
         oKruNfwn13Tx/vTzPK62BbNZhk768Q6CrWoTep/e3Vl8ZmLcZa2O11Hx9hJU7IGE7TRh
         22qw==
X-Gm-Message-State: AHQUAuYP3y5L408QnpJCEHEbyVjPRnL9xCK7a8PLdFcPi6lm3pn0ga8r
        xi+f+IasCbxwxAFZZN4LhcVqRebXvGt6NHh0LXTap2tvNYZBN38Lwj0jzLHPfq/ni3Dtfi3sfj3
        AJSOgmJ77aAY=
X-Received: by 2002:aca:b7c4:: with SMTP id h187mr13591181oif.112.1551730215965;
        Mon, 04 Mar 2019 12:10:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXqTnnx5fQAV+Ix1hlrzGk92sVZqzyTzrIzV6IOQ09YD9GysuSu9w0nQh3neLqUNghafRxtQ==
X-Received: by 2002:aca:b7c4:: with SMTP id h187mr13591165oif.112.1551730215636;
        Mon, 04 Mar 2019 12:10:15 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-141.natpool.nyu.edu. [216.165.95.141])
        by smtp.gmail.com with ESMTPSA id q6sm2746208oia.4.2019.03.04.12.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 12:10:13 -0800 (PST)
Date:   Mon, 4 Mar 2019 15:10:12 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Fabio Aiuto <polinice83@libero.it>
Cc:     git@vger.kernel.org
Subject: Re: Can't build first git commit
Message-ID: <20190304201011.j7dopqp6ug66ccum@LykOS.localdomain>
References: <1551729517.4092.1.camel@libero.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oe5igo65jx3ujrfb"
Content-Disposition: inline
In-Reply-To: <1551729517.4092.1.camel@libero.it>
X-Orig-IP: 209.85.167.197
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=7 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040143
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oe5igo65jx3ujrfb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This commit is about 14 years old:

    Date:   Thu Apr 7 15:13:13 2005 -0700

Unless you have a toolchain from around that time, I'd be very surprised
if things build. Notably, there you're having an issue with the symbols
that lssl is exposing (I suspect you're not even using the openssl 1.0.0
series anymore.

Thanks,
-Santiago.

On Mon, Mar 04, 2019 at 08:58:37PM +0100, Fabio Aiuto wrote:
> Hi to all,
>=20
> I'm trying to build first commit of git made by Linus. I mean the one
> named e83c5163316f89bfbde7d9ab23... (I think this is enough).
> But at building stage i have the following error:
>=20
> make all=A0
> gcc -g -o update-cache update-cache.o read-cache.o -lssl
> /usr/bin/ld: update-cache.o: undefined reference to symbol
> 'SHA1_Update@@OPENSSL_1_1_0'
> //usr/lib/i386-linux-gnu/libcrypto.so.1.1: error adding symbols: DSO
> missing from command line
> collect2: error: ld returned 1 exit status
> make: *** [update-cache] Errore 1
> Makefile:16: set di istruzioni per l'obiettivo "update-cache" non
> riuscito
>=20
> I run a debian stretch on my machine. Could anyone help me?
> Thanks in advance.
> Fabio.
>=20

--oe5igo65jx3ujrfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlx9hiMACgkQRo8SLOgW
IpXPKg/6Axf4NbvRXczbYrYNJCn39eESHGKRPHme26tgKRGYQsTN+JFdyTzsxBlB
TmRhP8H2W+mxWoVh0Qi2xYgQ9Bjpz2KPMz6Aar5204rVWlecA2zqoQLkuJGpAc+u
iPYk3Op6jFUstCuNiW/1HqsICCscSc7IemWEfClYUGzeTQL3Wc1oGTLph51FFR37
veXRg5d4NvgCyXHXNAdohkkspnq9SGB1u7KiNd7vhsfK5quBlbX0lBc9NKmcCBzI
SVJPddC6fIyXuecSQ5Z9/QTLEvkMqLn48IoiBtFNnIGpYmFqt9KisL+VeDgX26yd
3RAz4ytbr8LYmh0Qnc0W93j9RZfCYeFANocb/9PEa/TaUy6Yz+MVhSIv+8/ByePD
1V4YnEkkGG8AAfMT20FaEnydC/JI8cPYVFy2R8c0rJkcvSwB7P8YH1vXOG20y0pj
AqC1oQEgGAobxTow29LmHit1ntnm85AU5JQjEpNYQvtvGUEPwfd5I6lC3UkHSVOH
FMDjaagwUSTjs+d0NA1tYech3rr5PlOnBAqKFpThNZ7fS9m+/y4nU3paPLIm0F29
7kV+h23KEgfnkjJDQXdBEHTNXBgdBV40erhyE1asUguQVmam3QDflYjl3AX8immW
Y31oKywczUqL6J0R+n3bUype59VWKraXp1Mvn34ztcdaTn+lesg=
=ir2m
-----END PGP SIGNATURE-----

--oe5igo65jx3ujrfb--
