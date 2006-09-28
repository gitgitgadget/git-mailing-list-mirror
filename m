From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on Using Git with Subprojects
Date: Thu, 28 Sep 2006 13:30:39 -0700
Message-ID: <451C30EF.8050305@gmail.com>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <451AADC3.40201@gmail.com> <20060928073706.GE8056@admingilde.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 22:30:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT2Wv-0002eo-JK
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 22:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWI1Uaq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 16:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWI1Uaq
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 16:30:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:45454 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750756AbWI1Uap (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 16:30:45 -0400
Received: by nf-out-0910.google.com with SMTP id o25so823177nfa
        for <git@vger.kernel.org>; Thu, 28 Sep 2006 13:30:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=EomZ2Nbuu+Z0oIPf20sSFbZTXFPIcr4xcrlPZTjxl5bN573YeH5VUcYYCCQif+9iLDSP0+LxxvB39KmtJzW6D5FM7bDUGNnFTM/jWi8JZLP81PljjLEpXMniaF1d9gjqL3BkksqHw6YzixFvxz4SuoIf4ZB46YkadGjgd6ybu08=
Received: by 10.49.8.15 with SMTP id l15mr572536nfi;
        Thu, 28 Sep 2006 13:30:43 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.67.46])
        by mx.gmail.com with ESMTP id b1sm6220040nfe.2006.09.28.13.30.41;
        Thu, 28 Sep 2006 13:30:43 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060928073706.GE8056@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28046>

Martin Waitz wrote:
> On Wed, Sep 27, 2006 at 09:58:43AM -0700, A Large Angry SCM wrote:
>> This means that modules are not separate, stand alone projects but, 
>> rather, just a sub part of your bigger project. Very useful and 
>> applicable in some situations but other situations want/need separate, 
>> stand alone subprojects.
> 
> you can do everything with the submodule which would be possible with
> a normal GIT repository.  And you can always clone it into an directory
> which is not controlled by a parent project.
> 
> I really think that this is an very important property of a submodule.

I must be missing something.

I just read you original message in the (sub)thread again and you said:

	 * the .git/refs/heads directory of the submodule gets stored in
	   .gitmodule/<modulename> inside the parent project

If the submodule refs in the parent are a _copy_, then work performed in 
the submodule outside of the parent will be lost when the parent is in 
control of the submodule again.

If the submodule refs in the parent are the actual submodule refs then 
the submodule is not independent of the parent.

If the submodule refs in the parent are a symlink to the refs in the 
submodule, then the parent has no control over which version of the 
submodule it gets on the next checkout since the submodule can update 
the ref.

[...]
> One use-case which may be important here:
> 
> The submodule has two different branches which got forked and are not
> intended to be merged again.  At some point in time the parent project
> wants to switch from one branch of the submodule to another branch.
> If a user still has modifications in the old branch and wants to
> update the parent project then it is important to know if the local
> modifications and those coming from the parent have to be merged or
> should stay in different branches.
> If the parent is switching branches there should only be some warning
> if the user still has modifications in the old branch, giving him the
> chance to port the modifications to the other branch.

Again, this is leading me to believe that the submodule is not 
independent of the parent.
