From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: tracking file locally without pushing it to remote
Date: Sat, 23 Jul 2011 19:35:45 +0700
Message-ID: <CACsJy8AaDj3QV-unj80cY4x18tHRDAr0hdgtiRuCs6SCYP33ng@mail.gmail.com>
References: <CALFxCvzqGBbq0fqtLJdwTideh9Un-cAEeQi8WpC496qoyCLg4w@mail.gmail.com>
 <CACsJy8BZSWaaNPjQYKXmTHvJ5vbNXBfNCtV78DUJVDuPqtp1Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: neubyr <neubyr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 14:36:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkbRu-0006nm-Kr
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 14:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab1GWMgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 08:36:18 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:46417 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab1GWMgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 08:36:16 -0400
Received: by fxd18 with SMTP id 18so6532661fxd.11
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=d2wcuuY0npxpVUIlx2oqDqOtz2YtdAfuHNyCVjS4yFw=;
        b=IaPaUqFkH6p0DS0y8VYCCqej1SibsdywEAWGVkoKF7d22BN+YICJjka75FwPsTyyvS
         W2el944YIFgnjmCJmkxOSYIBCqjxk5rUG/7hBq4ztZ0+hoA5qddlgVvdaMUCMV+0oJFE
         uiAkLIn+2upLuxObs+beglOonOc2S9c9nEf0A=
Received: by 10.205.37.66 with SMTP id td2mr727803bkb.296.1311424575316; Sat,
 23 Jul 2011 05:36:15 -0700 (PDT)
Received: by 10.204.59.83 with HTTP; Sat, 23 Jul 2011 05:35:45 -0700 (PDT)
In-Reply-To: <CACsJy8BZSWaaNPjQYKXmTHvJ5vbNXBfNCtV78DUJVDuPqtp1Hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177694>

On Sat, Jul 23, 2011 at 7:27 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Manage the configuration files in a different repository (but with the
> same working tree). Git does not support sharing worktree this way, so
> it's a bit inconvenient.

And if you still want to manage config template files with the same
name in the main repository, to be pushed to a remote one. Set
assume-unchanged bit (see update-index man page) on those files in
main repo, so you won't see their changes against the templates and
"git commit -a" won't commit them. To be on the safe side, add a
post-commit hook that disallows committing any changes to config
files.

Assume unchanged bits are not persistent (ie. you will need to set it
after branch switching, reset index...), but if this way works well,
maybe we can add a pattern file to automatically set it.
-- 
Duy
