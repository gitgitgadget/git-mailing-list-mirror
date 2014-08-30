From: Stefan Beller <stefanbeller@gmail.com>
Subject: Auto Packing message twice?
Date: Sat, 30 Aug 2014 13:28:47 +0200
Message-ID: <5401B56F.6000907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: GIT Mailing-list <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 13:28:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNgpv-0003K3-QP
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 13:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbaH3L2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 07:28:48 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:53158 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbaH3L2r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 07:28:47 -0400
Received: by mail-we0-f170.google.com with SMTP id p10so3294368wes.15
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 04:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=VtHadfohbAtCpZSSrPWwJfAVksky/0SvQr/y3OhqYyI=;
        b=Ku9v3pYPq4Z1vVVLiYIt5KGtjpJzHhpkHtc+gaqGY2Y0Xe8V/QU60ICVDl7spk8VRH
         SDUkaZa70Sqk0utv1Q0IimK0aiCwj+wQAfb/GVYExg8XEngVkbPOe3e8x1msTS8SuJkS
         lEdlllgEkePXVKgbMp65C2KvbjlqajSCCJrcKs7Cb6cy3loFal5/6AkCc444Lzw0m3TU
         N54FUNZGulKLjVXWs/WokjaCW9cPzrZPH2dCmyusp3YcutQiCaMYr99HrsXw6CRXcx7b
         lbmYqROwWxptNS5zbp6miy4VlXu40b8XoZYwsH3IVEPMTkIHN7p5tWO5K7tgbpzwAtz9
         R0RA==
X-Received: by 10.194.123.1 with SMTP id lw1mr20127289wjb.4.1409398126057;
        Sat, 30 Aug 2014 04:28:46 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id bg10sm6573066wjc.47.2014.08.30.04.28.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 04:28:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256248>

Hi,

so I fetched from a repository today and I got the message twice:

> Auto packing the repository in background for optimum performance.
> See "git help gc" for manual housekeeping.

I'm running git version 2.1.0.rc2

Full output:

$ git fetch --all --prune
Fetching origin
Fetching mainline
remote: Counting objects: 832, done.
remote: Compressing objects: 100% (332/332), done.
remote: Total 832 (delta 593), reused 659 (delta 498)
Receiving objects: 100% (832/832), 955.44 KiB | 660.00 KiB/s, done.
Resolving deltas: 100% (593/593), done.
From git://github.com/danmar/cppcheck
   7237b01..eace67e  master     -> mainline/master
 * [new tag]         1.66       -> 1.66
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.

Obviously it should only report once?
The reporting is done from within function cmd_gc(...),
which makes me wonder, if it also packs twice?

Thanks,
Stefan
