From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/6] git.1: Clarify the behavior of the --paginate option
Date: Sun, 14 Feb 2010 06:02:35 -0600
Message-ID: <20100214120235.GC3499@progeny.tock>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Celis <sebastian@sebastiancelis.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 13:02:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgdBT-0001od-UV
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 13:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab0BNMCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 07:02:39 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:46176 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955Ab0BNMCi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 07:02:38 -0500
Received: by iwn39 with SMTP id 39so1362841iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 04:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=83F9S4q5DIo8CTEzMcSupvlJjwz6lB/MaWwSbU8pO18=;
        b=tOsY4RWyA3QKQWM1RgYjHjPxe7z7RIu5+NWoSFKjDHViCqSBm4u+A/iF5LrXI2b/k0
         mYIYyZamSwp5jm7COhh7MycK6eOg8Uiy7hQmKvaZ/Ao5vTI6CIHhbjZjyTxX+rkj0Xoq
         p7B7DFac4WGcY5IaM7K3dp+dpxzFDMmjpXLdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iHogsNre3uMhq90hArh9S2HlViyKa1WT120VAwTVLOJ85LuDHgChRZNogVdMAux0Mt
         UlIg/UgzRo/My4zZa61akUTQdFpWcvOni8HferYqsaWWuxxBJVjc2zGgkOEqIMM13XIT
         jy+zC2PoiVBykqHcnunnMcaX5uqfcLYyjl/aY=
Received: by 10.231.172.129 with SMTP id l1mr5449883ibz.7.1266148958198;
        Sun, 14 Feb 2010 04:02:38 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm5156339iwn.1.2010.02.14.04.02.37
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 04:02:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100214115430.GA1849@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139903>

The --paginate option is meant to negate the effect of an explicit or
implicit pager.<cmd> = false setting.  Thus it turns the pager on if
output is going to a terminal rather than unconditionally.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Noticed while testing.  (It might be nice to have an --always-paginate
facility to allow debugging by writing output from a pager into
something that is not a terminal.)

 Documentation/git.txt |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 01c4631..f26641a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -229,7 +229,10 @@ help ...`.
 
 -p::
 --paginate::
-	Pipe all output into 'less' (or if set, $PAGER).
+	Pipe all output into 'less' (or if set, $PAGER) if standard
+	output is a terminal.  This overrides the `pager.<cmd>`
+	configuration options (see the "Configuration Mechanism" section
+	below).
 
 --no-pager::
 	Do not pipe git output into a pager.
@@ -401,7 +404,8 @@ people.  Here is an example:
 ------------
 
 Various commands read from the configuration file and adjust
-their operation accordingly.
+their operation accordingly.  See linkgit:git-config[1] for a
+list.
 
 
 Identifier Terminology
-- 
1.7.0
