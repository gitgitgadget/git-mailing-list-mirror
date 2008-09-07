From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: Howto forward workdir to HEAD
Date: Sun, 7 Sep 2008 00:05:53 -0700
Message-ID: <905315640809070005r6183a5f7n351b9bfd4df76af5@mail.gmail.com>
References: <200809062332.39147.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Sun Sep 07 09:08:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcEO2-00051s-9Z
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 09:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbYIGHF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 03:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbYIGHFz
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 03:05:55 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:54042 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbYIGHFz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 03:05:55 -0400
Received: by ey-out-2122.google.com with SMTP id 6so469492eyi.37
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 00:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=QKsjd4RysDkGjNeUvjkr2YH28MNyqdIEyU3tJvjW/JQ=;
        b=dO90RrN0siKa4t3Cl0HAhaM1Q1DRJmRtCJoVIEfxdCzYrsBxR5nxyXq/x7FnvYSYnj
         iKiJnshrFS0he1bRuPL/oMKqZ1Gdq3LcaqWgFa0vR4WrxTKu4batcpIWwH32lFsJbQul
         y70vkvIIOomqnfMIZgeIjx9OG35jYB9rycxpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=rIZrkdbtVCo1ORj47c8kMBFYkJZm/EgSAN3WlUDyvtkE9yLY/jpLUADwW2sHV5RX1e
         BS/oHtJuFLHY28p07kleM8z3EFwdV+cKNKREUh5xwRipt0GHA/zTgRPtJmulN767vk8m
         eMQ8oxLZgHp8XyYFrl5Dbab3hV/x4mHKB3f94=
Received: by 10.210.125.7 with SMTP id x7mr16597646ebc.198.1220771153194;
        Sun, 07 Sep 2008 00:05:53 -0700 (PDT)
Received: by 10.210.109.18 with HTTP; Sun, 7 Sep 2008 00:05:53 -0700 (PDT)
In-Reply-To: <200809062332.39147.thomas@koch.ro>
Content-Disposition: inline
X-Google-Sender-Auth: cd6d5a27756599b5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95122>

On Sat, Sep 6, 2008 at 2:32 PM, Thomas Koch <thomas@koch.ro> wrote:
> Hi,
>
> I'm trying to setup an intranet Webapp using GIT for maintanance and
> backup. First I created a git repo on my working machine and imported
> the webapp, made some changes.
>
> Then I created a normal, non-bare repo at the server and pushed from my
> local repo into the server repo, checked out branch "stable" and
> everything is fine.
>
> Now I made a local change and pushed again, but the servers workdir is
> not automatically forwarded to the pushed state. How do I forward it?

Please read http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73

> Can I define a Hook that automatically forwards the workdir after a
> push, but only if the workdir is clean?
>
> What do you think of this method to deploy a webapp?

Generally it is frowned upon.  The recommended way it to have a script
or build process that you run from the git repo to populate the
workdir.  In addition to the reasons mentioned in the FAQ, you
probably also don't want your live website to be updated in some
random order decided by git, but want to update it in a particular
order to stay consistent for anyone who loaded it in the middle of the
update.  This is best controlled by your makefile/script.

-Tarmigan
