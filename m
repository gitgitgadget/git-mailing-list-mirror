From: meanlogin@gmail.com
Subject: possibly a spurious conflict in a three way merge
Date: Thu, 07 Aug 2014 12:30:22 -0400
Message-ID: <53E3A99E.1090102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 18:30:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQZt-0008GK-Ao
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbaHGQaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:30:03 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:41036 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092AbaHGQaB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:30:01 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so4743359qgd.9
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=EcVnNxKiOD0Hkqwn71jlgU2mH+Bjtzz6tz3hhMmzx6Q=;
        b=hxg4AUVR+1gLVhHZ8tl4YtH32HwoKo9JFlDw/WnL4tf9Vkn+WaRvcS8p9869jhIPyr
         b8HqqZ4y4TKRnW2NkspVvwFSY7Zp5Qii9lBJ5WJiu1ync9cT28wl+MF7eTq6m0UNafXM
         wU9gOn/6AmleW9Auu3exBy/1/nfbl8oYsnGJ5JGcqdjMRFLsxUuojE/tICyA6KAKSuZl
         1iafW7pJp67H5DPEYuhaOY9/iqSfwv5w7/g6u1EYb/bL+9tp+ZqiI9bH8yZSEGrG0iI9
         WCfTxq6F19iKXsf4kD3qpuSlc8loLCoQcczOIzxSoYoJwR6rtNN1Lx2sXIYKZMyg8Eb0
         I7QQ==
X-Received: by 10.224.114.74 with SMTP id d10mr3190628qaq.33.1407429000316;
        Thu, 07 Aug 2014 09:30:00 -0700 (PDT)
Received: from [127.0.0.1] (c-73-47-50-200.hsd1.ma.comcast.net. [73.47.50.200])
        by mx.google.com with ESMTPSA id k109sm403358qge.2.2014.08.07.09.29.59
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Aug 2014 09:29:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Thunderbird/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254975>

git 2.0.4 on ubuntu 14.04 64

1. new repo
2. commit test.txt to master:
line1
line1

3. branch and checkout branch1
4. make and commit the following change to branch1:
#line1
#line2

5. checkout master
6. make and commit the following change to master:
line1
#line2

7. merge branch1, git sees a conflict:
<<<<<<< HEAD
line1
=======
#line1
 >>>>>>> branch1
#line2

Why?  The first line changed in branch1 but not in master so a 3 way 
merge should take branch1 changes.  Beyond Compare ( used as a 
mergetool) does not flag any conflicts.
