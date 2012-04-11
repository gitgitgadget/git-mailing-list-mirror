From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/3] add mergesort() for linked lists
Date: Tue, 10 Apr 2012 23:19:22 -0700
Message-ID: <4F85226A.7050709@gmail.com>
References: <201203291818.49933.mfick@codeaurora.org> <7v7gy2q1kq.fsf@alter.siamese.dyndns.org> <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com> <20120330093207.GA12298@sigill.intra.peff.net> <20120330094052.GB12298@sigill.intra.peff.net> <4F7780C3.2050408@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Martin Fick <mfick@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Apr 11 08:20:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHqun-0001YF-RW
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 08:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab2DKGUF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 02:20:05 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51091 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab2DKGT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 02:19:27 -0400
Received: by obbtb18 with SMTP id tb18so816888obb.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 23:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yXGTud5bu3B6woaKt4eN98+LC8mEfyIo6EswNipgdRo=;
        b=OAWYg6/YWRsYvrtqTqxVhKob0B0nAkHArQTIjesTKLxiytWVnpxZZdQ3sJxOMI0Efk
         YKceeJWIxbvwDvRYKYYsQEw7+SLgMfEXqZgJz277Eq5r1OwP057TnjzJMYRdAWLdtsbL
         FxlAWTAAyqgbcOoyXOxGyayvK/S8hB0XkrzaVdvED2ZwHNdw0ZgZ2SYanOhQRQW+UN/w
         fk6ELcTVpL25jvRB0J7SqHBzziWAWhoZW3QQ5V98hHltdolsEVrNNcBz/4//Co2z8KEc
         VzjsezbROvDpExZvffiXEXhbcrXGXlc3MKg26ATiXSuXk0GJo75gkGrgUcyDNR4JetK1
         bd1A==
Received: by 10.182.52.104 with SMTP id s8mr19651420obo.59.1334125166600;
        Tue, 10 Apr 2012 23:19:26 -0700 (PDT)
Received: from [192.168.2.10] (ip68-105-100-241.sd.sd.cox.net. [68.105.100.241])
        by mx.google.com with ESMTPS id j10sm1991183oba.4.2012.04.10.23.19.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 23:19:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110911 Thunderbird/6.0
In-Reply-To: <4F7780C3.2050408@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195152>

On 03/31/2012 03:10 PM, Ren=E9 Scharfe wrote:
> diff --git a/mergesort.c b/mergesort.c
> new file mode 100644
> index 0000000..c0f1874
> --- /dev/null
> +++ b/mergesort.c
> @@ -0,0 +1,75 @@
> +#include "cache.h"
> +#include "mergesort.h"
> +
> +#include "commit.h"

This is an unnecessary include, right?

diff --git a/mergesort.c b/mergesort.c
index c0f1874..d084c60 100644
--- a/mergesort.c
+++ b/mergesort.c
@@ -1,8 +1,6 @@
 #include "cache.h"
 #include "mergesort.h"

-#include "commit.h"
-
 struct mergesort_sublist {
        void *ptr;
        unsigned long len;
