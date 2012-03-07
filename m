From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git push from client is not updating files on server
Date: Tue, 06 Mar 2012 20:34:46 -0600
Message-ID: <4F56C946.8080601@gmail.com>
References: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>	<4F567DC6.4070903@gmail.com>	<4F567FEF.5000105@gmail.com>	<CAC0z1F_eyMo4D8E2j15dOFhp-6tZ_ixacB6XcKfNpJategcsXQ@mail.gmail.com>	<CAC0z1F_LYRkReO1qqcjkWy6Vb3E0_oNo-0kSf15nGfQFAtXpdg@mail.gmail.com>	<CAC0z1F87ORZQmrZeMGo2suV1fAt-5mAwwpkkV3ZTx0US3AjM8Q@mail.gmail.com>	<4F569EA8.4050907@gmail.com> <CAC0z1F9sBYCuv_HMCx1ryWLvxZKUcLPS1UUj80ihEesje+SKzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jerome Yanga <jerome.yanga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 03:35:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S56ii-0006MX-GZ
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 03:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174Ab2CGCet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 21:34:49 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35629 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863Ab2CGCes (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 21:34:48 -0500
Received: by yhmm54 with SMTP id m54so2670165yhm.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 18:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=i1pf3YcnAQFNoaPYDit0UjY3539Mx/UgBOkuRrpaR4U=;
        b=lQGPJi3volMhcOl3PBxgo01ZIgmau8yP7Mm0jNWUAMjNKGTEr+CYtsuv+jxlAG+qiG
         /3OaDetRq8A+MnJzL+tUFUacMNnLpf2v2lyOWf4mTZEdhAB670eiASRnuBoJfAzpzq9Y
         wgVLR4gj6MLP/Sh5UP3OhtZGwwUN/D4nkmewfHrdUn4Amr9BtxbzTS4sTyH0SR/NIwQp
         ON29LbV5X8sJebXDqrY9sD1NmH+lSVqp5wRUM34nVEuGxx4D0ak7cRUp2bmeAOr0vZnu
         6NlISN4PhUkpt7rTkXmageXh2/PzO24IMOpuIBxhEO3cZyQHqJoLuH4ZfIIYLyTIw784
         /v0g==
Received: by 10.236.157.9 with SMTP id n9mr389989yhk.96.1331087688191;
        Tue, 06 Mar 2012 18:34:48 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id e8sm9295412yhk.0.2012.03.06.18.34.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 18:34:47 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <CAC0z1F9sBYCuv_HMCx1ryWLvxZKUcLPS1UUj80ihEesje+SKzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192422>

On 3/6/2012 6:28 PM, Jerome Yanga wrote:
> The project in Apache's DocumentRoot was created using the following command:
>
> "cd /var/www/git
> git clone --bare<non-bare working directory>  <project>.git"
>
> Hence, I believe that is is bare.  Besides, it does not have .git
> folder.

The bare repo is the .git folder.  That's why its called barerepo.git. 
.git = git repo.  worktree/.git = non-bare repo with worktree and .git 
repo.  barerepo.git = bare repo and no worktree.

> I assumed that when I did this that the non-bare directory
> will also be updated when a push is performed via http.
>
The non-bare you cloned from is independent.  It doesn't know about the 
bare repo you cloned from it, and your bare repo does not know about the 
non-bare repo it was cloned from.  I'm not sure what you were doing with 
that non-bare before you created the bare from it.  You may not need 
that non-bare anymore if that's all it was for.

> My objective is that I would like the developers to be able to push
> via http and these pushes will need to be reflected on the non-bare
> working directory as these directories will be used for automated
> tests.
>
Create a new non-bare clone of your bare repo.  Then do git-pull on the 
new non-bare after the bare gets updates (someone does git push to it) 
and you want to test those new commits.  The worktree of the new 
non-bare clone can be the document root of your testing virtual host, if 
that's what you're doing.  That way, you know that no one else is 
messing with new non-bare (test repo) like doing development in it and 
messing up your tests.

v/r,
neal
