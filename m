From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git push from client is not updating files on server
Date: Tue, 06 Mar 2012 17:32:56 -0600
Message-ID: <4F569EA8.4050907@gmail.com>
References: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>	<4F567DC6.4070903@gmail.com>	<4F567FEF.5000105@gmail.com>	<CAC0z1F_eyMo4D8E2j15dOFhp-6tZ_ixacB6XcKfNpJategcsXQ@mail.gmail.com>	<CAC0z1F_LYRkReO1qqcjkWy6Vb3E0_oNo-0kSf15nGfQFAtXpdg@mail.gmail.com> <CAC0z1F87ORZQmrZeMGo2suV1fAt-5mAwwpkkV3ZTx0US3AjM8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jerome Yanga <jerome.yanga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:33:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S53sP-0003L6-KC
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 00:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212Ab2CFXdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 18:33:00 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55253 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940Ab2CFXc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 18:32:59 -0500
Received: by ghrr11 with SMTP id r11so2622370ghr.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 15:32:58 -0800 (PST)
Received-SPF: pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.195.38 as permitted sender) client-ip=10.236.195.38;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.195.38 as permitted sender) smtp.mail=nkreitzinger@gmail.com; dkim=pass header.i=nkreitzinger@gmail.com
Received: from mr.google.com ([10.236.195.38])
        by 10.236.195.38 with SMTP id o26mr17835227yhn.100.1331076778717 (num_hops = 1);
        Tue, 06 Mar 2012 15:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IlUPbAK7Otc8qJIwRbKg80j56XOoLQacAgEyibeOjww=;
        b=RSYp15dpBLmfDVqEbyUWtHBjVvJgphcakn3dYwSyTjgu07yNMT9sHdsvPro009chia
         9rtDXvRTuucFbKHjiwTlcoHvoLXXSTywGYitS2ufU3ORXVz9T2BzOib8yMJw8pIkAjru
         xotvBuLh/3GqUsQZ0VSTvD7qGMK9yNFlh8504ApRwtrc0OUEF088nXk2mPzASTNXdXMX
         0GixnpMpOD43U1e5ue9BoMxaRXkWCIm8+rirpN2hsK3F3lycgqwDmkCMzOmwbtyKNXac
         PP3hj6f3e9rbD6dlJhZ0PXicHDjYChcGnM/xyZ1gfo/gEcbfheHa8A0LqmDW+Gx6f5DE
         1wKA==
Received: by 10.236.195.38 with SMTP id o26mr14147214yhn.100.1331076778610;
        Tue, 06 Mar 2012 15:32:58 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id z3sm4315461and.18.2012.03.06.15.32.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 15:32:58 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <CAC0z1F87ORZQmrZeMGo2suV1fAt-5mAwwpkkV3ZTx0US3AjM8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192416>

On 3/6/2012 5:07 PM, Jerome Yanga wrote:
> Is there a way to make git write to the working directory of the
> central public server?
>
In your original post you stated:

 > From the git client server, I can successfully clone projects in from
 > the central public Git server using the command below.
 >
 > git clone 
http://<hostname_of_central_public_git_server>/<Project_name>.git

".git" extension implies "bare" repo.  A bare repo has _no_ working 
tree.  Is the repo in question bare or non-bare?  If you are not sure, 
then cd to the central-repo-dir (ie., the <Project_name>.git you cloned 
_from_ in your example above) and run "git config -l |grep bare".  If it 
says "core.bare=true" then it is a bare repo.

v/r,
neal
