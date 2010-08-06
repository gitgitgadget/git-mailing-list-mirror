From: PCMan <pcman.tw@gmail.com>
Subject: Re: How to replace master branch of a repo with that of another 
	totally unrelated repo?
Date: Fri, 6 Aug 2010 16:21:02 +0800
Message-ID: <AANLkTikxzUAVpsA8DtOM+1_u54xb5S91GV+3PAi52GLD@mail.gmail.com>
References: <AANLkTiksJd-VfiP2Wzz-FsZoJk8djWyuxgweQpy6WaPB@mail.gmail.com>
	<20100806080720.GB31901@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 10:21:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhIAz-0004w3-8m
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 10:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934070Ab0HFIVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 04:21:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58506 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932936Ab0HFIVE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 04:21:04 -0400
Received: by wwj40 with SMTP id 40so8760018wwj.1
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 01:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=8+1L0CjVQ/rKlyPtLjRhUVRwZgGQe6fi3YKbcwgP3SE=;
        b=YkmvZjdvxigXjoOCKJws2mkBOiuLDXloj1NxPnzAtlRY8Cf1+k+JgIRB6b7Bd19riK
         6UKbamkCrLbe7bdVUkPfszOau2XbW5jRCsl7EI3iRTrWLU9vQpWr6rHEy77b5ZyBG5ej
         mb+NTdA7JhfZ4vddD76cLfnB6KFFFL4ktJ/vU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jw/GBsNGpcIDh98nSOZ54dlY/1VlWuJ+/BVeQg1Q36EFnv7QhQw5i3Crg99P3oaZtK
         NsQdmj4mK9hUa4OacM+9q6du1eA+fqlldwaprwlMCCEU9FyRYi9RCf/U9CfBJaVeQA57
         YM6DegNkT71zQ2RB4aWMURyksq/p+StvA4RCk=
Received: by 10.227.69.202 with SMTP id a10mr9817862wbj.81.1281082862747; Fri, 
	06 Aug 2010 01:21:02 -0700 (PDT)
Received: by 10.216.61.12 with HTTP; Fri, 6 Aug 2010 01:21:02 -0700 (PDT)
In-Reply-To: <20100806080720.GB31901@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152771>

Thank you for the detailed answer! It's really useful.

Now I fetch the new source code to a new branch.
Later I plan to replace master with merge --ours when it's ready.

Thanks

On Fri, Aug 6, 2010 at 4:07 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Hi,
>
> PCMan writes:
>> I want to rewrite a program totally from scratch rather than branching
>> from current one.
>> So I created a new repo for it and do the development there.
>> Now it's finished and I want to replace the old program with it.
>> Is it possible to replace the master branch of the old repo with the
>> code in this new repo?
>> I want to move the old code to a separate branch for backup, and
>> replace the master branch with the master branch of the new repo.
>> Since git rm -r * than git add all new files will lost history of new
>> repo, it's not an option.
>> The old repo is a public online repo used by multiple users. So just
>> renaming the repo won't work since the users who pull code from the
>> old repo will get troubles.
>> What's the best strategy for smooth migration in this case?
>> I'm not able to find the answer on Google.
>
> In your old repository:
> $ git checkout master # Switch to branch master
> $ git checkout -b backup # Create a branch backup of master
> $ git remote add new <new_repository_url> # "new" is the name of the remote
> $ git fetch new # Fetch all the objects from the remote "new"
> $ git checkout master # Get ready to rewrite master
> $ git reset --hard new/master # Use `reset --hard` with extreme caution
> $ git checkout backup # Your backup is safe here
> $ # Done!
>
> -- Ram
>
