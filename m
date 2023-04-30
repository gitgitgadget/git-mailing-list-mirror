Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42009C77B73
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 06:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjD3GvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Apr 2023 02:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3GvF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2023 02:51:05 -0400
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B871BE
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 23:51:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 922183C097AFA;
        Sat, 29 Apr 2023 23:51:02 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ip41IZzH_ZHw; Sat, 29 Apr 2023 23:51:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 662553C09FA05;
        Sat, 29 Apr 2023 23:51:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 662553C09FA05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1682837461;
        bh=UGU29DlUUllvwtLbeVvM8/M0hFESmlAmH+NVXQWlfHA=;
        h=Message-ID:Date:MIME-Version:To:From;
        b=hM74vTtVexnTRh8WUH48VTwIHnmYpRQl47bPTl8UIc+crG4Krql+jyUVfnv2L5+rI
         CmFzH291ijj2fqC0TPiE0Np45EwkwFUUESHtZHzfa5C08MELhe58x9XvABvQ1N4bRr
         hTTkvi08macYOk15z75DdodaPYTtH/yTaDVcgrcP18VYjJzUB4se67g/KswFd/tPR8
         eVjLnxVuyAGBwRX6NDdTJl4PhIB6e0tf2oxCFSZJdXj3gCVM69x/J5v2M4tSpchfX/
         RYtK5ZRXCv5vzbPD3OUebxtK4TvZCFkSPcqGhe9/OTh3PwR1HtUeYMVKsAdlmgdh6B
         dgYd5aVOrG+VQ==
X-Virus-Scanned: amavisd-new at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m5WVxWkCYhpR; Sat, 29 Apr 2023 23:51:01 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by mail.cs.ucla.edu (Postfix) with ESMTPSA id 1E5DD3C097AFA;
        Sat, 29 Apr 2023 23:51:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------IDK4hagaOv1Xh1BciSgtTXi4"
Message-ID: <b6a77d9a-f862-685f-f697-a58acc3a077b@cs.ucla.edu>
Date:   Sat, 29 Apr 2023 23:51:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Jim Meyering <jim@meyering.net>, grep-devel@gnu.org,
        demerphq <demerphq@gmail.com>, pcre2-dev@googlegroups.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <m28rf0pa2m.fsf@meyering.net>
 <4322c414-2bb7-924f-0f6d-dbf517599c3f@cs.ucla.edu>
 <CA+8g5KFqgtKadru7g0LMPpoNDO0vxGGsva_+hQAUcOOfMTd22w@mail.gmail.com>
 <c5j7tduynkzhqpcgqc7iei4mmlnlwvfohmj7ryfhifpay6hhtn@ha3apuuzhxzz>
 <508ca102-63a9-6334-fee8-7a1ae84c7a23@cs.ucla.edu>
 <CAPUEsph9MvGhyh0zTz3o5ELj0XKMdPNvghrg6VDRh25UipgXwQ@mail.gmail.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: Compatibility between GNU and Git grep -P
In-Reply-To: <CAPUEsph9MvGhyh0zTz3o5ELj0XKMdPNvghrg6VDRh25UipgXwQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------IDK4hagaOv1Xh1BciSgtTXi4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-04-21 15:05, Carlo Arenas wrote:

> This is really not that recent, and has been released already with git
> 2.40, so at least at that point in time git and grep 3.9 were
> consistent.  That was changed with grep 3.10 though.

OK, so currently GNU grep -P and git grep -P treat \d differently (the 
former matches only ASCII digits; the latter matches all decimal 
digits). And the next GNU grep -P (i.e., the one currently on Savannah 
master), when combined with a future PCRE2 release, is planned to change 
behavior in other areas, but the two programs will continue to treat \d 
differently. Not good, obviously.


> FWIW, it doesn't seem git had any issues (other than the crasher with
> PCRE2 10.34) with the transition to matching multibyte digits with
> '\d' and which is what perl (and therefore PCRE2) does

I suspect the issues that Jim is worried about have more to do with 
people attacking grep-using programs with data that unexpectedly match 
\d. This is more likely to happen with GNU grep -P (which gets all sorts 
of weird junk thrown at it) than with Git grep -P (which tends to lead a 
more cloistered life). If my suspicion is right, then even if Git users 
don't have issues with PCRE2_UCP and \d, that doesn't mean GNU grep 
users would be free of such issues.


