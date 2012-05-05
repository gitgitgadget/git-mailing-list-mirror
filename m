From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: recipe to use git for deployment
Date: Sat, 5 May 2012 17:44:16 +0530
Message-ID: <CAMK1S_i0bsO0fp69Ae_75dySsN9r=z1+c2psEMm4urw+UpYGXw@mail.gmail.com>
References: <jo283q$kna$1@dough.gmane.org>
	<1336190286-sup-3813@nixos>
	<4FA4BAF3.10601@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8ff1c634d0261a04bf48f99a
Cc: Marc Weber <marco-oweber@gmx.de>, git <git@vger.kernel.org>
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 14:14:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQdsT-0001pG-D9
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 14:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386Ab2EEMOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 08:14:17 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48631 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab2EEMOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 08:14:16 -0400
Received: by obbtb18 with SMTP id tb18so5378475obb.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/elUarg1HKL5bZWDD0YSaHuBYES92lILyZoxryXNRHc=;
        b=R5nUb8eWdHkSBBGjObrHfDc8ROJHPpDI1RcGhjTgcazxg+HHppD31mUpXXvnMsn+aF
         L+fxusqYwAzAY9oxbHU8aCktBhoxIwKbMC+KogU1Vij4+Yd3KjaiDUAPEovS6qJ0HTKv
         mev8FKEbAU456a5EbM+JziQC1SeJjzajRjxjI/5Z/bWcLJwYQdFr5RLF2+2M9FF3tLZY
         KuUOv7gXrBB71sIAcC6tEtGUwXvuoeatROwQCSSRad3jPSgHir9gSYQZKTihUJ6qwRgy
         GI/CrxenwAEQ6z3g/q+pApqWawa/rg4XZDA52jSRxNEtTDxIKg2UsqszlfYDZTHYTqJ+
         TZ+Q==
Received: by 10.60.27.38 with SMTP id q6mr13369867oeg.20.1336220056561; Sat,
 05 May 2012 05:14:16 -0700 (PDT)
Received: by 10.182.108.67 with HTTP; Sat, 5 May 2012 05:14:16 -0700 (PDT)
In-Reply-To: <4FA4BAF3.10601@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197109>

--e89a8ff1c634d0261a04bf48f99a
Content-Type: text/plain; charset=UTF-8

On Sat, May 5, 2012 at 11:00 AM, Neal Kreitzinger
<nkreitzinger@gmail.com> wrote:

> Interestingly, git-archive was not intended for deployment, but it does
> pretty good at it.

Except it doesn't delete files that should be deleted (the way 'git
checkout' does or rsync would if you gave it --delete).

On a lark I once wrote a very efficient way of dealing with this; see
attached.  It's probably won't work on anything but Linux and requires
bash, and it's only been minimally tested and I do not actually use
it, but someone might like it.

--e89a8ff1c634d0261a04bf48f99a
Content-Type: application/octet-stream; name=tar-checkout-f
Content-Disposition: attachment; filename=tar-checkout-f
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h1umw6tu0

IyEvYmluL2Jhc2gKCiMgV0FSTklOR1M6CiMgICAgICAgVEhFIERJUkVDVE9SWSBTUEVDSUZJRUQg
TUlHSFQgR0VUIFdJUEVEIE9VVCEhIQoKIyBVU0FHRToKIyAgICAgICBnaXQgYXJjaGl2ZSBIRUFE
IHwgdGFyLWNoZWNrb3V0LWYgLS15ZXMtSS1rbm93IC9wYXRoL3RvL2RlcGxveWRpcgoKZGllKCkg
eyBlY2hvICIkQCIgPiYyOyBleGl0IDE7IH0KIyBjaGVjayBhcmctMSBmb3IgQ1lBCmRyeXJ1bj0x
ClsgIiQxIiA9ICItLXllcy1JLWtub3ciIF0gJiYgeyBkcnlydW49MDsgc2hpZnQ7IH0KIyBjaGVj
ayBhcmctMSBpcyBhIHZhbGlkIGRpcmVjdG9yeQpbIC1kICQxIF0gfHwgZGllICJ1cmtrIChtYWtl
cyBzdHJhbmdsZWQgbm9pc2UpLi4uIgoKdGQ9JChta3RlbXAgLWQpCiMgZWNobyB0ZD0kdGQgPiYy
CnRyYXAgIi9iaW4vcm0gLXJmICR0ZCIgMAoKdGVlID4odGFyIHRmIC0gfCBzZWQgLWUgJ3MsXlwu
LywsJyA+ICR0ZC90ZikgfCB0YXIgLUMgIiQxIiAteGYgLQoKIyBvayBub3cgdGhlIGZ1biBzdHVm
ZjsgZGVsZXRlIHN0dWZmIHRoYXQgc2hvdWxkIG5vdCBiZSB0aGVyZQpjZCAiJDEiCmNtZD0iZWNo
byB3b3VsZCBkZWxldGU6IgpbICIkZHJ5cnVuIiA9ICIwIiBdICYmIGNtZD0icm0gLXYiCmZpbmQg
LiAtdHlwZSBmIHwgc2VkIC1lICdzLF5cLi8sLCcgfCBmZ3JlcCAtdiAteCAtZiAkdGQvdGYgfCB4
YXJncyAtciAtZCAnXG4nICRjbWQK
--e89a8ff1c634d0261a04bf48f99a--
