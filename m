Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95C7C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 13:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiDUNXc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 21 Apr 2022 09:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiDUNXb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 09:23:31 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-oln040092066035.outbound.protection.outlook.com [40.92.66.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6C5BC03
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fq1UovD8aIKGm9oj3rC+jkl7Wdr00BnEN5kVrqU4F6HN2LB/p0LMbts9UukvrG65+rB067fVlJ2yB3ABLHdScgvO+Cd9gPrsI6XOf0gUELQSSTdpn1z+BcXEfNsgGHkL27NVoFfrS7KsYpFwJMikxd3l3vfTmrzMsWI5q/yidCcVBJ+GlEnSZorwUCn4tbDF5LgvAKr54Ghkmu6/F3EozfSBoRWvN4QuseRjeXtroO/F4PiOFGZLktZmmuxLuXrfDvv6RTU7MF3fkemSQQ2c7rUcMeYQPYFlu214T4weWzNL6AKvkbToOEjwiX5d5ZIkateGBIjz6PyJ2kkrTp1NBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqKURHSCttxRV8sBcuV8vHL6x6YDPhgQtXTacf0zlW8=;
 b=FTSMqhpFWM/aA61chxuBRLQpcJR8zG9cy8xJDxJ+gLcSJ33YbYnaYFsxrhx++kM6sZhlt3D92vhiFF9SQAUKrVvwGRNjcwnnKNYbVdlRoIb23MY6KdQtfjI/VDTK6qjs2wDfrrMO13Y8HukLTRkzRGRA8NvNzJVN6G3uMT+p7q8F/gyor/48g5F5+4rms8IwwL+LhO+JpGhNvElAwMPwo6OXqsmF/nWH00qeQPfkoqrPIGfToKkhfoNK5pfKmgLtdw+69lSinsTcQoMXYTGNaeRfWshTwhintj5A2GJyRgPciGQvKKnVxoiRdQfCgyRQouh2qF/CfjBrNIHMpvjfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1P190MB1750.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4a8::21)
 by DB9P190MB1258.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 13:20:37 +0000
