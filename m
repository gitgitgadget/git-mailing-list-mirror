From: David Abdurachmanov <david.abd@gmail.com>
Subject: "fatal: reference is not a tree:" on git checkout <branch>
Date: Fri, 26 Jul 2013 11:52:32 +0200
Message-ID: <CC257523-1C84-4F73-9AB0-D1B5A5ECDC45@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 26 11:52:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2ehV-0003dF-L8
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 11:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325Ab3GZJwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 05:52:37 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:49536 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab3GZJwh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jul 2013 05:52:37 -0400
Received: by mail-ee0-f45.google.com with SMTP id b15so1450614eek.32
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        bh=MPmg8rapK/Ve/c16fsOsIkiKh4Wofq5cyVL2h2ZOXA8=;
        b=uQOu7dXVvZhXySAfbCrz1V07SPwoaYaTX84mKRx43d90q/z63NFEuJHRN/cw2d80Xj
         MOULyY9uz1Y43OLwfXvA5vB4qUwSD77QwKBsIexOhntlFZ2pfZdjHeeF6LVb/1okM3eJ
         6NBW0bgtJXablHwYBzUZvIaPi7FktHwlQTm6a883ebx1/RNVarSOziLPOvzKAkFih5zO
         b3rMzEWpv9MCGpxY/yf2rajICFnLTg5nRviK3EoS7TGqDm9CkzZSL5BpuLuOwHlwQsBB
         zmOic57Xt2myDw7I7zLn5rZ0i4QNkxHlL66h5vQ7Q2GLbWiCqngDV9/wczJ0Oyhwd4B7
         QJLw==
X-Received: by 10.15.73.197 with SMTP id h45mr45923807eey.146.1374832355429;
        Fri, 26 Jul 2013 02:52:35 -0700 (PDT)
Received: from pb-d-128-141-104-61.cern.ch (pb-d-128-141-104-61.cern.ch. [128.141.104.61])
        by mx.google.com with ESMTPSA id p49sm79872199eeu.2.2013.07.26.02.52.33
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 02:52:34 -0700 (PDT)
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231176>

Hi,

Reproduce:

$ git clone https://github.com/cms-sw/cmsdist.git
$ git branch -a | grep devel-gcc48
remotes/origin/IB/CMSSW_7_0_X/devel-gcc48
$ git checkout IB/CMSSW_7_0_X/devel-gcc48
fatal: reference is not a tree: IB/CMSSW_7_0_X/devel-gcc48

It has stopped to work with the last pull request. All the references on Google 
talk about submodules, which I don't use. Any ideas what could be causing this
issue?

You can get into detached state by:
$ git checkout origin/IB/CMSSW_7_0_X/devel-gcc48 

You also can checkout a branch by doing:
$ git clone -b IB/CMSSW_7_0_X/devel-gcc48 https://github.com/cms-sw/cmsdist.git
$ git branch
* IB/CMSSW_7_0_X/devel-gcc48

Thanks,
david