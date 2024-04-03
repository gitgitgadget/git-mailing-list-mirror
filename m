Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2020.outbound.protection.outlook.com [40.92.73.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE956136674
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.73.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139114; cv=fail; b=e1DbiBC533Oz0Rfu3YYkZGujTc1JQmrTf+BBDPqwgg9lUvzWj9MPHm6j4ErzuH9HQ80i+yv3KaHSFK+2dnENXzdA31UmKf5pCVcRmpl8Us1sv8SRjL05apoElF9xnTf88MnG+QmKBJWjkBzKPvVE4KbgLZsKPwHKiaVvHzRx/Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139114; c=relaxed/simple;
	bh=3c3KXUiNaIZg32jlSnAY2X8DPoTBkmH0+5K85+GhXe8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=cGiLzgXjurWeLjJ5/Xe3wykty97V5Y5HqwlYK12bj52R7UGdgMj0jTc2+HhdifvCNBt5QXo+AxJJcskb1haDUazgIIh5gIlbF1x/SOO2gx/jD1/IPYJsuuxtfcj6aPmWfEA/PRy2yhQR7mMaT5e/sZAJwwhVCJVQkI16MTdoVNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de; spf=pass smtp.mailfrom=live.de; dkim=fail (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b=TyRTfiqc reason="signature verification failed"; arc=fail smtp.client-ip=40.92.73.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b="TyRTfiqc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+PnaKOrxvc3uowtZl52AbrCtY7ZgMWdiYNJE/VaySbq0i+5tZ2eMRZoM7dNpDpOeA9f/NyxTk0k3nRMxgx6vun+WSmtYv2QYDxHz3nFQs6U08rKgoZT2u4TdMuto18AF2gM/nitTUyd5t40Ws+Q95pFQujvQI2WO8IbOgvMbh2+Bj+zB6QeqaIAEvjJwVBsJLtnfr3Eqfw/R4YnyismUFNpR/3q7PpXUbqsUxBJgxpVUEIY+10GHauTmBD2FmbjLpWdsab5m9c8yaXVbU1TY2tIswGMp5h5SbUFzvUcp7IWz4sXZTuTS35fmQO2oo7lRL6tGrSOu6q8xqlm20C3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84d++V302H6+bni7p732MJqFhVIgVBsX+4q26wWhXxc=;
 b=abgMQ3qXqfFHlrWE16YX2cH8S8o26I3tlrOsrrb1Mu+P7/C3I8ilMgQr2UZVx/XJ8MBO9xA349iigwk0ov+ohKOXDaThqfGlFe/XacHmqbah59I7RXxpET20WunI8zb3GEeE4bFfiw3mhSKWnxx3l0HvPabMduR7C933JXy94zEZSYq2msC1KknOVul+hk+FBf8W6SCJYe0KACeTT5DPaIdvNgC6OBUgMhjq/3KXCrsxtubqMr20SrZSALagWjNXh3SoJOiN9mNoFLD9vI8/oZ1tZ+K/TYnirtNqEvUS9mWBet/MVFcuraiPdt5L9UNyB1/gFnF794QXbvkHbcvxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.DE; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84d++V302H6+bni7p732MJqFhVIgVBsX+4q26wWhXxc=;
 b=TyRTfiqc/jjSINr9UzLHKK0fz7b8xiAGkHiPddE4MAsa0UiZjJBrRfafwEjixwl0waMNetau863tB/joW2Uc9qVsL/wCVDW6ECLnhxNWNyC/I/3hFKEXBBJNrES3B0JqcypenacFPUa5PRk/bz00F7uAbY38TUGy/FmZUIeLuHIfUni1IGAYjyfQKuowr39IJuNntAWQfJ7LifrBj+Lw1eoicgbTHJ3bxDrheYJvvLzdxdq0a/xXBDBwmqKqtgEdWGC6/5xjWIeuRGVmIwST12U2dniELAwWLU3is4v8qhkZJp2JzJtFZya/H4q8wCxXwBzlkgNMLLDTpdfQRDZ7aQ==
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by PA2P250MB1069.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:40d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 10:11:49 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9eb9:f756:55ee:f036]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9eb9:f756:55ee:f036%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 10:11:49 +0000
Date: Wed, 3 Apr 2024 12:11:47 +0200 (CEST)
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
    Junio C Hamano <gitster@pobox.com>, 
    Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
    Jonathan Tan <jonathantanmy@google.com>, 
    Emily Shaffer <nasamuffin@google.com>, 
    Matthieu MOY <matthieu.moy@univ-lyon1.fr>, Linus Arver <linusa@google.com>
Subject: [RFC] git-contacts: exclude list (was: Re: [PATCH] docs: recommend
 using contrib/contacts/git-contacts)
In-Reply-To: <35192e61-c442-6719-caf0-1019bf3e44c9@live.de>
Message-ID:
 <DB9P250MB06923CE0F60A117A5CA5B028A53D2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com> <35192e61-c442-6719-caf0-1019bf3e44c9@live.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
X-TMN: [2PuD+jyY1MX8Py1vTWFZiWVIZJ0ds1Ad]
X-ClientProxiedBy: FR4P281CA0274.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::18) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <89bc63fd-ad25-77d3-0475-30c4ec603670@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|PA2P250MB1069:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbc5fdf-eaa8-41e1-218c-08dc53c67986
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EyvR2MJ7uuKVSqavtITf96DnJkwzqc4/h843utcAl//+ixsl0l1cSlzGI8JkVbElVMRvplotXfSqXvVjxw35WgMZsmwXt9dLFgE/uLH5UWAeLRCzGqfc/tXAzr0xqex3pnsYrpx74jUzWwQfk6tpcdR86vqBA/ugnNnrdDbUJkcmuO5RjbRMuFsfMHuJxPx/bah2yXEOKOQGFl0fAPMsz1wKnaX9t0ZJ27g6BiVzFE1K/dNnpNuQn/Fc6s9ygavzTSrge239iBhAVXXDa4JWbI4kM7sLemHeB8WVEPLrjnhpIuc2xjtb2/Pj7zFbN7fT+nGIa9sGakOfNWDz5PZQQRJh+Nr6FK+CH3f1e41WSNeI3+rukXMUyQWL2WstzMN1GQrJ2ZT62/uT+Buy8tr+aO8NIG2GK/8SvMn81cTHBK0E+QlsSMFgC28qNtsvGPdD150VXxcxYYd3YQYq0QXZ7ziboAZ6uAgkBcnc+zqGUXXGpu0q4hz4fMPfymwx3l2ER+rV1p3Qzrebmfon5Lc+jG4mumpRtaOGzBl+SvhQ4AIMSLsh4YZasArl2WZ2vFjqjZobkp4qDi1F0SPwF8xOdGfqpvb9Two250s136Jh9wH2D28q2Sjx+35MvjlboyIW5C6MRwAeY6DDeAvgI8+fl1MSEetoGT/xW93CPKbUt//nm6u7LClBgZ0LxSR2BYBHOZpGu0lfnq94xgDH+eb/hw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-15?Q?DH8FMaR6jRMKUBVgJZUHJ9YnWG9JWLKeBkZqvHQdv+YnI6prIUIo7W0oo?=
 =?iso-8859-15?Q?R9iMOVxYO9Iqg9hLgZh7cujj/+4S+VGQeyyO8jmEkqvjTeEIItp3BVQCZ?=
 =?iso-8859-15?Q?h8mRqgj3Rc8Yi1rdfGyOw5RTBUFr2Hi99SwiUO3/DqMoQbd8UVPOZjPwl?=
 =?iso-8859-15?Q?U6afzr8GuXxazsEBnkhOq81L32BaeAc79bzcAgJavXNcrHTiOzsupL64Q?=
 =?iso-8859-15?Q?92sZrR8vSJpR289PSGqrB98Z5So3ppyUfW2UUq1FsXvOLBAjkiWmW/J4K?=
 =?iso-8859-15?Q?TyfhcqOFtcThY6c2c/5mLo6s3ON8POGdDcbAb8V/LvnHupIeshGMilFB0?=
 =?iso-8859-15?Q?Wst/bXH9+xWF/69MGJOXD3yQYRdio4N1oQ3v6m4qrFHKpcXxM+B40Q9BH?=
 =?iso-8859-15?Q?gF3r8Lx2f8v+MnZNiXWSxRNPG1839QQIdvmxfmA3jgyLoYE/OJTaQVnDK?=
 =?iso-8859-15?Q?RrBI4Dob6V2VyYT1SY1Eqm+KxIx6pnSAZyBvUMoLrzC41lhzzTJeIh/hU?=
 =?iso-8859-15?Q?w9lUVVvjJXNmPoUn9xIVrw9XFovl05lHxWbIoGgtiQD0aELgu9x/dJNKp?=
 =?iso-8859-15?Q?2KHA+MPp4GBDwu48X+pVTh82K0ZHJZ2DZSwL5aS4SmL/beOcLl+tJVAiW?=
 =?iso-8859-15?Q?CoIiOIxQxyzhVZ0WDW7GKBvb3hvg4wv4sw0Mw7bOxMsVyNC1/ihFQOTpc?=
 =?iso-8859-15?Q?1Js679Xh4G8yPe9T0ptbKcO6d0h3bMtXR/oWsqKiMQMCY5wgikPV2ijtJ?=
 =?iso-8859-15?Q?r/hWbIK2Aqf3DvVZsIbNMfkhcMYcF0eds7fJYtDci+ZpHdusVoS+3668s?=
 =?iso-8859-15?Q?bN9nqwQLC40DWiAUMDHC+yNGrQg05QSigbvahFOix4r2fyT7KJSDHur0n?=
 =?iso-8859-15?Q?ym2gNGdttIX/93yh2jOUYd4paI6LaFsiUosOcroHWQcfkD7+icz/kuhFX?=
 =?iso-8859-15?Q?REjeeSlW8eLshxxRPbCbbYL/3iZ74YvJBD0moVyMTLnq6c8kfcdejsguO?=
 =?iso-8859-15?Q?0uf+u6r8CEO9CgYJhY+xl1ZFrdVuARo54cdO6oYinW8Y42m4L0ZYq9olk?=
 =?iso-8859-15?Q?xGCYeG0d3VBTbZlgFJZl5Xe1Ku6eKqp9tnVfSaQnd6YQREB5/xJNcSGmY?=
 =?iso-8859-15?Q?eqpLONjsOVNkqXXLC1xgjcR3bpdwXIBFre3Ayht/dQsf4rfDf7PPF9PJa?=
 =?iso-8859-15?Q?tbQZP4/ZTWdCz1onnJIRJFb4Bf5MW4ruzCOG/Qx/iIHanrFhN/B2LgkOO?=
 =?iso-8859-15?Q?Xufg2WKbSCESynD9EkIUdzQ5Lkgms8U9eqShm4jOHkxHZ4upL+CDCGWR4?=
 =?iso-8859-15?Q?Wr/jE=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-0fa01.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbc5fdf-eaa8-41e1-218c-08dc53c67986
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 10:11:49.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P250MB1069