> My assumption is that you would also need PCRE2_EXTRA_ASCII_DIGIT, and
> indeed bleeding edge pcre2grep[2] had a compatibility option added
> assuming as much.

Although I wasn't aware of that future PCRE2 option, I am not sure GNU 
grep -P should use it. As things stand, the next GNU grep -P release, 
when combined with the next PCRE2 release, will have \d match ASCII 
digits only, and will have [[:digit:]] match all decimal digits. This is 
compatible with how plain GNU grep [[:digit:]] works (plain GNU grep 
lacks \d of course, so there's no compatibility issue there).

Quite possibly GNU grep -P should retain [[:digit:]] compatibility with 
plain grep by not using PCRE2_EXTRA_ASCII_DIGIT. Though it'd be 
unfortunate that \d would not mean the same thing as [[:digit:]], that 
might be better than the alternative of having [[:digit:]] mean 
something different with -P than without -P.


> The proposed patch for git would IMHO just cause the same risk I was
> trying to prevent with my proposed change to GNU grep.

It sounds like this ship has already sailed. At best we can now try to 
repair it.

For now I installed the attached documentation patch. I left the grep 
code alone as we are so close to a release.
--------------IDK4hagaOv1Xh1BciSgtTXi4
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-doc-improve-doc-for-P-d.patch"
Content-Disposition: attachment; filename="0001-doc-improve-doc-for-P-d.patch"
Content-Transfer-Encoding: base64

RnJvbSA4ZDNhZmVlYmNjMmJkZjJlOGZkNGVkMWM1MjU2ZTU0YmU5NWYzNmExIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXVsIEVnZ2VydCA8ZWdnZXJ0QGNzLnVjbGEuZWR1
PgpEYXRlOiBTYXQsIDI5IEFwciAyMDIzIDIzOjQxOjE0IC0wNzAwClN1YmplY3Q6IFtQQVRD
SF0gZG9jOiBpbXByb3ZlIGRvYyBmb3IgLVAgJ1xkJwpNSU1FLVZlcnNpb246IDEuMApDb250
ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1F
bmNvZGluZzogOGJpdAoKVGhpcyBmb2xsb3dzIHVwIHRvIENhcmxvIE1hcmNlbG8gQXJlbmFz
IEJlbMOzbuKAmXMgZW1haWwKPGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9yL2dyZXAtZGV2ZWwv
MjAyMy0wNC9tc2cwMDAxNy5odG1sPgp0aGF0IHByb3Bvc2VkIGNoYW5naW5nIHRoZSBjb2Rl
IHRvby4gIFRoZXNlIHBhdGNoZXMgY2hhbmdlCm9ubHkgdGhlIGRvY3VtZW50YXRpb24gc2lu
Y2Ugd2XigJlyZSBzbyBuZWFyIGEgcmVsZWFzZS4KKiBORVdTOiBCZSBsZXNzIG9wdGltaXN0
aWMgYWJvdXQgdGhlIGZpeCBmb3IgLVAgJ1xkJywKYW5kIHdhcm4gdGhhdCBiZWhhdmlvciBp
cyBsaWtlbHkgdG8gY2hhbmdlIGFnYWluLgoqIGRvYy9ncmVwLnRleGkgKGdyZXAgUHJvZ3Jh
bXMpOiBCZSBsZXNzIHNwZWNpZmljIGFib3V0IC1QIFxkCmJlaGF2aW9yLCBzaW5jZSBpdOKA
mXMgc3RpbGwgaW4gZmx1eC4gIFdhcm4gYWJvdXQgbWlzbWF0Y2hpbmcKVW5pY29kZSB2ZXJz
aW9ucywgb3IgZGlzYWdyZWVtZW50cyBhYm91dCBvYnNjdXJlIGNvbnN0cnVjdHMuCi0tLQog
TkVXUyAgICAgICAgICB8IDE0ICsrKysrKysrLS0tLS0tCiBkb2MvZ3JlcC50ZXhpIHwgMTMg
KysrKystLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxNCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ORVdTIGIvTkVXUwppbmRleCBjMTU3NjRjLi45
OTVkMTRlIDEwMDY0NAotLS0gYS9ORVdTCisrKyBiL05FV1MKQEAgLTQsMTEgKzQsMTIgQEAg
R05VIGdyZXAgTkVXUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0qLSBv
dXRsaW5lIC0qLQogCiAqKiBCdWcgZml4ZXMKIAotICBXaXRoIC1QLCBwYXR0ZXJucyBsaWtl
IFtcZF0gbm93IHdvcmsgYWdhaW4uICBUaGUgZml4IHJlbGllcyBvbiBQQ1JFMgotICBzdXBw
b3J0IGZvciB0aGUgUENSRTJfRVhUUkFfQVNDSUlfQlNEIGZsYWcgcGxhbm5lZCBmb3IgUENS
RTIgMTAuNDMuCi0gIFdpdGggUENSRTIgdmVyc2lvbiAxMC40MiBvciBlYXJsaWVyLCBiZWhh
dmlvciByZXZlcnRzIHRvIHRoYXQgb2YKLSAgZ3JlcCAzLjgsIGluIHRoYXQgcGF0dGVybnMg
bGlrZSBcdyBhbmQgXGIgdXNlIEFTQ0lJIHJhdGhlciB0aGFuCi0gIFVuaWNvZGUgaW50ZXJw
cmV0YXRpb25zLgorICBXaXRoIC1QLCBwYXR0ZXJucyBsaWtlIFtcZF0gbm93IHdvcmsgYWdh
aW4uICBGaXhpbmcgdGhpcyBoYXMgY2F1c2VkCisgIGdyZXAgdG8gcmV2ZXJ0IHRvIHRoZSBi
ZWhhdmlvciBvZiBncmVwIDMuOCwgaW4gdGhhdCBwYXR0ZXJucyBsaWtlIFx3CisgIGFuZCBc
YiBnbyBiYWNrIHRvIHVzaW5nIEFTQ0lJIHJhdGhlciB0aGFuIFVuaWNvZGUgaW50ZXJwcmV0
YXRpb25zLgorICBIb3dldmVyLCBmdXR1cmUgdmVyc2lvbnMgb2YgR05VIGdyZXAgYW5kL29y
IFBDUkUyIGFyZSBsaWtlbHkgdG8gZml4CisgIHRoaXMgYW5kIGNoYW5nZSB0aGUgYmVoYXZp
b3Igb2YgXHcgYW5kIFxiIGJhY2sgdG8gVW5pY29kZSBhZ2FpbiwKKyAgd2l0aG91dCBicmVh
a2luZyBbXGRdIGFzIDMuMTAgZGlkLgogICBbYnVnIGludHJvZHVjZWQgaW4gZ3JlcCAzLjEw
XQogCiAgIGdyZXAgbm8gbG9uZ2VyIGZhaWxzIG9uIGZpbGVzIGRhdGVkIGFmdGVyIHRoZSB5
ZWFyIDIwMzgsCkBAIC0yNSw3ICsyNiw4IEBAIEdOVSBncmVwIE5FV1MgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAtKi0gb3V0bGluZSAtKi0KIAogICBwcmV2aW91cyB2
ZXJzaW9ucyBvZiBncmVwIHdvdWxkbid0IHJlc3BlY3QgdGhlIHVzZXIgcHJvdmlkZWQgc2V0
dGluZ3MgZm9yCiAgIFBDUkVfQ0ZMQUdTIGFuZCBQQ1JFX0xJQlMgd2hlbiBidWlsZGluZyBp
ZiBhIGxpYnBjcmUyLTggcGtnLWNvbmZpZyBtb2R1bGUKLSAgZm91bmQgaW4gdGhlIHN5c3Rl
bS4KKyAgd2FzIGZvdW5kLgorCiAKICogTm90ZXdvcnRoeSBjaGFuZ2VzIGluIHJlbGVhc2Ug
My4xMCAoMjAyMy0wMy0yMikgW3N0YWJsZV0KIApkaWZmIC0tZ2l0IGEvZG9jL2dyZXAudGV4
aSBiL2RvYy9ncmVwLnRleGkKaW5kZXggY2U2ZDZkYy4uZmYzMWQ1ZCAxMDA2NDQKLS0tIGEv
ZG9jL2dyZXAudGV4aQorKysgYi9kb2MvZ3JlcC50ZXhpCkBAIC0xMTU0LDE4ICsxMTU0LDE1
IEBAIEZvciBkb2N1bWVudGF0aW9uLCByZWZlciB0byBAdXJse2h0dHBzOi8vd3d3LnBjcmUu
b3JnL30sIHdpdGggdGhlc2UgY2F2ZWF0czoKIEBzYW1we1xkfSBtYXRjaGVzIG9ubHkgdGhl
IHRlbiBBU0NJSSBkaWdpdHMKIChhbmQgQHNhbXB7XER9IG1hdGNoZXMgdGhlIGNvbXBsZW1l
bnQpLCByZWdhcmRsZXNzIG9mIGxvY2FsZS4KIFVzZSBAc2FtcHtccEB7TmRAfX0gdG8gYWxz
byBtYXRjaCBub24tQVNDSUkgZGlnaXRzLgotCi1XaGVuIEBjb21tYW5ke2dyZXB9IGlzIGJ1
aWx0IHdpdGggUENSRTIgMTAuNDIgYW5kIGVhcmxpZXIsCi1Ac2FtcHtcZH0gYW5kIEBzYW1w
e1xEfSBpZ25vcmUgaW4tcmVnZXhwIGRpcmVjdGl2ZXMgbGlrZSBAc2FtcHsoP2FEKX0KLWFu
ZCB3b3JrIGxpa2UgQHNhbXB7WzAtOV19IGFuZCBAc2FtcHtbXjAtOV19IHJlc3BlY3RpdmVs
eS4KLUhvd2V2ZXIsIGxhdGVyIHZlcnNpb25zIG9mIFBDUkUyIGxpa2VseSB3aWxsIGZpeCB0
aGlzLAotYW5kIHRoZSBwbGFuIGlzIGZvciBAY29tbWFuZHtncmVwfSB0byByZXNwZWN0IHRo
b3NlIGRpcmVjdGl2ZXMgaWYgcG9zc2libGUuCisoVGhlIGJlaGF2aW9yIG9mIEBzYW1we1xk
fSBhbmQgQHNhbXB7XER9IGlzIHVuc3BlY2lmaWVkIGFmdGVyCitpbi1yZWdleHAgZGlyZWN0
aXZlcyBsaWtlIEBzYW1weyg/YUQpfS4pCiAKIEBpdGVtCiBBbHRob3VnaCBQQ1JFIHRyYWNr
cyB0aGUgc3ludGF4IGFuZCBzZW1hbnRpY3Mgb2YgUGVybCdzIHJlZ3VsYXIKLWV4cHJlc3Np
b25zLCB0aGUgbWF0Y2ggaXMgbm90IGFsd2F5cyBleGFjdCwgcGFydGx5IGJlY2F1c2UgUGVy
bAorZXhwcmVzc2lvbnMsIHRoZSBtYXRjaCBpcyBub3QgYWx3YXlzIGV4YWN0LiAgRm9yIGV4
YW1wbGUsIFBlcmwKIGV2b2x2ZXMgYW5kIGEgUGVybCBpbnN0YWxsYXRpb24gbWF5IHByZWRh
dGUgb3IgcG9zdGRhdGUgdGhlIFBDUkUyCi1pbnN0YWxsYXRpb24gb24gdGhlIHNhbWUgaG9z
dC4KK2luc3RhbGxhdGlvbiBvbiB0aGUgc2FtZSBob3N0LCBvciB0aGVpciBVbmljb2RlIHZl
cnNpb25zIG1heSBkaWZmZXIsCitvciBQZXJsIGFuZCBQQ1JFMiBtYXkgZGlzYWdyZWUgYWJv
dXQgYW4gb2JzY3VyZSBjb25zdHJ1Y3QuCiAKIEBpdGVtCiBCeSBkZWZhdWx0LCBAY29tbWFu
ZHtncmVwfSBhcHBsaWVzIGVhY2ggcmVnZXhwIHRvIGEgbGluZSBhdCBhIHRpbWUsCi0tIAoy
LjM5LjIKCg==

--------------IDK4hagaOv1Xh1BciSgtTXi4--
