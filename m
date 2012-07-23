From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2 0/7] i18n for git-am, git-rebase and git-merge
Date: Mon, 23 Jul 2012 15:32:04 +0800
Message-ID: <CANYiYbGyDcR-y-JG5sPLVx0vfc9P+rQerF5ME2nkQ=0FyQB4xw@mail.gmail.com>
References: <cover.1342920089.git.worldhello.net@gmail.com>
	<7vmx2rr320.fsf@alter.siamese.dyndns.org>
	<CANYiYbFvk60NxfOTxq-xS8vt5t9xW8HLQrE_GuHGkC+u6vWfsw@mail.gmail.com>
	<7v4nozozz0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 09:32:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StD7l-0003Ni-UN
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 09:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941Ab2GWHcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 03:32:08 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56680 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab2GWHcG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 03:32:06 -0400
Received: by gglu4 with SMTP id u4so5149721ggl.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HQTZzcAF4gu2UT87vXocOVVfEZWqyhFes1BpwIsisDM=;
        b=w5RHKqh0XHAaWL9XK3sjxnSz8fGIGDPMa1fyBx7TG5XohJFUrmZ1v1LcBDdgHL/Vjw
         TAu27JsG/JPfuEPluKh7WaN5D4Phtu326OUEYmuRhpwVROHYdt+S8K0GV7Rh3S6c+Syv
         85e3peOthSxDxskQGOwLsjJp6Te66TPozvAZMkgJfVyN0bgem2v4//vy4JpTTF6rCuGV
         g8DKW06ONLvaoT428ameZgnnew8mrw6U/+yvw6ogDEXxqsv1bXUJluTrbQ+hWCu9MbAj
         QCxmJesKi/eqKXNzeqvcbNuEgfj218/cew4NeLRO+Cg2vTcpdvdp2U45oO4aCDxd/rh9
         kfaw==
Received: by 10.50.89.130 with SMTP id bo2mr9836122igb.19.1343028724983; Mon,
 23 Jul 2012 00:32:04 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Mon, 23 Jul 2012 00:32:04 -0700 (PDT)
In-Reply-To: <7v4nozozz0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201919>

2012/7/23 Junio C Hamano <gitster@pobox.com>:
>> I find one test case failed, and correct it in PATCH 3/7.
>
> That test used i18ncmp already, so the update to expected string
> would be sufficient.  I was worried if there were existing tests
> that have been expecting that the output from am/rebase/merge would
> not be i18n'ised and using "test_cmp expect actual" to compare their
> output with expected result.

If build git with GETTEXT_POISON and test, lots of test cases failed.
It seems that we haven't run these test cases for i18n for a long time.

test of t0006-date.sh failed, because of i18n in commit 7d29af.

    7d29a i18n: mark relative dates for translation

test of t0040-parse-options.sh failed, because of i18n in commit 54e6dc7:

    54e6d i18n: parseopt: lookup help and argument translations when
showing usage

I will try to fix them in next version of the patches.

Test Summary Report
-------------------
./t0006-date.sh                                    (Wstat: 256 Tests:
45 Failed: 11)
  Failed tests:  1-11
  Non-zero exit status: 1
./t0050-filesystem.sh                              (Wstat: 0 Tests: 10
Failed: 0)
  TODO passed:   6
./t0040-parse-options.sh                           (Wstat: 256 Tests:
36 Failed: 4)
  Failed tests:  1, 11-12, 27
  Non-zero exit status: 1
./t1502-rev-parse-parseopt.sh                      (Wstat: 256 Tests:
8 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
./t1450-fsck.sh                                    (Wstat: 256 Tests:
16 Failed: 1)
  Failed test:  13
  Non-zero exit status: 1
./t1300-repo-config.sh                             (Wstat: 256 Tests:
104 Failed: 1)
  Failed test:  48
  Non-zero exit status: 1
./t2006-checkout-index-basic.sh                    (Wstat: 256 Tests:
2 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
./t2107-update-index-basic.sh                      (Wstat: 256 Tests:
3 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
./t3004-ls-files-basic.sh                          (Wstat: 256 Tests:
4 Failed: 2)
  Failed tests:  3-4
  Non-zero exit status: 1
./t3200-branch.sh                                  (Wstat: 256 Tests:
82 Failed: 2)
  Failed tests:  3, 10
  Non-zero exit status: 1
./t3406-rebase-message.sh                          (Wstat: 256 Tests:
6 Failed: 1)
  Failed test:  6
  Non-zero exit status: 1
./t3400-rebase.sh                                  (Wstat: 256 Tests:
26 Failed: 4)
  Failed tests:  5-8
  Non-zero exit status: 1
./t3501-revert-cherry-pick.sh                      (Wstat: 256 Tests:
7 Failed: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
./t4006-diff-mode.sh                               (Wstat: 256 Tests:
7 Failed: 4)
  Failed tests:  4-7
  Non-zero exit status: 1
./t4012-diff-binary.sh                             (Wstat: 256 Tests:
13 Failed: 2)
  Failed tests:  7-8
  Non-zero exit status: 1
./t4035-diff-quiet.sh                              (Wstat: 256 Tests:
20 Failed: 3)
  Failed tests:  16, 18, 20
  Non-zero exit status: 1
./t4120-apply-popt.sh                              (Wstat: 256 Tests:
8 Failed: 2)
  Failed tests:  3, 5
  Non-zero exit status: 1
./t4133-apply-filenames.sh                         (Wstat: 256 Tests:
2 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
./t4200-rerere.sh                                  (Wstat: 256 Tests:
25 Failed: 2)
  Failed tests:  24-25
  Non-zero exit status: 1
./t4205-log-pretty-formats.sh                      (Wstat: 256 Tests:
13 Failed: 1)
  Failed test:  12
  Non-zero exit status: 1
./t4202-log.sh                                     (Wstat: 256 Tests:
33 Failed: 1)
  Failed test:  33
  Non-zero exit status: 1
./t3903-stash.sh                                   (Wstat: 256 Tests:
46 Failed: 1)
  Failed test:  45
  Non-zero exit status: 1
./t5300-pack-object.sh                             (Wstat: 256 Tests:
33 Failed: 2)
  Failed tests:  32-33
  Non-zero exit status: 1
./t5505-remote.sh                                  (Wstat: 256 Tests:
68 Failed: 9)
  Failed tests:  2-3, 6-9, 13, 15, 46
  Non-zero exit status: 1
./t5530-upload-pack-error.sh                       (Wstat: 256 Tests:
10 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
./t6500-gc.sh                                      (Wstat: 256 Tests:
3 Failed: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
./t6042-merge-rename-corner-cases.sh               (Wstat: 256 Tests:
26 Failed: 1)
  Failed test:  18
  Non-zero exit status: 1
./t6022-merge-rename.sh                            (Wstat: 256 Tests:
46 Failed: 3)
  Failed tests:  12, 15-16
  Non-zero exit status: 1
./t7008-grep-binary.sh                             (Wstat: 0 Tests: 20
Failed: 0)
  TODO passed:   12
./t7508-status.sh                                  (Wstat: 256 Tests:
76 Failed: 1)
  Failed test:  5
  Non-zero exit status: 1
./t7600-merge.sh                                   (Wstat: 256 Tests:
48 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
./t9903-bash-prompt.sh                             (Wstat: 256 Tests:
44 Failed: 6)
  Failed tests:  6, 8, 12-15
  Non-zero exit status: 1
Files=595, Tests=8548, 739 wallclock secs ( 5.05 usr  2.11 sys +
362.59 cusr 466.00 csys = 835.75 CPU)
Result: FAIL

-- 
Jiang Xin
