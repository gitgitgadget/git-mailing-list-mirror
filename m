From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] merge: refuse to create too cool a merge by default
Date: Fri, 18 Mar 2016 13:25:44 -0700
Message-ID: <CA+55aFz7309BkfHjD5H7tp9WE0yf1VWncxfmB3hgimJ00fbT-Q@mail.gmail.com>
References: <xmqqshznpmfe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1134b82037f5bf052e588daf
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 21:25:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah0xy-0003kC-9E
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 21:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbcCRUZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 16:25:47 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38289 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbcCRUZp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 16:25:45 -0400
Received: by mail-ig0-f171.google.com with SMTP id ig19so30145143igb.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=CbX3MSLSzCPWmPybxQqW9HAHaqIaUGdboiXEq9LJGm8=;
        b=BrLHu7Bo/MKgZsQcJfH4X8d080HBe39BmuC+DuhgjbnZE6MSJ6EnmyMovwVA2VRk07
         ISe6LH9heA9j+RGdoxuC+B4+MEQqp13CmD7CXH94eMpjM5ykAHMmJD7ZQBs+62J9g6F3
         jNsxnaCDem454tu50cnI5qbo2hgT4fh0jw4FSUywhra6KSIvOrn4n2iIDLk5CzPKuKkn
         6SL0uQxksd0v00+vepR4oKMcVT4Vk3T/xd/L02WKSE+G6t4kVNFRj6/HQVWQJwlvk1q7
         ISu5r5NN6+KHD/bccrKRwHOV70bcvOmm8Ndw2GsLzM+BVUF/bdcegUHhHqcd/5NaP3Vb
         t55g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=CbX3MSLSzCPWmPybxQqW9HAHaqIaUGdboiXEq9LJGm8=;
        b=N8Yq1BLjm058ltir+EWOPiJjp6JuvszTvD/lMpFyIEDdpedMsLUZPB47vwqCU3WBgK
         6tA+u0gU1OGFvgD/FSi8VLwwF0WOFz0dnWKXzgQmi8o7i/qHxD2lp7GfCByo2AKDTCqM
         jE1N7IFHU757QWD+6cQjOqehVYKKZgKeCO6W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=CbX3MSLSzCPWmPybxQqW9HAHaqIaUGdboiXEq9LJGm8=;
        b=gftc4AfaWaWP7TWXFZog52nVdMT1Wd3Q8THahJmz7Gk46iMvGocO+haoMfSnbJc7Ek
         KDVi8NEyaXgqMJn50VV+zfJXOWXOt6N/cHk8XFjER3s86vwjB6Vs8EORaCZxYrbuls7R
         EbuwheLGQaP+2ot88DCXC1/ryhsFsdbDMeqePpjfmcrK016gUW9kjKhrmnS4Of7TTctU
         leyTjdDeUFrYKPMCtz87SZavY3X/KLbJK7ADKo9LeCVRhr6Yynz2uZsw9f3i3nE/u+Lf
         PLv2vySunK0aiotRIfoM7vSg1gjuV13b4hNDVDZjBOOhZk/ZkGf1yGrcKNlDe76UepYd
         i4Mw==
X-Gm-Message-State: AD7BkJLjdqk/YVI8M1Q6pStjdEMD4jcjRMhl+NmpfLhfrH1L2NQ2pAM272Ec2hgVcJSBZa/4IG66JtNRKD7x8Q==
X-Received: by 10.51.17.38 with SMTP id gb6mr1309943igd.45.1458332744746; Fri,
 18 Mar 2016 13:25:44 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Fri, 18 Mar 2016 13:25:44 -0700 (PDT)
In-Reply-To: <xmqqshznpmfe.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: fPrLlgaJnNayAYyOkpB0eg5o8uU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289249>

--001a1134b82037f5bf052e588daf
Content-Type: text/plain; charset=UTF-8

On Fri, Mar 18, 2016 at 1:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> While it makes sense to allow merging unrelated histories of two
> projects that started independently into one, in the way "gitk" was
> merged to "git" itself aka "the coolest merge ever", such a merge is
> still an unusual event.  Worse, if somebody creates an independent
> history by starting from a tarball of an established project and
> sends a pull request to the original project, "git merge" however
> happily creates such a merge without any sign of something unusual
> is happening.
>
> Teach "git merge" to refuse to create such a merge by default,
> unless the user passes a new "--allow-unrelated-histories" option to
> tell it that the user is aware that two unrelated projects are
> merged.

