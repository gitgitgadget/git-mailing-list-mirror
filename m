From: Israel Garcia <igalvarez@gmail.com>
Subject: Re: backup git repo on every commit
Date: Tue, 13 Oct 2009 11:43:51 -0500
Message-ID: <194a2c240910130943j40c12902o760e463e7a8ce8fa@mail.gmail.com>
References: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com>
	 <20091012141544.GF9261@spearce.org>
	 <194a2c240910120725u72cdb588p3c66bc730e6953d@mail.gmail.com>
	 <20091012143043.GJ9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 18:46:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxkWU-0001us-6v
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 18:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbZJMQoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 12:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbZJMQo3
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 12:44:29 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:34194 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbZJMQo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 12:44:28 -0400
Received: by fxm27 with SMTP id 27so10419857fxm.17
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=h0eTuST1yImaRfCBpv6gsf8N495RCt8u7kyQsv/1uBE=;
        b=CjADt8qpylnE/gxvwXY1uphMtqHc9fGLEONR2oz49yhtBosfqjUzjLRS1oO8NGN4N0
         oiw/6n7WnUXVIR6Luu/dXtIlgNd8LF9X1VKg9ukHckta1y9haRb74dhDk/GFBy33JzRr
         AAWmsfWfyxpHup03WI8bqKLTUZl4lgcD8cupQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JONA3cchkdpbp4E0zV/KkUvVVMB8NxOR/6SuCYt2OHuhdps7/PIH3E5LpIOWYFOIsl
         rWgIt77qtwdJGnrh1ZifXju2l48TYQi1y3u6EIYwHqCljmysc+UpUSCbC8OZcOWXD/5U
         kUZOKKF0YsUNR9f4JpbFA4iO1HJE4V2C0BMCs=
Received: by 10.204.36.207 with SMTP id u15mr1951937bkd.39.1255452231708; Tue, 
	13 Oct 2009 09:43:51 -0700 (PDT)
In-Reply-To: <20091012143043.GJ9261@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130169>

Hi Shawn,

Sorry to ask again, but I'm a little confuse about how git work in my case.
I use gitosis on a server where I have all repos
(/usr/local/git/repositories/), so different people clone their repos
on their computers. What I want is to backup, on gitosis server, all
repos in /backups/git/repositories/ after every commit. So, my
questions are:

Do I have to run these two comands on tha gitosis server? Or on a
remote computer?
  git --git-dir=/backup/project.git init
  git remote add --mirror backup /backup/project.git

The post-commit are execute on gitosis server or on the remote pc?

I'm completely new using git so I'm a little confuse.. sorry for asking again.

thanks a lot.
regards
Israel.
On 10/12/09, Shawn O. Pearce <spearce@spearce.org> wrote:
> Israel Garcia <igalvarez@gmail.com> wrote:
>> That's OK, but I want to backup my git repo locally
>
> Just change the path of the backup remote (that final argument to
> git remote add) to point to the local directory.
>
> Though I guess you would also need to run git init there, e.g.:
>
>   git --git-dir=/backup/project.git init
>   git remote add --mirror backup /backup/project.git
>
>   # and create the hook as below
>
> Of course, backup to another folder on the same disk isn't a backup
> at all, the disk can still fail and lose both repositories.
>
>> On 10/12/09, Shawn O. Pearce <spearce@spearce.org> wrote:
>> > Israel Garcia <igalvarez@gmail.com> wrote:
>> >> Which is the simplest  way to backup a git repository after every
>> >> commit?
>> >
>> > Add a commit hook to push to another location, e.g.:
>> >
>> >   git remote add --mirror backup you@another.host:path/to/backup.git
>> >
>> >   cat >.git/hooks/post-commit
>> >   #!/bin/sh
>> >   git push backup
>> >   ^D
>> >
>> >   chmod a+x .git/hooks/post-commit
>
> --
> Shawn.
>


-- 
Regards;
Israel Garcia
