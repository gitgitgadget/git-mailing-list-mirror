From: Thorsten von Eicken <tve@rightscale.com>
Subject: git status doesn't ignore GIT_DIR directory?
Date: Fri, 22 May 2015 18:03:38 -0700
Message-ID: <555FD1EA.2060706@rightscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 03:03:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvxqu-0005ze-92
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 03:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757257AbbEWBDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 21:03:42 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33897 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757019AbbEWBDm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 21:03:42 -0400
Received: by pdbnk13 with SMTP id nk13so31146828pdb.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 18:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=fUsPNqrfWMr3OyJnjQev82w92M5rSIwMoLk5egDAf/o=;
        b=dn6xXzbNq2PjK+/1WccTMwiGtS95A8fGLQH1XjgULTN/ewRBxWcb7TcZ9LmW+PmWyR
         auGdXMP7WL6NPcEIuMD+0a6GO6b52bHANxLk/k7bOHCYSeX3PPifcP4SqaR2vlzkR1Dc
         M12RX8t+KbeSW8OpL7e7E2LS2YTcdt8yJAdbiL2CPAoQLHn7/ehfPR78dGHpKuBGNWGL
         h6E3RyXGT94Oj4mooh2K5lCNOjjbcBovXiNq2Y32H4Chvc5BfXDUh40JGUIknoM8TB+j
         mMYJkeaXmROB+/VBN52oVGdSwhiiQT2/XsUNjQcBG6omNZ4ztAPTqKSHg7PSiUlwwPO+
         jOCg==
X-Gm-Message-State: ALoCoQk2VUS91LWKePfyaF+zx+iXA9AI6/HGsmnozlF0NmaoflvrFxHRyYoGzCbOgUL+4LgIVb9n
X-Received: by 10.66.116.132 with SMTP id jw4mr20349522pab.10.1432343021467;
        Fri, 22 May 2015 18:03:41 -0700 (PDT)
Received: from [10.10.12.173] ([173.227.0.2])
        by mx.google.com with ESMTPSA id dv3sm3223966pbb.91.2015.05.22.18.03.39
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2015 18:03:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269786>

I renamed my .git directory to _git and I'm surprised that git status 
thinks that it's an untracked file:

$ GIT_DIR=_git git status
On branch master
Your branch is up-to-date with 'origin/master'.

Untracked files:
   (use "git add <file>..." to include in what will be committed)

         _git/

nothing added to commit but untracked files present (use "git add" to track)

This doesn't seem to make sense, shouldn't git ignore whatever $GIT_DIR 
points to? Or is there some other magic option I need to use for it to 
do what I expect?
