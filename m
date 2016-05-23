From: Armin Kunaschik <megabreit@googlemail.com>
Subject: t4204-patch-id failures
Date: Mon, 23 May 2016 18:30:38 +0200
Message-ID: <CALR6jEgf_FiGWs=45+n8uzKEiXU7yKDsP+CjOUAWu1CnUXZbPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 18:30:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4ske-0006GN-Bz
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 18:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbcEWQak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 12:30:40 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34739 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbcEWQaj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 12:30:39 -0400
Received: by mail-yw0-f195.google.com with SMTP id j74so5337490ywg.1
        for <git@vger.kernel.org>; Mon, 23 May 2016 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=khKGf6l7H+fFZD5xwoHJOpf6O6WPrYJ1T/yV1ZE8tAE=;
        b=U9keYwJtThyj9AD50y/m7nCnCdSM5bYtXKJWMZAkIBTepchPB6kIkPEb7kArxa5ZPf
         5nIfza20HgtcLLS/He4nfCOQkky+usi/pUZy2Sn6eZC75hR/vApS4YrjXNebMeICTOO/
         MKEt1daG1k0KAzjrgmC55wI577WLGBn9tQ/fvvlW03CNC5nqkbf2RUxPJjrtJpVKnOQy
         jP9fByYGlREhqXW4ORBFTBHUjfcyvCObu1zaIL+jbovBnqXsYjwZSLIGbwNLSwm3gQm7
         f+MZUT4v4SAWWApwlfcYnYxiAy1MrE9fsToxy2cypPtOYD237nECdc+EuUjGq5YjzKiu
         CzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=khKGf6l7H+fFZD5xwoHJOpf6O6WPrYJ1T/yV1ZE8tAE=;
        b=bv0ZC7zdo8NOIlibIIH/2xp90lw+nygwBf3Sg6+hINhwm9ejQjBTvXRw1MNFLx5fU6
         y96uSPCNkF5bjY87AqSCbSAzNz6LclSXSK2EeRnHJ8AQ1jjP6fK5JL5WTQxOids5K9gJ
         ui8oX/z+uYWPG8QudP80UMe1qZ1FL24zMv7jquNItFB/R0wu16TxPDBlsnf/1GvrNBkG
         ubLV/Pfq9mYJLbv+Ks/rorw0W6N0/rc60HZnBUezKsIvtHlKxbSwEcCv0G7OIcO2Mk93
         gcpBzkMrNqsCD/78Tu0njom75M2M0kBKycCITXd5ogjBvFXlIKkdKDpNGCT70gyuZyaM
         N1AA==
X-Gm-Message-State: AOPr4FXB+e02GNsQEN1rmUkSjQxp1u3BkxEQ40Xml9BunLkeWyU8BmCC/oSlbRtwYZKblcZA4ahLtFUgRzKb0w==
X-Received: by 10.37.204.212 with SMTP id l203mr9983017ybf.13.1464021038674;
 Mon, 23 May 2016 09:30:38 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Mon, 23 May 2016 09:30:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295336>

Hello,

I see 3 test failures in t4202:

expecting success:
        test_patch_id_file_order irrelevant --stable --stable

Already on 'same'
cmp: cannot open patch-id_ordered-ordered-order---stable-irrelevant
not ok 7 - file order is irrelevant with --stable
#
#               test_patch_id_file_order irrelevant --stable --stable
#

expecting success:
        test_patch_id_file_order relevant --unstable --unstable

Already on 'same'
cmp: cannot open patch-id_ordered-ordered-order---unstable-relevant
[..]

expecting success:
        test_config patchid.stable true &&
        test_patch_id irrelevant patchid.stable=true

Already on 'same'
cmp: cannot open patch-id_ordered-ordered-order-patchid.stable=true-irrelevant
not ok 10 - patchid.stable = true is stable
#
#               test_config patchid.stable true &&
#               test_patch_id irrelevant patchid.stable=true
#
[..]

expecting success:
        test_config patchid.stable false &&
        test_patch_id irrelevant patchid.stable=false--stable --stable

Already on 'same'
cmp: cannot open
patch-id_ordered-ordered-order-patchid.stable=false--stable-irrelevant
not ok 13 - --stable overrides patchid.stable = false
#
#               test_config patchid.stable false &&
#               test_patch_id irrelevant patchid.stable=false--stable --stable
#


Please notice the double "ordered"!
From my point of view there is a problem in the function
calc_patch_id() which changes
the variable $name and causes the test to fail.

Essentially it's working like this:
<snip>
#!/bin/bash

func1() {
        name=${1}
        echo "func1 name=$name"
}

func2() {
        name=${1}
        echo "func2 name=$name"
        func1 "ordered-$name"
        echo "func2 again name=$name"
}

func2 foo
<snip>
which prints in bash, ksh88 and ksh93 on Linux and AIX the same
func2 name=foo
func1 name=ordered-foo
func2 again name=ordered-foo

I wonder if those 3 tests ever worked... and why? :-)

A suggested patch would be to rename $name inside calc_patch_id into
something else
except $name... e.g. $pname.

Armin
