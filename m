From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: [PATCH 2/2] Document toplevel gitconfig file
Date: Thu, 25 Nov 2010 14:01:50 -0600
Message-ID: <f15d6598e5e90de3bcdb8caf706735ac4809ad36.1290870042.git.nathan.panike@gmail.com>
References: <cover.1290870041.git.nathan.panike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 27 16:34:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMMnf-0006E8-Rl
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 16:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729Ab0K0Pel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 10:34:41 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65383 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401Ab0K0Pek (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 10:34:40 -0500
Received: by mail-iw0-f174.google.com with SMTP id 35so661819iwn.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 07:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:in-reply-to
         :references:from:date:subject:to;
        bh=s3/5W1MqIggWvcdfV62/EZYhTRzRUM0gVJv1/iSqGHQ=;
        b=qOhzhNFS0rZguddLa2IH1WyKTgNPShiM9SxWFpAfSfAp5hXpIurlvIiHi8vHc4zaHa
         aD8Ja59CcC0VcHooubJAoTrW7gbXePzLUiDO0aiHBnhmHPwHK/erjeCe+uBdDqYd4aIh
         dmiIYMBP4ItChnOKuZ3ENJmv6f0qlICZby++s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:in-reply-to:references:from:date:subject:to;
        b=LowlufALdpxpOoakn7vS5ECmDzF6v9N21rZjDoQYTk9U8T12HUMJ904xq5qrsoFT3t
         q8kns7PkvE7ADCVeej30+Y5Rdup43hL5ci6u49nWLickHFO4+ZI8bv0UTPuN5vLix1sG
         49qO58gBPI3JvmFJCmnWesEgktxqO+tLfCJ6w=
Received: by 10.42.170.196 with SMTP id g4mr1024244icz.454.1290872080357;
        Sat, 27 Nov 2010 07:34:40 -0800 (PST)
Received: from localhost (ppp-70-226-163-137.dsl.mdsnwi.ameritech.net [70.226.163.137])
        by mx.google.com with ESMTPS id d21sm3484612ibg.3.2010.11.27.07.34.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Nov 2010 07:34:39 -0800 (PST)
In-Reply-To: <cover.1290870041.git.nathan.panike@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162311>

Try to explain its security implications and how to turn it off.

Signed-off-by: Nathan W. Panike <nathan.panike@gmail.com>
---
 Documentation/config.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6a6c0b5..6ec9a0b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -8,6 +8,17 @@ is used to store the configuration for that repository, and
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store a system-wide default configuration.
 
+One can also create a `.gitconfig` file in the toplevel of the
+repository. This config file will then be propogated to collaborators
+when they pull from your repository.  Only `alias` config variables are
+allowed to be set in this `.gitconfig` file.  One can turn off the
+shared `.gitconfig` by setting the environment variable
+'GIT_CONFIG_NOSHARED' to 1; it will then be propogated but will not be
+used for configuration settings.  Note that this is a security issue
+because you are basically allowing someone else to dictate your
+configuration, but should be fine if you pay attention and do not use
+aliases from someone else blindly.
+
 The configuration variables are used by both the git plumbing
 and the porcelains. The variables are divided into sections, wherein
 the fully qualified variable name of the variable itself is the last
-- 
1.7.3.2.347.gd33a62
