From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/3] t7400-submodule-basic.sh cleanups
Date: Sat, 10 Apr 2010 00:37:29 -0500
Message-ID: <20100410053729.GA17595@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 07:37:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0TNt-00032b-80
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 07:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788Ab0DJFhH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 01:37:07 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38755 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701Ab0DJFhG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 01:37:06 -0400
Received: by gwj19 with SMTP id 19so138386gwj.19
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 22:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=QVc5ExQ6B9EKlsQTx3H+VdU7cHHpsqwmvyjEn9NT7Ho=;
        b=N305aLcMb03FB96FlDuAFqpIrz7blSjwFV9HZ1vBat8EzNLHXxEAM8Nhjd7ptpW046
         omnGdBqTVGNZ0myqRqUJk/v3VmAOsYaHupuZWvbdCdAqMvb67cV6rn7f+yYcBxyKGkmL
         VlrbzbiCc4QutkbRa0TkfP76j3LvC98v+Zh6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=epc4wKhf0aMnInOvUPBsUS/cAxC1Fiwy91Bs6WafS/Z+ZtTfCCxKdEVGUH2ceyvAav
         Aa6LdvdiXsRXehtm+j3xge7d1Ls5THaY2i210WDJWWH4kWxh87QVvamwCGATWbkK0HWA
         AiE/CltaDailGt1fZPbQ6F6xCK69KnwwgKiU8=
Received: by 10.151.92.15 with SMTP id u15mr775537ybl.11.1270877823297;
        Fri, 09 Apr 2010 22:37:03 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1503802iwn.5.2010.04.09.22.37.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 22:37:02 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144508>

The 'update --init' test from t7400 is failing on a few machines
I don=E2=80=99t have access to.  It=E2=80=99s hard to say what the dang=
erous
ingredient is --- maybe a libc bug or something. [1]

I took the opportunity to clarify what some of the tests do and to
make the output a little more helpful.

This series has three patches for easier review, but it might make
sense to squash them; alternatively, it might make sense to split the
test into several files.

What do you think?

Jonathan Nieder (3):
  t7400: split setup into multiple tests
  t7400: clarify 'submodule add' tests
  t7400: clarify submodule update tests

 t/t7400-submodule-basic.sh |  331 +++++++++++++++++++++++++++---------=
--------
 1 files changed, 201 insertions(+), 130 deletions(-)

[1] You can see some logged test failures at [2] [3], though it isn=E2=80=
=99t
very illuminating.  Well, that=E2=80=99s more of something for a Debian
Developer or someone with access to a similar machine to investigate.
[2] <https://buildd.debian.org/build.cgi?pkg=3Dgit-core>
[3] <http://bugs.debian.org/569594>.
