Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB551F461
	for <e@80x24.org>; Mon, 26 Aug 2019 20:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbfHZUI0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 16:08:26 -0400
Received: from mx0b-0016e101.pphosted.com ([148.163.141.31]:10410 "EHLO
        mx0b-0016e101.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731657AbfHZUI0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Aug 2019 16:08:26 -0400
Received: from pps.filterd (m0151358.ppops.net [127.0.0.1])
        by mx0b-0016e101.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7QK8CQg016203
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 13:08:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucsd.edu; h=from : content-type :
 content-transfer-encoding : mime-version : subject : date : in-reply-to :
 cc : references : message-id; s=campus;
 bh=tqfE68vGFky5E+D0gy4J9ynjoAXWJkQomKIAMnpB0KQ=;
 b=SwOl+gTkyiPESrJvpVy8mYf95lecXWQpqVFQt4ChrlyhFZDXmxLWUyvaSkZCk6vIrgHE
 IHFbl48GthM1S+OQzkc0V38QGQYDU9Pxs53wgN8CtB8a3CNRmTK50VXo0GKQ+fsYT61Q
 u7QYXj3OaOpuz5Tbijm+X4M+ODcOfb9ExMf46GHKHpScwXgHFP2FKuCryjRpT507GjTx
 4zihfGnXpC0T7NBKvrd75k2YbSOw+GOnd9HleC3YDkoY3AC9+Lr0CDZCQvUl6lnNFugw
 3ouM4XFG+JOlim6BY8QbSNWs+QEKIX/UjLpt6PG+mPHyf7VaIaeBKZtvW5vjcGZlLjZ8 EA== 
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by mx0b-0016e101.pphosted.com with ESMTP id 2uk3fcxk67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 13:08:24 -0700
Received: by mail-pl1-f199.google.com with SMTP id v4so10594588plp.23
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsd-edu.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:date
         :in-reply-to:cc:references:message-id;
        bh=tqfE68vGFky5E+D0gy4J9ynjoAXWJkQomKIAMnpB0KQ=;
        b=XOBjE/JksyapRg99rZk1DaqAonCZuwhVBuZjd3EXrYaxQhxRoX55Wh3EX/L2JaLHB/
         SguPcee2xPqc8pDVTFREhsjjxyY6goQL4+mPIi58dEZe7UO55yavxr4iHh1zzi+f6zlr
         vm9ey6wFK+OknHDJ2t2pJ0Al+Jnea3xxj0a7OujUUDNIiloyrxkbiE5XPBulsDFiz3ta
         PkJQ2ljNFm+hM/KV6yJFom5ljTQpHnG/y1K5fhQ4O9Zn2GEon4XTz46dX1DOC4obTLEy
         8x0mQiiW8ONvG3N0G78O8+SDArL/qIchRGz9CENAkeTHdMB1wvIS04UDcEen+UEs3xWZ
         Sn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:in-reply-to:cc:references:message-id;
        bh=tqfE68vGFky5E+D0gy4J9ynjoAXWJkQomKIAMnpB0KQ=;
        b=EMD5tTRtK8nJP+k5Pij0LL5TNLL36aItnxfUqp8KsN2sPhmWd8umAjXGTfXcfgN7JN
         Ksq3MbcTD11gKVIYmue4LaoWvvicPfFsACN+j5r9YECgfK3aSR+4NIdSi0EeF4S53kGi
         1JohEtyVyiuG7I4clSvCdZy18z2N2X097BOCZztqSIqPly/+TzQVXkoafWDZX72rALkt
         V8AMkY5YdyaqFp26zh69XLUPoBlVVBRGhTnKdKHmAM7Rlowl/IzKc60bYIL1i+TRZQvU
         ce+RqnbyuydEF7Z204A9v03kURUkuCCiq9I7APn0q6aTRs0DoLuRcXt6/FoliC+RpuhC
         8ZFg==
X-Gm-Message-State: APjAAAUr41Ve6JgUll9x3Ev2bHFz6EHxaFbcKTfZQypZucnyqCoUrWQr
        mRIS9RkqF+QLQSz7ZLDUART0U6eFaCkGstuTfdy2o0Xy8Jhd2XTEI2V0csXuwrE+4DdUaWhyypT
        8ggpMj+yRPv4=
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr20362406plb.93.1566850098132;
        Mon, 26 Aug 2019 13:08:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwftElluWw8B2Vs/ZglWbLNAdlL8Thfm5GORFlyiEh8EUIzcS+JXG7oC/tk+y7M66MbzEe2Dw==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr20362388plb.93.1566850097928;
        Mon, 26 Aug 2019 13:08:17 -0700 (PDT)
Received: from ?IPv6:2601:646:c101:8c30:b92c:823a:6706:8ac1? ([2601:646:c101:8c30:b92c:823a:6706:8ac1])
        by smtp.gmail.com with ESMTPSA id q22sm14659756pgh.49.2019.08.26.13.08.17
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 13:08:17 -0700 (PDT)
From:   Andrey Portnoy <aportnoy@ucsd.edu>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/1] banned.h: fix vsprintf warning
Date:   Mon, 26 Aug 2019 13:08:16 -0700
In-Reply-To: <20190826183317.GB23399@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
References: <pull.322.git.gitgitgadget@gmail.com>
 <xmqqwoezj3o5.fsf@gitster-ct.c.googlers.com>
 <20190826183317.GB23399@sigill.intra.peff.net>
Message-Id: <0766F8E0-9A36-4304-A99D-35CC65063F3A@ucsd.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-campus_gsuite: gsuite_33445511
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_08:2019-08-26,2019-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=922 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908260189
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Aug 26, 2019, at 11:33 AM, Jeff King <peff@peff.net> wrote:
>=20
> On Mon, Aug 26, 2019 at 09:24:10AM -0700, Junio C Hamano wrote:
>=20
>> "Andrey Portnoy via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>=20
>>> Previously sprintf was the argument to the BANNED macro, where =
vsprintf is
>>> expected.
>>=20
>> Good eyes.  Thanks.
>=20
> There's an identical patch in:
>=20
> =
https://public-inbox.org/git/cab687db8315dd4245e1703402a8c76218ee1115.1566=
762128.git.me@ttaylorr.com/
>=20
> and both were inspired by:
>=20
> https://news.ycombinator.com/item?id=3D20793298
Nope, mine was not =E2=80=9Cinspired by=E2=80=9D that comment, noticed =
the bug myself. I did look at this header because it was posted on HN, =
though.
>=20
> whose author has little info there, but I think is separate from =
either
> submitter.
>=20
> I don't know if we want to try to spread credit around via trailers.
> "Racily-implemented-by:" ? :)
>=20
> Anyway, the original bug is mine and the patch is obviously correct.
>=20
> -Peff
>=20

