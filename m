Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1085BC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A9061A52
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbhKQJjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:39:49 -0500
Received: from mx0f-0020b901.pphosted.com ([67.231.155.103]:44223 "EHLO
        mx0f-0020b901.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235232AbhKQJjg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Nov 2021 04:39:36 -0500
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Nov 2021 04:39:36 EST
Received: from pps.filterd (m0196084.ppops.net [127.0.0.1])
        by mx0e-0020b901.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AH9UNJ0018050
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 09:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jpl.nasa.gov; h=from : to : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=InSight1906;
 bh=Dx4OEK0WUKscpbRLBCLID4oqu7sl45ZnvwFFqfpOBys=;
 b=nDUfwZDBYI1OCBagy3qnqZS7Y7vrZN4+sV6GEPlglFlWDYaS4VpjkxhxC7lbHveycDdN
 uMeh6zJRQ1xeNdecVlBhpk8Ay8882fcBLhsQWzj049mbIEZcPd61DQOGbyruvULZpCYv
 OQvjgc7fkslqHqsYrovOy5+VoNIGoUTZI5krbCNkOu9k//AtAom4N+O4a9sZfw3WNo2Q
 ueB0MCdzhdFeje2epSfVrVZRtABFJZU1G0hgdeb/5tq9FIyG4iU/AjcVG9iNiWPZ4FeL
 rFgGmXUIDhezTRtzjfm48lAkjHGKu/xMpb/eu51oX7Q69XQaWfEQbXuKOXINUV0R+nOQ Ww== 
Received: from mail.jpl.nasa.gov (smtp.jpl.nasa.gov [128.149.137.102])
        by mx0e-0020b901.pphosted.com with ESMTP id 3ccqdq0ukr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 09:30:57 +0000
Received: from ap-embx16-sp10.RES.AD.JPL (ap-embx16-sp10.jpl.nasa.gov [128.149.137.83])
        by smtp.jpl.nasa.gov (Sentrion-MTA-4.5.4/Sentrion-MTA-4.5.4) with ESMTPS id 1AH9UtXr016957
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128 bits) verified FAIL)
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 09:30:55 GMT
Received: from ap-embx16-sp20.RES.AD.JPL (2002:8095:8954::8095:8954) by
 ap-embx16-sp10.RES.AD.JPL (2002:8095:8953::8095:8953) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 17 Nov 2021 01:30:55 -0800
Received: from ap-embx16-sp20.RES.AD.JPL ([fe80::75fd:e59f:c074:39dd]) by
 ap-embx16-sp20.RES.AD.JPL ([fe80::75fd:e59f:c074:39dd%17]) with mapi id
 15.01.2242.012; Wed, 17 Nov 2021 01:30:55 -0800
From:   "Wallace, Brooke T (US 349D-Affiliate)" 
        <brooke.t.wallace@jpl.nasa.gov>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Config spec for git
Thread-Topic: Config spec for git
Thread-Index: AQHX25XS/wQPOjTZ6EOIcpW8MMhmRg==
Date:   Wed, 17 Nov 2021 09:30:55 +0000
Message-ID: <D5EE9939-F639-4E69-BD81-10B05EC43A8E@jpl.nasa.gov>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4436A21F1772348A9A88BCD0CE12947@ad.jpl>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Source-IP: ap-embx16-sp10.jpl.nasa.gov [128.149.137.83]
X-Source-Sender: brooke.t.wallace@jpl.nasa.gov
X-AUTH: Authorized
X-Proofpoint-GUID: c8iYl6tYU_n4uEeuSYBOIazAczIfJlgh
X-Proofpoint-ORIG-GUID: c8iYl6tYU_n4uEeuSYBOIazAczIfJlgh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-17_03:2021-11-16,2021-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=884
 malwarescore=0 bulkscore=0 clxscore=1011 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170047
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Has any one considered adding a config spec feature to Git or does Git alre=
adt have some way to support the same features?

I've been using Git for a while now for small projects but taking on a new =
larger project I've come to realize that Git does not have config specs and=
 so seems to be missing an important feature for managing large projects.

We use configuration specs to select directories from a common code base (r=
epo) and map them into different baselines to creat multiple product builds=
 with different feature sets. We used this feature in VCSs such as Clearcas=
e and Perforce. Ultimately this allows us to manage the repo in one directo=
ry structure and create product builds with a different one. For example th=
e repo has multiple directories for different products/targets, but a basel=
ine, the workspace, has only one target directory always with the same name=
 mapped to the same location. Obviously the corresponding directories in th=
e repo have different names.

Git supports the notion of submodules, but I see no way to map a submodule =
directory to a different name, remove unwanted subdirs of a submodule, or m=
ap a submodule over a subdirectory of the primary repo. Config specs also a=
llow you to specify a specific branch or version that you want to map to yo=
ur workspace independent of other directories, branches and versions.

I suppose it may be possible to achieve the same result by treating the pri=
mary repo as the configspec. But I feel like there are some features config=
 specs support that i do not have using submodules, but might need down the=
 road.

I can see that omitting, obscuring, or overwriting parts of a repo would no=
t play well with the commit id. So I imagine there could be some real compl=
ications trying to add support for the notion of a flexible config spec.

Appreciate any comments/feedback
-Brooke=
