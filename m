From: "Andrew Arnott" <andrewarnott@gmail.com>
Subject: Re: Repo corrupted somehow?
Date: Tue, 4 Nov 2008 07:12:40 -0800
Message-ID: <216e54900811040712k51db6fbfu44c59d9f90f1eabd@mail.gmail.com>
References: <216e54900811032309s51c8cb1fr64054ff18c450b1d@mail.gmail.com>
	 <216e54900811032334y35ada7daw753c0ad3073c0317@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 16:14:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxNbS-0007Zj-Dz
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 16:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbYKDPMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 10:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbYKDPMn
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 10:12:43 -0500
Received: from rn-out-0910.google.com ([64.233.170.191]:4677 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbYKDPMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 10:12:42 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2275899rnd.17
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 07:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7+HR7jawU6k1dOmeNTOKQNq1fG/Zeomb9h91qQhVd5Y=;
        b=G7ksnVLc/fIqFhE5hclLhGxPa27hJEIrDWKhUsnTQE/UmWGKFtJn0CtE2fKP+NG/xq
         LgPeiAWH+7PJxxD/rucWFHVxkhIDiZ6qrYElmOGf64XECL6mRWtu0x0jiANNzsT1rpic
         dcXccRjm8SbV3wdrsjCKFCznoyv4y8Mxv6pmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PUZrdA9OsmL8GmwLYZg/b9A/rEoYxYvWrmMZalGgRu5+Ou02CfaK2Y0BXyH7Ytf0it
         AqKYDSQv7oBcNQz9ernEDyqtIoOPL6oqRuaFJ/rx/eacyYZsTgmykXs7qmVHRI3BlWET
         RxfED0C84lf8FEaN3xvNEYVH/7Vc+3VzjgiQc=
Received: by 10.151.149.14 with SMTP id b14mr2543419ybo.232.1225811560253;
        Tue, 04 Nov 2008 07:12:40 -0800 (PST)
Received: by 10.151.142.12 with HTTP; Tue, 4 Nov 2008 07:12:40 -0800 (PST)
In-Reply-To: <216e54900811032334y35ada7daw753c0ad3073c0317@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100081>

Nah, that wasn't a false alarm after all.  It's happening again, only
this time for dozens of files, and
git rebase --abort
git reset --hard

is not helping.

On Mon, Nov 3, 2008 at 11:34 PM, Andrew Arnott <andrewarnott@gmail.com> wrote:
> I guess I was still in the middle of a rebase.  git rebase --abort
> sort of ultimately fixed it.
>
> On Mon, Nov 3, 2008 at 11:09 PM, Andrew Arnott <andrewarnott@gmail.com> wrote:
>> I was just git commit'ing, and then I was doing a git rebase to squash
>> several commits into one when the rebase failed.  I then did a
>> git checkout -f master
>> git reset --hard
>> but no matter what I do, git thinks that several files have changed.
>> The diff shows all the lines in these several files removed and then
>> added, yet without any changes made to them.  git reset --hard doesn't
>> revert the change. When I jump around history with git checkout these
>> files remain in their "changed" state.  I even tried "git clone" to
>> create a whole new repo, but one of these several files STILL
>> registered as changed before I made any changes.
>>
>> Any idea what's wrong and how to recover?
>>
>> Observe the below command buffer: (I can upload my repo so you can
>> clone it and perhaps repro it if you want).
>>
>> Andrew@LACKY /c/git/dotnetoauth
>> $ git status
>> # On branch master
>> # Changed but not updated:
>> #   (use "git add <file>..." to update what will be committed)
>> #
>> #       modified:   tools/Documentation.targets
>> #       modified:   tools/DotNetOpenAuth.Common.Settings.targets
>> #       modified:   tools/DotNetOpenAuth.Versioning.targets
>> #       modified:
>> tools/Sandcastle/Presentation/vs2005/Content/reference_content.xml
>> #       modified:   tools/libcheck.ps1
>> #       modified:   tools/sandcastle.targets
>> #
>> no changes added to commit (use "git add" and/or "git commit -a")
>>
>> Andrew@LACKY /c/git/dotnetoauth
>> $ git reset --hard
>> HEAD is now at 13d37b8 Patching up the bad merges in the phases.
>>
>> Andrew@LACKY /c/git/dotnetoauth
>> $ git status
>> # On branch master
>> # Changed but not updated:
>> #   (use "git add <file>..." to update what will be committed)
>> #
>> #       modified:   tools/Documentation.targets
>> #       modified:   tools/DotNetOpenAuth.Common.Settings.targets
>> #       modified:   tools/DotNetOpenAuth.Versioning.targets
>> #       modified:
>> tools/Sandcastle/Presentation/vs2005/Content/reference_content.xml
>> #       modified:   tools/libcheck.ps1
>> #       modified:   tools/sandcastle.targets
>> #
>> no changes added to commit (use "git add" and/or "git commit -a")
>>
>
