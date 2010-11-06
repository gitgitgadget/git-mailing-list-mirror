From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/8] pack-objects: mark file-local variable static
Date: Sat, 6 Nov 2010 06:47:57 -0500
Message-ID: <20101106114757.GF27641@burratino>
References: <20101106113905.GA27405@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:48:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEhFk-00034b-Px
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886Ab0KFLsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:48:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36569 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851Ab0KFLsE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 07:48:04 -0400
Received: by mail-iw0-f174.google.com with SMTP id 41so1928499iwn.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 04:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=oP5SzccD+hqjBQXFrizeNOVCeDHTir5NiBAuNAnLlno=;
        b=SDfg9VeUd9cCIVePCKP9lrUQbIKC7AO0npuPdcTMozgjnFUSnn4vJ4s7diA2B7uDAH
         MSWFypkxI4h6gMm591ujX1HIJdZzViMb/HeDy8LZDzmafLm4dE/tISfwVsxVnWID6fQt
         khNCNRA0w2hJaCFC3RYWRdz711iam2FqycX80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hKbBdIRmzr+U8O2W16dY8Jp0AXmxl08t8DpABUwNS1bKA2BkrsWX7mQ34xyuCTKx/P
         aIQEt4yVc/Wg6ndvU35lOK72QpKldkCQbof2P7f4gmOWIAT80610XqPIhXesKDGOZVuL
         Lp7eVkSKnoubqaGnc6JMZeECK+LEJSdo2OlBY=
Received: by 10.42.228.68 with SMTP id jd4mr2247825icb.68.1289044084594;
        Sat, 06 Nov 2010 04:48:04 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d21sm2823002ibg.9.2010.11.06.04.48.03
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Nov 2010 04:48:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101106113905.GA27405@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160848>

old_try_to_free_routine is not meant for use from other files.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/pack-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f8eba53..7471c92 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1529,7 +1529,7 @@ static void try_to_free_from_threads(size_t size)
 	read_unlock();
 }
 
-try_to_free_t old_try_to_free_routine;
+static try_to_free_t old_try_to_free_routine;
 
 /*
  * The main thread waits on the condition that (at least) one of the workers
-- 
1.7.2.3.557.gab647.dirty
