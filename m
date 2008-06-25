From: "Ifejinelo Onyiah" <nelo.onyiah@googlemail.com>
Subject: Errors building git-1.5.6 from source on Mac OS X 10.4.11
Date: Wed, 25 Jun 2008 14:20:39 +0100
Message-ID: <2eb980790806250620t73ae0ff7heedb65780a66ad00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 15:22:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBUwL-0004O8-VB
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 15:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985AbYFYNUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 09:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755885AbYFYNUm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 09:20:42 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:43924 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375AbYFYNUl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 09:20:41 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1146651wxd.4
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=5eoEjW1oV71mh4gHYVpUvOvVxPybJsvvgZ7LeXiFFRE=;
        b=igfAeRJMqslgQXxmjfo2EsPuwi4ODwKfjoDvTKptY7t4bUJHhnWud0qm7ex0sSKrwH
         Mj8yWfAd9b4UsmEAUqaXCOBliWd5zTmvqbippyNB5NOFbTcXfXUa4dPjBnEJg6/OA2hv
         IviqA/ZO7b+KuDrpFuMlaFddlZu4SwWbdvkYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=SySNMsBL9ijmT9xsDjFhPUpUZ1GiDvfHfsxNOzTI0SUoK/AW9MGvDEHA5ImPrmZqxS
         OjGjW8glfJt8DsHc15k6HEUS3QImX5BknWHpnJRF71D7Z+Jbu8mPFI9c7THHxFFKZqMl
         Jrcy3WuTxFKT9532O617v1uZpn9/81AH5Il34=
Received: by 10.142.133.15 with SMTP id g15mr6767097wfd.83.1214400039366;
        Wed, 25 Jun 2008 06:20:39 -0700 (PDT)
Received: by 10.151.7.15 with HTTP; Wed, 25 Jun 2008 06:20:39 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86277>

Hi,

I have made several attempts to build Git (version 1.5.6) on my Mac OS
X 10.4.11 (Tiger) but have had little luck. At the time of my last try
 (2008-06-25 11:08) there were no pre-built binaries for Tiger on the
Git home page. I downloaded the source file from home page and issued
the following commands:

% tar -xzf git-1.5.6.tar.gz
% cd git-1.5.6
% ./configure --prefix=/Users/io1/Applications/Git/1.5.6
% make

They all run fine but when I issue the make test command, it dies at
the following:

% make test

... TRUNCATED OUTPUT ...

*** t2004-checkout-cache-temp.sh ***
* FAIL 1: preparation

        mkdir asubdir &&
        echo tree1path0 >path0 &&
        echo tree1path1 >path1 &&
        echo tree1path3 >path3 &&
        echo tree1path4 >path4 &&
        echo tree1asubdir/path5 >asubdir/path5 &&
        git update-index --add path0 path1 path3 path4 asubdir/path5 &&
        t1=$(git write-tree) &&
        rm -f path* .merge_* out .git/index &&
        echo tree2path0 >path0 &&
        echo tree2path1 >path1 &&
        echo tree2path2 >path2 &&
        echo tree2path4 >path4 &&
        git update-index --add path0 path1 path2 path4 &&
        t2=$(git write-tree) &&
        rm -f path* .merge_* out .git/index &&
        echo tree2path0 >path0 &&
        echo tree3path1 >path1 &&
        echo tree3path2 >path2 &&
        echo tree3path3 >path3 &&
        git update-index --add path0 path1 path2 path3 &&
        t3=$(git write-tree)
*   ok 2: checkout one stage 0 to temporary file
*   ok 3: checkout all stage 0 to temporary files
*   ok 4: prepare 3-way merge
* FAIL 5: checkout one stage 2 to temporary file

        rm -f path* .merge_* out &&
        git checkout-index --stage=2 --temp -- path1 >out &&
        test $(wc -l <out) = 1 &&
        test $(cut "-d  " -f2 out) = path1 &&
        p=$(cut "-d     " -f1 out) &&
        test -f $p &&
        test $(cat $p) = tree2path1
* FAIL 6: checkout all stage 2 to temporary files

        rm -f path* .merge_* out &&
        git checkout-index --all --stage=2 --temp >out &&
        test $(wc -l <out) = 3 &&
        for f in path1 path2 path4
        do
                test $(grep $f out | cut "-d    " -f2) = $f &&
                p=$(grep $f out | cut "-d       " -f1) &&
                test -f $p &&
                test $(cat $p) = tree2$f
        done
