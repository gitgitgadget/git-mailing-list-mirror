Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847C3C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 08:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D07920723
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 08:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="r9k9rQrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbgFWI7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:59:45 -0400
Received: from mout.web.de ([217.72.192.78]:45517 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731899AbgFWI7o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 04:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592902771;
        bh=GBf3dFtUXMwIO2mI8LkNT2t3D9MoLYanVb5P+il37Lo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=r9k9rQrfxouv4wgJSK5syyHc9NyNKlMwigtiHV14oq8N6BXBwUTwwAqIUU8zRSxEW
         jYFgjKAOvpqNiNKZpWLrEUsf1fsrAjRoPfCsHG8En3JOrRZD4a4WAxlx6ygx6cS5U6
         WduNx1q4egY2ZcUWXqbelYViT3wgbugxzAQcvq6w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2dbt-1ixTZ01X9R-00sK71; Tue, 23
 Jun 2020 10:59:31 +0200
Subject: Re: Git 2 force commits but Git 1 doesn't
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Ward <mward@smartsoftwareinc.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <dea24348-770c-1228-115d-23153fbecebd@smartsoftwareinc.com>
 <20200622202122.GO6531@camp.crustytoothpaste.net>
 <a42d038f-bf14-8f1a-927e-7488796e7710@smartsoftwareinc.com>
 <20200622204346.GP6531@camp.crustytoothpaste.net>
 <8ad16219-2426-6127-b41d-bb3007a9b993@smartsoftwareinc.com>
 <20200622210953.GQ6531@camp.crustytoothpaste.net>
 <2e43580c-9952-9ccf-6b35-27a4333fb83e@smartsoftwareinc.com>
 <20200623010519.GR6531@camp.crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <09a7fa54-d7ae-772c-fb36-29dbd27bc626@web.de>
Date:   Tue, 23 Jun 2020 10:59:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623010519.GR6531@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KzVfy1G1QcCukf9Vc2DS78AU/BWbBAsxGU0ndErxVdyUug0Rm4V
 Gfau4aC3fdz74erdh2gcEarsOuCf0UTyjS2zqrgc3MUwsjGSV9ETZZJg8wIOgK8rFYFGVo4
 IglUJOhvuaQ24NuV0Aik7IZRxkM9kI6mCaz1lv/bYgoxkYU0y/Sd2p9E65Hkhhm2ZoNZR3o
 fXp/DbRZkVM/jjGguZ9EA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hq4N1TV8zQs=:d+7WeHeIoL/0VwT+QHa1BA
 xiukSyhNbHW1psVuY2mpvdwrRTNiIkJ1q4aLlJPzyfQLvCgOv0Ej0mpZO4EwaNszW36bA1DJi
 +EiW+Ze49+vAzbggAC6b7ZtWhbPfXBI8Er5h4vJ7Bew9XRtLfb5S0gRHRkXT8xHmeaA1Bdfs9
 pmAPrEV3BSN8I+s8oyrM11Kbl/WGYug+2nQb6YUbs6dKODNL+6XN+yo8bfPtCRMjVtCn0/PzH
 xQLuIPwmJi91M9bX7L/XTlxZqaK+wnQP9LOgRKqdzaF/q01K/AtVgLPWZ+dWfDk8PAYVV0tRu
 svFOnaJ3cPlzHUcjvlgMN01r7xolcSyX+74BVs/DdXFjVzkFgG4ljxglAexJL4BN8CtL1fsah
 XN78eCXBKWK+Vx/rhdForbzEe2v2zpt4NBUl6O+BUkQWyKv5yYQd6ht9aCCnqstXOxHtAFLhg
 wuP3Qn9/R6FJ6CbBduDfsBpp2ecxML4aUym1HUTwNWuZRqv4HWQ1S0LZViaSwtiBB7utOqGqv
 iclw+5sxljNvGOZDGU41/BJ/1gDZ3gMsalRj2maHK89v/k3pxo24lT0Q+I8Z3tXwk+9RKOC0H
 j/bttR6vfEc6NVdNaNpIb2Mg1iUSN7iatIjaiKV2NW5ubtzIngELJcpRGOvZ1laZKCufkPIqM
 LZcPDdatNqSQMp06OThQxBnRF3CWeF0QHdJI/B/k8FjWeoD5BpP8LZsq+huwNIXSIeyq4CutT
 T8l+nvBxN1AK/WAB/CE1z1AJr3XZKcDzPJ5aBLRORQ+0V0uZqDL4dE5vlAotza+Jx0reNPmdD
 zZOwfRCQsXPro23fy8J0SlDK36AMPSlRc2MpEbx482Vng3+J9r+w60TNHNlS88oGCODn+R+qe
 VL8/T29E3c/twLaXFm0pK1Ro37CLCcOlhTNWw1nXOtQu7xLUngogPbjnMHt/lnciHYmPfo6Vv
 WCwrug8g2Y3AiDuy3CsirCjjlwk+v7R0nGwP+FZTBAwJA8wqDBqI7pQdjxkjlDEbmb33ZXltZ
 EeOi2vwa+W3emoFVC/x3bn8Z8JKMp1nIrCWmz+GzhIU35i8ycqtk/AvY4QPZ1BsTg5kjXLu/x
 sWjqbs0nOVGyknNVw1TyMGHmrF3XQj8zRmtnn3rWjaL0i0GXxhlwQs8HKyANqmzrPYw4V9oXl
 c2Se6sS7ly5SkvxoY9uNsn1Pg4bhP8TDZeBufYTMxz4D3e5EkUTW5tEFzuwfh0/sog8Zo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.20 um 03:05 schrieb brian m. carlson:
> On 2020-06-22 at 22:17:21, Michael Ward wrote:
>> This is assuming that the repository is completely empty to start. Setu=
p:
>>
>> git clone [repository] repo1
>> git clone [repository] repo2
>> cd repo1
>> echo "test1" > testfile
>> git add testfile
>> git commit -m 'initializing test from 1'
>> git push
>> cd ../repo2
>> git pull
>> cd ../repo1
>>
>> Now for the issue:
>>
>> echo "test1 update" >> testfile
>> git add testfile
>> git commit -m 'update test from 1'
>> git push
>> cd ../repo2
>> echo "test2" >> testfile
>> git commit -m 'update test from 2'
>> git push
>>
>> At this point using the git 2.26 client if I pull in repo1, the commit =
with
>> comment "update test from 1" is gone and the head is now the commit fro=
m 2
>> with "update test from 2" as the comment along with a borked tree. Usin=
g the
>> 1.18 client, the push from 2 will prompt to pull first.
>
> Thanks, I can reproduce this with the following test in t5540:
>
> test_expect_success 'non-force push fails if not up to date' '
> 	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_conflict.git &&
> 	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_conflict.git update-server=
-info &&
> 	git clone $HTTPD_URL/dumb/test_repo_conflict.git "$ROOT_PATH"/c1 &&
> 	git clone $HTTPD_URL/dumb/test_repo_conflict.git "$ROOT_PATH"/c2 &&
> 	test_commit -C "$ROOT_PATH/c1" path1 &&
> 	git -C "$ROOT_PATH/c1" push origin HEAD &&
> 	git -C "$ROOT_PATH/c2" pull &&
> 	test_commit -C "$ROOT_PATH/c1" path2 &&
> 	git -C "$ROOT_PATH/c1" push origin HEAD &&
> 	test_commit -C "$ROOT_PATH/c2" path3 &&
> 	git -C "$ROOT_PATH/c1" log --graph --all &&
> 	git -C "$ROOT_PATH/c2" log --graph --all &&
> 	test_must_fail git -C "$ROOT_PATH/c2" push origin HEAD
> '
>
> The relevant code is here:
>
> 			if (!has_object_file(&ref->old_oid) ||
> 			    !ref_newer(&ref->peer_ref->new_oid,
> 				       &ref->old_oid)) {
>
> In this case, ref_newer returns 1 (true), which is wrong.  _However_, if
> I add a debugging statement that prints ref_newer immediately above that
> line, like so:
>
> 			fprintf(stderr, "debug: a: %s %s %d\n", oid_to_hex(&ref->old_oid), oi=
d_to_hex(&ref->peer_ref->new_oid), ref_newer(&ref->peer_ref->new_oid, &ref=
->old_oid));
>
> The test starts passing (that is, ref_newer must return 0).
>
> I'm CCing Derrick Stolee, to whom that code blames, because I'm not sure
> that we should be returning different results in this case with what
> must be the same arguments.

The following patch helps by avoiding a commit flag collision between
http-push.c and commit-reach.c.  I don't know if it causes other
collisions, though.

How could we possibly check that?  Perhaps by having a commit flag
register (a global unsigned int) and having functions announce their
bits in it.  Colliding announcements would BUG().

diff --git a/http-push.c b/http-push.c
index 822f326599..99adbebdcf 100644
=2D-- a/http-push.c
+++ b/http-push.c
@@ -70,10 +70,10 @@ enum XML_Status {
 #define LOCK_REFRESH 30

 /* Remember to update object flag allocation in object.h */
-#define LOCAL    (1u<<16)
-#define REMOTE   (1u<<17)
-#define FETCHING (1u<<18)
-#define PUSHING  (1u<<19)
+#define LOCAL    (1u<<11)
+#define REMOTE   (1u<<12)
+#define FETCHING (1u<<13)
+#define PUSHING  (1u<<14)

 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
diff --git a/object.h b/object.h
index b22328b838..a496d2e4e1 100644
=2D-- a/object.h
+++ b/object.h
@@ -67,7 +67,7 @@ struct object_array {
  * builtin/blame.c:                        12-13
  * bisect.c:                                        16
  * bundle.c:                                        16
- * http-push.c:                                     16-----19
+ * http-push.c:                          11-----14
  * commit-graph.c:                                15
  * commit-reach.c:                                  16-----19
  * sha1-name.c:                                              20

