From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: how to share files between machines?
Date: Fri, 25 May 2012 18:06:45 -0500
Message-ID: <4FC01085.30709@gmail.com>
References: <4FBFDD49.2000801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: "J.V." <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 26 01:06:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY3au-00033y-HX
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 01:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723Ab2EYXGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 19:06:48 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51088 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237Ab2EYXGr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 19:06:47 -0400
Received: by obbtb18 with SMTP id tb18so1826575obb.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Xn4swRfp7dhiBovV4NyGPL41dEp8DFH27DGrguCF6XY=;
        b=vKg9DBDkudKo5T5IuJh1FkVpPHot/2VSZaLYw+60HXuaKHLnbljF6XM3VuEbTcatyV
         w8dwlfy/Ht0EabBtIxJgUjkJk+nZu4p27KJWGI4cV3QnvsRdLu63JXHDQAZxitq0oKfc
         0LDRcDAYIaGD1hB6vQd6RJaRmQrsi3yZSTEK5/H4P8nBA6Hllnu35eBjQ3ff41ET/5H6
         dm2d/sGsYIpnG8PRoRi8uDVPdxdMFFPpLw7nb1yaImhEGi9mnikTs5nolLsy7dJARBR5
         2KOrTTP4hOumRz1B5XHcRyYxwRlgQnsIOQlQKF+ReFrko/s5jAzC+cXSTpBxFmDEk9RC
         Yu3Q==
Received: by 10.60.0.164 with SMTP id 4mr599669oef.28.1337987207095;
        Fri, 25 May 2012 16:06:47 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id g3sm3136283obz.12.2012.05.25.16.06.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 May 2012 16:06:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FBFDD49.2000801@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198532>

On 5/25/2012 2:28 PM, J.V. wrote:
> We have a shared git repository (origin). Everyone on the team clones
> the repo, does some work, commits locally then pushes to the shared
> repository.
>
> I have a box where I have cloned the repo. I have another box (test box)
> where I have also cloned the same repo. I change/commit/push code on
> either box to the shared repo depending on the task at hand.
>
> Now I want to do something different. I want to create new files on my
> local box in various directories that are part of my local git rep, and
> share them only between just the two boxes. So I need the ability to
> commit/push to another repo such that others on the repo mentioned in
> the first sentence will not be affected.
>
> There will be various files in various sub directories, so when I pull
> on the second box, I want all the files to come down and be put in the
> same directory that they existed on my box 1 where I committed them.
>
> Is this at all possible? Maybe by creating a bare repository on my box 1?
>
There could be lots of ways to do this.  Some ideas are:

   - git-remote allows you to communicate exclusively with the box-2-repo.
   - git-branch allows you to have a branch based on origin, and then 
create another branch based on it that has the extra stuff and that is 
the branch you share with box-2-repo.  To incorporate the original 
branch you can rebase on it or merge it in.

The real question is why do you want to do this, and is the above the 
best way to accomplish it.

Less likely, you could also find that git-submodule is your friend and 
you and box-2-repo are using an extra submodule that the origin repo is 
not using.

v/r,
neal
