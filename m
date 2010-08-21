From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: t5560-http-backend-noserver.sh fails on FreeBSD 8.1-STABLE
Date: Sat, 21 Aug 2010 08:06:39 +0000
Message-ID: <AANLkTimm9uXRxcwL=o1JE_voOOYVNo-1V-+Sx78votJO@mail.gmail.com>
References: <AANLkTin8KvXBn4R3-_2_wG3B3QU9F1X0Ax69Rrb1cw1y@mail.gmail.com>
	<AANLkTimPpiO2RBbNNo0Z8mFm1VH_Ujk7HVskYvh=X2Fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5afd31ebe48048e50e51d
Cc: Git Mailing List <git@vger.kernel.org>
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 10:06:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omj6H-0005lM-Kv
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 10:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab0HUIGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 04:06:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58402 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518Ab0HUIGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 04:06:40 -0400
Received: by fxm13 with SMTP id 13so2198342fxm.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 01:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=3GMCwRcrMTce5+lhgFUEqapFWwBfsNQ9F0Dw5Dmi9mQ=;
        b=H3YbZuYs+pCSYY8LVt29IsgO4TcOsgixmQvkSrlT0Npzgz2vuJCkaUqq0JO5RhhlQM
         iBsPrO5UtJkULTWz0SU6ix5rJpaoa3RCmZtaoWViVcd/PHqzIqDXYOaSCRA8yR7xBDbF
         1wdhCjho/Gtem9o893RDf5HC88kywzh3oGRv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KBwjUgYvNVr/1+RGa4XHnqd+JIHmlV3Bz3AC9121e3RE7m3pwgJIiPyTjVOOIsRl1f
         AFou5ccXY/IvY7iSp7fXrwGdt0iCeOQl28WEkULxgmd/ABlra1lIikAUTnlZYC50zDRk
         4+EftoSDO+O8NrRtVvxHGBtBKZ6QOOvNiHl08=
Received: by 10.223.116.193 with SMTP id n1mr1384435faq.77.1282377999367; Sat,
 21 Aug 2010 01:06:39 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Sat, 21 Aug 2010 01:06:39 -0700 (PDT)
In-Reply-To: <AANLkTimPpiO2RBbNNo0Z8mFm1VH_Ujk7HVskYvh=X2Fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154124>

--001636c5afd31ebe48048e50e51d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 21, 2010 at 07:57, Tarmigan <tarmigan+git@gmail.com> wrote:
> On Thu, Aug 19, 2010 at 9:56 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> I haven't investigate this, but here's the failure output:
>>
>> ok 7 - static file if http.getanyfile false fails
>>
>> expecting success:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0log_div "uploadpack default"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0GET info/refs?service=3Dgit-upload-pack "200 =
OK" =C2=A0&&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0POST git-upload-pack 0000 "200 OK"
>>
>> --- exp 2010-08-19 15:56:14.000000000 +0000
>> +++ act 2010-08-19 15:56:14.000000000 +0000
>> @@ -1 +1 @@
>> -Status: 200 OK
>> +Status: 404 Not Found
>> not ok - 8 http.uploadpack default enabled
>> #
>> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log_div "uploadpack d=
efault"
>> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GET info/refs?service=
=3Dgit-upload-pack "200 OK" =C2=A0&&
>> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 POST git-upload-pack =
0000 "200 OK"
>> #
>>
>
> Thanks for the report. =C2=A0Is this a new breakage and what version is i=
t
> failing on?
>
> Do you ever test with GIT_TEST_HTTPD set? =C2=A0If not, can you please tr=
y this
> =C2=A0 =C2=A0 export GIT_TEST_HTTPD=3D1 && ./t5561-http-backend.sh -d -i =
-v
> and report back? =C2=A0Hopefully the test suite will automatically find
> apache on FreeBSD, otherwise you may need to give it some hints (see
> lib-httpd.sh).

Here are the outputs of:

$ GIT_TEST_HTTPD=3D ./t5560-http-backend-noserver.sh -d -i -v >
/tmp/no-httpd.txt 2>&1
$ GIT_TEST_HTTPD=3D1 ./t5560-http-backend-noserver.sh -d -i -v >
/tmp/with-httpd.txt 2>&1

Can't investigate this further now, sorry.

--001636c5afd31ebe48048e50e51d
Content-Type: text/plain; charset=US-ASCII; name="with-httpd.txt"
Content-Disposition: attachment; filename="with-httpd.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gd46ptak0

