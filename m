From: Junio C Hamano <gitster@pobox.com>
Subject: Re* OS X Yosemite make all doc fails
Date: Wed, 26 Aug 2015 10:42:15 -0700
Message-ID: <xmqqmvxe2bgo.fsf_-_@gitster.dls.corp.google.com>
References: <CAJD5XByPQASzYpyTFdKo83RJ0QwPFHg-nPWyusDCucMRFbor4g@mail.gmail.com>
	<CAJD5XBy=skwogN+kbqHipa3poUt-EjSxMABxRZKoEk0J+2TM3w@mail.gmail.com>
	<CAJD5XBy+RnM7ZYt9_SGXgoE2gOKaiM=rmUv=Tkn3Ndi4S4-atQ@mail.gmail.com>
	<20150825010428.GA428718@vauxhall.crustytoothpaste.net>
	<CAJD5XBze8S23umS5enPaOKF6RFKwqkY-ZyuAfLG4SBp8CbCeRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff S <acornblue@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 19:42:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUeiM-0003uG-OE
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 19:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877AbbHZRmS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2015 13:42:18 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35617 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbbHZRmR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 13:42:17 -0400
Received: by pacdd16 with SMTP id dd16so167265674pac.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=G7eUNiyFN3B7yOmIT20BqaMdn7r05BevoB6xqoWFuTY=;
        b=t7nFxPtpvon3YvhToq6gOBweU3rAdY4gmiYVTjBUaz/TutVMUN8wW4/I7jtsJgh2K8
         lIOSjKDFpK3loGHHJhUkgwjHTcntUyIFR1aotKZ8mt6jVAHzAM6xDbvfz66c2wRLULPw
         oPp6peHcs2zGMpdW1uNRqwchzcJzxGnar5LWoyXoGT0KVn5uwh8Bf7Gt/wOO0CxdBAJX
         MfTzpEkHN/cJyNJWYtpNf7Mh1X3SKca6GD2M61rng7YKdg2Ppvc9MBLv2LFJvINYaxo0
         hG7jltDQn73+adNZol1o0upskp1eakycI5kNN3+o/Iv9g9A5ItH17tOASYDmXHwLT8Cz
         2edQ==
X-Received: by 10.68.117.11 with SMTP id ka11mr72486625pbb.77.1440610937041;
        Wed, 26 Aug 2015 10:42:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id dn3sm23052527pdb.66.2015.08.26.10.42.16
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 10:42:16 -0700 (PDT)
In-Reply-To: <CAJD5XBze8S23umS5enPaOKF6RFKwqkY-ZyuAfLG4SBp8CbCeRg@mail.gmail.com>
	(Jeff S.'s message of "Tue, 25 Aug 2015 17:20:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276621>

Jeff S <acornblue@gmail.com> writes:

> Brian thanks for responding! I'm finally able to build git completely=
=2E
> Would it be possible to add the OS X dependency to the git/INSTALL
> file?
>
> OSX Yosemite 10.10.5
> Xcode 6.4 (6E35b)
> =E2=80=A6
> $ brew install autoconf
> $ brew install asciidoc
> $ brew install xmlto
> $ brew install docbook
> $ export XML_CATALOG_FILES=3D/usr/local/etc/xml/catalog
> $ brew install docbook-xsl

It may not be a bad idea to add a whole section at the end of the
document to list the prerequisite packages for various common
platforms, whose beginning perhaps would look like this?

diff --git a/INSTALL b/INSTALL
index ffb071e..84fa5cf 100644
--- a/INSTALL
+++ b/INSTALL
@@ -221,3 +221,23 @@ Issues of note:
          http://www.oasis-open.org/docbook/xml/4.5/xsl/current \
          /usr/share/sgml/docbook/xml-dtd-4.5 \
      /etc/xml/catalog
+
+
+Platform specific hints:
+
+You would need to install prerequiste tools and libraries to compile
+and use Git from the source.
+
+ - OSX needs the following packages installed with 'brew install'
+   (in addition to the usual make and C compiler suite):
+
+   autoconf, asciidoc, xmlto, docbook, docbook-xsl
+
+ - Linux distributions derived from Debian need the following packages
+   instaslled via 'apt-get install' or similar (in addition to the
+   usual 'make' and C compiler suite that come as part of
+   build-essential):
+
+   autoconf, asciidoc, xmlto, docbook, libz-dev, livcurl4-openssl-dev,
+   ...
+
