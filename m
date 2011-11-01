From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: checking out later commits from rolled back state
Date: Tue, 1 Nov 2011 18:56:26 +0400
Message-ID: <20111101185626.6e16326c@zappedws>
References: <1320158207959-6951892.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: photoshop_nerd <JBreuer@consumercredit.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 15:56:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLFld-00022S-CD
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 15:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853Ab1KAO4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 10:56:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45922 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab1KAO4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 10:56:40 -0400
Received: by bke11 with SMTP id 11so482104bke.19
        for <git@vger.kernel.org>; Tue, 01 Nov 2011 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=zISDM3zXP3MMvL0zqyuiiInlL6WHfRlsEcQQrQy/UbU=;
        b=MQFfcy/vywOPTIReERDLWDldFZT3SVUIxVDMn3J3PiJVZ2LHMUcHbSlCPnsZ0XZNgY
         emudOwtuVdOsFrOWBKPseuDl2IfMpczXyVyxEO3lrKh6m2As0mZQ9k0tgmW6GKlXjt1h
         2UCxqVnj6UK+JHXKwcJ9vOeI1DiYHZtue+Tvw=
Received: by 10.204.145.89 with SMTP id c25mr15105566bkv.35.1320159399354;
        Tue, 01 Nov 2011 07:56:39 -0700 (PDT)
Received: from zappedws (ppp91-77-54-196.pppoe.mtu-net.ru. [91.77.54.196])
        by mx.google.com with ESMTPS id a1sm10915826bkk.3.2011.11.01.07.56.33
        (version=SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 07:56:38 -0700 (PDT)
In-Reply-To: <1320158207959-6951892.post@n2.nabble.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184569>

usually, before you checkout a "past" commit you are on a "current"
named branch
so, do
$ git log <branch_you_were_on_before>

In general, most "history" git commands take a commit hash as an
argument and HEAD as a default one if none was specified
(HEAD is always CURRENT commit (you are on), it is a difference of SVN)

when you ran
$ git log
it was, actually, 
$ git log HEAD

Also, you may specify several commits as arguments of git log
It it very usefull to use (in terminal) to see how branches are diverged
(on X/Windows gitk is more pretty)
$ git log --oneline --graph --decorate <branch1> <branch2> <branchN>


There is also  "git reflog" command
RTM git-reflog

> Hello, I a m relatively new to git, and my question pertains to
> moving back and forth through the history of my commits.
> 
> Here is how I open a previous commit:
> 
> 1)$ git log
> 
> 2) (get sha1 hash of previous commit)
> 
> 3)$ git checkout <hash of my previous commit>
> 
> the problem is that once I am working with that commit, git log only
> shows the hash tags up to the time that the commit was made, but not
> any of the later commits. Is there a way to get the hash tags of my
> later commits when I am in that rolled back state?
> 
> --
> View this message in context:
> http://git.661346.n2.nabble.com/checking-out-later-commits-from-rolled-back-state-tp6951892p6951892.html
> Sent from the git mailing list archive at Nabble.com.
