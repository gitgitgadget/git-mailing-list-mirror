From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] gitk: Add ability to define an alternate temporary
 directory
Date: Tue, 10 Nov 2009 20:07:16 -0800
Message-ID: <20091111040715.GA44672@gmail.com>
References: <1257904149-44381-1-git-send-email-davvid@gmail.com>
 <4AFA368F.207@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: paulus@samba.org, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 05:07:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N84UY-0007Mp-Fo
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 05:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbZKKEHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 23:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbZKKEHU
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 23:07:20 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:49590 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbZKKEHR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 23:07:17 -0500
Received: by gxk26 with SMTP id 26so708020gxk.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 20:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=w9KAu3g467GdqZfnqbHHOgf89/VXvtUIH53bGGsyP10=;
        b=DQ+w1xMF/HHvL8Zk3MjybCzLWv9hDWwGMWghE2k2vH0NzPVWO5tZEq4AOWQStGHjbR
         jr93grT8IQ0uW1SZLswNm0+IFd/ytO70hqwyiLIMqucbyRbY2dACeFAFsDRtF6u1dfUZ
         RNtVf+4L3bARi8uAAofQOr8NrD2B5kdTMepXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MkVROs6bO4f+TWjQn7oCNe8jh7mrC5RxsdlngK/107xaEKk3PQoRb4n7D+D6Us+C4V
         Mn18A30lNMohktQ047J0xO9K/7K+IFkAMHQQayue3O1rqBJiwKaxS15CHABJS6sPKmf6
         1Xq+7sc2EEPE007JZ/6kiQa7Z8J9RZiwUn8eU=
Received: by 10.151.29.20 with SMTP id g20mr1779705ybj.189.1257912442268;
        Tue, 10 Nov 2009 20:07:22 -0800 (PST)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id 22sm539249ywh.0.2009.11.10.20.07.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 20:07:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4AFA368F.207@vilain.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132614>

On Wed, Nov 11, 2009 at 04:59:11PM +1300, Sam Vilain wrote:
> David Aguilar wrote:
> > gitk fails to show diffs when browsing a repository for which
> > we have read-only access.  This is due to gitk's assumption
> > that the current directory is always writable.
> >
> > This teaches gitk to honor the GITK_TMPDIR environment
> > variable.  This allows users to override the default location
> > used for writing temporary files.
> >   
> 
> Is there a good reason not to use the common TMPDIR or TMP environment
> variables for this?

I, personally, would not be opposed to that.
The only reason I chose a different variable was that I didn't
want to change the existing behavior (backwards-compat hat on).

Since TMPDIR and TMP are common then we'd be changing the
behavior.

That said, if there's a consensus that the path doesn't matter
much than we could change the behavior.  I was just trying to be
careful.

-- 
		David
