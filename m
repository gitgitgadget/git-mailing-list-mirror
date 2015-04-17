From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] sha1_file.c: make parse_sha1_header_extended() static
Date: Fri, 17 Apr 2015 07:33:47 +0530
Message-ID: <24F2AEE2-C353-411F-9DE2-C999DC5AB454@gmail.com>
References: <552FAA35.4050806@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Apr 17 04:04:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YivdV-00008z-IL
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 04:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbbDQCEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 22:04:01 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33072 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbbDQCD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 22:03:59 -0400
Received: by pdbnk13 with SMTP id nk13so111800815pdb.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 19:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=Dm9nYgiCrG8wx5vlXZLT6FmYIu7Pa/XvXsnuOExeydY=;
        b=YCSd3gY1sKSIwZ66FSSbyjRAZyoI+Dp/mD6/96BReOXs3M5j3KXeuvGFapQKmzTT3v
         WFF8bDjbXJB8rX+0q3NrmhvcCIZsxbN2Xv98Tkv63oVYv7yP48yuBFAgbaaOhmVgqyHf
         mdAALvPv5uMsl7fY3vpjcKMXRBMfQc1wPGEuf3D6e4AhxIAsH/jE/kNx65A2u2Sofpbw
         UsxCVUZT7/t+8L5YVP8RnbmuEdziOZ+youGbAWNjE5W/w+eeLQfEj5nJweycGFueer0w
         zuuK7BfKTSh+kLSC+J/b7CM8e/VeiU1yDgoAkWlI/Esw4bzsC0FMXXlgl64pBvp1zkkF
         TijQ==
X-Received: by 10.68.190.106 with SMTP id gp10mr1089445pbc.163.1429236239475;
        Thu, 16 Apr 2015 19:03:59 -0700 (PDT)
Received: from [100.95.7.168] ([106.66.135.21])
        by mx.google.com with ESMTPSA id fn6sm8422690pab.31.2015.04.16.19.03.56
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 16 Apr 2015 19:03:58 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <552FAA35.4050806@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267345>



On April 16, 2015 5:55:25 PM GMT+05:30, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>
>commit 9e1f5bc0 ("sha1_file.c: support reading from a loose object of
>unknown type", 15-04-2015) added a new externally visible function
>which does not require more than file scope. This causes sparse to
>issue a warning message about this symbol. In order to suppress the
>warning, add the static qualifier to the function definition.
>
>[An alternative solution, if this symbol should have external scope,
>is to add an external declaration for the function to the "cache.h"
>header file (next to the one for parse_sha1_header()).]
>
>Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>---
>
>Hi Karthik,
>
>If you need to re-roll your patches in the 'kn/cat-file-literally'
>branch, could you please squash this, or something like it, into
>the relevant patch.

Thanks for this Ramsay, will be re rolling, will squash it into my commit.

Regards
Karthik
>
>Thanks!
>
>ATB,
>Ramsay Jones
>
> sha1_file.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/sha1_file.c b/sha1_file.c
>index 267399d..2b81534 100644
>--- a/sha1_file.c
>+++ b/sha1_file.c
>@@ -1642,7 +1642,7 @@ static void *unpack_sha1_rest(git_zstream
>*stream, void *buffer, unsigned long s
>  * too permissive for what we want to check. So do an anal
>  * object header parse by hand.
>  */
>-int parse_sha1_header_extended(const char *hdr, struct object_info
>*oi,
>+static int parse_sha1_header_extended(const char *hdr, struct
>object_info *oi,
> 			       unsigned int flags)
> {
> 	struct strbuf typename = STRBUF_INIT;
>-- 
>2.3.0

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
