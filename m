From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: [PATCH] Fix Documentation for git-describe
Date: Thu, 22 Jan 2009 12:26:25 -0600
Message-ID: <200901221226.25342.bss@iguanasuicide.net>
References: <497857CE.3060101@iaik.tugraz.at> <497867BE.8070509@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Martin Pirker <Martin.Pirker@iaik.tugraz.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 21:01:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ5kR-0007iV-Ts
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 21:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbZAVUA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 15:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbZAVUA0
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 15:00:26 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:55864 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbZAVUA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 15:00:26 -0500
Received: from [63.167.77.128]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LQ5id-0000z5-Ej; Thu, 22 Jan 2009 20:00:03 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <497867BE.8070509@dbservice.com>
X-Eric-Conspiracy: There is no conspiracy.
Content-Disposition: inline
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106782>

The documentation for git-describe says the default abbreviation is 8
hexadecimal digits while cache.c clearly shows DEFAULT_ABBREV set to 7.
This patch corrects the documentation.

Signed-off-by: Boyd Stephen Smith Jr <bss@iguanasuicide.net>
---
On Thursday 2009 January 22 06:34:06 Tomas Carnecky wrote:
>On 01/22/2009 12:26 PM, Martin Pirker wrote:
>> john@doe:/workspace$ git version
>> git version 1.6.1
>> john@doe:/workspace$ git describe
>> fatal: cannot describe '7aee61cc635a923e70b74091486742481ee0928b'
>> john@doe:/workspace$ git describe --always
>> 7aee61c
>> john@doe:/workspace$ git describe --always --abbrev=8
>> 7aee61cc
>>
>> man git-describe:
>>    --abbrev=<n>
>>        Instead of using the default 8 hexadecimal digits as the
>>        abbreviated object name, use<n>  digits.
>>
>> There is one character missing from default or what am I missing?
>
>The man page is wrong:
>
>cache.h:#define DEFAULT_ABBREV 7
>builtin-describe.c:static int abbrev = DEFAULT_ABBREV;

Let's fix it then!  This is a patch against maint.

Is there any way to include values from the source as text in the ascidoc
other than copy-and-paste?  It would be nice if we don't have to do this fix
again in the future.

I did a quick scan of 'git grep 8 -- Documentation' and didn't see
anywhere else this needed fixing.

 Documentation/git-describe.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 3d79f05..a30c5ac 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -43,7 +43,7 @@ OPTIONS
 	Automatically implies --tags.
 
 --abbrev=<n>::
-	Instead of using the default 8 hexadecimal digits as the
+	Instead of using the default 7 hexadecimal digits as the
 	abbreviated object name, use <n> digits.
 
 --candidates=<n>::
-- 
1.6.0.2
-- 
Boyd Stephen Smith Jr.                     ,= ,-_-. =. 
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-' 
http://iguanasuicide.net/                      \_/     
