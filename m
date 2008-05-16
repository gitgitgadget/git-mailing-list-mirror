From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: [BUG] make test fails on osx (t7502-commit.sh)
Date: Fri, 16 May 2008 19:59:11 -0400
Message-ID: <75B80F22-AC86-4D3F-A7E6-7DE70AEE5114@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 02:00:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx9qJ-0002tw-Q4
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 02:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbYEPX7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 19:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbYEPX7R
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 19:59:17 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:30208 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbYEPX7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 19:59:16 -0400
Received: by an-out-0708.google.com with SMTP id d40so257742and.103
        for <git@vger.kernel.org>; Fri, 16 May 2008 16:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=JOqe9rDqLakOaP5MbdqQUaiu8ZDY4+TsKegvZV5itw8=;
        b=NKSFagBlCIIwbmYesEkcfltoOCM6N0qQoS+3ffVa6AfjMwepgR2n6Upsj7LGBczHFPjap56EaPfvrv6eC9Qm+kJB4l3q38p2k7XhOTVkwniBDT7R+MvGNUCWbxsaxnt9CHjLYQVHUMDsYCsLVc1MpQkFV55p/ZyM3w/rnFSiKVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=HUv9BL1DTcAHq3bxP+Oj63QtislQO+N2dJ3ZeIzz2mSN/nqdee1aMLqgLVIEpoSRiyg5w7ygBz4akYAtwPgEitHJJUE0phWrT9bz6jobpTm1SiY0lk3DNmp1z7xiLPCyZ/tVvsdPFAXwuO0diEaAFXnPcShAwsnpCNgo9ag2vgs=
Received: by 10.100.93.19 with SMTP id q19mr4832070anb.139.1210982354530;
        Fri, 16 May 2008 16:59:14 -0700 (PDT)
Received: from ?192.168.1.101? ( [65.96.170.12])
        by mx.google.com with ESMTPS id c37sm9622335ana.11.2008.05.16.16.59.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 May 2008 16:59:13 -0700 (PDT)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82319>

just checked out the main branch  
1fbb58b4153e90eda08c2b022ee32d90729582e6
The offending message from make test follows.

-Kate
P.S. My apologies if this is a dupe. I didn't see it when i searched  
the archives.


*** t7502-commit.sh ***
*   ok 1: the basics
*   ok 2: partial
*   ok 3: partial modification in a subdirecotry
*   ok 4: partial removal
*   ok 5: sign off
*   ok 6: multiple -m
*   ok 7: verbose
*   ok 8: cleanup commit messages (verbatim,-t)
*   ok 9: cleanup commit messages (verbatim,-F)
*   ok 10: cleanup commit messages (verbatim,-m)
*   ok 11: cleanup commit messages (whitespace,-F)
*   ok 12: cleanup commit messages (strip,-F)
*   ok 13: cleanup commit messages (strip,-F,-e)
*   ok 14: author different from committer
sed: 1: "expect": invalid command code e
* FAIL 15: committer is automatic
	
	
		echo >>negative &&
		git commit -e -m "sample"
		head -n 8 .git/COMMIT_EDITMSG |	\
		sed "s/^# Committer: .*/# Committer:/" >actual &&
		test_cmp expect actual
	
*   ok 16: do not fire editor in the presence of conflicts
* failed 1 among 16 test(s)
make[1]: *** [t7502-commit.sh] Error 1
make: *** [test] Error 2
