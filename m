From: Perrin Meyer <perrinmeyer@yahoo.com>
Subject: 1.5.3-rc5 regression on OS X?
Date: Wed, 15 Aug 2007 14:19:47 -0700 (PDT)
Message-ID: <600399.61066.qm@web52807.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 23:20:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILQHS-0002AB-Ms
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 23:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933616AbXHOVTu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 17:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934018AbXHOVTt
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 17:19:49 -0400
Received: from web52807.mail.re2.yahoo.com ([206.190.48.250]:22655 "HELO
	web52807.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933616AbXHOVTt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 17:19:49 -0400
Received: (qmail 61292 invoked by uid 60001); 15 Aug 2007 21:19:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=xlfMv2JeH9zSZsACNEjgPO3d8e6RCGR2S6xSFhkiZ43LcknUHzhmKMVYzRqdg0UA7gCAMQBmvF/6Izt5E6olo1zLKFYUimGDNgjbqieILKS18CQlhxBzaj521PqmpPuuBHvz/qctzlDbjHDgTVnwaAJJhACEq7Ya1RAE+AH8Iak=;
X-YMail-OSG: 27mylYkVM1nyKxs5QQcbEyjqJ2.EXvSDNJOJrdpdYKHa_zvVGPyi97akSU_1ZhhCkbk6CJfwQQ--
Received: from [216.52.12.233] by web52807.mail.re2.yahoo.com via HTTP; Wed, 15 Aug 2007 14:19:47 PDT
X-Mailer: YahooMailRC/651.48 YahooMailWebService/0.7.119
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55949>


Hi,

When I try to build and test 1.5.3-rc5 on my OS X box, I get a failure on "make test"

*   ok 82: 15 (fail) - must match A in O && A && B && O==A && O==B case
* FAIL 83: 16 - A matches in one and B matches in another.
        rm -f .git/index F16 &&
            echo F16 >F16 &&
            git update-index --add F16 &&
            tree0=`git write-tree` &&
            echo E16 >F16 &&
            git update-index F16 &&
            tree1=`git write-tree` &&
            git read-tree -m $tree0 $tree1 $tree1 $tree0 &&
            git ls-files --stage
* failed 1 among 83 test(s)
make[1]: *** [t1000-read-tree-m-3way.sh] Error 1
make: *** [test] Error 2


I was able to build and test git 1.5.2.4 fine, with no errors in the test suite. 

I also just build 1.5.3-rc5 on a redhat box, with no errors in the testsuite. 

My OS X box is a quad G5 running OS X 10.4.10, with gcc version: 

perrin-meyers-power-mac-g5:~/GIT/git perrin$ gcc -v
Using built-in specs.
Target: powerpc-apple-darwin8
Configured with: /private/var/tmp/gcc/gcc-5026.obj~19/src/configure --disable-checking --prefix=/usr --mandir=/share/man --enable-languages=c,objc,c++,obj-c++ --program-transform-name=/^[cg][^+.-]*$/s/$/-4.0/ --with-gxx-include-dir=/include/gcc/darwin/4.0/c++ --build=powerpc-apple-darwin8 --host=powerpc-apple-darwin8 --target=powerpc-apple-darwin8
Thread model: posix
gcc version 4.0.0 (Apple Computer, Inc. build 5026)

I define "NO_EXPAT" when I build on OS X. 

Am I doing something wrong?

Thanks,

Perrin
