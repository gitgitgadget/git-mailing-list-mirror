From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: tracking file locally without pushing it to remote
Date: Sat, 23 Jul 2011 19:27:20 +0700
Message-ID: <CACsJy8BZSWaaNPjQYKXmTHvJ5vbNXBfNCtV78DUJVDuPqtp1Hg@mail.gmail.com>
References: <CALFxCvzqGBbq0fqtLJdwTideh9Un-cAEeQi8WpC496qoyCLg4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: neubyr <neubyr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 14:28:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkbJH-0004cp-Vj
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 14:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717Ab1GWM1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 08:27:53 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:37609 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab1GWM1w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 08:27:52 -0400
Received: by fxd18 with SMTP id 18so6525578fxd.11
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8f/GUVxCjyxn82rpG1CP1xMT7r2XTT7GJgvnCSp0+NM=;
        b=LxFJCgkMvYLakwId/IaSF5hloDgzQ1whld5Fj/HLRWEL2wGV3Sa7NVIeoro9otXkUd
         FaiGnieupBa2/N8IFvsjV0MBFjy6DL1saTu2L62cSDNPOACHHV0f0VPA23Dl6OwbS0QD
         ZE+NVCRoyyjWfPpuDcyLzvhzV+/pYyywfUevw=
Received: by 10.204.7.205 with SMTP id e13mr735932bke.36.1311424070481; Sat,
 23 Jul 2011 05:27:50 -0700 (PDT)
Received: by 10.204.59.83 with HTTP; Sat, 23 Jul 2011 05:27:20 -0700 (PDT)
In-Reply-To: <CALFxCvzqGBbq0fqtLJdwTideh9Un-cAEeQi8WpC496qoyCLg4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177691>

On Sat, Jul 23, 2011 at 2:23 AM, neubyr <neubyr@gmail.com> wrote:
> I have two configuration files in a project which I would like to
> track locally, however avoid pushing them to the remote repository. Is
> it possible do that? Any suggestions on how can it be done?

Manage the configuration files in a different repository (but with the
same working tree). Git does not support sharing worktree this way, so
it's a bit inconvenient. Maybe other people can give more suggestions.

# Initialize a config repo, place it at $GIT_DIR/config.git so it's hidden
GIT_DIR=`git rev-parse --git-dir`/config.git
GIT_WORK_TREE=/path/to/worktree git init
# Work on all files as usual, when you need to commit config files
GIT_DIR=`git rev-parse --git-dir`/config.git git <command>

Create some aliases to shorten the commands. Branch switching will be
a problem, since you have to switch branch on two repositories
consistently.
-- 
Duy
