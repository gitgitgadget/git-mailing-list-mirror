Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0502EC4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 21:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiLAVnc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 1 Dec 2022 16:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiLAVnb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 16:43:31 -0500
X-Greylist: delayed 3725 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Dec 2022 13:43:30 PST
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com [67.231.157.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEC5BE4EA
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 13:43:30 -0800 (PST)
Received: from pps.filterd (m0048300.ppops.net [127.0.0.1])
        by m0048300.ppops.net-00176a03. (8.17.1.19/8.17.1.19) with ESMTP id 2B1HPN53002827
        for <git@vger.kernel.org>; Thu, 1 Dec 2022 15:41:24 -0500
From:   "Grochowalski, Matthew (GE Aerospace, US)" 
        <MatthewS.Grochowalski@ge.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: BUG: git log --follow always follows copies as well as renames
Thread-Topic: BUG: git log --follow always follows copies as well as renames
Thread-Index: AdkFxHbC536pGTtGRACk1slmrc6XEg==
Date:   Thu, 1 Dec 2022 20:41:22 +0000
Message-ID: <604700f9e2e74d0db047a47c0b58ce8a@ge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 22ABCDE81E573BA47066CAC5C02F22F8032421A001F10ED0BF1EA87C364B1493
  04CFC6BeJzVWF1z2lYQ7U9h9K5aEkKIjpWZVUIEadJEbqkthhd9Icz3RAIFfn139
  15Kk1oVmcQo3QeufFl7zrnn7N6Vb1dpEb64DYvWeuUo0SY5/Fx8KpTW1lHiXya7P
  P2YTwxd0yxLs+xJuN0mYRFOPm7C1eM6m2i9xDZ7kaW2jaStmqGpqXYnTVUrss0oN
  HppuxNNVnmW04fa1Y2oY8UJPkS2qutpokapFapT07Ta3cTsTWN9Eq5StUjzYiKz0
  //KPuPNj45idrtKq3AUvd3WTVPT7I7eMwxLtztKa+Yo2as/Ruvt8P2H7r07nC7f3
  n8o5sn+z34HNEdpPSaOorSipaNouGzwryit+BFPATD6d4ORfvf73ej1by+zEcCvw
  /cA7puFPTx+8h/GkMDovv3WKAebRHPvongfQTrTHqAqBvx5eJVVJfQBfHDpabkLb
  uZffv3GxA93Dd4IHkp3Dp4NUeauwFvAGNwleCZCcrfg9SECd0prkomfxT7n434AU
  enuYeDD2HcP8Jr3S/D8SujfJ/rnR3kGa1q9mHAgrneEa0f4Qt9dEE/EpRG/wHdzw
  ol5c1oT3z0+M9jL4nxkL+WS0ue4RD0QZ0DnjLqMWQc+7x2dO/KbgVeSjjvyxbgR8
  E+Ge34ciuVrfYd8UMc25ceVXr9m1Pkuo5X1QB4b8mFAdSH48r7gNSTd1pSPecfr1
  c0TUeO7kHVhPTTCGxAPxP+POithsEB9SLeY8rVG+dT7bkMr9wGqHyAf9gn/uc7Qd
  ynrtqBz2FAe/t6ReEa++8i+5b5oQgzYX549vsl3GusDgl/M/KieiPe5Dsfy+6vpV
  u+7k59ywn9B/0NfBuJnsc/5uL9ivegcuI88m24X+E76CfGm/iX37oh4T1mv8jujv
  SjqfXfqY4i3c8m922BfEFHjO8S3l/7QwRsSry3x+gH8VRV1vttJn5XkoyBDHbyF8
  NV1cX5F1PjuNBf8n+aiGt+hDtiX46f6xEXzbAN1Vee7kuaESK6Ie0m68L2E/Ry/3
  0rd9pz3RV01ExW++2wOlXoA4X1H9+mUdEh4XxP37I8UFb47+e303oZ1lPMcVIp5F
  HUw2Jc0FyFPvJcOsm9wnxvL+ykF8h3naVdiVOU7xpFQPaGf0F9cJ3Ep5gh+X0UdE
  eeM9EtkXxf3WNN9sNp3Md9HPr2nzuUcOud5KPubp5gjfLeQ/px/9p4Loq6Ca1+51
  b47yHlTlzpwPaU8V5/qi/v4UfbBXaM8zlHtO9HnFny/luL9B9cOzQ+n+kIf6qwni
  Pv3tN8sr2/ynUF8sQ/upG4z4hv6gl9C82AT/P7lO3CUmxe3N/yPyp/+AriztVI=
x-originating-ip: [3.159.19.214]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: p5E0ZIs6EetC8Dhy9Bn91KkMin0qy-iq
X-Proofpoint-GUID: p5E0ZIs6EetC8Dhy9Bn91KkMin0qy-iq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_14,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 mlxlogscore=488 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212010159
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Encountered on git 2.38.1.143.g1fc3c0ad40

Run git log --follow -M100% --no-find-copies --name-status path/to/renamed/file

The log follows copies despite being explicitly told not to.

This apparently goes back to at least 2017; see https://stackoverflow.com/questions/44083806/how-to-prevent-git-log-follow-from-following-copies-but-only-follow-renames

--Matt Grochowalski
