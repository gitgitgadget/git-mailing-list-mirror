From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: how to restrict git to specific non-root superuser
Date: Fri, 04 May 2012 22:29:42 -0500
Message-ID: <4FA49EA6.8030000@gmail.com>
References: <jo20t5$e8n$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat May 05 05:29:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQVgt-0001LV-M9
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 05:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758970Ab2EED3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 23:29:45 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38241 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab2EED3p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 23:29:45 -0400
Received: by obbtb18 with SMTP id tb18so4860536obb.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 20:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=OQE5Blbqts8wwVY9XAqNPU7uUkiR4gaeAUUlVdmwKBc=;
        b=r2SjJiklrEMwD4pKTfTQ+RA3NpUSsJ6rfYV+lEQu4MBMQELhwxegW6hMpNdVrMDNxx
         QXdxeR71oDmzDMH7bWjNpX+PmFBocyJrSpHMVHUplwdjbRXTvs0yIape1Ia6qdXwqcWC
         5Z5jXFgComjDOxLcY+Rc9eHyb9RdsaOKZ9kOIh0vQ/Z3xbbxZUOvl2nu0yeK1j7Il4rV
         PDI9U++HSX2wLVLEa0KtqOE56NGQtCTlwnOauW+/t3jiS4qscn2YnM0yhzrXKqHC1ZC4
         mL14VGpgAwl8UluBGkbPWBZ676LGQ8TJ3UnrWFY1n0P0mDqAr4zhbKoUGzCArQ51rqNP
         l0gQ==
Received: by 10.60.18.137 with SMTP id w9mr11536028oed.7.1336188584720;
        Fri, 04 May 2012 20:29:44 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id r8sm9009814oer.6.2012.05.04.20.29.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 20:29:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <jo20t5$e8n$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197087>

On 5/4/2012 8:48 PM, Neal Kreitzinger wrote:
> I work on systems where 'everyone' has the root password (that problem
> is somewhat out of my hands). Is there a technique to setup git so that
> only a certain non-root superuser (ie, gittech) is allowed to run git
> commands? I don't want people logged in as root to mess up the git repos.
>
> I'm considering using git for deployment and some anonymous root user
> messing it up would be a very, very, bad thing. Maybe this proposition
> is theoretically impossible. Maybe someone has implemented this concept
> in practice.
>
I'm thinking a way to achieve this effect is:

install git under the home dir of the 'gittech' user and add that path 
only to the PATH of 'gittech'.

have the git repos under the 'gittech' home dir with worktree(s) 
assigned to deployment locations.  If people mess with the worktrees I 
will be able to tell with git status via 'gittech'.

v/r,
neal
