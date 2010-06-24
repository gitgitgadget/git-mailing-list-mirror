From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: [PATCH 4/4] Makefile: Don't pass $(ALL_CFLAGS) to the linker
Date: Thu, 24 Jun 2010 11:30:09 -0400
Message-ID: <AANLkTinmGOSwNzLBngXHOU-pxNTbHFJQyCLIHQWFW6Eo@mail.gmail.com>
References: <4C226520.5080009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6d7ee966ef0570489c8549a
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 24 17:30:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORoNn-0004DX-Uy
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 17:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab0FXPaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 11:30:14 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:58632 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755559Ab0FXPaN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 11:30:13 -0400
Received: by wwi17 with SMTP id 17so323726wwi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=y7vpFCh2LY0lwlX+sbtLiXdQlj0BUJFJullMSj1ZnK0=;
        b=u7Uj3L4sANMuwGNakIrplWwTEWCBbCUKWMNON3Al5EKjIcB7DD09v8m8+TrqJnjhLD
         maDO/YQ24pVzA59mvSCiO/24NNprVbn+YAjYm+iO5qNpmI/eujFC+LYH3eR37wSB4SR6
         ugq32iNw61TDwHmecimByrjAfeiFxXI83Xmlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=M69J6Gl4cpKZ1axVerOfsWKwmpoUvot9P6mv0LeTyUhoXC0AbhuHU4fg4knKx0ReJ3
         vPHd8XtrJGWB3gr8aC4aBf/5jq3yDvT67CQEqzmYmq16myNAXPeBqWsRhEELZChQydcK
         NS0oRiBePg5EugujBUOjgebaQrBeaXU/rHiQI=
Received: by 10.216.90.2 with SMTP id d2mr7489539wef.24.1277393409852; Thu, 24 
	Jun 2010 08:30:09 -0700 (PDT)
Received: by 10.216.165.78 with HTTP; Thu, 24 Jun 2010 08:30:09 -0700 (PDT)
In-Reply-To: <4C226520.5080009@ramsay1.demon.co.uk>
X-Google-Sender-Auth: e7QwOBEWPlxCJV3gUl0CbWBDahQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149599>

--0016e6d7ee966ef0570489c8549a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 23, 2010 at 3:48 PM, Ramsay Jones wrote:
>
> The msvc debug build (make MSVC=3D1 DEBUG=3D1) issues a warning
> on every invocation of the linker:
>
> =A0 =A0LINK : warning LNK4044: unrecognized option '/Zi'; ignored
>
> In order to suppress the warning, we refrain from passing the
> $(ALL_CFLAGS) macro to the linker.

Alternatively, we could leave the makefile alone and fix it up in
compat/vcbuild/scripts/clink.pl

(Apologies for the patch attached instead of inline; I'm not using a
whitespace-clean email client at the moment.)

Peter Harris

--0016e6d7ee966ef0570489c8549a
Content-Type: application/octet-stream; name="msvc.patch"
Content-Disposition: attachment; filename="msvc.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gatqz7kv1

ZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggNzEzNDUwOS4uZGNjZWU4ZSAx
MDA2NDQKLS0tIGEvTWFrZWZpbGUKKysrIGIvTWFrZWZpbGUKQEAgLTEwNzIsNyArMTA3Miw4IEBA
IGlmbmRlZiBERUJVRwogCUJBU0lDX0xERkxBR1MgKz0gLUxUQ0cKIAlBUiArPSAtTFRDRwogZWxz
ZQogCUJBU0lDX0NGTEFHUyArPSAtWmkgLU1UZAorCUJBU0lDX0xERkxBR1MgPSAtREVCVUcgLU1B
UAogZW5kaWYKIAlYID0gLmV4ZQogZW5kaWYKZGlmZiAtLWdpdCBhL2NvbXBhdC92Y2J1aWxkL3Nj
cmlwdHMvY2xpbmsucGwgYi9jb21wYXQvdmNidWlsZC9zY3JpcHRzL2NsaW5rLnBsCmluZGV4IDQz
NzQ3NzEuLmFlYzk5ODAgMTAwNjQ0Ci0tLSBhL2NvbXBhdC92Y2J1aWxkL3NjcmlwdHMvY2xpbmsu
cGwKKysrIGIvY29tcGF0L3ZjYnVpbGQvc2NyaXB0cy9jbGluay5wbApAQCAtMTIsMTAgKzEyLDE0
IEBACiB1c2Ugc3RyaWN0OwogbXkgQGFyZ3MgPSAoKTsKIG15IEBjZmxhZ3MgPSAoKTsKK215IEBs
ZmxhZ3MgPSAoKTsKIG15ICRpc19saW5raW5nID0gMDsKK215ICVsaW5rZmxhZyA9ICggJy1ERUJV
RycgPT4gMSwgJy1NQVAnID0+IDEgKTsKIHdoaWxlIChAQVJHVikgewogCW15ICRhcmcgPSBzaGlm
dCBAQVJHVjsKLQlpZiAoIiRhcmciID1+IC9eLVtESU1HT10vKSB7CisJaWYgKCRsaW5rZmxhZ3sk
YXJnfSkgeworCQlwdXNoKEBsZmxhZ3MsICRhcmcpOworCX0gZWxzaWYgKCIkYXJnIiA9fiAvXi1b
RElNR09aXS8pIHsKIAkJcHVzaChAY2ZsYWdzLCAkYXJnKTsKIAl9IGVsc2lmICgiJGFyZyIgZXEg
Ii1vIikgewogCQlteSAkZmlsZV9vdXQgPSBzaGlmdCBAQVJHVjsKQEAgLTQ0LDYgKzQ4LDcgQEAg
d2hpbGUgKEBBUkdWKSB7CiB9CiBpZiAoJGlzX2xpbmtpbmcpIHsKIAl1bnNoaWZ0KEBhcmdzLCAi
bGluay5leGUiKTsKKwlwdXNoKEBhcmdzLCBAbGZsYWdzKTsKIH0gZWxzZSB7CiAJdW5zaGlmdChA
YXJncywgImNsLmV4ZSIpOwogCXB1c2goQGFyZ3MsIEBjZmxhZ3MpOwo=
--0016e6d7ee966ef0570489c8549a--
