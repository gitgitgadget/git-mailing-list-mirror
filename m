From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 22:02:59 -0700
Message-ID: <451B5783.5080107@gmail.com>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de> <451AB122.9020600@gmail.com> <Pine.LNX.4.63.0609280113490.14200@wbgn013.biozentrum.uni-wuerzburg.de> <20060927233639.GE21839@spearce.org> <451B0F59.6070901@dawes.za.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Martin Waitz <tali@admingilde.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 07:03:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSo3G-0008OI-RI
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 07:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWI1FDH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 01:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWI1FDH
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 01:03:07 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:37142 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751578AbWI1FDD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 01:03:03 -0400
Received: by nz-out-0102.google.com with SMTP id n1so190182nzf
        for <git@vger.kernel.org>; Wed, 27 Sep 2006 22:03:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=G45I0U3QEE52Sqp+CkrrDIVgPGBl3PgfL7DcgsdefWSeqUotikZd4/a/uv6SdYK1slFloQCEOegUJlgmQXfZW8t+LJhDHBiICVZsLHjDE32HBvoE7ruHR6+ro8T+NtpgGLAPphAM3zQHbQqhvDaHI2eIBKfQfA2kiHveqko8BEs=
Received: by 10.64.199.8 with SMTP id w8mr1233798qbf;
        Wed, 27 Sep 2006 22:03:03 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.67.46])
        by mx.gmail.com with ESMTP id f15sm1673577qba.2006.09.27.22.03.01;
        Wed, 27 Sep 2006 22:03:02 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Rogan Dawes <lists@dawes.za.net>
In-Reply-To: <451B0F59.6070901@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27990>

Rogan Dawes wrote:
[...]
> Does it not make sense that a commit of the higher level project should 
> include the contents of its subprojects at that particular moment in time?
> 
> e.g. using the previous example of a kernel, apache, glibc, etc
> 
> You may track the subprojects using whatever scm applies to THAT 
> subproject. But when you want to record the state of the entire project, 
> you want to include the state of the subprojects. So, your super-project 
> commit would actually recurse down into the working directories of the 
> subprojects and record the state/contents of each file that makes up 
> each of the subprojects.
> 
> So, if someone is tracking the overall project, and they do a pull of 
> v1.1 (tag), they will see exactly what v1.1 looked like in your repo.
> 
> What this makes me think is that it might be useful to have a mechanism 
> for recalculating the tree-ish of a subdirectory and finding an 
> associated commit, for the case where a subproject is also managed by git.
> 
> i.e. given a super-project in this state, and knowing that this 
> subproject is managed by git, which revision of the subproject are we 
> talking about, and can we find a commit that matches this tree-ish? 
> (assuming we have the history of the subproject available, of course)

Some development environments will require that all the (used) code is 
imported into the local VCS of choice. But not all environments. For 
some development environments, recording the version of the subproject 
is sufficient. Assuming it's possible at some future time to get the 
state associated with the version.

Also keep in mind, to effectively participate in a project, you will 
likely need to use the VCS of the project. So importing everything into 
another VCS (Git) will just cause _you_ more work.