*   ok 7: checkout all stages/one file to nothing
* FAIL 8: checkout all stages/one file to temporary files

        rm -f path* .merge_* out &&
        git checkout-index --stage=all --temp -- path1 >out &&
        test $(wc -l <out) = 1 &&
        test $(cut "-d  " -f2 out) = path1 &&
        cut "-d " -f1 out | (read s1 s2 s3 &&
        test -f $s1 &&
        test -f $s2 &&
        test -f $s3 &&
        test $(cat $s1) = tree1path1 &&
        test $(cat $s2) = tree2path1 &&
        test $(cat $s3) = tree3path1)
* FAIL 9: checkout some stages/one file to temporary files

        rm -f path* .merge_* out &&
        git checkout-index --stage=all --temp -- path2 >out &&
        test $(wc -l <out) = 1 &&
        test $(cut "-d  " -f2 out) = path2 &&
        cut "-d " -f1 out | (read s1 s2 s3 &&
        test $s1 = . &&
        test -f $s2 &&
        test -f $s3 &&
        test $(cat $s2) = tree2path2 &&
        test $(cat $s3) = tree3path2)
* FAIL 10: checkout all stages/all files to temporary files

        rm -f path* .merge_* out &&
        git checkout-index -a --stage=all --temp >out &&
        test $(wc -l <out) = 5
*   ok 11: -- path0: no entry
* FAIL 12: -- path1: all 3 stages

        test $(grep path1 out | cut "-d " -f2) = path1 &&
        grep path1 out | cut "-d        " -f1 | (read s1 s2 s3 &&
        test -f $s1 &&
        test -f $s2 &&
        test -f $s3 &&
        test $(cat $s1) = tree1path1 &&
        test $(cat $s2) = tree2path1 &&
        test $(cat $s3) = tree3path1)
* FAIL 13: -- path2: no stage 1, have stage 2 and 3

        test $(grep path2 out | cut "-d " -f2) = path2 &&
        grep path2 out | cut "-d        " -f1 | (read s1 s2 s3 &&
        test $s1 = . &&
        test -f $s2 &&
        test -f $s3 &&
        test $(cat $s2) = tree2path2 &&
        test $(cat $s3) = tree3path2)
* FAIL 14: -- path3: no stage 2, have stage 1 and 3

        test $(grep path3 out | cut "-d " -f2) = path3 &&
        grep path3 out | cut "-d        " -f1 | (read s1 s2 s3 &&
        test -f $s1 &&
        test $s2 = . &&
        test -f $s3 &&
        test $(cat $s1) = tree1path3 &&
        test $(cat $s3) = tree3path3)
* FAIL 15: -- path4: no stage 3, have stage 1 and 3

        test $(grep path4 out | cut "-d " -f2) = path4 &&
        grep path4 out | cut "-d        " -f1 | (read s1 s2 s3 &&
        test -f $s1 &&
        test -f $s2 &&
        test $s3 = . &&
        test $(cat $s1) = tree1path4 &&
        test $(cat $s2) = tree2path4)
* FAIL 16: -- asubdir/path5: no stage 2 and 3 have stage 1

        test $(grep asubdir/path5 out | cut "-d " -f2) = asubdir/path5 &&
        grep asubdir/path5 out | cut "-d        " -f1 | (read s1 s2 s3 &&
        test -f $s1 &&
        test $s2 = . &&
        test $s3 = . &&
        test $(cat $s1) = tree1asubdir/path5)
* FAIL 17: checkout --temp within subdir

        (cd asubdir &&
         git checkout-index -a --stage=all >out &&
         test $(wc -l <out) = 1 &&
         test $(grep path5 out | cut "-d        " -f2) = path5 &&
         grep path5 out | cut "-d       " -f1 | (read s1 s2 s3 &&
         test -f ../$s1 &&
         test $s2 = . &&
         test $s3 = . &&
         test $(cat ../$s1) = tree1asubdir/path5)
        )
*   ok 18: checkout --temp symlink
* failed 12 among 18 test(s)
make[1]: *** [t2004-checkout-cache-temp.sh] Error 1
make: *** [test] Error 2

%

I have searched the mailing lists and googled around but have yet to
turn up a satisfactory solution. Hence I come to you.

Any assistance will be greatly appreciated.

_____________________________

Ifejinelo Onyiah

Computer Biologist
Genome Dynamics and Evolution Group
Wellcome Trust Sanger Institute
Hinxton
Cambridge CB10 1SA
UK
