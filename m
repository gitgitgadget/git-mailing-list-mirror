From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 'Unable to find remote helper'
Date: Thu, 4 Nov 2010 17:40:10 -0500
Message-ID: <20101104224010.GA18693@burratino>
References: <F815EC90C848458886E418CB6DE1DA8B@ssipboulton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Philip Boulton <philipb@ssimicro.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 23:40:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE8U4-00056L-QI
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 23:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab0KDWkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 18:40:36 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58949 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab0KDWkf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 18:40:35 -0400
Received: by yxk8 with SMTP id 8so1869294yxk.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 15:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jlU4DQdhQiMnG8I6jN3ATaYp0Zk0aC2wUTlmDNjdyIY=;
        b=l4ar48M9pZ5NzMI9/UjtzgdGlb8UnnRaQrZOk5yRSsLE6huLuVFKpvi5riJ6xwBWB0
         T8DL5HAr4c44GZBvJIyOncyqG0zNy7+n+N+LWXQP4qJF6a9f/LF6MBQxNUTNI8YFIqgY
         r9e8RzQUTFv43ZCyCkkm5l9hEr9WywlItafdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sKaWLWvuRQr5DVUEEu5Bg1PV4F52XebRtsd83ivcpAKo7+EX8Z0rmhPVjYJ53Uo/P0
         yUx3Bo6FlWbmqnDnssxUKT5qQ9aK3HYzkv1/KNmUUa+oGPj8LIbIfFD5aDFqkUx4vfOO
         1dfHxujGoBT1bsfck8MTTkhN3BGnthVBn7nbs=
Received: by 10.150.199.6 with SMTP id w6mr2157011ybf.363.1288910434502;
        Thu, 04 Nov 2010 15:40:34 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id m7sm497641qck.25.2010.11.04.15.40.32
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 15:40:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <F815EC90C848458886E418CB6DE1DA8B@ssipboulton>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160789>

Hi Philip,

Philip Boulton wrote:

> My git build commands are:
> ./configure
> gmake clean && gmake all
> gmake install

The "gmake clean" undoes the effect of "./configure".

Hope that helps.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/Makefile b/Makefile
index d3dcfb1..c693652 100644
--- a/Makefile
+++ b/Makefile
@@ -2229,7 +2229,7 @@ dist-doc:
 ### Cleaning rules
 
 distclean: clean
-	$(RM) configure
+	$(RM) configure config.mak.autogen
 
 clean:
 	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
@@ -2240,7 +2240,7 @@ clean:
 	$(RM) -r $(dep_dirs)
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
 	$(RM) -r autom4te.cache
-	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
+	$(RM) config.log config.mak.append config.status config.cache
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
