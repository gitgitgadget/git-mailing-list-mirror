From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: Re: Need to set GIT_WORK_TREE when setting GIT_DIR !?
Date: Sun, 11 Mar 2012 22:13:52 +0100
Message-ID: <4F5D1590.9050306@gmail.com>
References: <CALeToSUaPzdr=u7FfwHEtEanphVP5LZ09QdQXno52PLBTK0H-g@mail.gmail.com> <7v4ntx4bol.fsf@alter.siamese.dyndns.org> <4F5B55E8.4080000@gmail.com> <CACsJy8AUo3+ECdxfnyfYGA-mAtHB8KBOUrie3_Qo3cyfshZmAA@mail.gmail.com> <7vsjhg17bh.fsf@alter.siamese.dyndns.org> <CALeToSVPWPwJTYxRgy0BW4TBfBJrb+LXC+QJDWjceQ=4f2_tRw@mail.gmail.com> <CALeToSV6xx=Vfw8gRbmeKWDzcHFaYvgFhMqx5cwtCYKdASJptw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:14:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6q5a-0000QY-KC
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 22:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867Ab2CKVN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 17:13:59 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43057 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab2CKVN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 17:13:57 -0400
Received: by wejx9 with SMTP id x9so2652873wej.19
        for <git@vger.kernel.org>; Sun, 11 Mar 2012 14:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=3dSg2NLRxxR2YEkOcsGVmwQFNrjQz3efALAErCBXPJY=;
        b=AtkvfK7sd3VH9ibg1sJa+eK2j4yYSkCsvvSPSFgdAMe24JA/UIcWWPaQjpHDyWBiyg
         6ixkuwsM0dow1xqLRkCL90Sd5UVomN1ogk7h5eaxt6C/tej4WFwPT2aqaDdQHLLaG82W
         v75Hzz+qfXHhPRigutmsuFB4IdT/9Qxc65NfwmzMX/UmGDYS8ePmnd68LJGRBKfhmcmY
         tynH0UHfES+5eH38soU/96iklwSrwnrFZJKlXJFbuwzNWonl9s6NU2z3mvjLMsdOmw1s
         5TyWEh4qS2WrQ1YDjHlNS77krGzcN48wo7xIyEgsMUKQGt1Ls6KH7Q/iY8uWZcjj4zzo
         OXXg==
Received: by 10.180.81.37 with SMTP id w5mr21742123wix.16.1331500436546;
        Sun, 11 Mar 2012 14:13:56 -0700 (PDT)
Received: from [192.168.0.10] (dra38-7-88-179-84-80.fbx.proxad.net. [88.179.84.80])
        by mx.google.com with ESMTPS id j3sm47955630wiw.1.2012.03.11.14.13.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Mar 2012 14:13:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <CALeToSV6xx=Vfw8gRbmeKWDzcHFaYvgFhMqx5cwtCYKdASJptw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192831>

Hi all,

My initial mistake was that I unintenionnaly created a bare repo (which 
is really not what I want to do).
If I change that  - GIt_DIR=.gita git init --no-bare - everything runs fine.

Lessons learned :

1/ the kind of repo  - bare or not bare - that git init creates depends 
on GIT_DIR.
This _is_ documented - I should have read more carefully - but it is 
surprising for someone not aware of the history of GIT_DIR, 
GIT_WORK_TREE, and so on.
Don't know if it 's worth changing this semantic though.
I let more experienced git hackers decide on this.

2/ Calling a git command that needs a working tree (add, status, commit, 
...) in a bare repo should probably trigger a more explicit message. 
Using the current directory if GIT_WORK_TREE is not set would actually 
hide a potential configuration problem.

Thanks for your help,
--
Fred
