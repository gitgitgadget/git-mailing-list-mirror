From: Alecs King <alecsk@gmail.com>
Subject: [PATCH] add freebsd support in Makefile
Date: Fri, 27 Jan 2006 02:04:30 +0800
Message-ID: <20060126180430.GA29593@alc.ourbox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 26 19:05:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2BUJ-0005Et-8S
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 19:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWAZSEq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 13:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWAZSEq
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 13:04:46 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:10839 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932383AbWAZSEp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jan 2006 13:04:45 -0500
Received: by zproxy.gmail.com with SMTP id 13so445104nzn
        for <git@vger.kernel.org>; Thu, 26 Jan 2006 10:04:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=J3Li0Acvjisc75Bo3xtAoVGy2ZMvNG96xTn2xY87GyobqD9Y64krNeORNt5p/u6J3iz3MMll8k3daVfX7Gb4JwIt9t4gqtHNi7xaDfBrFq76UE14qKnh6PKPsqlDdR+wUA3IO63MJoukOEeQjXLxXLxgyFpAlooWUg+rHeV194g=
Received: by 10.37.20.41 with SMTP id x41mr1725642nzi;
        Thu, 26 Jan 2006 10:04:44 -0800 (PST)
Received: from localhost ( [218.58.83.181])
        by mx.gmail.com with ESMTP id 16sm2088361nzo.2006.01.26.10.04.43;
        Thu, 26 Jan 2006 10:04:44 -0800 (PST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15170>

fbsd needs iconv and third party lib/headers are inside /usr/local

Signed-off-by: Alecs King <alecsk@gmail.com>

e3b0db75ae3521b979a0b7ab115abdfab24b3111
diff --git a/Makefile b/Makefile
index 2e95353..6910448 100644
--- a/Makefile
+++ b/Makefile
@@ -251,6 +251,11 @@ ifeq ($(uname_O),Cygwin)
 	NO_IPV6 = YesPlease
 	X = .exe
 endif
+ifeq ($(uname_S),FreeBSD)
+	NEEDS_LIBICONV = YesPlease
+	ALL_CFLAGS += -I/usr/local/include
+	ALL_LDFLAGS += -L/usr/local/lib
+endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
 	NEEDS_LIBICONV = YesPlease

-- 
Alecs King
