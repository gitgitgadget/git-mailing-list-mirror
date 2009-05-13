From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: switching upstream tips
Date: Wed, 13 May 2009 09:41:40 +0200
Message-ID: <81b0412b0905130041t327ef5f2m3b6d1dfac51fc1b1@mail.gmail.com>
References: <4A0A6BD1.7050907@gmail.com>
	 <81b0412b0905130019x114d53d1v86833217bff613bc@mail.gmail.com>
	 <4A0A777E.7080506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 09:41:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4965-0005Aa-Ow
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 09:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbZEMHlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 03:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbZEMHlm
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 03:41:42 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:55006 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbZEMHll (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 03:41:41 -0400
Received: by bwz22 with SMTP id 22so459703bwz.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 00:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5lvIBvMQzpTN0OGirxYPC8FSwy+8ZFBueWqKAweViDM=;
        b=I58YaZ5FUkEZsw53F1FRwjXZxIbfjKPvhuGtaUy5hrEhMDxboqe8vDLibTTMGNGY+c
         POuhPKoh/sWRUt9TB3Bg24jxRJ9CP4M11tdK0Nul9BgsgZRhqkWXZ2wbcNJeqAQnR9Ij
         VjrbTgudadzAyWnWadXwGZPG+v++oYS4xzeiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ltF70w98NuV1rmMcS06YgShX0doTekXquhBjbRvfUoTavz03EPXwXiVExQe8pjVAJY
         dkaiPCsaB31ArOGCHHGcSr2fNDshbqIOfzrA8X86OsQ6a1+iKNDXjT+0zcm+dJQpdUI6
         8DcXjTw+P6t928VUBLSf5BMEjmZ1VjlYqJiv0=
Received: by 10.204.53.1 with SMTP id k1mr617194bkg.125.1242200500766; Wed, 13 
	May 2009 00:41:40 -0700 (PDT)
In-Reply-To: <4A0A777E.7080506@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118995>

2009/5/13 Ittay Dror <ittay.dror@gmail.com>:
>> Alex Riesen wrote:
>>> * Reorder my history so that my commits are on top of the tip of the old
>>> upstream repository.
>>
>> Look at "git rebase -i" (interactive rebase)
>
> well, i was hoping for something more automatic. git rebase will list all
> commits without author, so i'll have to manually figure which of them is
> mine from the commend and reorder

git rebase will list only commits not on upstream (simplified).
Has nothing to do with author being absent.

>>> * Change the upstream repository reference so it points to the new
>>> repository
>>
>> Just edit your .git/config and re-fetch.
>
> but then git suddenly sees a bunch of new objects (because of the svn
> changes) and i get a lot of conflicts.

"git fetch" and "git remote update" do not produce conflicts. You cannot
get them unless you also do a merge (like when you do "git merge" or
"git pull").

> note that it is not the directory structure that changed, just the svn
> repository which is included in the commit comment (by git-svn) and
> so changes the commit sha1.

Ok, that simplifies everything. Just cherry-pick (see "git cherry-pick")
your commits on new upstream. You might find it easiest if you cherry-pick
them on commits in new upstream which correspond the old-upstream
exactly.