SW5pdGlhbGl6ZWQgZW1wdHkgR2l0IHJlcG9zaXRvcnkgaW4gL3Vzci9ob21lL2F2YXIvZy9naXQv
dC90cmFzaCBkaXJlY3RvcnkudDU1NjAtaHR0cC1iYWNrZW5kLW5vc2VydmVyLy5naXQvCmV4cGVj
dGluZyBzdWNjZXNzOiAKCWVjaG8gY29udGVudCA+ZmlsZSAmJgoJZ2l0IGFkZCBmaWxlICYmCgln
aXQgY29tbWl0IC1tIG9uZSAmJgoKCW1rZGlyICIkSFRUUERfRE9DVU1FTlRfUk9PVF9QQVRIL3Jl
cG8uZ2l0IiAmJgoJKGNkICIkSFRUUERfRE9DVU1FTlRfUk9PVF9QQVRIL3JlcG8uZ2l0IiAmJgoJ
IGdpdCAtLWJhcmUgaW5pdCAmJgoJIDogPm9iamVjdHMvaW5mby9hbHRlcm5hdGVzICYmCgkgOiA+
b2JqZWN0cy9pbmZvL2h0dHAtYWx0ZXJuYXRlcwoJKSAmJgoJZ2l0IHJlbW90ZSBhZGQgcHVibGlj
ICIkSFRUUERfRE9DVU1FTlRfUk9PVF9QQVRIL3JlcG8uZ2l0IiAmJgoJZ2l0IHB1c2ggcHVibGlj
IG1hc3RlcjptYXN0ZXIgJiYKCgkoY2QgIiRIVFRQRF9ET0NVTUVOVF9ST09UX1BBVEgvcmVwby5n
aXQiICYmCgkgZ2l0IHJlcGFjayAtYSAtZAoJKSAmJgoKCWVjaG8gb3RoZXIgPmZpbGUgJiYKCWdp
dCBhZGQgZmlsZSAmJgoJZ2l0IGNvbW1pdCAtbSB0d28gJiYKCWdpdCBwdXNoIHB1YmxpYyBtYXN0
ZXI6bWFzdGVyICYmCgoJTE9PU0VfVVJMPSQoZmluZF9maWxlIG9iamVjdHMvPz8pICYmCglQQUNL
X1VSTD0kKGZpbmRfZmlsZSBvYmplY3RzL3BhY2svKi5wYWNrKSAmJgoJSURYX1VSTD0kKGZpbmRf
ZmlsZSBvYmplY3RzL3BhY2svKi5pZHgpCgpbbWFzdGVyIChyb290LWNvbW1pdCkgZTAwZDJkMF0g
b25lCiBBdXRob3I6IEEgVSBUaG9yIDxhdXRob3JAZXhhbXBsZS5jb20+CiAxIGZpbGVzIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBm
aWxlCkluaXRpYWxpemVkIGVtcHR5IEdpdCByZXBvc2l0b3J5IGluIC91c3IvaG9tZS9hdmFyL2cv
Z2l0L3QvdHJhc2ggZGlyZWN0b3J5LnQ1NTYwLWh0dHAtYmFja2VuZC1ub3NlcnZlci9yZXBvLmdp
dC8KVG8gL3Vzci9ob21lL2F2YXIvZy9naXQvdC90cmFzaCBkaXJlY3RvcnkudDU1NjAtaHR0cC1i
YWNrZW5kLW5vc2VydmVyL3JlcG8uZ2l0CiAqIFtuZXcgYnJhbmNoXSAgICAgIG1hc3RlciAtPiBt
YXN0ZXIKW21hc3RlciBlMTAxMDkwXSB0d28KIEF1dGhvcjogQSBVIFRob3IgPGF1dGhvckBleGFt
cGxlLmNvbT4KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygt
KQpUbyAvdXNyL2hvbWUvYXZhci9nL2dpdC90L3RyYXNoIGRpcmVjdG9yeS50NTU2MC1odHRwLWJh
Y2tlbmQtbm9zZXJ2ZXIvcmVwby5naXQKICAgZTAwZDJkMC4uZTEwMTA5MCAgbWFzdGVyIC0+IG1h
c3RlcgpvayAxIC0gc2V0dXAgcmVwb3NpdG9yeQoKZXhwZWN0aW5nIHN1Y2Nlc3M6IAoJbG9nX2Rp
diAicmVmcy9oZWFkcy9tYXN0ZXIiCglHRVQgcmVmcy9oZWFkcy9tYXN0ZXIgIjQwNCBOb3QgRm91
bmQiCgpvayAyIC0gZGlyZWN0IHJlZnMvaGVhZHMvbWFzdGVyIG5vdCBmb3VuZAoKZXhwZWN0aW5n
IHN1Y2Nlc3M6IAoJbG9nX2RpdiAiZ2V0YW55ZmlsZSBkZWZhdWx0IgoJZ2V0X3N0YXRpY19maWxl
cyAiMjAwIE9LIgoKb2sgMyAtIHN0YXRpYyBmaWxlIGlzIG9rCgpleHBlY3Rpbmcgc3VjY2Vzczog
Cglsb2dfZGl2ICJubyBnaXQtZGFlbW9uLWV4cG9ydC1vayIKCWdldF9zdGF0aWNfZmlsZXMgIjQw
NCBOb3QgRm91bmQiCgpvayA0IC0gbm8gZXhwb3J0IGJ5IGRlZmF1bHQKCmV4cGVjdGluZyBzdWNj
ZXNzOiAKCWxvZ19kaXYgImdpdC1kYWVtb24tZXhwb3J0LW9rIgogICAgICAgIChjZCAiJEhUVFBE
X0RPQ1VNRU5UX1JPT1RfUEFUSC9yZXBvLmdpdCIgJiYKCSB0b3VjaCBnaXQtZGFlbW9uLWV4cG9y
dC1vawoJKSAmJgogICAgICAgIGdldF9zdGF0aWNfZmlsZXMgIjIwMCBPSyIKCm9rIDUgLSBleHBv
cnQgaWYgZ2l0LWRhZW1vbi1leHBvcnQtb2sKCmV4cGVjdGluZyBzdWNjZXNzOiAKCWxvZ19kaXYg
ImdldGFueWZpbGUgdHJ1ZSIKCWNvbmZpZyBodHRwLmdldGFueWZpbGUgdHJ1ZSAmJgoJZ2V0X3N0
YXRpY19maWxlcyAiMjAwIE9LIgoKb2sgNiAtIHN0YXRpYyBmaWxlIGlmIGh0dHAuZ2V0YW55Zmls
ZSB0cnVlIGlzIG9rCgpleHBlY3Rpbmcgc3VjY2VzczogCglsb2dfZGl2ICJnZXRhbnlmaWxlIGZh
bHNlIgoJY29uZmlnIGh0dHAuZ2V0YW55ZmlsZSBmYWxzZSAmJgoJZ2V0X3N0YXRpY19maWxlcyAi
NDAzIEZvcmJpZGRlbiIKCm9rIDcgLSBzdGF0aWMgZmlsZSBpZiBodHRwLmdldGFueWZpbGUgZmFs
c2UgZmFpbHMKCmV4cGVjdGluZyBzdWNjZXNzOiAKCWxvZ19kaXYgInVwbG9hZHBhY2sgZGVmYXVs
dCIKCUdFVCBpbmZvL3JlZnM/c2VydmljZT1naXQtdXBsb2FkLXBhY2sgIjIwMCBPSyIgICYmCglQ
T1NUIGdpdC11cGxvYWQtcGFjayAwMDAwICIyMDAgT0siCgotLS0gZXhwCTIwMTAtMDgtMjEgMDg6
MDQ6NTcuMDAwMDAwMDAwICswMDAwCisrKyBhY3QJMjAxMC0wOC0yMSAwODowNDo1Ny4wMDAwMDAw
MDAgKzAwMDAKQEAgLTEgKzEgQEAKLVN0YXR1czogMjAwIE9LDQorU3RhdHVzOiA0MDQgTm90IEZv
dW5kDQpub3Qgb2sgLSA4IGh0dHAudXBsb2FkcGFjayBkZWZhdWx0IGVuYWJsZWQKIwkKIwkJbG9n
X2RpdiAidXBsb2FkcGFjayBkZWZhdWx0IgojCQlHRVQgaW5mby9yZWZzP3NlcnZpY2U9Z2l0LXVw
bG9hZC1wYWNrICIyMDAgT0siICAmJgojCQlQT1NUIGdpdC11cGxvYWQtcGFjayAwMDAwICIyMDAg
T0siCiMJCg==
--001636c5afd31ebe48048e50e51d
Content-Type: text/plain; charset=US-ASCII; name="no-httpd.txt"
Content-Disposition: attachment; filename="no-httpd.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gd46q0981

