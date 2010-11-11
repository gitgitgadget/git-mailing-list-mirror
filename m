From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to recover a lost commit...
Date: Thu, 11 Nov 2010 10:50:23 -0600
Message-ID: <20101111165023.GB16972@burratino>
References: <AANLkTinfYTMKicr3V=T=scVpOte_XrmaDgVA_oMj2fYU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 17:50:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGaMQ-0001Bk-L1
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 17:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab0KKQur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 11:50:47 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49453 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab0KKQuq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 11:50:46 -0500
Received: by qyk30 with SMTP id 30so902299qyk.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 08:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SFQie6aJMLCzbNAWHmixbx6s1YVdPCBio8ykXPWLT7M=;
        b=hnm5MW5a+0LTqJt9ry/k5pFWrpKPaaL8i+6+5urRl5pzrPnTGudr9zkViKQwooox1W
         6HrKYKRzAtqXO1f5/bZ+dB3dzUVvHHV7nyjU649wy9VvkKUlVj55yxEho2czji0a7EoT
         vBp0oOlKOnbmuExuSgOiM+hnctC0oAxTEcihE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sWhqqeExeJip+w/6p4KO7Pn738r+jCKjib8d3lQu0Ed7IEdZ+IbfNdl0naDZQxVeTq
         8UvoRSF2LHhP3y4fTH8JpB1dZvrKyxyZK6bNfmr+xoKKS4jcQAFGBf01pZTOu1Ss8dAh
         0RwEiif6nSdoHHscCRFztsp2E3n0NUbWvRxGY=
Received: by 10.229.214.73 with SMTP id gz9mr931116qcb.226.1289494245986;
        Thu, 11 Nov 2010 08:50:45 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id l14sm2064418qck.17.2010.11.11.08.50.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 08:50:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinfYTMKicr3V=T=scVpOte_XrmaDgVA_oMj2fYU@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161270>

Patrick Doyle wrote:

> But I'm curious... given the reflog show below... can any of you tell
> what I did to myself to shoot myself in the foot?  Aside from "use git
> stash next time dummy", is there any way I could have avoided this?

I don't know. :)  But if you still have the svn_to_git_wip branch,
you might want to try

	$ git log -g svn_to_git_wip

which just shows the history of that branch.

> Today I want to pick up where I left off with the work-in-progress (on
> the "svn_to_git_wip" branch).  What I _really_ wanted to do was to
> grab the contents of that branch, dump them into my working directory
> for the master branch, and continue as if nothing had happened.  (This
> is exactly the use case for which git-stash was created, and I
> probably should have used that to begin with.)

Couldn't

	$ git cherry-pick --no-commit svn_to_git_wip
	$ git reset

or something like

	$ git merge --no-commit svn_to_git_wip
	$ git reset

have worked?

Hope that helps,
Jonathan
