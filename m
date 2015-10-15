From: Alexander Riesen <alexander.riesen@cetitec.com>
Subject: [PATCH] Allow "clone --dissociate" to dissociate from alternates
Date: Thu, 15 Oct 2015 16:38:00 +0200
Message-ID: <561FBA48.3050609@cetitec.com>
References: <561F8DE9.4040703@cetitec.com> <alpine.DEB.1.00.1510151609280.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 15 16:38:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmjfZ-0008Dv-K8
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 16:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311AbbJOOiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 10:38:09 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50774 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbbJOOiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 10:38:08 -0400
Received: from pflsmail.localdomain ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue103) with ESMTPSA (Nemesis) id
 0MYLUv-1a8Tes3Zrd-00VCNl; Thu, 15 Oct 2015 16:38:03 +0200
Received: from localhost (localhost [127.0.0.1])
	by pflsmail.localdomain (Postfix) with ESMTP id 26D74B016D5;
	Thu, 15 Oct 2015 16:38:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pflsmail.corp.cetitec.com
Received: from pflsmail.localdomain ([127.0.0.1])
	by localhost (pflsmail.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V9JFUSQID7pA; Thu, 15 Oct 2015 16:38:00 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.11.230])
	by pflsmail.localdomain (Postfix) with ESMTPS id 48071B016D4;
	Thu, 15 Oct 2015 16:38:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <alpine.DEB.1.00.1510151609280.31610@s15462909.onlinehome-server.info>
X-Provags-ID: V03:K0:pwZ1ASMEV2hu9tnYONsw+gFpLbza8s8HAsC0Iy39NuPRrn9KbkV
 h4CsxC71+mAp/vfTn1fwFi9/JO2ESIPDRRLW9+b8w5QTEyscMXFVG+gxhdNU7b1poyY8cTZ
 CIf6B/BopDlHUmCmbP69/bc3lCl1V0dUj9MFdatblTAen5sekAB9YRIdmBz6k3FV7fNQz7+
 9SrkA5QvAo0tDk83qnPxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sInj1Pdn2OI=:GcJkabKHtkcSEsDHWHewFu
 +Q3ik5oHHraDJGrnkaCEAwagtVxzwg9dHwXJk6wg+bEBbxX0K622ucNMeWIGM4y5Fu4s/Pnpk
 wdJtMWqDCyDjO05nkPsW6nj8pb5tFKTrVz0lzwmXgUnlpznJLjzsQPvN2ML4d/dAmla2FSQdt
 IUs11LXVsTwZQvmMhofaQ/Y5k9T6QaSml9CAFd6E7R3LARydzUC3STLW8NFXiUdFNTSCLPLmB
 zK8AnkUzhYjVczx46x9sMKUYGlEkcX165bwml3ihDhY1K8ThsNbfBDsFYVMjmv2mUZT6mKvhx
 yfajDok7hh2Fkt8l5C7OT8JRjwbDdr/OHkpjAG7aE/IfIUbgbFYrMk72CtyogYRP94qPIq7rV
 ZC4Lw6mNgztaMHZZxTUGEL6LZGzr3GTIIgZ1UAyTMKa4WT1kY0oTbNHRa76ngbOsriIsx6+6H
 mHAM7lGeQeFUa52r0lNBYrCpL4MqfrJyzCZhzFCQj6ytMqoqkcoMCWNUJ5P3CJ0T4CCC8Jrdu
 HSBq6MSgWOvl/rFcq5jBLvr3llyNZOR2gUtMCuqvdiNym8305fzGh5dZfBn1bXQCHAuDd9mfW
 m+JNBWCXTUu8pnFOgUUD4qO9AYo3p7zXlGUYPOV1XH2WTy8LrOh6Ew6D7s49VKlVGN4cNrAU3
 nmZJAAe9qeDz1rcfAn5iWBPja1zf0Qr1UKIZHnXbpC9aiZyHTTqUUnULsAcvB50+lvruPcjda
 4E1w6t4/xxz1mAlB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279668>

The option requiring the explicit reference repositories is a bit of overkill:
the alternates in the original repository *are* reference repositories and
would be dissociated from should one pass any reference repository (even an
unrelated one).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

On 10/15/2015 04:11 PM, Johannes Schindelin wrote:
> On Thu, 15 Oct 2015, Alexander  Riesen wrote:
 >
 >> The "--dissociate" option required reference repositories, which sometimes
 >> demanded a look into the objects/info/alternates by the user. As this
 >> is something which can be figured out automatically, do it in the
 >> clone unless there is no other reference repositories.
 >
 > Would it not make sense to reuse the copy_alternates() function to simply
 > copy the alternates and let `--dissociate` run its course with the copied
 > .objects/info/alternate file? That would make for less new code...

IIUC, I should validate the alternates in the source repository...
But, the only thing the user looses if it is not validated, is the nice
warning regarding no reference repositories to dissociate from, right?

So maybe we can just remove the reset of option_dissociate and be done with
it? I would actually suggest removing the warning as well: the alternates are
something to dissociate from. And I see no harm otherwise.

How about this instead?

  builtin/clone.c | 4 ----
  1 file changed, 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 578da85..b33d6f9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -947,10 +947,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)

      if (option_reference.nr)
          setup_reference();
-    else if (option_dissociate) {
-        warning(_("--dissociate given, but there is no --reference"));
-        option_dissociate = 0;
-    }

      fetch_pattern = value.buf;
      refspec = parse_fetch_refspec(1, &fetch_pattern);
-- 
2.6.1.151.g74e8091
