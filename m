From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 09:04:53 +0000
Message-ID: <200701190904.58515.andyparkins@gmail.com>
References: <87r6trsu7n.wl@mail2.atmark-techno.com> <200701190727.26505.andyparkins@gmail.com> <7vfya7ju1l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 10:08:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7pj5-0001V9-8U
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 10:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbXASJH4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 04:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbXASJH4
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 04:07:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:12413 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964996AbXASJHy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 04:07:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so406423uga
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 01:07:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fwAFN2lb38CE107x9VoF9oP11NblNeaU4GqBe9dyGvYssunnXa9SLGz54wGelRcdH4svk1TeA9doB8+v2xGrgyeXUyYrE89lVDIIUzSTDUXr08ha8ktjHSikatacCIcrId+I9YB+UuA453B42s8PNC88bueHXTPsWL6X+FSGibQ=
Received: by 10.67.20.3 with SMTP id x3mr2684626ugi.1169197673461;
        Fri, 19 Jan 2007 01:07:53 -0800 (PST)
Received: from ?192.168.1.48? ( [84.201.153.164])
        by mx.google.com with ESMTP id k28sm2258579ugd.2007.01.19.01.07.52;
        Fri, 19 Jan 2007 01:07:52 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.5
In-Reply-To: <7vfya7ju1l.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37165>

On Friday 2007, January 19 08:32, Junio C Hamano wrote:

> Have you actually read the code to see what 'share' variable
> means there?  It is only false when creating the toplevel .git

Nope.  I'm an idiot :-) I assumed it was from the --shared command line 
argument.  What they say about assumptions is true isn't it?

> Nothing unusual.  The code explicitly asks for .git/config by
> name, so that does not involve readdir(".git"), which is what
> the 0333 change prevents from running.

In this case I was talking more about the user editing those files than the 
code looking for them.  I suppose if you know its there then a 
vim .git/config will be fine.

> > On ocassion I've found myself doing
> >   mv .git/refs/remotes/origin .git/refs/remotes/up
> >
> > Which this patch would break.
>
> Does it?

You're right it doesn't.  As long as you know the refs directory is there it 
doesn't stop you changing into it, and messing about in any way you want.  I 
was looking at it from the point of view of how I originally found out about 
these git inner workings - I did it by poking around in the .git directory.

> You all should not take "amusing" too seriously.  That was a
> tongue-in-cheek patch.

Fair enough.  I took it more as meaning,  "this would fix this problem /and/ 
it's funny too".  Apologies.

> In other words, I am not sure if there is anything worth fixing.

After a bit of thought; I think I agree.


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
