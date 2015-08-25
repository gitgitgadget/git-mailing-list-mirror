From: Rafik E Younan <rafik.arkdev@gmail.com>
Subject: Re: index file list files not found in working tree
Date: Tue, 25 Aug 2015 12:16:43 +0200
Message-ID: <55DC408B.5030804@gmail.com>
References: <55DAF343.2050908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 25 12:16:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUBHg-0004U5-QU
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 12:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139AbbHYKQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 06:16:48 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37630 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046AbbHYKQr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 06:16:47 -0400
Received: by widdq5 with SMTP id dq5so10209853wid.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type:content-transfer-encoding;
        bh=9pooYIuzfQYDec4p80cKMuUy0WBcVzm2P9rV0NV8exw=;
        b=TGcxwqqgkyIEpQKoBqKDMSkV5c1nMhBi5nMESBehqYiTh/7L/C9l0vC1r3lD54XPMd
         3DlYHmo0DhjIqX273haJ7F0VzMdctk8QuU5dj3xFMBIGOXRH5s3ev2NE0YbCiilTJDLV
         UYiPE4BgVve68GKGxlhztOS1KzsCfM+x6saCcdjuk7vqcMWYGQbPKIClLBUMuXjqhCul
         JBTTX5dCq2GCbx7jSs2sgbiiDW+CQwG8NCtbacL/ASnoUswQik6CmiYhvT8zENoK0OYo
         AgVju35UfQFltsuGZTZ48wXe4sjHvQVgzylg6Xp0LIpuL3aFF9zCX3Z4RmQCurf6nEsM
         SiAg==
X-Received: by 10.180.90.209 with SMTP id by17mr3522691wib.60.1440497806843;
        Tue, 25 Aug 2015 03:16:46 -0700 (PDT)
Received: from [192.168.1.115] ([196.205.146.227])
        by smtp.googlemail.com with ESMTPSA id ej5sm27323514wjd.22.2015.08.25.03.16.45
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Aug 2015 03:16:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <55DAF343.2050908@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276513>

Hi,

I got a recommendation to use reset --hard. I tried it and it says the 
HEAD is now at correct commit, but missing files are not restored!

I tried `ls-tree --name-only` and it lists missing files and folders, 
but the actual working tree doesn't have these files and folders.

The question I'd like to answer, how does git generates the `index` file 
between checkouts?

Thanks,
Rafik

On 08/24/2015 12:34 PM, Rafik E Younan wrote:
> Hi,
>
> After several merges and rebases I finally got my branches and history 
> to reflect valid commits and proper history. Everything is pushed to 
> internal bare repo and the remotes seems OK.
>
> When I clone the updated repository, all branches reflect the correct 
> updated trees and blobs.
>
> The problem occurs only on the original local repository where all the 
> merging and re-basing took place!
>
> When I checkout a branch, several files and folders are deleted from 
> the working tree. When I examine the history of these files, there are 
> only commits of adding them and modifying them but no log for deleting 
> them, and they aren't deleted when I checkout the same branch in 
> another fresh cloned repo.
>
> Git status command doesn't indicate any changes in these files. I 
> found the files and folders names in the `.git/index` file. So after 
> manually removing the `.git/index` file and usinge `git reset` 
> command, `git status` indicates that the files and folders are deleted.
>
> I use `git checkout -- <File_or_folder_names>...` and restore all 
> missing files and folders, just then the working tree matches the 
> fresh checkout of the same branch on any other cloned repo.
>
> After examining the tree object of the current commit, all files and 
> folders exists, although clearly the checkout missed some of them!
>
> Because the repository is local and private, I can't share any url for 
> publicly accessible repository, and if one exists, no problem could be 
> found, because the problem resides in just this certain local clone.
>
> Answering the following questions might give some clues for the problem:
> * How does git populate the index file after every branch checkout?
> * Is there any object to reflect the content of the index file?
>
> I would appreciate any pointers for where the problem could be.
>
> Thanks,
> Rafik
>