Received: from AS1P190MB1750.EURP190.PROD.OUTLOOK.COM
 ([fe80::196:7c98:c780:69af]) by AS1P190MB1750.EURP190.PROD.OUTLOOK.COM
 ([fe80::196:7c98:c780:69af%6]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 13:20:37 +0000
From:   Daniel Habenicht <daniel-habenicht@outlook.de>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug Report
Thread-Topic: Bug Report
Thread-Index: AQHYVNg8CVcF5Kz/l02dcun2ZjqvYaz5UhUAgAARsACAAPF6aA==
Date:   Thu, 21 Apr 2022 13:20:37 +0000
Message-ID: <AS1P190MB1750C249B4857371132C5DF0ECF49@AS1P190MB1750.EURP190.PROD.OUTLOOK.COM>
References: <f1647260b37d492d96ac92f8ef30a087AS1P190MB1750B08CC923A45E2C959250ECF59@AS1P190MB1750.EURP190.PROD.OUTLOOK.COM>
 <YmB7gvfKY/0njjZy@camp.crustytoothpaste.net>
 <017001d85506$bee0adf0$3ca209d0$@nexbridge.com>
In-Reply-To: <017001d85506$bee0adf0$3ca209d0$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [I3dK/unIyZTHEygrDG0+7jxWa549ki9UD+krTfQxX3CwdAXS6iO859XT10JBPp64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56bec087-96ed-49a6-4014-08da2399b99c
x-ms-traffictypediagnostic: DB9P190MB1258:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XGiSrUBtgHGSxnlF76YJ37OqzVwqtqaAJEKPZm+xPiSZrXzCnXv6Vu8zMetVrx0CojD4ke2qTt9l4+1N1EmWcp3k5fait4wjsd6cT7kBFxXY0195Hf+pouOe/paxi+l67rThc5FfEpO4sJ4KZW6s40Ag+bDIxfsOkTrapJmWCIfAk9aztWxAWHkhW9TZuoiSILPU1Geq6QKpDI2A/ykxxnoB6pnO5k4yVVYJGpB95MT3pQEOmcaH+7ud/uPiVV/3jbAfu9McWLOq+EdIWkR3NT0wHGzZVEpEZAvbil9VLJbJNIErdtdmHg4w+LNhOOavNKFnJUzIUaWo219AZB7S30iAcBiwkwXnC4wAeKFqYZbGvmUjdUkPQEhVT3mgHoO0zy7wJVGcT0qY3hQOQBbUxFgq2yGacmG3nHoPpbCeBIP/qWtNmY2T9nmyL1+G533m4U23jDSovhHV2/A56T5n/7wltZZi+LnOxuYbWDM/ZtTbEKyx3Pi5F+/hIsOiYUfCD9mOfhMiirm4QAnTRsjr0SNfPMaY5hHq3vk/MNIpwwSzvHwNW9G6QexFycCuYQ2xnpySOEjgfl5ZmV3mTWpKJ0yCen4wdKntdytSBPxCXjns0TIzzmnQ7ptz4h90l+Ug3sZV0VfFo6XLL2VkMIPaKuwKLpQSZP4sX8KlWS3n00s=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0Ob0Q8Wng0h2ynrIJZUkiEtj9lACc5SwFaa1QFcNGP062RjTQ6RnSOxWQ9?=
 =?iso-8859-1?Q?NmUjUCsGCGCaIJMUskyiyOynEityCg9EccsVJTMsUqutY/8OKjqExuy9cN?=
 =?iso-8859-1?Q?4SVqFatFPaNQTwrnZbPFCgpAsPcZGvBF52JyVoLfTCPncqw6YSoccOXeSQ?=
 =?iso-8859-1?Q?sqG6b+BXUwxcaNWXOTNtHh1ApP0nL+5coEaxggDDAkvM+Pk+sOG89KUVFd?=
 =?iso-8859-1?Q?cNBwZc717u9qhbJAY25uxfjrldqLR3ySKQutZN0g3QMLEKmyPdUcfwK2pX?=
 =?iso-8859-1?Q?xUStvwJQHF02r9/mQgGfHGe8yR1prkeTaf3irHcD/cUyNG3REccLEuf5eS?=
 =?iso-8859-1?Q?x3xJX6uDERE48jDOGdkfYBVPFwVIb81IzYu+VUU+UvVbJY5Um3cUwD+B64?=
 =?iso-8859-1?Q?68QSmKp59m/Ms4LCRZmy1fRVZ16SbeXAfMUJVD0dnLiHBxhP/a/aOD/kuQ?=
 =?iso-8859-1?Q?TlVYo+fhr23jRK3FqpJM5XivQDSDOFyUCAFT5qfMc6eurRnPkVSptXptD5?=
 =?iso-8859-1?Q?IGxJGgYUW7ESOs+68TPQCwd3FL3EH6o+VyLWKY/UhEpvYnLQTRm0mjaO4j?=
 =?iso-8859-1?Q?tN59g/ptj6QYbgC123EZ+5cBTmCm00i+2CHhU+WyqKHDP6TmWvZXsfzmBA?=
 =?iso-8859-1?Q?mpREfqf68OGhvJD2bfa+s+VIHp7unHZELyZXzf2MFBEbhbnjM3DwKhVHUj?=
 =?iso-8859-1?Q?H4pfV47VCK2sxCBuzam7mYJtnJ+a2FCpnys8mlr1z9Rj1lPS7y5qn9F5nA?=
 =?iso-8859-1?Q?KmEYvgAY6eR3fKjjy5/WO1Kovob+FeGT1MWN6NxlTnE4q/tjMjAZtW4H0P?=
 =?iso-8859-1?Q?Hh+LmD2ygdi1bwi0jT41ZqPFNGEzhXVK8g2gJM62R7B3j2d1wqftIMYpri?=
 =?iso-8859-1?Q?dIpeg53vAoIfkbTwHXPZ2e70I5PX0W8vDO5VE6eUZ1M/MB6IYapyBhWfmV?=
 =?iso-8859-1?Q?LMAo9kVmOJ5FaeMsNC0RYKsFUokaIRIsf4MGDLjnLtIIL3GZxJNuOP0Lvj?=
 =?iso-8859-1?Q?0NndYI+jPamxz+CgtruBA5FgnLivgNUTGP+PiSUIkCDOYmc7gDSqxhL7ZF?=
 =?iso-8859-1?Q?fqhnybqmKHIyh/+X6JyzMqR2yrSrfcX1AsZ9XZ8LOC0KS3G+gYRfKazgFw?=
 =?iso-8859-1?Q?D+nxn9CAd//zcW153gdBVlaYYt12QRDE+m8fP1vYMtx0KS9bfT4vssjR8l?=
 =?iso-8859-1?Q?pJ7iL+wOORZJaimE+2w7pjCSMLwW2d312o4bftkbKVwyejCfeqyqwkGx6O?=
 =?iso-8859-1?Q?OPyaOdZwIaoPtgJlcQuzrgJD9HhEF1WfBjdJ+cZkQRoqLouQIqnw33oFYw?=
 =?iso-8859-1?Q?H8ZvSOmmafvjhN/LfvzOEqH7DzgcmlqqDIDRvOcG67e62SBnAKCSDeoHvv?=
 =?iso-8859-1?Q?fv1AlppsoknKps8f0NEnflPmuSpQuWDq5UaUEgqMjcN8ajjFmdxIjschLR?=
 =?iso-8859-1?Q?WeYCysyxnxO+WLzqxlj8BkatWuY1OaUPsmwqlpytgvbjRP31v4bv5YmoZs?=
 =?iso-8859-1?Q?qPtDfjkMY/twGyyEtHedbdVhvJSmq23eE6FpJqrQnUsEFnrHKVsSQibyhv?=
 =?iso-8859-1?Q?TKlxcM0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-91991.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1P190MB1750.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bec087-96ed-49a6-4014-08da2399b99c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 13:20:37.6715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1258
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall and Brian, 

thanks for the fast response. 
@Randall: I also tried it with autocrlf=input and it still reproduces. I included it in the reproduction. I also added more examples for confusing behaviour. 


Here is the full bug report: 
(You can view a Markdown rendered version of this reproduction at: https://github.com/DanielHabenicht/bug-reproduction.git-repo)

# Description 

When changing the `.gitattributes` file not all changes to the checked in files are apparent.
They only get updated on a new clone or when refreshing the index - that's somehow expected. 
But it creates confusion and unexpected behavior if they are not updated together with the `.gitattributes` changes. 
It can make easy changes between branches impossible, break the flow of squashing commits or lead to confusing state of everlasting uncommited change.
These edge cases for confusing behaviour I have added below. 

# Reproduction 

1. Checkout with the following `.gitconfig` settings set:

```gitconfig
# .gitconfig
[core]
    autocrlf = false
# Or
    autocrlf = input
```

2. Clone the repository
```bash
git clone https://github.com/DanielHabenicht/bug-reproduction.git-repo.git
```

3. `test.cs` should be shown as `modified`

> This is confusing to the user, he just checked the repo out and did not change a thing. At least there should be a warning?
   
```
git status
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   test.cs

no changes added to commit (use "git add" and/or "git commit -a")
```

5. Running any git command like the ones below will not remove the changed file:

```bash
git rm --cached -r .
git reset --hard
git add --renormalize .
```

> This as well is very confusing and there is no indication on why this is happening and there are still modified files after everything should be reset. 
> Keep in mind that this could have happened in error and could be happening to a totally unrelated (to the inital `.gitattributes` change) user. 

6. Running `git diff` is even more confusing, and doing as the warning suggests (`warning: CRLF will be replaced by LF in test.cs. The file will have its original line endings in your working directory`) and replacing `CRLF` by `LF` does silence the warning but does not change the diff itself:

```diff
warning: CRLF will be replaced by LF in test.cs.
The file will have its original line endings in your working directory
diff --git b/test.cs a/test.cs
index 1e230ed..5464a2d 100644
--- b/test.cs
+++ a/test.cs
@@ -1,11 +1,11 @@
-using System.Diagnostics.CodeAnalysis;
-using System.Linq;
-using Xunit;
-using Moq;
-
-
-
-namespace Tests
-{
-
-}
+using System.Diagnostics.CodeAnalysis;^M
+using System.Linq;^M
+using Xunit;^M
+using Moq;^M
+^M
+^M
+^M
+namespace Tests^M
+{^M
+^M
+}^M
```

> This is showing the exact opposite of what git is really doing. Actually it replaces the line encoding of the index (i/crlf) with the right encoding (i/lf) (see **[1]**)
> From the git user perspective everything is in great shape, the file is LF, as it should be, but still git complains about a change that is not visible to the user without background knowledge about gitattributes and the git index. 

8. Try changing the branch to a modified copy with `git checkout some-changes` is not possible (also with the recommended command). The only solution would be to commit - nothing else helps (but thats not really a solution). : 

```bash
error: Your local changes to the following files would be overwritten by checkout:
        test.cs
Please commit your changes or stash them before you switch branches.
Aborting
```

> This makes changing branches harder, as it can't be force reset and git will always complain about files being overwritten.
> It also break the flow for squashing commits as you would need to manually intervene (and add a commit) if someone forgot to commit all files after a .gitattributes change and only recognized it at a later date.


**[1]**: I hope this answer explained it right to me: https://stackoverflow.com/a/71937898/9277073. 
But it is rather unintuitive to me, and possibly other users, as there seems to be a hidden middle layer leading to this problem. See the graph at the github repo)



Cheers,
Daniel




Daniel Habenicht


From: rsbecker@nexbridge.com <rsbecker@nexbridge.com>
Sent: Thursday, April 21, 2022 00:34
To: 'brian m. carlson' <sandals@crustytoothpaste.net>; 'Daniel Habenicht' <daniel-habenicht@outlook.de>
Cc: git@vger.kernel.org <git@vger.kernel.org>
Subject: RE: Bug Report 
 
On April 20, 2022 5:31 PM, brian m. carlson wrote:
>On 2022-04-20 at 19:45:32, Daniel Habenicht wrote:
>> Hi there,
>>
>> I think I found a bug or at least some unexpected behavior. Please
>> have a look at the following reproduction repo:
>>
>> https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FDanielHabenicht%2Fbug-reproduction.git-repo%2Fblob%2Fmain&amp;data=05%7C01%7C%7C145ae6f595d54ac7b5fd08da231de43c%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C637860908535410706%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=HXFm4sBZ5yQGQPkBlkzKhkgDJOXBqSlgETkrhGxgkmI%3D&amp;reserved=0
>> /README.md
>
>You're more likely to get someone to look at this if you post the actual text to the
>list.  While I might be willing to look at it on GitHub, other folks won't, and I
>probably won't get a chance to look at this issue anytime soon.

The only thing that I can see that is apparently a problem is that autocrlf=false is not documented in the config help, so it is not apparent what the expected result should be relative to the test case. That could be considered confusing. There could also be confusion relative to when the git diff was done relative to what is in the staging area given his test case. I think what Daniel may really want is to use autocrlf=input.

Daniel, please post your entire report to this list rather than using GitHub, links, or attachments. I happened to be on GitHub at that moment, so looked, but otherwise, I would not have specifically looked.

--Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.
