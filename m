From: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@bitplanet.net>
Subject: [PATCH] Remove .git/branches from the .git template.
Date: Sun, 9 Dec 2007 13:38:56 -0500
Message-ID: <20071209183856.GA5587@bitplanet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Dec 09 18:57:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1QOd-0001gc-0b
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 18:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbXLIR4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Dec 2007 12:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbXLIR4P
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 12:56:15 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:63634 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbXLIR4O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 12:56:14 -0500
Received: by py-out-1112.google.com with SMTP id u77so2950786pyb
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 09:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent:from:sender;
        bh=PHJOqxgk3RMA5W3LhEXmuceqhDyRLV+qyHfUgZxZ7F4=;
        b=UvgUkgyVODkHuRY9DAWwinTYkE2lBcL0Lv6HcgOQ1P2S2e2T84Z8jfaFc9b3XamBd1DWKJY3axSRxsTHIY+HAh3QUHiy1Up5222OmSo/meQ5lShl8msu3Jeh3HlFfj8IV25AsYBh6FbIP9eeuq7uZjPTXGwaQrPr5djOenCllnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent:from:sender;
        b=Ezuyo5YfBOIn2XeJ9FYVXZEQDt6lck4MMQsyVf6mc6SndpRzcZ2bMQFnR84xq/vqVLr4oFnESRBxzFb09L0bO7Sh7ZuNFIZAtOt+Ve6IW/XEKD4ZD2KkNncJbfS2yaWS98Kp8Tmsp5ncDxef3oHEgYfaO05enzheJ2KQDvNfyx0=
Received: by 10.142.104.9 with SMTP id b9mr1530047wfc.1197222969583;
        Sun, 09 Dec 2007 09:56:09 -0800 (PST)
Received: from localhost ( [76.24.237.133])
        by mx.google.com with ESMTPS id 29sm4175822wrl.2007.12.09.09.56.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Dec 2007 09:56:07 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67636>

The code in git to read the info in .git/branches is still there,
but nothing ever writes to this, so lets stop creating it.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---

As far as I can see this should be safe, but I admit to never really
knowing what .git/branches was originally used for - tracking remote
branches or something?  In any case, we only ever read from this dir
so the only left in git to deal with this seems to be for compatibilty
with older repos.

Kristian

 templates/branches-- |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 100644 templates/branches--

diff --git a/templates/branches-- b/templates/branches--
deleted file mode 100644
index fae8870..0000000
--- a/templates/branches--
+++ /dev/null
@@ -1 +0,0 @@
-: this is just to ensure the directory exists.
--=20
1.5.3.4