Heh. I had a separate set of patches for you, but hadn't sent them out
because of the other test failures (which you also worked out).

Mine was slightly different, I just went with a "unrelated" merge option.

I'll attach my two patches anyway, if for no other reason than the
fact that I actually wrote a new test for this.

Feel free to ignore my patches, they have nothing really different
from yours, just slightly different implementation.

                  Linus

--001a1134b82037f5bf052e588daf
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-t3035-test-merging-of-unrelated-branches.patch"
Content-Disposition: attachment; 
	filename="0001-t3035-test-merging-of-unrelated-branches.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ily5npvh0

RnJvbSAwZjNlNGE5Mjk0ZWVkYTY3OTllM2U1MGUyODgwOTEzMzIzMzEyNmRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IEZyaSwgMTggTWFyIDIwMTYgMTI6NDY6MDYgLTA3MDAKU3ViamVjdDog
W1BBVENIIDEvMl0gdDMwMzU6IHRlc3QgbWVyZ2luZyBvZiB1bnJlbGF0ZWQgYnJhbmNoZXMKClJp
Z2h0IG5vdyB0aGlzIHN1Y2NlZWRzLCBhbmQgdGhlIHRlc3QgYWN0dWFsbHkgdmVyaWZpZXMgdGhh
dCBiZWhhdmlvci4KClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51
eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiB0L3QzMDM1LW1lcmdlLXJlY3Vyc2l2ZS1hY3Jvc3MtcHJv
amVjdC5zaCB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAyOCBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA3NTUgdC90MzAzNS1tZXJnZS1yZWN1
cnNpdmUtYWNyb3NzLXByb2plY3Quc2gKCmRpZmYgLS1naXQgYS90L3QzMDM1LW1lcmdlLXJlY3Vy
c2l2ZS1hY3Jvc3MtcHJvamVjdC5zaCBiL3QvdDMwMzUtbWVyZ2UtcmVjdXJzaXZlLWFjcm9zcy1w
cm9qZWN0LnNoCm5ldyBmaWxlIG1vZGUgMTAwNzU1CmluZGV4IDAwMDAwMDAwMDAwMC4uYjVkNjE0
ZGI2YjA4Ci0tLSAvZGV2L251bGwKKysrIGIvdC90MzAzNS1tZXJnZS1yZWN1cnNpdmUtYWNyb3Nz
LXByb2plY3Quc2gKQEAgLTAsMCArMSwyOCBAQAorIyEvYmluL3NoCisKK3Rlc3RfZGVzY3JpcHRp
b249J21lcmdlLXJlY3Vyc2l2ZSB3aXRoIHVucmVsYXRlZCBwcm9qZWN0cworCitUZXN0IHJlbmFt
ZSBkZXRlY3Rpb24gYnkgZXhhbWluaW5nIHJlbmFtZS9kZWxldGUgY29uZmxpY3RzLgorCisgKiBB
OiBmaWxlIEEKKworICogQjogZmlsZSBCCisnCisKKy4gLi90ZXN0LWxpYi5zaAorCit0ZXN0X2V4
cGVjdF9zdWNjZXNzICdzZXR1cCByZXBvc2l0b3J5JyBcCisJJ2VjaG8gSGVsbG8gPkEgJiYKKwkg
Z2l0IGFkZCBBICYmCisJIGdpdCBjb21taXQgLW0gIkJyYW5jaCBBIiBBICYmCisJIGdpdCBicmFu
Y2ggQSAmJgorCSBnaXQgbXYgQSBCICYmCisJIGVjaG8gSGkgPkIgJiYKKwkgZ2l0IGNvbW1pdCAt
bSAiQnJhbmNoIEIiIC0tYW1lbmQgQiAmJgorCSBnaXQgYnJhbmNoIEInCisKK3Rlc3RfZXhwZWN0
X3N1Y2Nlc3MgJ21lcmdlIHVucmVsYXRlZCBicmFuY2hlcycgXAorCSdnaXQgY2hlY2tvdXQgLWIg
bWVyZ2VkIEEgJiYKKwkgZ2l0IG1lcmdlIEInCisKK3Rlc3RfZG9uZQotLSAKMi44LjAucmMzLjku
ZzQ0OTE1ZGIKCg==
--001a1134b82037f5bf052e588daf
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0002-merge-fail-merging-of-unrelated-branches.patch"
Content-Disposition: attachment; 
	filename="0002-merge-fail-merging-of-unrelated-branches.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ily5npw41

