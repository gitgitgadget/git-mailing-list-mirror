From: Rafal Rusin <rafal.rusin@gmail.com>
Subject: 'error: unable to set permission to './objects/...'
Date: Sun, 22 Nov 2009 21:02:12 +0100
Message-ID: <9bbf67fa0911221202r605de38coc2496b1f09123725@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175dd9c64bd3130478fb2f47
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 21:02:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCIdg-0003BV-7K
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 21:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbZKVUCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 15:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbZKVUCI
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 15:02:08 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:35541 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbZKVUCH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 15:02:07 -0500
Received: by bwz27 with SMTP id 27so4531437bwz.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 12:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=NUtuT5lf2uWPDlZLmrcbYJah0LZy/kDCKABs+BXMMLk=;
        b=xBHphGPZI+WsN07KahvPfXWyNZnuaA7KlUenkDx5GDBTKZZuRM9YGvNq57E6vpMgV8
         g9xyOEY+ebY5TjCi68I4nX5h+U+FMQgUEzzdE9V1R+kc0BHFqMjBwq4hBItaMLP0UGwX
         ywuygB5G5id4UvwoFKPvWf/p5lkjBBq1iNotU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=KRaqC3gX2KbAy/qayj21FmWY2dWszyfaoPMinWF1j8aNKY59iYAOao0g82FoqhLFBX
         wGBipw3KTMAo86urC6vtVurmetXBS65HO+DrQJXqbKHZbnmBsGDJS+MewGKKi0O4LyZt
         dGnV9LP1MM212xraaM6TEuLgZMO3c9ZCHkbXU=
Received: by 10.204.150.76 with SMTP id x12mr3954189bkv.30.1258920132465; Sun, 
	22 Nov 2009 12:02:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133455>

--0015175dd9c64bd3130478fb2f47
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I'm hosting git repository on filesystem with 'chmod <some-file>'
causing permission denied error (it's smbfs mounted directory),
When I was doing push to such repo using file:// protocol, I got
following error:
error: unable to set permission to './objects/...'

I did a small fix to sha1_file.c (patch in attachment) and git now
warns when unable to chmod, and continues push. This resolved problem.
What do you think about applying it?

Regards,
--=20
Rafa=C5=82 Rusin
http://rrusin.blogspot.com
http://www.touk.pl
http://top.touk.pl

--0015175dd9c64bd3130478fb2f47
Content-Type: text/x-diff; charset=US-ASCII; name="permission.patch"
Content-Disposition: attachment; filename="permission.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g2c8e1cr0

ZGlmZiAtLWdpdCBhL3NoYTFfZmlsZS5jIGIvc2hhMV9maWxlLmMKaW5kZXggNGVhMGIxOC4uMzA1
ZTc1MSAxMDA2NDQKLS0tIGEvc2hhMV9maWxlLmMKKysrIGIvc2hhMV9maWxlLmMKQEAgLTIyNzIs
OCArMjI3Miw5IEBAIGludCBtb3ZlX3RlbXBfdG9fZmlsZShjb25zdCBjaGFyICp0bXBmaWxlLCBj
b25zdCBjaGFyICpmaWxlbmFtZSkKIAl9CiAKIG91dDoKLQlpZiAoc2V0X3NoYXJlZF9wZXJtKGZp
bGVuYW1lLCAoU19JRlJFR3wwNDQ0KSkpCi0JCXJldHVybiBlcnJvcigidW5hYmxlIHRvIHNldCBw
ZXJtaXNzaW9uIHRvICclcyciLCBmaWxlbmFtZSk7CisJaWYgKHNldF9zaGFyZWRfcGVybShmaWxl
bmFtZSwgKFNfSUZSRUd8MDQ0NCkpKSB7CisJCXdhcm5pbmcoInVuYWJsZSB0byBzZXQgcGVybWlz
c2lvbiB0byAnJXMnIiwgZmlsZW5hbWUpOworICAgIH0KIAlyZXR1cm4gMDsKIH0KIAo=
--0015175dd9c64bd3130478fb2f47--