SW5pdGlhbGl6ZWQgZW1wdHkgR2l0IHJlcG9zaXRvcnkgaW4gL3Vzci9ob21lL2F2YXIvZy9naXQv
dC90cmFzaCBkaXJlY3RvcnkudDU1NjAtaHR0cC1iYWNrZW5kLW5vc2VydmVyLy5naXQvCmV4cGVj
dGluZyBzdWNjZXNzOiAKCWVjaG8gY29udGVudCA+ZmlsZSAmJgoJZ2l0IGFkZCBmaWxlICYmCgln
aXQgY29tbWl0IC1tIG9uZSAmJgoKCW1rZGlyICIkSFRUUERfRE9DVU1FTlRfUk9PVF9QQVRIL3Jl
cG8uZ2l0IiAmJgoJKGNkICIkSFRUUERfRE9DVU1FTlRfUk9PVF9QQVRIL3JlcG8uZ2l0IiAmJgoJ
IGdpdCAtLWJhcmUgaW5pdCAmJgoJIDogPm9iamVjdHMvaW5mby9hbHRlcm5hdGVzICYmCgkgOiA+
b2JqZWN0cy9pbmZvL2h0dHAtYWx0ZXJuYXRlcwoJKSAmJgoJZ2l0IHJlbW90ZSBhZGQgcHVibGlj
ICIkSFRUUERfRE9DVU1FTlRfUk9PVF9QQVRIL3JlcG8uZ2l0IiAmJgoJZ2l0IHB1c2ggcHVibGlj
IG1hc3RlcjptYXN0ZXIgJiYKCgkoY2QgIiRIVFRQRF9ET0NVTUVOVF9ST09UX1BBVEgvcmVwby5n
aXQiICYmCgkgZ2l0IHJlcGFjayAtYSAtZAoJKSAmJgoKCWVjaG8gb3RoZXIgPmZpbGUgJiYKCWdp
dCBhZGQgZmlsZSAmJgoJZ2l0IGNvbW1pdCAtbSB0d28gJiYKCWdpdCBwdXNoIHB1YmxpYyBtYXN0
ZXI6bWFzdGVyICYmCgoJTE9PU0VfVVJMPSQoZmluZF9maWxlIG9iamVjdHMvPz8pICYmCglQQUNL
X1VSTD0kKGZpbmRfZmlsZSBvYmplY3RzL3BhY2svKi5wYWNrKSAmJgoJSURYX1VSTD0kKGZpbmRf
ZmlsZSBvYmplY3RzL3BhY2svKi5pZHgpCgpbbWFzdGVyIChyb290LWNvbW1pdCkgMGJmY2ZlNF0g
b25lCiBBdXRob3I6IEEgVSBUaG9yIDxhdXRob3JAZXhhbXBsZS5jb20+CiAxIGZpbGVzIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBm
aWxlCkluaXRpYWxpemVkIGVtcHR5IEdpdCByZXBvc2l0b3J5IGluIC91c3IvaG9tZS9hdmFyL2cv
Z2l0L3QvdHJhc2ggZGlyZWN0b3J5LnQ1NTYwLWh0dHAtYmFja2VuZC1ub3NlcnZlci9yZXBvLmdp
dC8KVG8gL3Vzci9ob21lL2F2YXIvZy9naXQvdC90cmFzaCBkaXJlY3RvcnkudDU1NjAtaHR0cC1i
YWNrZW5kLW5vc2VydmVyL3JlcG8uZ2l0CiAqIFtuZXcgYnJhbmNoXSAgICAgIG1hc3RlciAtPiBt
YXN0ZXIKW21hc3RlciBkODllMWNkXSB0d28KIEF1dGhvcjogQSBVIFRob3IgPGF1dGhvckBleGFt
cGxlLmNvbT4KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygt
KQpUbyAvdXNyL2hvbWUvYXZhci9nL2dpdC90L3RyYXNoIGRpcmVjdG9yeS50NTU2MC1odHRwLWJh
Y2tlbmQtbm9zZXJ2ZXIvcmVwby5naXQKICAgMGJmY2ZlNC4uZDg5ZTFjZCAgbWFzdGVyIC0+IG1h
c3RlcgpvayAxIC0gc2V0dXAgcmVwb3NpdG9yeQoKZXhwZWN0aW5nIHN1Y2Nlc3M6IAoJbG9nX2Rp
diAicmVmcy9oZWFkcy9tYXN0ZXIiCglHRVQgcmVmcy9oZWFkcy9tYXN0ZXIgIjQwNCBOb3QgRm91
bmQiCgpvayAyIC0gZGlyZWN0IHJlZnMvaGVhZHMvbWFzdGVyIG5vdCBmb3VuZAoKZXhwZWN0aW5n
IHN1Y2Nlc3M6IAoJbG9nX2RpdiAiZ2V0YW55ZmlsZSBkZWZhdWx0IgoJZ2V0X3N0YXRpY19maWxl
cyAiMjAwIE9LIgoKb2sgMyAtIHN0YXRpYyBmaWxlIGlzIG9rCgpleHBlY3Rpbmcgc3VjY2Vzczog
Cglsb2dfZGl2ICJubyBnaXQtZGFlbW9uLWV4cG9ydC1vayIKCWdldF9zdGF0aWNfZmlsZXMgIjQw
NCBOb3QgRm91bmQiCgpvayA0IC0gbm8gZXhwb3J0IGJ5IGRlZmF1bHQKCmV4cGVjdGluZyBzdWNj
ZXNzOiAKCWxvZ19kaXYgImdpdC1kYWVtb24tZXhwb3J0LW9rIgogICAgICAgIChjZCAiJEhUVFBE
X0RPQ1VNRU5UX1JPT1RfUEFUSC9yZXBvLmdpdCIgJiYKCSB0b3VjaCBnaXQtZGFlbW9uLWV4cG9y
dC1vawoJKSAmJgogICAgICAgIGdldF9zdGF0aWNfZmlsZXMgIjIwMCBPSyIKCm9rIDUgLSBleHBv
cnQgaWYgZ2l0LWRhZW1vbi1leHBvcnQtb2sKCmV4cGVjdGluZyBzdWNjZXNzOiAKCWxvZ19kaXYg
ImdldGFueWZpbGUgdHJ1ZSIKCWNvbmZpZyBodHRwLmdldGFueWZpbGUgdHJ1ZSAmJgoJZ2V0X3N0
YXRpY19maWxlcyAiMjAwIE9LIgoKb2sgNiAtIHN0YXRpYyBmaWxlIGlmIGh0dHAuZ2V0YW55Zmls
ZSB0cnVlIGlzIG9rCgpleHBlY3Rpbmcgc3VjY2VzczogCglsb2dfZGl2ICJnZXRhbnlmaWxlIGZh
bHNlIgoJY29uZmlnIGh0dHAuZ2V0YW55ZmlsZSBmYWxzZSAmJgoJZ2V0X3N0YXRpY19maWxlcyAi
NDAzIEZvcmJpZGRlbiIKCm9rIDcgLSBzdGF0aWMgZmlsZSBpZiBodHRwLmdldGFueWZpbGUgZmFs
c2UgZmFpbHMKCmV4cGVjdGluZyBzdWNjZXNzOiAKCWxvZ19kaXYgInVwbG9hZHBhY2sgZGVmYXVs
dCIKCUdFVCBpbmZvL3JlZnM/c2VydmljZT1naXQtdXBsb2FkLXBhY2sgIjIwMCBPSyIgICYmCglQ
T1NUIGdpdC11cGxvYWQtcGFjayAwMDAwICIyMDAgT0siCgotLS0gZXhwCTIwMTAtMDgtMjEgMDg6
MDQ6NTEuMDAwMDAwMDAwICswMDAwCisrKyBhY3QJMjAxMC0wOC0yMSAwODowNDo1MS4wMDAwMDAw
MDAgKzAwMDAKQEAgLTEgKzEgQEAKLVN0YXR1czogMjAwIE9LDQorU3RhdHVzOiA0MDQgTm90IEZv
dW5kDQpub3Qgb2sgLSA4IGh0dHAudXBsb2FkcGFjayBkZWZhdWx0IGVuYWJsZWQKIwkKIwkJbG9n
X2RpdiAidXBsb2FkcGFjayBkZWZhdWx0IgojCQlHRVQgaW5mby9yZWZzP3NlcnZpY2U9Z2l0LXVw
bG9hZC1wYWNrICIyMDAgT0siICAmJgojCQlQT1NUIGdpdC11cGxvYWQtcGFjayAwMDAwICIyMDAg
T0siCiMJCg==
--001636c5afd31ebe48048e50e51d--
