From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] Drop unnecessary #includes from test-hashmap
Date: Fri, 13 Dec 2013 18:06:40 -0800
Message-ID: <20131214020640.GD2311@google.com>
References: <52851FB5.4050406@gmail.com>
 <528521E2.7090305@gmail.com>
 <20131214020413.GB2311@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 03:06:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vred0-000239-Ey
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 03:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383Ab3LNCGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Dec 2013 21:06:46 -0500
Received: from mail-yh0-f47.google.com ([209.85.213.47]:42395 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab3LNCGp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 21:06:45 -0500
Received: by mail-yh0-f47.google.com with SMTP id 29so2122230yhl.20
        for <git@vger.kernel.org>; Fri, 13 Dec 2013 18:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=65zX485QiHXOnFAaHQrl8QFU0ejGd8Lx0KHgfXYjMkg=;
        b=Qda9G+ydHQX0/OqEpCv4uJijAYtKLozyiczRUIEKZgxzC/mrsAczQVL9X2saeReyD7
         LqtBFQUKpU1jKC64b+D2/jPlRIP6+ytApN7ds+Q9WeXNN2sbBUk43JfYO3Q2Qvq2Lnj/
         S2IUJq5CckjTZEHkkguidtRHtHvcUCUR3JvaUbp1PZfJiUW1bJwvVaBIVcxnLdtrWrXe
         m8AIfxJKCko+oxJnaIcqQFdlM6Y6DpqltdrdYi9BPUx/UQbaDO8jRaV1HJJ5peB1STZB
         sRHNPygV/Oqyyf8dLxU+tcaVPoatQHS7E299370ksiQUQAA4egLGMAe5Ajy9MyhLqSuL
         CInA==
X-Received: by 10.236.82.198 with SMTP id o46mr4843352yhe.53.1386986805353;
        Fri, 13 Dec 2013 18:06:45 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 9sm6191960yhe.21.2013.12.13.18.06.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Dec 2013 18:06:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131214020413.GB2311@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239275>

Per Documentation/CodingGuidelines most C files in git start with
a #include of git-compat-util.h or another header file that includes
it, such as cache.h or builtin.h.  This file doesn't need anything
beyond "git-compat-util.h", so use that.

Remove a #include of the system header <stdio.h> since it is already
included by "git-compat-util.h".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 test-hashmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/test-hashmap.c b/test-hashmap.c
index 7e86f88..f5183fb 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -1,6 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "hashmap.h"
-#include <stdio.h>
 
 struct test_entry
 {
-- 
1.8.5.1
