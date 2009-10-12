From: Israel Garcia <igalvarez@gmail.com>
Subject: Re: backup git repo on every commit
Date: Mon, 12 Oct 2009 09:39:24 -0500
Message-ID: <194a2c240910120739j58cc1ec0o629b0df7d31e3fdd@mail.gmail.com>
References: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com>
	 <20091012141544.GF9261@spearce.org>
	 <194a2c240910120725u72cdb588p3c66bc730e6953d@mail.gmail.com>
	 <20091012143043.GJ9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 16:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxM4V-0002uT-Of
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 16:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbZJLOkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 10:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbZJLOkE
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:40:04 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:48845 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208AbZJLOkC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 10:40:02 -0400
Received: by fxm27 with SMTP id 27so9259489fxm.17
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=d1U5/Zu9VRqz2IjWAG7sjTaTuTf2zBPrHKPwvfmAT6I=;
        b=kwwp6tOiGOIPbjYzE5YTu/Bzc8TC84fmcFQMUx43lmieYt1gL0IyNzDk6vkQwhnz5+
         9Fu+e+1x8jFBNGWuTBhHZMaDsjm2xF5xq/7f/nipz6V8+yig/UgoG2L41+kyy3Isf+zk
         IbDX3HBonWfjY6Zv7I82wkX9Xlth7zDY10iR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VMSO0yfzrDXFwiZno3bo01RjICQqoc0tZGveal5BfXdks/A2QsAXM/y7MdNyPNj/+j
         SLCfUPSSsmB1s462q6/eXcxaEAJL06CTluB8kZIsk3eQheSYtfq6bocBKTDCTcXBnClV
         6euw/ix/rOEvve69s4YyF6B72PgvKoe1TRfIY=
Received: by 10.204.25.152 with SMTP id z24mr5190232bkb.44.1255358364955; Mon, 
	12 Oct 2009 07:39:24 -0700 (PDT)
In-Reply-To: <20091012143043.GJ9261@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130022>

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
Nice..:-)

>
> Of course, backup to another folder on the same disk isn't a backup
> at all, the disk can still fail and lose both repositories.
Yeap, but I use rsync to backup /backup folder on a remote server
every night. /backup folder other apps backups.

thanks Shawn.

regards

Israel.

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
