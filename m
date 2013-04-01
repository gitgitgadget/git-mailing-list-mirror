From: Phil Hord <phil.hord@gmail.com>
Subject: transient build error after 'Writing MYMETA.yml and MYMETA.json'
Date: Mon, 1 Apr 2013 12:38:46 -0400
Message-ID: <CABURp0os62JCPCRsvQ+NneGaSobTUmgs7oZ9SqUiTH8AG0hPmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 01 18:39:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMhlh-0002GF-D3
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 18:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759117Ab3DAQjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 12:39:08 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:65034 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759113Ab3DAQjH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 12:39:07 -0400
Received: by mail-ve0-f171.google.com with SMTP id b10so2736527vea.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=f8//I2lxR2mJ063oyk6baFS0/RUXIOk+5V4MZlRYfJM=;
        b=v76r6sAoslk12SrhdmcQwwuWaJGOMeKXq0iIT+3Pd36K5McwiA2CGBCzj+qNq9Zulq
         JoDBAZJLHzU6V1Kve2b4LtEYxCmQ63Px1kFgiXwr8ny51Gz+ivwRg5mRbz8x+dkaXxQS
         o9vipSWgSxiAF+bglIANTnhtS3vK4slxP5Xu6PM3xEtHBYVL7gVPYBz1M+kIvnHsSUa/
         cyhEXNwl1qNDdbGS5zT+JWgsfx7+Tjk3NZwfJePRqVp0eULYlZIvQu39heyW2x/lXKPf
         mpvlOIUg01hvi2NutqmkmTHKP3VHJN7gLuK+chKxBnHieBdITt4k9tDBQM5wcp7+pmkO
         XPVA==
X-Received: by 10.58.187.42 with SMTP id fp10mr9721280vec.46.1364834346485;
 Mon, 01 Apr 2013 09:39:06 -0700 (PDT)
Received: by 10.58.23.135 with HTTP; Mon, 1 Apr 2013 09:38:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219692>

I have not seen this before, which makes me think it is something new
in the makefiles.  But maybe it was a one-time fluke. When I ran
'make' again, it proceeded as normal.

My previous build was on pre-rebase 'next' at c1ece63.  I did not try
a 'make clean' in between, but I have since.  I tried to reproduce it
and I cannot.  I am building on Ubuntu 12.04.

I do not see any significant differences in the Makefile between my
last build point and this one.

Is this expected or easily explained?

$ make prefix=/home/hordp all doc man
...
    GEN git-add--interactive
Writing perl.mak for Git
Writing MYMETA.yml and MYMETA.json
make[2]: *** [perl.mak] Error 1
make[1]: *** [instlibdir] Error 2
make: *** [git-add--interactive] Error 2
$ make prefix=/home/hordp all doc man
    GEN perl/PM.stamp
    SUBDIR perl
/usr/bin/perl Makefile.PL PREFIX='/home/hordp' INSTALL_BASE=''
--localedir='/home/hordp/share/locale'
Writing perl.mak for Git
Writing MYMETA.yml and MYMETA.json
    GEN git-add--interactive
    GEN git-difftool
    GEN git-archimport


Phil
