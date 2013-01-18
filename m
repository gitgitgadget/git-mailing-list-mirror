From: Phil Hord <phil.hord@gmail.com>
Subject: Re: merge vs. rebase question
Date: Fri, 18 Jan 2013 13:38:49 -0500
Message-ID: <CABURp0rTNh4Xe4h6RwvDgQaBKJFq-ami-wO+X0mR5hiubaF7mw@mail.gmail.com>
References: <50F8073F.90304@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Dennis Putnam <dap1@bellsouth.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 19:39:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwGqi-0001Zz-6Y
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 19:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686Ab3ARSjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 13:39:11 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:53559 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab3ARSjL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 13:39:11 -0500
Received: by mail-vc0-f174.google.com with SMTP id n11so1972045vch.19
        for <git@vger.kernel.org>; Fri, 18 Jan 2013 10:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4fb7hr6MdGz46QjkhDt+UawFXNVqqcFzBcSysb8OvAQ=;
        b=SYy6SbVxqtyhqNxJCgOkQq9uP04e3mWd1W7MjxGQb3LmPT7p+qE4az//yxQZxxaMdA
         +gLzLqTQ9VNF0uwzTNx3htJs8Uksmbo6WIl8wGMBdWkQP/YnwolM18gb7HJSPpeY6l1n
         K6uKMBB7/wpP+SHKDdBelqKsv7FwR2Zq3cAxCUOrbb1e8qIlQ8YHK8xc/uIHIxINcT3R
         iBF+w/gb6W9XaaJLFTMH3bfyQeBg6Pu0c65WUFzG1qsQcKVHmkxEITuzD6xHCKoYpifi
         hBFME5OMvOd/KVRgtsUUvqFrMzRwj3NT4JWBvPr1+6CY0sU3lN7vytz9CorMB2jVOfYl
         tmYg==
X-Received: by 10.52.178.225 with SMTP id db1mr9587433vdc.10.1358534349360;
 Fri, 18 Jan 2013 10:39:09 -0800 (PST)
Received: by 10.58.241.203 with HTTP; Fri, 18 Jan 2013 10:38:49 -0800 (PST)
In-Reply-To: <50F8073F.90304@bellsouth.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213921>

On Thu, Jan 17, 2013 at 9:14 AM, Dennis Putnam <dap1@bellsouth.net> wrote:
> As a git noob I am having trouble understanding when to use which
> commands. I have a repository (bare) on my Linux server. I also created
> a build directory as a local repository. In my build script I do a 'git
> pull' to make sure the build directory is up to date. No changes are
> made to my source so this repository never does an 'add' or 'commit'.
> When I run my script with 'pull', the output indicates that changes were
> found and seems to have pulled them into the local directory. However,
> when I look at the resulting source, none of the expected changes show
> up. I then tried a 'fetch' and 'rebase'. That worked but I don't
> understand why. I thought 'pull' did a 'fetch' and a 'merge' so I don't
> understand why a 'fetch' and 'rebase' worked but 'fetch' and 'merge' did
> not. Unless my understanding of what 'pull' does is wrong. In my case,
> what should I be using in my script to assure that the build directory
> is current?

If your build directory never has any source changes or new commits,
then pull is the right thing to do.  You might want to use 'git pull
--ff-only' to guarantee that your build directory is not creating
merges unexpectedly.

You did not provide enough information to help figure out why your
pull is failing to achieve the results you expect.  I suggest you
perform the pull manually in your build directory.  If it fails, git
should tell you why.  If it reports success but actually fails, you
can post a detailed explanation of the problem here so someone can
suggest the cause.

Phil
