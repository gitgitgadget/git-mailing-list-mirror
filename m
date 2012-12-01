From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: Also close config file handle when leaving git_config_set_multivar_in_file()
 early
Date: Sat, 1 Dec 2012 22:01:51 +0800
Message-ID: <CAHtLG6SDb5t3ABttbCi5=nVsygf5gLw9DzVtZt0L3WMPNECBWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d0401229f3fe27f04cfcaf5b2
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 15:02:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tendy-00088q-63
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 15:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933Ab2LAOBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 09:01:54 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:61602 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab2LAOBx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 09:01:53 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so1094797lag.19
        for <git@vger.kernel.org>; Sat, 01 Dec 2012 06:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=v/NNXSlh/aGMGKlkRQnxBIjRK7fBdcnyjMZjtKbwu0s=;
        b=eV/RBTK+HgSzK+Sc+52v5xRy7hdhr9F+FbrSYX1WtGJnDpbuN73uXNPU4Tz8El3lM1
         2dMP76cwFXtV3gargWQqIrOXZYOsUcZZdD0bqP9Bh/jYSdyEWL116KbhT04peyRLd2RY
         IA6Ti04MDxPGM2v8h6cVbfXkNlIJOFplxuPorvc6KTF0tCxtdhvCeBrP4iV+/1Cgu8OY
         9n4uKRsf0nwTDEFNgdyg4WMOMi2vHoSIRPlR4wlaDZWp/GNRbN++E2ndtQDSlyN7g6SM
         HuaqEduiWZJiu/35cLR+zEXqUw9Gg6iuJilcc79BXklIu3pdY6S5My5pq1sHlAG/TbMH
         9XAw==
Received: by 10.112.44.164 with SMTP id f4mr2086361lbm.111.1354370511790; Sat,
 01 Dec 2012 06:01:51 -0800 (PST)
Received: by 10.112.132.199 with HTTP; Sat, 1 Dec 2012 06:01:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210971>

--f46d0401229f3fe27f04cfcaf5b2
Content-Type: text/plain; charset=ISO-8859-1

Hi,

This patch fixes the captioned problem.
It is needed because our program statically link git.
In this case, do not assume a fail will call die() and exit program so
the handle is leave not closed.

Regards,
ch3cooli

--f46d0401229f3fe27f04cfcaf5b2
Content-Type: application/octet-stream; 
	name="0001-Also-close-config-file-handle-when-leaving-git_confi.patch"
Content-Disposition: attachment; 
	filename="0001-Also-close-config-file-handle-when-leaving-git_confi.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ha6t45sm0

RnJvbSA1ZDhkMjhmMDM5YjRkYjdiNGYwNDBhNDBmZGMyZWRmODY2MjAwZjBjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXAgWXV0IFN1bSA8Y2gzY29vbGlAZ21haWwuY29tPgpEYXRl
OiBTYXQsIDEgRGVjIDIwMTIgMjE6NTY6NDEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBbHNvIGNs
b3NlIGNvbmZpZyBmaWxlIGhhbmRsZSB3aGVuIGxlYXZpbmcKIGdpdF9jb25maWdfc2V0X211bHRp
dmFyX2luX2ZpbGUoKSBlYXJseQoKU2lnbmVkLW9mZi1ieTogU3VwIFl1dCBTdW0gPGNoM2Nvb2xp
QGdtYWlsLmNvbT4KLS0tCiBjb25maWcuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvY29uZmlnLmMgYi9jb25maWcuYwppbmRleCBmZmY4YTQz
Li40YjVjODc3IDEwMDY0NAotLS0gYS9jb25maWcuYworKysgYi9jb25maWcuYwpAQCAtMTQyNCw2
ICsxNDI0LDcgQEAgaW50IGdpdF9jb25maWdfc2V0X211bHRpdmFyX2luX2ZpbGUoY29uc3QgY2hh
ciAqY29uZmlnX2ZpbGVuYW1lLAogCQljb250ZW50cyA9IHhtbWFwKE5VTEwsIGNvbnRlbnRzX3N6
LCBQUk9UX1JFQUQsCiAJCQlNQVBfUFJJVkFURSwgaW5fZmQsIDApOwogCQljbG9zZShpbl9mZCk7
CisJCWluX2ZkID0gLTE7CiAKIAkJaWYgKHN0b3JlLnNlZW4gPT0gMCkKIAkJCXN0b3JlLnNlZW4g
PSAxOwpAQCAtMTQ5Myw2ICsxNDk0LDggQEAgb3V0X2ZyZWU6CiAJaWYgKGxvY2spCiAJCXJvbGxi
YWNrX2xvY2tfZmlsZShsb2NrKTsKIAlmcmVlKGZpbGVuYW1lX2J1Zik7CisJaWYgKGluX2ZkID49
IDApCisJCWNsb3NlKGluX2ZkKTsKIAlyZXR1cm4gcmV0OwogCiB3cml0ZV9lcnJfb3V0OgotLSAK
MS44LjAubXN5c2dpdC4wCgo=
--f46d0401229f3fe27f04cfcaf5b2--
