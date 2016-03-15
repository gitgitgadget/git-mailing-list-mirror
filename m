From: Phil Susi <phillsusi@gmail.com>
Subject: git checkout --theirs fails
Date: Tue, 15 Mar 2016 13:27:12 -0400
Message-ID: <56E845F0.9020609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 18:27:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afslB-0005n8-A0
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 18:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934823AbcCOR1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 13:27:53 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34537 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934777AbcCOR1w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 13:27:52 -0400
Received: by mail-vk0-f47.google.com with SMTP id e185so29797896vkb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 10:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=NG+JCXonRzTo+MffOXAOoCKZoUSIBV5UmKtn3LQUQE8=;
        b=PtBBHi/Szp0jl8SREGu6XzP3HDfSO4bTDUTqgoT3KxUHkGRvnUAC2kNumQNKG7BXWK
         uZl5FPEUXm7l6eOc8hVN1UDZXxRCW10kNQI254ptiLlPpwZP0FXiKTGLJdTpF1SRgcAj
         t0JR14ctPbE5HLJs3P8bwop6DMKRn8JfDllWf5IOW+fPD77vTPoM65ScEFMW3M5ia592
         Z1rMoqfrn3sz3ErU6JXtNddDEYmyuc8j5zmodcgczn9hRHUxYBgXlKDjcHpJtW45Ng6q
         pANN4B1Cdb9vZ8wHmPsIOApWpryYESa88vVH/vGmynKofxkuagHUAOT6HCsOAGgFtViT
         /jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=NG+JCXonRzTo+MffOXAOoCKZoUSIBV5UmKtn3LQUQE8=;
        b=j3PqY2JJZ318y8/N4ET1jazijVz6uD2Wu8adtaGIxIEwssqH5BqL3rD+CCpOXQseew
         8ht//w2PiW0p+5bGrL1ak9j8lyqmu11AAMOoSJNeV7N11VpcnA1cOVw5TEnHJOyHtNM/
         FDtHURlzh6cf195MMzfQ/HAKIn5zo1y1T3Tdblk9+KKq1AN9ipsxnwX4nV7xuH+zW5a1
         h+71LqwDIHdlbr9qe/MuZIEOxrUH/M64jId/y21Jo1jQUuyt4QqQINKduRkWascMHilF
         3yzWI7jlGtRASptMyhee7Wl6KLH4y/baD6rIMObBXLtxisT7/in9poPE9r6ue04H3AlA
         lSWw==
X-Gm-Message-State: AD7BkJKv2blA0PV1ugGCnX7uCNsqM2LtQnbKO06Ro690CTmQ/PMR5HsyW9RiC+11a8CCig==
X-Received: by 10.31.179.146 with SMTP id c140mr28217296vkf.50.1458062871301;
        Tue, 15 Mar 2016 10:27:51 -0700 (PDT)
Received: from [10.1.1.189] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by smtp.googlemail.com with ESMTPSA id t72sm9816426vke.28.2016.03.15.10.27.50
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Mar 2016 10:27:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288886>

I'm doing a rebase and got some conflicts.  I just want to take their
version of all files, but git checkout --theirs complains:

--ours/--theirs' cannot be used with switching branches

What gives?  I'm not *trying* to switch branches.  I just want to
resolve the conflict by taking their version.  If I try git checkout
--theirs ., then it complains that not every single file in the
directory has a "their" version.  So?  Take the ones that do.
