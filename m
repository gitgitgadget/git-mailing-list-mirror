From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Errors install git-1.5.2.2 on 64-bit AIX
Date: Wed, 20 Jun 2007 10:45:35 +0800
Message-ID: <4b3406f0706191945j1a489743qfacdcafd7f7d73d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jun 20 04:45:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0qCQ-0006vm-Ci
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 04:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759434AbXFTCph (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 22:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759611AbXFTCpg
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 22:45:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:45177 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759019AbXFTCpg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 22:45:36 -0400
Received: by wx-out-0506.google.com with SMTP id t15so40629wxc
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 19:45:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DfKaT9GufT4PJecauGdrqWzH2ylzQ3xQppxtxdQZZ1rYdXrTrYZuUJu8Nrns2eKEkyNAdh3AbvxaORix28/kC4iTaGiQWDflOAJOLiXktNbyK5uL6C3H1spsFukHlawfjj3UvZ7FxAoljdKM9WeFVDEg9GPENqlklW2smf7irVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bT8eLJxFvEVDwkEvNNwCeVAupP9iRRlW3c77/pr9i+qTDxLnLg7Y3N4Ov3AIeO0RuATbKiSPyBsMDf1q8uycKnJC/Z1RRn3Qi/fB7nFBQBqtOraGj2Yf/Efr/ddlKgUc/syRQD99DR+ahut52wPUyhp5rWd/fxzCpARc/8o+XYE=
Received: by 10.70.113.5 with SMTP id l5mr251866wxc.1182307535211;
        Tue, 19 Jun 2007 19:45:35 -0700 (PDT)
Received: by 10.70.43.12 with HTTP; Tue, 19 Jun 2007 19:45:35 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50524>

After I modified Makefile:

NO_OPENSSL=1
NO_CURL=1
NO_EXPAT=1

CFLAGS = -maix64 -g -O2 -Wall
LDFLAGS = -b64 -lz
AR = ar -X64

Make succeed:

bash-3.00# gnumake
GIT_VERSION = 1.5.2.2
    * new build flags or prefix
    CC convert-objects.o
...
    SUBDIR perl
cp private-Error.pm blib/lib/Error.pm
cp Git.pm blib/lib/Git.pm
Manifying blib/man3/private-Error.3
Manifying blib/man3/Git.3
    SUBDIR templates
gcc -maix64 -g -O2 -Wall  -DNO_OPENSSL
-DSHA1_HEADER='"mozilla-sha1/sha1.h"'
-DETC_GITCONFIG='"/usr/git/etc/gitconfig"' -DNO_STRCASESTR
-DNO_STRLCPY -o test-chmtime -lz  test-chmtime.c
gcc -maix64 -g -O2 -Wall  -DNO_OPENSSL
-DSHA1_HEADER='"mozilla-sha1/sha1.h"'
-DETC_GITCONFIG='"/usr/git/etc/gitconfig"' -DNO_STRCASESTR
-DNO_STRLCPY -o test-genrandom -lz  test-genrandom.c

But install failed:

bash-3.00# gnumake install
    SUBDIR git-gui
    SUBDIR perl
    SUBDIR templates
install -d -m755 '/usr/git/bin'
getopt: illegal option -- d
getopt: illegal option -- 7
getopt: illegal option -- 5
getopt: illegal option -- 5
Usage: install [-c dira] [-f dirb] [-i] [-m] [-M mode] [-O owner]
               [-G group] [-S] [-n dirc] [-o] [-s] file [dirx ...]
gnumake: *** [install] Error 2

Thanks for some help.

---
Dongsheng