On Wed, 3 Apr 2024, Matthias Aßhauer wrote:

>

After sending my previous message I've noticed that all of the 
etu.univ-lyon1.fr recipients bounced with the 
message

> 550 5.5.0 Requested actions not taken as the mailbox is unavailable

After running https://etu.univ-lyon1.fr/ through a machine translation 
service it seems like that subdomain is used for mailboxes of current 
students, whereas staff like Matthieu get a mailbox on the main domain.
With Corentin, Nathan and Pablo presumably being former students, it's 
probably unlikely that these mailboxes will become active again.

Would it make sense to have a way to teach `git-contacts` to exclude a 
user defined list of known-bad recipient adresses? This could potentiallly 
be an extension of mailmap or a separate file.

>
> On Tue, 2 Apr 2024, Linus Arver via GitGitGadget wrote:
>
>> From: Linus Arver <linusa@google.com>
>> 
>> Although we've had this script since 4d06402b1b (contrib: add
>> git-contacts helper, 2013-07-21), we don't mention it in our
>> introductory docs. Do so now.
>> 
>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>    docs: recommend using contrib/contacts/git-contacts
>> 
>> Published-As: 
>> https://github.com/gitgitgadget/git/releases/tag/pr-1704%2Flistx%2Freviewers-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git 
>> pr-1704/listx/reviewers-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1704
>> 
>> Documentation/MyFirstContribution.txt | 3 +++
>> Documentation/SubmittingPatches       | 4 ++++
>> 2 files changed, 7 insertions(+)
>> 
>> diff --git a/Documentation/MyFirstContribution.txt 
>> b/Documentation/MyFirstContribution.txt
>> index f06563e9817..eb1e27a82df 100644
>> --- a/Documentation/MyFirstContribution.txt
>> +++ b/Documentation/MyFirstContribution.txt
>> @@ -1116,6 +1116,9 @@ $ git send-email --to=target@example.com psuh/*.patch
>> NOTE: Check `git help send-email` for some other options which you may find
>> valuable, such as changing the Reply-to address or adding more CC and BCC 
>> lines.
>> 
>> +NOTE: Use `contrib/contacts/git-contacts` to get a list of reviewers you 
>> should
>> +include in the CC list.
>> +
>> NOTE: When you are sending a real patch, it will go to git@vger.kernel.org 
>> - but
>> please don't send your patchset from the tutorial to the real mailing list! 
>> For
>> now, you can send it to yourself, to make sure you understand how it will 
>> look.
>> diff --git a/Documentation/SubmittingPatches 
>> b/Documentation/SubmittingPatches
>> index e734a3f0f17..52d11ff510b 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -459,6 +459,10 @@ an explanation of changes between each iteration can 
>> be kept in
>> Git-notes and inserted automatically following the three-dash
>> line via `git format-patch --notes`.
>> 
>> +[[suggested-reviewers]]
>> +Use `contrib/contacts/git-contacts` to get a list of reviewers you should
>> +include in the CC list.
>> +
>
> There is already a paragraph about this in Documentation/SubmittingPatches 
> just a few paragraphs below.
>
>> Send your patch with "To:" set to the mailing list, with "cc:" listing
>> people who are involved in the area you are touching (the `git
>> contacts` command in `contrib/contacts/` can help to
>> identify them), to solicit comments and reviews.  Also, when you made
>> trial merges of your topic to `next` and `seen`, you may have noticed
>> work by others conflicting with your changes.  There is a good possibility
>> that these people may know the area you are touching well.
>
> Could we improve the existing paragraph instead of duplicating this 
> information?
>
>> [[attachment]]
>> Do not attach the patch as a MIME attachment, compressed or not.
>> Do not let your e-mail client send quoted-printable.  Do not let
>> 
>> base-commit: c2cbfbd2e28cbe27c194d62183b42f27a6a5bb87
>> -- 
>> gitgitgadget
>> 
>
