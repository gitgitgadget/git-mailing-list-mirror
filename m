Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606C5C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 04:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiCWEIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 00:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCWEIK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 00:08:10 -0400
Received: from zimbra.cs.ucla.edu (zimbra.cs.ucla.edu [131.179.128.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846356E4D5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 21:06:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 10A1A160052;
        Tue, 22 Mar 2022 21:06:41 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 09V7es879cjW; Tue, 22 Mar 2022 21:06:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 0AFB916007E;
        Tue, 22 Mar 2022 21:06:40 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PIqbnPfLjUeZ; Tue, 22 Mar 2022 21:06:39 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id C6D6C160052;
        Tue, 22 Mar 2022 21:06:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Ga5QkJd2iRsm4Fu3ECqu9nx0"
Message-ID: <3642dffd-2241-9fd4-3ab8-04ce14c0f1a8@cs.ucla.edu>
Date:   Tue, 22 Mar 2022 21:06:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        GNU grep developers <grep-devel@gnu.org>
References: <bd751d5c-2f8b-4c52-72ec-f2b7268a30a8@cs.ucla.edu>
 <99b0adb6-26ba-293c-3a8f-679f59e7cb4d@web.de>
 <20220323010931.jzf7op7hdusdty33@carlos-mbp.lan>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: improve performance of PCRE2 bug 2642 bug workaround
In-Reply-To: <20220323010931.jzf7op7hdusdty33@carlos-mbp.lan>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------Ga5QkJd2iRsm4Fu3ECqu9nx0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/22/22 18:09, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> AFAIK the contents of the bugzilla are no longer accessible to anyone (=
lost in the migration of PCRE2 to github),

Yes, that confused me too.

> the bug will trigger when both PCRE2_UTF and PCRE2_MULTILINE are set (a=
s shown in the PCRE2 regression added), with the later set by default in =
git and NEVER set in GNU grep, hence why I later retracted[6] my suggesti=
on to add the workaround to grep

OK, thanks, I installed the attached to GNU grep and we'll call it a day.
--------------Ga5QkJd2iRsm4Fu3ECqu9nx0
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-grep-Remove-recent-PCRE2-bug-workarounds.patch"
Content-Disposition: attachment;
 filename="0001-grep-Remove-recent-PCRE2-bug-workarounds.patch"
Content-Transfer-Encoding: base64

RnJvbSA3NDNiMWY2ZjVjYTdlZTg2MzQ4ZmEwNTkzZGEyZWZmMDNkZjFhODJhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXVsIEVnZ2VydCA8ZWdnZXJ0QGNzLnVjbGEuZWR1
PgpEYXRlOiBUdWUsIDIyIE1hciAyMDIyIDIwOjEyOjM4IC0wNzAwClN1YmplY3Q6IFtQQVRD
SF0gZ3JlcDogUmVtb3ZlIHJlY2VudCBQQ1JFMiBidWcgd29ya2Fyb3VuZHMKTUlNRS1WZXJz
aW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRl
bnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKCiogc3JjL3BjcmVzZWFyY2guYyAoUGNvbXBp
bGUpOiBSZW1vdmUgcmVjZW50IHdvcmthcm91bmQgZm9yIFBDUkUyCmJ1Z3M7IGFwcGFyZW50
bHkgaXTigJlzIG5vdCBuZWVkZWQuICBUaGlzIHJldmVydHMgYmFjayB0byB3aGVyZQp0aGlu
Z3Mgd2VyZSBiZWZvcmUgdG9kYXkuICBTdWdnZXN0ZWQgYnkgQ2FybG8gQXJlbmFzIGluOgpo
dHRwczovL2xpc3RzLmdudS5vcmcvci9ncmVwLWRldmVsLzIwMjItMDMvbXNnMDAwMDYuaHRt
bAotLS0KIHNyYy9wY3Jlc2VhcmNoLmMgfCA3IC0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9wY3Jlc2VhcmNoLmMgYi9zcmMvcGNy
ZXNlYXJjaC5jCmluZGV4IDY5NDc4MzguLmYzMzJhNDQgMTAwNjQ0Ci0tLSBhL3NyYy9wY3Jl
c2VhcmNoLmMKKysrIGIvc3JjL3BjcmVzZWFyY2guYwpAQCAtMTU3LDEzICsxNTcsNiBAQCBQ
Y29tcGlsZSAoY2hhciAqcGF0dGVybiwgaWR4X3Qgc2l6ZSwgcmVnX3N5bnRheF90IGlnbm9y
ZWQsIGJvb2wgZXhhY3QpCiAjZW5kaWYKICAgICB9CiAKLSNpZiBkZWZpbmVkIFBDUkUyX01B
VENIX0lOVkFMSURfVVRGICYmICEoMTAgPCBQQ1JFMl9NQUpPUiArICgzNiA8PSBQQ1JFMl9N
SU5PUikpCi0gIC8qIFdvcmsgYXJvdW5kIFBDUkUyIGJ1ZyAyNjQyLCBhbmQgYW5vdGhlciBi
dWcgcmVwb3J0ZWRseSBmaXhlZCBpbgotICAgICBQQ1JFMiBjb21taXQgZTBjNjAyOWE2MmRi
OWMyMTYxOTQxZWNkZjQ1OTIwNTM4MmQ0ZDM3OS4gICovCi0gIGlmIChmbGFncyAmIChQQ1JF
Ml9VVEYgfCBQQ1JFMl9DQVNFTEVTUykpCi0gICAgZmxhZ3MgfD0gUENSRTJfTk9fU1RBUlRf
T1BUSU1JWkU7Ci0jZW5kaWYKLQogICAvKiBGSVhNRTogUmVtb3ZlIHRoaXMgcmVzdHJpY3Rp
b24uICAqLwogICBpZiAocmF3bWVtY2hyIChwYXR0ZXJuLCAnXG4nKSAhPSBwYXRsaW0pCiAg
ICAgZGllIChFWElUX1RST1VCTEUsIDAsIF8oInRoZSAtUCBvcHRpb24gb25seSBzdXBwb3J0
cyBhIHNpbmdsZSBwYXR0ZXJuIikpOwotLSAKMi4zMi4wCgo=

--------------Ga5QkJd2iRsm4Fu3ECqu9nx0--
