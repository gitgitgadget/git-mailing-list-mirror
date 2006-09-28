From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 21:48:47 -0700
Message-ID: <451B542F.8060205@gmail.com>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de> <451AB122.9020600@gmail.com> <Pine.LNX.4.63.0609280113490.14200@wbgn013.biozentrum.uni-wuerzburg.de> <20060927233639.GE21839@spearce.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Waitz <tali@admingilde.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 06:49:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSnpP-0006Oa-Qm
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 06:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWI1Esx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 00:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWI1Esx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 00:48:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:7962 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751451AbWI1Esw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 00:48:52 -0400
Received: by wx-out-0506.google.com with SMTP id s14so451715wxc
        for <git@vger.kernel.org>; Wed, 27 Sep 2006 21:48:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ETQ2g2VQYcY/jdgj7wSSc6gXsgqrcusu4l0FX2ctWl/GzDCvLDtxI9TmMdPIheC/4jg47dKXcMwidAeUL87RcIQ8ey535FDlBPdWQI8UALl1DZkLSxH6zh4UINTTIVCYpWW59Jbp9gp6EKmZdx0kJfMf/vOli9HG/g6n0UG/t24=
Received: by 10.70.37.12 with SMTP id k12mr2109114wxk;
        Wed, 27 Sep 2006 21:48:51 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.67.46])
        by mx.gmail.com with ESMTP id h10sm1830586wxd.2006.09.27.21.48.49;
        Wed, 27 Sep 2006 21:48:51 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060927233639.GE21839@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27986>

Shawn Pearce wrote:
[...]
>  - Git Porcelain should help the user.
> 
>    Git operations should translate down through lower level projects
>    when possible, and lower level project changes should push up
>    when possible.
> 
>    E.g. git-fetch in a higher level repository should percolate
>    down into the lower level repositories automatically.  Ditto with
>    git-checkout and probably git-push.  git-commit in a lower level
>    repository probably should update the specification file(s)
>    in the higher level repository but not commit the higher level
>    repository.

I think recursing through all subprojects for most Git commands is 
actually the exception. Plus, porcelains aren't going to help much past 
the first subproject that isn't Git managed.

[...]

> However an annoted tag probably should not be able to be created
> on the higher level project unless all lower-level subprojects
> are referenced by tags (or the equivilant) in their SCM.  Which
> implies using a "stable tag" in CVS, a "/tags/foo@rev" in SVN,
> or an annotated tag in Git and updating the specification file(s)
> to reflect that.

I fail to see a reason for this restriction. Each project should be 
managed separately. Also, how do you enforce the restriction on other VCSs?
