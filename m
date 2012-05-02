From: bill lam <cbill.lam@gmail.com>
Subject: git pull and GIT_DIR
Date: Wed, 2 May 2012 22:25:36 +0800
Message-ID: <20120502142536.GA2609@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 02 16:26:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPaVJ-0002zK-QX
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 16:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab2EBO0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 10:26:00 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:63221 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916Ab2EBOZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 10:25:59 -0400
Received: by gghe5 with SMTP id e5so66443ggh.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=1M+q32To6PNLzPPsv1LN3H0HtH7s6AyEwOZ6/GH67yI=;
        b=bF0Mx/rMmoINSi9cLYkd6Q9p3/xMR1xoZg29CGDc636ROve9+ai/M8J/261I5k6SbV
         5s+EIsLE1ZKx+IaRo7fcrOAWhq1xZol4PJKisqJKPMbRtLfl3rjsGp6mALy81Ho0taru
         CiytGJ7rMGV+ZCkUTKggBvbl76sMypB8hO+MdEHcQ9oK48p2Yy41+WZOnow5QJqnH46r
         DbFYNHTmydaiHUPLSrwLxmawymtlBm/Fiz/gYm3FiLM9+4XMZaY0TRWePjlBbT5EWpt6
         uM6AjR9zMpIUgVw+25dqKZkmY0en9uhNIGPLGXJj/Y0Gdd5oNbEqu3jsG8vzLNGZ14q5
         N25Q==
Received: by 10.68.129.99 with SMTP id nv3mr41966336pbb.161.1335968758389;
        Wed, 02 May 2012 07:25:58 -0700 (PDT)
Received: from localhost (n1164843249.netvigator.com. [116.48.43.249])
        by mx.google.com with ESMTPS id wi6sm2109446pbc.66.2012.05.02.07.25.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 07:25:56 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196824>

It appeared that

a)
cd /path/to && git pull git/https://....

will fetch and checkout latest changes to working tree.  This is as
expected.  On the contrary

b)
GIT_DIR=/path/to/.git git pull git/https://....

will only update git repo, but leaving working tree untouched.
Subsequent git status and git diff will indicate unstaged changes, 
apparently a commit that will revert the updated git repo. I have to
do 'git reset --hard' to really update the working three.

I'm not sure if this is an intended behavior or I missed something. 

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
