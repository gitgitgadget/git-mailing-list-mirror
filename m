From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: svn:externals using git submodules
Date: Tue, 1 May 2007 19:36:11 +0100
Message-ID: <200705011936.14345.andyparkins@gmail.com>
References: <200705011121.17172.andyparkins@gmail.com> <20070501152228.GF5942@spearce.org> <20070501153626.GA21182@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Chris Shoemaker <c.shoemaker@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 20:36:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HixDG-0003kW-8b
	for gcvg-git@gmane.org; Tue, 01 May 2007 20:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031265AbXEASg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 14:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031267AbXEASg3
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 14:36:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:47294 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031265AbXEASg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 14:36:28 -0400
Received: by ug-out-1314.google.com with SMTP id 44so103534uga
        for <git@vger.kernel.org>; Tue, 01 May 2007 11:36:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=T+GewJLh0f4cxELwS5Dhy5BNQXJ698eE/hi2tU6CUQFEZxZ/hEnAocNZuHmLXVLvWq8O7bCQiNOdA48ij/PYV6hJd37UZoNkuSB49AejUIHIC49FILbM3p2NTzHj70tSnx4t5VxhVQ3XCF3F3/jUmHotHbn1G2/Ijr9gkW0Wwoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=D6erJEekwbIqlC/XZYwpDgwoNm13fSPM+2vq8hQ7lyraqkIN1PC9IkwUdPiOytLe8YOQh9+UGaROhpJXhikSTnymicbopn28XV7WV4A2lsQ3r/cPkJfi6kYMbT/VVGLnqv3wIECeLeRAcPBMFcU9YS+cz28oPHs1o6vPjyIEoJI=
Received: by 10.66.237.9 with SMTP id k9mr475480ugh.1178044586869;
        Tue, 01 May 2007 11:36:26 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id 54sm1283820ugp.2007.05.01.11.36.25;
        Tue, 01 May 2007 11:36:25 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <20070501153626.GA21182@pe.Belkin>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45968>

On Tuesday 2007, May 01, Chris Shoemaker wrote:

> > Actually that is an interesting point that Chris makes.  Isn't the
> > svn:externals property revision controlled on the parent directory?
> > So each change to it is actually recorded in the revision history
> > of the parent project.
>
> Yes and yes.

Yes and no.  Think of svn:externals as a file in the parent repository; 
it contains

 directory-name URL

Now, changes to that file _are_ tracked, in that if I changed the URL 
that change would be recorded in the parent repository.  However, 
nowhere is the revision of the external recorded.  Subversion always 
fetches the latest revision at that URL.

> > And if every svn:externals URL included the
> > exact version of the other project to include, aren't svn:externals
> > then more-or-less like the subproject link support, except they
> > also include the URL?
>
> Just to clarify, my point was just that Andy's setup seems to assume
> that the externals don't specify a revision.  If they do, maybe

They don't.  If they did, they'd be just as useful as git's submodules.

> git-svn can map the externals into subprojects.  Is this what
> you're thinking?

Well, I'm thinking that that information /can/ be reconstructed from the 
revision date information - kind of - the problem is that there is no 
way to know when the parent updated the module.   svn:externals really 
is just a quick way of doing
 $ cd submodule
 $ svn update
That's it.  That's all you get.  We could guess that when the parent 
module was at date YYYY-MM-DD, that the submodule would be at that same 
date - but who knows?



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
