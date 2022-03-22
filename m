Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409EDC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 21:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiCVVOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 17:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiCVVOO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 17:14:14 -0400
Received: from zimbra.cs.ucla.edu (zimbra.cs.ucla.edu [131.179.128.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FE0633F
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 14:12:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 48D101600E5;
        Tue, 22 Mar 2022 14:12:45 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uNA81TuDZJvy; Tue, 22 Mar 2022 14:12:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 480751600EA;
        Tue, 22 Mar 2022 14:12:44 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 52GLFsIhSe1Y; Tue, 22 Mar 2022 14:12:44 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id 1364E1600E5;
        Tue, 22 Mar 2022 14:12:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------DtKdgZQ0V6OnFGRQlX1hUm0X"
Message-ID: <325b7ba6-04a8-0010-a288-a118a820f3c3@cs.ucla.edu>
Date:   Tue, 22 Mar 2022 14:12:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: improve performance of PCRE2 bug 2642 bug workaround
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        GNU grep developers <grep-devel@gnu.org>
References: <bd751d5c-2f8b-4c52-72ec-f2b7268a30a8@cs.ucla.edu>
 <99b0adb6-26ba-293c-3a8f-679f59e7cb4d@web.de>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <99b0adb6-26ba-293c-3a8f-679f59e7cb4d@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------DtKdgZQ0V6OnFGRQlX1hUm0X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/22/22 13:26, Ren=C3=A9 Scharfe wrote:

> However, the looser check works around another bug, if only by accident=
.

Thanks for letting me know. In that case, GNU grep should use a looser=20
check too, like Git grep does. I installed the attached into GNU grep.
--------------DtKdgZQ0V6OnFGRQlX1hUm0X
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-grep-work-around-another-potential-PCRE2-bug.patch"
Content-Disposition: attachment;
 filename="0001-grep-work-around-another-potential-PCRE2-bug.patch"
Content-Transfer-Encoding: base64

RnJvbSBmZjJkMjRiMDgyMjNlNmM3YjcwNGE5MTEyN2JhYzQzOTFhOWI4YWRiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXVsIEVnZ2VydCA8ZWdnZXJ0QGNzLnVjbGEuZWR1
PgpEYXRlOiBUdWUsIDIyIE1hciAyMDIyIDE0OjA5OjA1IC0wNzAwClN1YmplY3Q6IFtQQVRD
SF0gZ3JlcDogd29yayBhcm91bmQgYW5vdGhlciBwb3RlbnRpYWwgUENSRTIgYnVnCk1JTUUt
VmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApD
b250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpQb3RlbnRpYWwgcHJvYmxlbSByZXBv
cnRlZCBieSBSZW7DqSBTY2hhcmZlIGluOgpodHRwczovL2xvcmUua2VybmVsLm9yZy9naXQv
OTliMGFkYjYtMjZiYS0yOTNjLTNhOGYtNjc5ZjU5ZTdjYjRkQHdlYi5kZS9UCiogc3JjL3Bj
cmVzZWFyY2guYyAoUGNvbXBpbGUpOiBNaW1pYyBnaXQgZ3JlcOKAmXMgd29ya2Fyb3VuZHMK
Zm9yIFBDUkUyIGJ1Z3MgbW9yZSBjbG9zZWx5OyB0aGlzIGlzIG1vcmUgY29uc2VydmF0aXZl
LgotLS0KIHNyYy9wY3Jlc2VhcmNoLmMgfCAxMyArKysrKysrLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Ny
Yy9wY3Jlc2VhcmNoLmMgYi9zcmMvcGNyZXNlYXJjaC5jCmluZGV4IDBjZjgwNGQuLjY5NDc4
MzggMTAwNjQ0Ci0tLSBhL3NyYy9wY3Jlc2VhcmNoLmMKKysrIGIvc3JjL3BjcmVzZWFyY2gu
YwpAQCAtMTU0LDE1ICsxNTQsMTYgQEAgUGNvbXBpbGUgKGNoYXIgKnBhdHRlcm4sIGlkeF90
IHNpemUsIHJlZ19zeW50YXhfdCBpZ25vcmVkLCBib29sIGV4YWN0KQogI2lmZGVmIFBDUkUy
X01BVENIX0lOVkFMSURfVVRGCiAgICAgICAvKiBDb25zaWRlciBpbnZhbGlkIFVURi04IGFz
IGEgYmFycmllciwgaW5zdGVhZCBvZiBlcnJvci4gICovCiAgICAgICBmbGFncyB8PSBQQ1JF
Ml9NQVRDSF9JTlZBTElEX1VURjsKLQotIyBpZiAhICgxMCA8IFBDUkUyX01BSk9SICsgKDM2
IDw9IFBDUkUyX01JTk9SKSkKLSAgICAgIC8qIFdvcmsgYXJvdW5kIFBDUkUyIGJ1ZyAyNjQy
LiAgKi8KLSAgICAgIGlmIChmbGFncyAmIFBDUkUyX0NBU0VMRVNTKQotICAgICAgICBmbGFn
cyB8PSBQQ1JFMl9OT19TVEFSVF9PUFRJTUlaRTsKLSMgZW5kaWYKICNlbmRpZgogICAgIH0K
IAorI2lmIGRlZmluZWQgUENSRTJfTUFUQ0hfSU5WQUxJRF9VVEYgJiYgISgxMCA8IFBDUkUy
X01BSk9SICsgKDM2IDw9IFBDUkUyX01JTk9SKSkKKyAgLyogV29yayBhcm91bmQgUENSRTIg
YnVnIDI2NDIsIGFuZCBhbm90aGVyIGJ1ZyByZXBvcnRlZGx5IGZpeGVkIGluCisgICAgIFBD
UkUyIGNvbW1pdCBlMGM2MDI5YTYyZGI5YzIxNjE5NDFlY2RmNDU5MjA1MzgyZDRkMzc5LiAg
Ki8KKyAgaWYgKGZsYWdzICYgKFBDUkUyX1VURiB8IFBDUkUyX0NBU0VMRVNTKSkKKyAgICBm
bGFncyB8PSBQQ1JFMl9OT19TVEFSVF9PUFRJTUlaRTsKKyNlbmRpZgorCiAgIC8qIEZJWE1F
OiBSZW1vdmUgdGhpcyByZXN0cmljdGlvbi4gICovCiAgIGlmIChyYXdtZW1jaHIgKHBhdHRl
cm4sICdcbicpICE9IHBhdGxpbSkKICAgICBkaWUgKEVYSVRfVFJPVUJMRSwgMCwgXygidGhl
IC1QIG9wdGlvbiBvbmx5IHN1cHBvcnRzIGEgc2luZ2xlIHBhdHRlcm4iKSk7Ci0tIAoyLjMy
LjAKCg==

--------------DtKdgZQ0V6OnFGRQlX1hUm0X--