RnJvbSBjZDZiMjM4OGM3M2YzN2IzZGQ2MTgwZDlhNDI5OTNmZDIxOWViYjMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IEZyaSwgMTggTWFyIDIwMTYgMTI6NTc6MzAgLTA3MDAKU3ViamVjdDog
W1BBVENIIDIvMl0gbWVyZ2U6IGZhaWwgbWVyZ2luZyBvZiB1bnJlbGF0ZWQgYnJhbmNoZXMKCkFk
ZCB0ZXN0IGZvciB0aGlzLCBhbmQgYWRkIHRoZSAidW5yZWxhdGVkIiBtZXJnZSBvcHRpb24gdG8g
YWxsb3cgaXQgdG8gc3VjY2VlZC4KClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2
YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBtZXJnZS1yZWN1cnNpdmUuYyAgICAgICAg
ICAgICAgICAgICAgICAgICB8IDYgKysrKysrCiBtZXJnZS1yZWN1cnNpdmUuaCAgICAgICAgICAg
ICAgICAgICAgICAgICB8IDEgKwogdC90MzAzNS1tZXJnZS1yZWN1cnNpdmUtYWNyb3NzLXByb2pl
Y3Quc2ggfCA3ICsrKysrLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tZXJnZS1yZWN1cnNpdmUuYyBiL21lcmdlLXJlY3Vy
c2l2ZS5jCmluZGV4IGI4ODBhZTUwZTdlZS4uOTI3NzlkYjBiYmU2IDEwMDY0NAotLS0gYS9tZXJn
ZS1yZWN1cnNpdmUuYworKysgYi9tZXJnZS1yZWN1cnNpdmUuYwpAQCAtMTkyNyw2ICsxOTI3LDkg
QEAgaW50IG1lcmdlX3JlY3Vyc2l2ZShzdHJ1Y3QgbWVyZ2Vfb3B0aW9ucyAqbywKIAkJLyogaWYg
dGhlcmUgaXMgbm8gY29tbW9uIGFuY2VzdG9yLCB1c2UgYW4gZW1wdHkgdHJlZSAqLwogCQlzdHJ1
Y3QgdHJlZSAqdHJlZTsKIAorCQlpZiAoIW8tPmFsbG93X3VucmVsYXRlZCkKKwkJCWRpZShfKCJ3
aWxsIG5vdCBtZXJnZSB1bnJlbGF0ZWQgYnJhbmNoZXMiKSk7CisKIAkJdHJlZSA9IGxvb2t1cF90
cmVlKEVNUFRZX1RSRUVfU0hBMV9CSU4pOwogCQltZXJnZWRfY29tbW9uX2FuY2VzdG9ycyA9IG1h
a2VfdmlydHVhbF9jb21taXQodHJlZSwgImFuY2VzdG9yIik7CiAJfQpAQCAtMjAzOSw2ICsyMDQy
LDcgQEAgdm9pZCBpbml0X21lcmdlX29wdGlvbnMoc3RydWN0IG1lcmdlX29wdGlvbnMgKm8pCiAJ
bWVtc2V0KG8sIDAsIHNpemVvZihzdHJ1Y3QgbWVyZ2Vfb3B0aW9ucykpOwogCW8tPnZlcmJvc2l0
eSA9IDI7CiAJby0+YnVmZmVyX291dHB1dCA9IDE7CisJby0+YWxsb3dfdW5yZWxhdGVkID0gMDsK
IAlvLT5kaWZmX3JlbmFtZV9saW1pdCA9IC0xOwogCW8tPm1lcmdlX3JlbmFtZV9saW1pdCA9IC0x
OwogCW8tPnJlbm9ybWFsaXplID0gMDsKQEAgLTIwOTIsNiArMjA5Niw4IEBAIGludCBwYXJzZV9t
ZXJnZV9vcHQoc3RydWN0IG1lcmdlX29wdGlvbnMgKm8sIGNvbnN0IGNoYXIgKnMpCiAJCW8tPnJl
bm9ybWFsaXplID0gMTsKIAllbHNlIGlmICghc3RyY21wKHMsICJuby1yZW5vcm1hbGl6ZSIpKQog
CQlvLT5yZW5vcm1hbGl6ZSA9IDA7CisJZWxzZSBpZiAoIXN0cmNtcChzLCAidW5yZWxhdGVkIikp
CisJCW8tPmFsbG93X3VucmVsYXRlZCA9IDE7CiAJZWxzZSBpZiAoIXN0cmNtcChzLCAibm8tcmVu
YW1lcyIpKQogCQlvLT5kZXRlY3RfcmVuYW1lID0gMDsKIAllbHNlIGlmICghc3RyY21wKHMsICJm
aW5kLXJlbmFtZXMiKSkgewpkaWZmIC0tZ2l0IGEvbWVyZ2UtcmVjdXJzaXZlLmggYi9tZXJnZS1y
ZWN1cnNpdmUuaAppbmRleCA1MmYwMjAxZjY4YTMuLjE5ZWI1MmVlYjczMiAxMDA2NDQKLS0tIGEv
bWVyZ2UtcmVjdXJzaXZlLmgKKysrIGIvbWVyZ2UtcmVjdXJzaXZlLmgKQEAgLTE1LDYgKzE1LDcg
QEAgc3RydWN0IG1lcmdlX29wdGlvbnMgewogCWNvbnN0IGNoYXIgKnN1YnRyZWVfc2hpZnQ7CiAJ
dW5zaWduZWQgYnVmZmVyX291dHB1dCA6IDE7CiAJdW5zaWduZWQgcmVub3JtYWxpemUgOiAxOwor
CXVuc2lnbmVkIGFsbG93X3VucmVsYXRlZCA6IDE7CiAJbG9uZyB4ZGxfb3B0czsKIAlpbnQgdmVy
Ym9zaXR5OwogCWludCBkZXRlY3RfcmVuYW1lOwpkaWZmIC0tZ2l0IGEvdC90MzAzNS1tZXJnZS1y
ZWN1cnNpdmUtYWNyb3NzLXByb2plY3Quc2ggYi90L3QzMDM1LW1lcmdlLXJlY3Vyc2l2ZS1hY3Jv
c3MtcHJvamVjdC5zaAppbmRleCBiNWQ2MTRkYjZiMDguLjg3OTAyZjFjOGY2NiAxMDA3NTUKLS0t
IGEvdC90MzAzNS1tZXJnZS1yZWN1cnNpdmUtYWNyb3NzLXByb2plY3Quc2gKKysrIGIvdC90MzAz
NS1tZXJnZS1yZWN1cnNpdmUtYWNyb3NzLXByb2plY3Quc2gKQEAgLTIxLDggKzIxLDExIEBAIHRl
c3RfZXhwZWN0X3N1Y2Nlc3MgJ3NldHVwIHJlcG9zaXRvcnknIFwKIAkgZ2l0IGNvbW1pdCAtbSAi
QnJhbmNoIEIiIC0tYW1lbmQgQiAmJgogCSBnaXQgYnJhbmNoIEInCiAKLXRlc3RfZXhwZWN0X3N1
Y2Nlc3MgJ21lcmdlIHVucmVsYXRlZCBicmFuY2hlcycgXAordGVzdF9leHBlY3Rfc3VjY2VzcyAn
ZmFpbCBtZXJnaW5nIG9mIHVucmVsYXRlZCBicmFuY2hlcycgXAogCSdnaXQgY2hlY2tvdXQgLWIg
bWVyZ2VkIEEgJiYKLQkgZ2l0IG1lcmdlIEInCisJIHRlc3RfbXVzdF9mYWlsIGdpdCBtZXJnZSBC
JworCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdleHBsaWNpdGx5IG1lcmdlIHVucmVsYXRlZCBicmFu
Y2hlcycgXAorCSdnaXQgbWVyZ2UgLVh1bnJlbGF0ZWQgQicKIAogdGVzdF9kb25lCi0tIAoyLjgu
MC5yYzMuOS5nNDQ5MTVkYgoK
--001a1134b82037f5bf052e588daf--
