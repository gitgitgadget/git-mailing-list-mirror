From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git-pull and tag objects
Date: Fri, 9 Feb 2007 10:33:46 +0100
Message-ID: <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
References: <1170933407.15431.38.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Bennee" <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 10:34:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFS91-00052h-J1
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 10:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946247AbXBIJeM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 04:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946264AbXBIJeM
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 04:34:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:32580 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946247AbXBIJeK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 04:34:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so714500uga
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 01:34:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DNsUs+ydbydANqdwCZIH0AaKIgO3IM2D0pW7RwyIb126JPRPkV9G7KB9LmZm0Y2DZBMdihgu4EXSXmpaAI4mVeeqBsd26gBPkQlaJVNfI/0wLeH4BO4UrcJxHMBp975rJgMVwWExNMYAOzeoON4mK8zmLL1NDAft/ZPcvl1QzTY=
Received: by 10.78.138.14 with SMTP id l14mr17867hud.1171013626207;
        Fri, 09 Feb 2007 01:33:46 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Fri, 9 Feb 2007 01:33:46 -0800 (PST)
In-Reply-To: <1170933407.15431.38.camel@okra.transitives.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39169>

On 2/8/07, Alex Bennee <kernel-hacker@bennee.com> wrote:
> I have slave repositaries which are cloned of the baseline which I do my
> development in. However when I bring the master branch of these work
> repositaries upto date (via git-pull ../baseline master) I find the tag
> objects are lost. Should they not be part of the tree? After all when I
> sync to Linus's kernel repo I get all his version tags as part of that.

You have to use "git pull ../baseline master:somewhere".
This "master:somewhere" expression makes git fetch and stores
the tags along with the branch' commits. Better yet, create an
entry in remotes: .git/remotes or .git/config, depending on the version
of git you have. The current master on kernel.org has the support
for latter (branches in .git/config), which will also be in the upcoming
release 1.5.
