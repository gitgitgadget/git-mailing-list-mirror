From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-push: add option --repo-all
Date: Fri, 18 Sep 2009 13:02:45 +0200
Message-ID: <200909181302.49335.jnareb@gmail.com>
References: <1253258222-11475-1-git-send-email-catap@catap.ru> <m3r5u43a8h.fsf@localhost.localdomain> <877hvwzkw7.wl%catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Fri Sep 18 13:03:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MobF0-0002ay-5j
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 13:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395AbZIRLCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 07:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbZIRLCv
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 07:02:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:32701 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbZIRLCu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 07:02:50 -0400
Received: by fg-out-1718.google.com with SMTP id 22so213172fge.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2009 04:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=wZ0voM2gbMeaqelRa6vZ2kUan8UpG8zukdgH25EmdC4=;
        b=wwuehIqtNNk8+bzjzyM5cMJr/3thA5+P0AANEWbIE+z8YbpLHG1ImKqk02b8Pm7geg
         n6qO+zBK1DZcvXshOjwUi0WeQuyrFUDiTZ3SKuLYIohmlWECZ5AwVeXpSpxlhIWNVT9Z
         w7cuLBnu3ATS0x1ddQMLfwOkuxdOITo9c3Cwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AiDzAD8MxwMDJmfmIKn3bOx1XphEAq8Gw1i+tSOaMz82RpKVyE+aBBebmyVsH2aXCd
         dUjF0RzFHa1p1LrjUcxG63WiFy07vKW2TTWY1MrG5KHNBbUJDdk4A0qye1dYEttFyieS
         qFw9Zne59N/cy7cfmeYoDbCTIg1D0zVr6vJFA=
Received: by 10.86.170.4 with SMTP id s4mr1642506fge.9.1253271773054;
        Fri, 18 Sep 2009 04:02:53 -0700 (PDT)
Received: from ?192.168.1.13? (abvh88.neoplus.adsl.tpnet.pl [83.8.205.88])
        by mx.google.com with ESMTPS id 3sm1394101fge.10.2009.09.18.04.02.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Sep 2009 04:02:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <877hvwzkw7.wl%catap@catap.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128794>

Kirill A. Korinskiy wrote:
> At Fri, 18 Sep 2009 01:52:49 -0700 (PDT),
> Jakub Narebski <jnareb@gmail.com> wrote:
> > "Kirill A. Korinskiy" <catap@catap.ru> writes:

> > > ---
> > >  Documentation/git-push.txt |    4 ++-
> > >  builtin-push.c             |   34 +++++++++++++++++++++-----------
> > >  t/t5523-push-repo-all.sh   |   46 ++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 71 insertions(+), 13 deletions(-)
> > >  create mode 100755 t/t5523-push-repo-all.sh
> > 
> > I have created 'pushall' *alias* for that purpose, but I think that
> > such functionality would be better added to "git remote" rather than
> > to "git push".
> 
> not sure, because git remote make interface for managment remotes
> repos and push make interface for pushing to remote repo. I just add a
> pushing to all repos.
> 
> I thought about pushing to some remotes repos, yes, but could not come
> up with a good symantics.

Well, git-remote has "git remote update" subcommand for fetching from
a group of remote repositories, so it is not only about managing remotes.
I think "git remote push" (or something like that) would fit in 
git-remote area of competence.

Besides git-remote understands groups of remote repositories for fetch
(update), which would be (I think) a good idea also for push.

-- 
Jakub Narebski
Poland
