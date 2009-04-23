From: Deskin Miller <deskinm@gmail.com>
Subject: Re: [GIT-SVN] master follows not trunk
Date: Wed, 22 Apr 2009 22:56:27 -0700
Message-ID: <86d4c5e00904222256r157ca34ex8c56c671991e663c@mail.gmail.com>
References: <36ca99e90904220821u3dae67d7jcb6366d7a95dfbd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 07:58:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwrxM-000079-5J
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 07:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbZDWF43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 01:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752680AbZDWF43
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 01:56:29 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:31642 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbZDWF42 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 01:56:28 -0400
Received: by yw-out-2324.google.com with SMTP id 5so245449ywb.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 22:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IhhbrjIG5LS0vZccAmDSF16IeZoN5ZAZNy6XURuzAmY=;
        b=mrf4wLbHLDTC2QFBs+W5PUqdi0Ms+AcSmGcxR2qTQPRJuAikRcLiSS2+RQI3qM1Eph
         sEsNhdbOPzAm0GQ2+CTq892pKkdRYMdonpgfbmYVBveQMeLp64awcin9UeFJWm4I3sQ0
         0Zy1Ukw7AJ+kKbDq904pHMzvlv7phU48RR7Z4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wKMUENYgpF4mxpru5YEwPbFGPxpceLfafrEXv7MXeGbTO8xjCU1D8B09T9uSF5Iizv
         4ZNGOSI0T7zrOeYH/17X1+SAz2qR2/3loQSrcSLaETnj7lhAZfI+P7pB6I+i03JUGJHG
         FyfVWG8j0QrdJnGvpumAXII9WTOh6ASyCiNj0=
Received: by 10.151.125.8 with SMTP id c8mr9643ybn.171.1240466187286; Wed, 22 
	Apr 2009 22:56:27 -0700 (PDT)
In-Reply-To: <36ca99e90904220821u3dae67d7jcb6366d7a95dfbd1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117299>

On Wed, Apr 22, 2009 at 08:21, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> Hi,
>
> it seams so, that git-svn sets the master branch to that svn branch
> which has the highest revision!
>
> I cloned a svn repo today where exactly this happend. I.e. master
> pointed not to the trunk but to the branch with the highest revision.
> After trunk moved forward, a git svn rebase told me that master is up
> to date.
>
> A second clean clone of this repo and master pointed to trunk.
>
> Is this indented?

It's well-known, at any rate, and it's somewhat conceptually
consistent with git, which will use the remote's HEAD for its
currently-checked-out branch upon clone.

Consider also that although your svn repository is well-formed and has
trunk/ tags/ branches/, not all do; or, perhaps someone is interested
in only one branch, or put multiple svn-remote.svn.fetch lines in
.git/config before fetching.  Which svn branch should become master
then?

With that said, you're not the first person to be surprised by this;
I'm sure you could patch git svn to tell you which svn branch it was
checking out.  It'd probably be a pretty simple tweak, but
unfortunately I'm not in a position to do it currently.

Deskin Miller
