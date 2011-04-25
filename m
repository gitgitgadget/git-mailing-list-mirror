From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Cloning into an existing, non-empty directory?
Date: Mon, 25 Apr 2011 03:00:10 -0500
Message-ID: <20110425075750.GA28172@elie>
References: <BANLkTi=VwiqN99AMEJb6jb1uFya2Hipibw@mail.gmail.com>
 <20110421220327.GA3396@elie>
 <BANLkTikY7c7rP+yv5vt2vxw5nu84k_H=Xw@mail.gmail.com>
 <20110423101500.GB1500@elie>
 <BANLkTinV4cFC5vzr25V-D3PMwWx284zgoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 10:00:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEGij-0006Q7-Em
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 10:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756994Ab1DYIAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 04:00:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49251 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756650Ab1DYIAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 04:00:16 -0400
Received: by iwn34 with SMTP id 34so1686116iwn.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 01:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=e+18xR8kCqFBOSYB9v/dyB1V0pcQP5BOt7oduHpDCow=;
        b=Mw/XUtp79UyjCgW86HsU7b5wVQ/uTtgd970cuXHDAEd4qBc80nbOIzNiP0bOnM6g/r
         CO6HG+eimCcGOQbNbeNxavNpBT+WT8M2J0eobRJrpIamoWKbM8z7/HMg3qeBEeFpBIC2
         srGWvZfXW7nvfmU/+GRcT9aAGsDfJp7lhpdio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KjU27270XcDX3Baq3SVoF8IjF5IB2Juvu8IPxWLg5wyQ2M00brCLHOgCjyLYXdjJmg
         mj6yZjZSOLNtzj/z6Mf1ls8EAp5wTF+1pFZWyiNLDj7I0PjhfdF/lMbyjjvCgDLCCthW
         yvHbhgOMZyZw/FTzVFwYFJZzg97qpguLuDwi0=
Received: by 10.42.132.71 with SMTP id c7mr4630275ict.147.1303718415931;
        Mon, 25 Apr 2011 01:00:15 -0700 (PDT)
Received: from elie (adsl-68-255-96-190.dsl.chcgil.sbcglobal.net [68.255.96.190])
        by mx.google.com with ESMTPS id wu17sm1743021icb.23.2011.04.25.01.00.13
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Apr 2011 01:00:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinV4cFC5vzr25V-D3PMwWx284zgoQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172015>

Hi,

Richard Hartmann wrote:

> I think I reduced the test-case as much as I can

All right, sorry to be so dense.  I tried:

	git init test && cd test
	git remote add origin ~/src/some-repo
	git fetch origin

and then:

	$ git merge origin
	fatal: origin - not something we can merge

Is this what you mean?  "git merge" is not advertised as taking the
name of a remote repository as a parameter.  The usual usage is
instead to pass a commit, as in "git merge origin/master".

I'm not sure what a good meaning for "git merge <repository>" would
be.  "git pull <repository>" does "git fetch <repository>" and then,
if one of the fetched branches from <repository> is the configured
upstream for the current branch, merges it.

Ideas?  Probably the documentation or error message could use help
from someone less blind to see what a first-time reader would see.

Regards,
Jonathan
