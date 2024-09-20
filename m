Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B421F95E
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726827877; cv=none; b=G2tJg1z7X8MqSdWhX1xGKn1G/T0iPSdA2CE7baatOc5YV/sDniUjiKV0vryV+SgaKfMfdmyZ267QwflPbks9PzFLvMUvbMzKsolIjSXo+IF58IfegvAvcLuPWgtvLC9nY5uwp1sVWHJHkI8UHGuH/OJL98VLOYqMjb/uFdHF5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726827877; c=relaxed/simple;
	bh=pgTrmgUIGcTzsLwZHt7Z58Y7vfSDICDqqHQRRRJYPPU=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=tRqABUz/IhtoGa5eOShfgJxcUPFu6iAVw7JLNc+rfWxqnHJmfJU9nMafGkI50TuXQmfklMUM9zFUx2SomPC18tWO/yHGUMjCIbHlBU0aOhb2wq97RGHsOW72sR9Q8AqnpmhmLUNdg2p/CJbaVV80jjN+vuoMCaUNbWduFR+BCvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=plasmahh@gmx.net header.b=QeYKsPUO; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=plasmahh@gmx.net header.b="QeYKsPUO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726827873; x=1727432673; i=plasmahh@gmx.net;
	bh=nwl1dzv4vETEFZjPI8Jc7CnyGWcK+IwpO9pNJ9xfgoo=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Date:Content-Type:
	 MIME-Version:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=QeYKsPUOTWh79AEmSutVKYQHGaf5dtB5PjLAMAvxjFM1D+sIJp88Z2YyXA4RVhRW
	 Bk/dsP/HtwnBSSyT+wO1r6feV1Ob/hbk1jacm1S2U+OeAR4KTV3lLuZ8musrF4+m5
	 qrxvtYufzlROKb8xBfTxbwObKKiPrE3MEWceJ0Uh7rNkg+DigwDeKqsQttBJNePwe
	 /2M9KtSZtAf7VAibC/VEdrygujqmm9kgZfqKIThjJJGP3Fds4GJoRotAQM0jO9rn2
	 UyvNQdNqSv/qvxXVjn9aOvLjl7Y9AEMe+LdsrG3BizmOoHnSY5EBx4KSoDzI23uzD
	 pHDe5q54S9uyItE8iQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.2.31] ([91.17.119.202]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6mE-1s6SHl1VgC-00dkmw for
 <git@vger.kernel.org>; Fri, 20 Sep 2024 12:24:33 +0200
Message-ID: <0218f6c7486cb6747a61db4a9d4990eab11f313f.camel@gmx.net>
Subject: Unable to checkout branch that has a new submodule with
 submodule.recurse
From: Dennis Lubert <plasmahh@gmx.net>
To: git@vger.kernel.org
Date: Fri, 20 Sep 2024 12:24:33 +0200
Content-Type: multipart/mixed; boundary="=-2xiTFdoHic4XAowlnnv5"
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:hyRJB2xi6vyNkgp+YQO4BDMBm8eG7ouUmVojaxtbW6jGhxuzofm
 lAxBA/uX832Ng0VQ/x5RBImw1JW4l1LGGdvwdsaz69v7SBS0xjLY2J8bjwCvZqlKjYUBk9k
 uZPvm90QOmJIXzBIJCktvqu9Gm9ac7je3mtfvh7odvfA2zruV4HPGJuhM5BpIe+LqiMU20v
 AUN7vkVGsczz2m4myPzzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CZxacKI7Nys=;KdUnHTbtOFipeVcJQxzVH7Mgv+b
 H95AShQrE7ankTXRcU0yM7VsMpQI6LVB+ZYFBkcdq+2jKCozzBBgDCpW3e1Z8WxFrYf4V3anY
 AXyLjRY8SktXOJOAojPWTRn9eXanj4ZcfQtrt7wUfQL9MMPdfgQnSV3tW/W3O2cCH/AvKFgmt
 rnjpf0fy/qBYSxgIXGRcIh0Itt2v6/d+rAMs8MoEUC+WxowVjSfpi541Qh7zVD8z4SSkq6elJ
 sDxoMfrKkBS7AEiuay/1aoSD6azKHw2kYdqoxZM4AHvUW5ulIoHSC7zSPdGWUhCR8GWaMWpfW
 PpJD2sCnHBuM9wtpppYSw+lUxFANEwCo85DCbgV9b0AA7shT3gFCym1khoexm6Ozwx6YtJkoK
 kZhMxcGNHfRh6QrStF4elQrDkfupkF2xnlSOFb/5ylEIxuriJ6hkvlxKSPN8aAJvosBOO7O/A
 gdbRp9Puam58oWX2oOLvAsanRSmyPEzodJRJgoK87v+t82cOYPo83j/yXLm5XKGDZZ1J3Ncs0
 sVJ+5LKwB79qzWqlUtirXQUrHkQmP6U7lL0OEuTAuIL5HFx3g/Brq2l/mq+0hsq/YVD0pwjXm
 Isvf/GNNEx27hgzbLMg6b5/SuYIGcwdicpuCbFH2XFeyq0ZPNHqGdBk7C/1I2VPDV2gr2QIkc
 DrvPjCX8g9bzwSQZuGKY46Dz9p2GX91f8QbDoUUagmizhEfZjawUHo6Z3jw6OPX8X1BmFFuMV
 xSsgX5PEcdtcBUjgb35HSiiNHlFRZg5Ui7XQed4RWZECr1CHr3k7/voWRVrAMwyqGtqDg75Ca
 P/Brsoh+FDGnDV3RQwO0a+LQ==

--=-2xiTFdoHic4XAowlnnv5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello World,

for years now this has been bothering me. From time to time there is a
new submodule in a branch and when checking that one out with my
standard setup I get something like:

> git checkout branchname

fatal: not a git repository: ../.git/modules/submodule_new
fatal: could not reset submodule index

(this happens on all versions up to 2.46.1 and OS and whatnot I have
access to)

While the workaround is clear (either clone with the desired branch
right away or dont use --recurse-submodules and do update --init
yourself), this is quite unfortunate for people in teams that work
mostly with git integration or gui, also because when this happens it
leaves the repo in an annoying state that needs  a bit more manual
cleanup than --reset hard sometimes and especially for people that just
use the basics this can be overwhelming.

It seems that there is something wrong going on with the order of
creation of the .git file and .git/modules/submodule/config entries,
but I am not deep enough in the details to comment more on that.

To help reproduce the problem reliably (hopefully) I have attached a
shell script. You can run it in an empty directory (please review it
before you do, I hacked it together, it might delete the wrong thing
accidentally). It will need local ssh access (though I think modifying
it to use local repos as submodules could be the same).

greets

Dennis

--=-2xiTFdoHic4XAowlnnv5
Content-Type: application/x-shellscript; name="gittest.sh"
Content-Disposition: attachment; filename="gittest.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKIyMjIyMjIyMjCiMgUnVuIHRoaXMgdGVzdCBpbiBhbiBlbXB0eSBkaXJlY3Rv
cnkuIE1ha2Ugc3VyZSB5b3UgY2FuIGxvZ2luIHRvIGxvY2FsaG9zdCB2aWEgc3NoCiMjIyMjIyMj
IwpybSAtcmYgZ2l0bGFiCnJtIC1yZiBjbGllbnRfb2xkCnJtIC1yZiBjbGllbnRfbmV3CgppZiBb
WyAteiAiJHtVU0VSfSIgXV07CnRoZW4KCVVTRVI9bWUKZmkKCgoKc2V0IC14CiMgTWFrZSBzdXJl
IHdlIGhhdmUgY2xlYW4gZGVmYXVsdCBzZXR0aW5ncwpIT01FPSQocHdkKQoKZ2l0IGNvbmZpZyAt
LWdsb2JhbCBzdWJtb2R1bGUucmVjdXJzZSB0cnVlCiNnaXQgY29uZmlnIC0tZ2xvYmFsIHByb3Rv
Y29sLmZpbGUuYWxsb3cgYWx3YXlzCmdpdCBjb25maWcgLS1nbG9iYWwgaW5pdC5kZWZhdWx0QnJh
bmNoIG1hc3RlcgpnaXQgY29uZmlnIC0tZ2xvYmFsIHVzZXIubmFtZSAidGVzdGNhc2UiCmdpdCBj
b25maWcgLS1nbG9iYWwgdXNlci5lbWFpbCB0ZXN0Y2FzZUBleGFtcGxlLmNvbQoKIyBzZXR1cCB0
aGUgInNlcnZlciIKcHVzaGQgLgpta2RpciBnaXRsYWIKY2QgZ2l0bGFiCkdJVExBQj0iJChwd2Qp
IgpnaXQgaW5pdCAtLWJhcmUgcHJvamVjdApnaXQgaW5pdCAtLWJhcmUgc3VibW9kdWxlX29sZApn
aXQgaW5pdCAtLWJhcmUgc3VibW9kdWxlX25ldwpwb3BkCgojIHNldHVwIHRoZSByZXBvcyB2aWEg
YSBjbGllbnQgdG8gbG9jYWxob3N0IChuZWVkcyBzc2hkKQpwdXNoZCAuCm1rZGlyIGNsaWVudF9v
bGQKY2QgY2xpZW50X29sZAoKCiMgU2V0dXAgc29tZSBmaWxlL2JyYW5jaCBpbiB0aGUgc3VibW9k
dWxlcwpwdXNoZCAuCmdpdCBjbG9uZSAke1VTRVJ9QGxvY2FsaG9zdDoke0dJVExBQn0vc3VibW9k
dWxlX29sZAoKY2Qgc3VibW9kdWxlX29sZApscyAtbGEgPiBhYWEKZ2l0IGFkZCBhYWEKZ2l0IGNv
bW1pdCAtbSAiQWRkZWQgYWFhIgoKZ2l0IHB1c2gKcG9wZAojIERlbGV0ZSBzbyBubyBsb2NhbCBy
ZXBvIHdpdGggdGhhdCBuYW1lIGlzIGFueXdoZXJlCnJtIC1yZiBzdWJtb2R1bGVfb2xkCgojIFNl
dHVwIHNvbWUgZmlsZS9icmFuY2ggaW4gdGhlIHN1Ym1vZHVsZXMKcHVzaGQgLgpnaXQgY2xvbmUg
JHtVU0VSfUBsb2NhbGhvc3Q6JHtHSVRMQUJ9L3N1Ym1vZHVsZV9uZXcKY2Qgc3VibW9kdWxlX25l
dwpscyAtbGEgPiBhYWEKZ2l0IGFkZCBhYWEKZ2l0IGNvbW1pdCAtbSAiQWRkZWQgYWFhIgoKZ2l0
IHB1c2gKCnBvcGQKIyBEZWxldGUgc28gbm8gbG9jYWwgcmVwbyB3aXRoIHRoYXQgbmFtZSBpcyBh
bnl3aGVyZQpybSAtcmYgc3VibW9kdWxlX25ldwoKZ2l0IGNsb25lICR7VVNFUn1AbG9jYWxob3N0
OiR7R0lUTEFCfS9wcm9qZWN0CmNkIHByb2plY3QKIyBGaWxsIHRoZSBwcm9qZWN0IHdpdGggYSBm
ZXcgY29tbWl0cwpscyAtbGEgPiBhYWEKZ2l0IGFkZCBhYWEKZ2l0IGNvbW1pdCAtbSAiQWRkZWQg
YWFhIgoKZ2l0IHB1c2gKCiMgTm93IGNyZWF0ZSBhIHN1Ym1vZHVsZQpnaXQgc3VibW9kdWxlIGFk
ZCAgLi4vc3VibW9kdWxlX29sZCBzdWJtb2R1bGVfb2xkCgpnaXQgY29tbWl0IC1tICJBZGRlZCBz
dWJtb2R1bGVfb2xkIgpnaXQgcHVzaAojIE5vdyB3ZSBkaXZlcmdlIGludG8gYSBuZXcgYnJhbmNo
CmdpdCBjaGVja291dCAtYiBzdWJ0ZXN0CmdpdCBzdWJtb2R1bGUgYWRkICAuLi9zdWJtb2R1bGVf
bmV3IHN1Ym1vZHVsZV9uZXcKZ2l0IGNvbW1pdCAtYSAtbSAiQWRkZWQgc3VibW9kdWxlX25ldyIK
Z2l0IHB1c2ggLS1zZXQtdXBzdHJlYW0gb3JpZ2luIHN1YnRlc3QKcG9wZAoKIyBOb3cgd2UgaGF2
ZSBhbGwgcmVwb3MgaW4gYSBzdGF0ZSB3ZSB0aGluayBzaG91bGQgYmUgc2ltaWxhciB0byB0aGUg
cHJvYmxlbQoKcHVzaGQgLgpta2RpciBjbGllbnRfbmV3CmNkIGNsaWVudF9uZXcKIyBDbG9uZSB0
aGUgcmVwbyBhbmV3CmdpdCBjbG9uZSAke1VTRVJ9QGxvY2FsaG9zdDoke0dJVExBQn0vcHJvamVj
dCAtLXJlY3Vyc2Utc3VibW9kdWxlCmNkIHByb2plY3QKZ2l0IGNoZWNrb3V0IHN1YnRlc3QKcG9w
ZAoKIyB2aW06IHRhYnN0b3A9NCBzaGlmdHdpZHRoPTQgbm9leHBhbmR0YWIK


--=-2xiTFdoHic4XAowlnnv5--
