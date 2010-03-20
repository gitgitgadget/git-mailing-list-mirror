From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH squash] gitk: Update makefile to keep -encoding option for
 gitk-wish
Date: Sat, 20 Mar 2010 01:24:58 -0500
Message-ID: <20100320062427.GA26434@progeny.tock>
References: <1268418709-4998-1-git-send-email-patthoyts@users.sourceforge.net>
 <1268418709-4998-2-git-send-email-patthoyts@users.sourceforge.net>
 <1268418709-4998-3-git-send-email-patthoyts@users.sourceforge.net>
 <20100320061452.GA26224@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Mar 20 07:24:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nss6a-0002OG-Cg
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 07:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021Ab0CTGYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 02:24:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35037 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab0CTGYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 02:24:09 -0400
Received: by gwaa18 with SMTP id a18so152504gwa.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 23:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kywAdSZPbEdcx9UIWLVmOVSDUgyUTvztULDJdCn9LT4=;
        b=d9LDKSFgRZJITNxP/ObuibqsdBjm5kKysBvRpmdSWoTSwFLyM9B5j6SKR+bRxAJ4vx
         32ORXrdBlDI1HfhpNT1u22w2HRxxt1UQjVv/ZuTEcbkXIT5itSFJo52H5CYmzIkeF50s
         AK94+AC0v/JsklZ0jngzx32BkA70H2mFGbayk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a+N/CcHJy39j5rgYLdHqPdA7LHf9SxzwNf0rYd47l5nZaxAyhtU7y8GDVWCzmW7MpA
         jsRT40T11XvEdNTXLUBhS96Xw/nn0lSleMdr2s+8+gJrx+N+UIOfhDHfkiK8exJfqnw/
         lq9zN18JVl6BHkzzlzNmKV/Tu31CsME7BUAPA=
Received: by 10.90.13.17 with SMTP id 17mr1454619agm.113.1269066247456;
        Fri, 19 Mar 2010 23:24:07 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm929581iwn.15.2010.03.19.23.24.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 23:24:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100320061452.GA26224@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142691>

Jonathan Nieder wrote:

> I can reproduce this in Linux with LANG=de_DE@euro ./gitk.

This should be squashed in to fix LANG=de_DE@euro ./gitk-wish, too.
Sorry for the trouble.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index e1b6045..1cc922c 100644
--- a/Makefile
+++ b/Makefile
@@ -53,7 +53,7 @@ clean::
 
 gitk-wish: gitk
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' <gitk >$@+ && \
+	sed -e '1,3s|^exec .* -encoding|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) -encoding|' <gitk >$@+ && \
 	chmod +x $@+ && \
 	mv -f $@+ $@
 
-- 
1.7.0.2
