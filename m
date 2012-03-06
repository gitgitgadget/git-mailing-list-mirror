From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git push from client is not updating files on server
Date: Tue, 06 Mar 2012 15:12:38 -0600
Message-ID: <4F567DC6.4070903@gmail.com>
References: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jerome Yanga <jerome.yanga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 22:12:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S51gd-0002k3-Aa
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 22:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031310Ab2CFVMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 16:12:41 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35417 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031152Ab2CFVMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 16:12:40 -0500
Received: by yhmm54 with SMTP id m54so2540208yhm.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 13:12:40 -0800 (PST)
Received-SPF: pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.190.5 as permitted sender) client-ip=10.236.190.5;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.190.5 as permitted sender) smtp.mail=nkreitzinger@gmail.com; dkim=pass header.i=nkreitzinger@gmail.com
Received: from mr.google.com ([10.236.190.5])
        by 10.236.190.5 with SMTP id d5mr37446891yhn.13.1331068360077 (num_hops = 1);
        Tue, 06 Mar 2012 13:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gPYybDCFQeEzLlbnnq3e8DUwkSQD+UDCfqE4haw6i50=;
        b=ji3nMNu4EBpWLG+meIoGrN495bPqeUwQsu+scxDnE4pSzhzL5KSNQRV3e4PmPwvDsR
         a4NP7yN7oLfhFk95mh4PhIgSiNeMLowwRrMRX1Rzoh/lQg9fDAXHllab4W1ql4C2l/kg
         hwrD6GesUJf2tFgm8OVJuAgqEorfxC7U8izZDt3UrQeJpMHnntqcGJCZ4fadsp0sr805
         maH3ES+fLWHSWgOFVH9ZYMBujm7uOZiNcNytniyL1/2OuUCWtmIgSD5YfaQ2PR5IJe4Z
         KnGu4v9iK2gSSawqxCkf+9MXvdJKagTYHJ7QuoPbO1vUiC/7ziLZto/M06bTJjLsaDZj
         tg7w==
Received: by 10.236.190.5 with SMTP id d5mr29673644yhn.13.1331068360025;
        Tue, 06 Mar 2012 13:12:40 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id i4sm32562992anm.5.2012.03.06.13.12.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 13:12:39 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192394>

On 3/6/2012 10:52 AM, Jerome Yanga wrote:
> My main objective is to create a central public Git server.  I had
> followed the instructions in the URL below to make it public.
>
> http://book.git-scm.com/4_setting_up_a_public_repository.html
>
> From the git client server, I can successfully clone projects in
> from the central public Git server using the command below.
>
> git clone
> http://<hostname_of_central_public_git_server>/<Project_name>.git
>
> My push seems to be successful too using the command below as I get
> the message "Everything up-to-date".
>
> git push
>
> However, when I log into the central public Git server and look at
> the files in the project, none of them have change.  I can only see
> the changes from the client via Gitweb.
>
Gitweb and gitk know how to look at .git (bare) repo and display the 
contents.  (I use gitk to verify that a push did what I wanted.)  There 
is no work-tree for a .git repo to do linux "ls" on.  If you really want 
to use commandline you would have to use git commands like git-show, 
git-ls-files, git-cat-file, git-log, etc., to display and interrogate 
the contents of git objects (tags, commits, trees, blobs) in a .git repo.

I suspect reviewing it in gitweb is sufficient to verify that the push 
did what you wanted.  (I don't use gitwet, yet.)

v/r,
neal
