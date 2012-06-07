From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Getting pickaxe to perform looser matches, or regex matching
Date: Thu, 7 Jun 2012 14:48:39 -0400
Message-ID: <CACPiFCJHY4vfrrWRm_cC2Ck6RAyQosWwqijxPbs+Fn0T_AoT1w@mail.gmail.com>
References: <CACPiFCKyhZPQR+e27Ah5THiPPJy3akajGN5xMwBumP-Wj6JrKQ@mail.gmail.com>
 <7vy5nzgg1h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=14dae9cdc78f2fa49004c1e656c3
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 20:49:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Schla-0003u9-NN
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 20:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932806Ab2FGStB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 14:49:01 -0400
Received: from mail-vb0-f52.google.com ([209.85.212.52]:51214 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932762Ab2FGStA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 14:49:00 -0400
Received: by vbzb23 with SMTP id b23so579908vbz.11
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8/XpElC9P4aSmuYD07EcK2Em1gfz2DOla5KcGGoHkqo=;
        b=0oDZhxWxfEG22uGX0z/n2QGkdw4GCp6gQJFzlpWvKs+VOa4VvIU6/2Bn8DlB+NIF0D
         2lcgdAKFJmE+C97wQdebpR0S4z8QrFsk6gyvmi9ANGzpPxj5Er3qlmnAO8rd1LJbPNc4
         kev/mMwjPbAsDhaS3fufsgiyTVbXfxQemWk9N2RvI/t0Gto+cnpSa30jfHuOUON/yywQ
         7f+i7xA+C6SvBuBcWf1pTneFX+BVZRvdKGpKpoecEwMB9pZ6pBgZoEv5rg0Vuc4IO9P3
         g6QBNS/nBtAY9ykd8s5VgQXuRq12ByqyzmF8W77rQM31wYFXxuKJ9c9c+JgDsAoQzeFL
         ftsQ==
Received: by 10.220.242.78 with SMTP id lh14mr3123573vcb.64.1339094939444;
 Thu, 07 Jun 2012 11:48:59 -0700 (PDT)
Received: by 10.52.162.34 with HTTP; Thu, 7 Jun 2012 11:48:39 -0700 (PDT)
In-Reply-To: <7vy5nzgg1h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199438>

--14dae9cdc78f2fa49004c1e656c3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 7, 2012 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Like more expensive -G that was recently added?

Yay! That does what I wanted, though the manpage relies on subtle
wording to convey it. You have to read -S and -G twice and think about
it. It would be much better to say something like "If -S isn't finding
what you need, try -G and you shall find it" -- AFAICT it is true for
the common cases.

gitk doesn't seem to know how to use it. Attached is a trivial patch
(apologies about attaching it, in lieu of proper list style). Simple,
and works for me.

While I am not learned in gitk internal structure, it seems complete.
My only doubt is whether any additional work is needed under set
known_view_options {}. I cannot quite fathom that part of gitk. Review
welcome.

cheers,



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff

--14dae9cdc78f2fa49004c1e656c3
Content-Type: application/octet-stream; 
	name="0001-gitk-add-support-for-G-regex-pickaxe-variant.patch"
Content-Disposition: attachment; 
	filename="0001-gitk-add-support-for-G-regex-pickaxe-variant.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h366g1xm0

RnJvbSBkODYxMzdjOGMyZjJhYzQyYjAzMGEwZTBiNDBjNTljNjAyOWNjZDRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJ0aW4gTGFuZ2hvZmYgPG1hcnRpbkBsYXB0b3Aub3JnPgpE
YXRlOiBUaHUsIDcgSnVuIDIwMTIgMTQ6NDE6NTggLTA0MDAKU3ViamVjdDogW1BBVENIXSBnaXRr
OiBhZGQgc3VwcG9ydCBmb3IgLUcncmVnZXgnIHBpY2theGUgdmFyaWFudAoKZ2l0IGxvZyAtRydy
ZWdleCcgaXMgYSB2ZXJ5IHVzYWJsZSBhbHRlcm5hdGl2ZSB0byB0aGUgY2xhc3NpYwpwaWNrYXhl
LiBNaW5pbWFsIHBhdGNoIHRvIG1ha2UgaXQgdXNhYmxlIGZyb20gZ2l0ay4KLS0tCiBnaXRrLWdp
dC9naXRrIHwgICAgNSArKysrLQogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZ2l0ay1naXQvZ2l0ayBiL2dpdGstZ2l0L2dpdGsK
aW5kZXggMjIyNzBjZS4uODc2YjhmOSAxMDA3NTUKLS0tIGEvZ2l0ay1naXQvZ2l0aworKysgYi9n
aXRrLWdpdC9naXRrCkBAIC0yMjMyLDcgKzIyMzIsOCBAQCBwcm9jIG1ha2V3aW5kb3cge30gewog
ICAgIHNldCBnbSBbbWFrZWRyb3BsaXN0IC50Zi5sYmFyLmdkdHR5cGUgZ2R0dHlwZSBcCiAJCVtt
YyAiY29udGFpbmluZzoiXSBcCiAJCVttYyAidG91Y2hpbmcgcGF0aHM6Il0gXAotCQlbbWMgImFk
ZGluZy9yZW1vdmluZyBzdHJpbmc6Il1dCisJCVttYyAiYWRkaW5nL3JlbW92aW5nIHN0cmluZzoi
XSBcCisJCVttYyAiY2hhbmdlcyBtYXRjaCByZWdleDoiXV0KICAgICB0cmFjZSBhZGQgdmFyaWFi
bGUgZ2R0dHlwZSB3cml0ZSBnZHR0eXBlX2NoYW5nZQogICAgIHBhY2sgLnRmLmxiYXIuZ2R0dHlw
ZSAtc2lkZSBsZWZ0IC1maWxsIHkKIApAQCAtNDU5NSw2ICs0NTk2LDggQEAgcHJvYyBkb19maWxl
X2hsIHtzZXJpYWx9IHsKIAlzZXQgZ2R0YXJncyBbY29uY2F0IC0tICRyZWxhdGl2ZV9wYXRoc10K
ICAgICB9IGVsc2VpZiB7JGdkdHR5cGUgZXEgW21jICJhZGRpbmcvcmVtb3Zpbmcgc3RyaW5nOiJd
fSB7CiAJc2V0IGdkdGFyZ3MgW2xpc3QgIi1TJGhpZ2hsaWdodF9maWxlcyJdCisgICAgfSBlbHNl
aWYgeyRnZHR0eXBlIGVxIFttYyAiY2hhbmdlcyBtYXRjaCByZWdleDoiXX0geworCXNldCBnZHRh
cmdzIFtsaXN0ICItRyRoaWdobGlnaHRfZmlsZXMiXQogICAgIH0gZWxzZSB7CiAJIyBtdXN0IGJl
ICJjb250YWluaW5nOiIsIGkuZS4gd2UncmUgc2VhcmNoaW5nIGNvbW1pdCBpbmZvCiAJcmV0dXJu
Ci0tIAoxLjcuNy42Cgo=
--14dae9cdc78f2fa49004c1e656c3--
