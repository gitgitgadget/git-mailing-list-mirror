From: Luke Diamand <luke@diamand.org>
Subject: git-p4: nicodeDecodeError in ./t9822-git-p4-path-encoding.sh
Date: Mon, 21 Sep 2015 08:01:54 +0100
Message-ID: <55FFAB62.8050106@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 09:02:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdv7L-0005zH-EL
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 09:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbbIUHB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 03:01:57 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33696 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbbIUHB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 03:01:57 -0400
Received: by wiclk2 with SMTP id lk2so131963511wic.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 00:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=Ts1NPx6b/8iZnwD2pop23U4IB4f126kwEeTCO83YwJ4=;
        b=fJYgsDqjTricpNqb55a5erMfWURGm55joYCM3hI+sOUR9Ico7aKVjnT4mzkm0q13/9
         JsJTiSxnDcF31K3XDiQRv0evUdJfpnISfor0hrkPnAHtGE8MkOeu2Xh4jNCundzIDexr
         DJm68PmxsJdsQHRW6zDfOaV/U8aa0vt6LBgN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:content-type:content-transfer-encoding;
        bh=Ts1NPx6b/8iZnwD2pop23U4IB4f126kwEeTCO83YwJ4=;
        b=fMhEkLqhNxGnNHsu7NTvr4AIHy5eYxCj8CC6G+vVkpIB53nbiPnwuMtaRHMwtN+EC5
         X+wqQGq1mY9tzoIw33fujkhU3mZ8r4Gukzrh07wyMX+hw163TXvFduioVSBtLm24YmSF
         NpnGeeiuBEVk6ke/Ep6YOIr3ubn6l3Zv9eyY01ND6dc5tL4lfyP3ET8tFP/4tYduVRHW
         9qJiBWfmtNPxHkVJPVunCyKrGO+3loFpIKIZImkI0tmLbwv6tfjcIbZc/4Iy7O9A3FOp
         +s49UMbvf1pKX7C/zXy5xCZ4Rt0DKLVVSla5FUQKMwWkiEVpfIBWD96+8CP7v/bEU46p
         O1/Q==
X-Gm-Message-State: ALoCoQkQ6jdgM3nsrHo+QLBwRaex4I2SPkcO107v83Z2dSudu/nmDntSnDI2G4DO2VrcAgSzE/DP
X-Received: by 10.194.190.75 with SMTP id go11mr20428780wjc.80.1442818915748;
        Mon, 21 Sep 2015 00:01:55 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id o10sm11862712wia.4.2015.09.21.00.01.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Sep 2015 00:01:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278280>

Lars,

When I run t9822-git-p4-path-encoding.sh, the last test fails (it's 
supposed to pass) with the following backtrace.

This is with 'next' at 3dd15c02a81a280c83c8d5e32c6cb71a64177ca6.

Any ideas as to what I'm doing wrong?

Thanks,
Luke


Reinitialized existing Git repository in /home/lgd/git/git/t/trash 
directory.t9822-git-p4-path-encoding/git/.git/
Importing from //depot into /home/lgd/git/git/t/trash 
directory.t9822-git-p4-path-encoding/git
Reinitialized existing Git repository in /home/lgd/git/git/t/trash 
directory.t9822-git-p4-path-encoding/git/.git/
Doing initial import of //depot/ from revision #head into 
refs/remotes/p4/master
fast-import failed: warning: Not updating refs/remotes/p4/master (new 
tip 66187e3e728015e083d9a4779d3c76cb8f30f835 does not contain 
1427162f1aaf3fa13dbbecabcab525605bdd0ab8)
git-fast-import statistics:
---------------------------------------------------------------------
Alloc'd objects:       5000
Total objects:            3 (         0 duplicates                  )
       blobs  :            1 (         0 duplicates          0 deltas of 
          0 attempts)
       trees  :            1 (         0 duplicates          0 deltas of 
          1 attempts)
       commits:            1 (         0 duplicates          0 deltas of 
          0 attempts)
       tags   :            0 (         0 duplicates          0 deltas of 
          0 attempts)
Total branches:           1 (         1 loads     )
       marks:           1024 (         1 unique    )
       atoms:              1
Memory total:          2344 KiB
        pools:          2110 KiB
      objects:           234 KiB
---------------------------------------------------------------------
pack_report: getpagesize()            =       4096
pack_report: core.packedGitWindowSize = 1073741824
pack_report: core.packedGitLimit      = 8589934592
pack_report: pack_used_ctr            =          4
pack_report: pack_mmap_calls          =          2
pack_report: pack_open_windows        =          2 /          2
pack_report: pack_mapped              =        517 /        517
---------------------------------------------------------------------

not ok 4 - Clone repo containing iso8859-1 encoded paths with 
git-p4.pathEncoding
