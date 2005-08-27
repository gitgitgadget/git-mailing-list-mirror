From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Merges without bases
Date: Sat, 27 Aug 2005 18:48:53 +1200
Message-ID: <46a038f90508262348b25d1c8@mail.gmail.com>
References: <1125004228.4110.20.camel@localhost.localdomain>
	 <7vvf1tps9v.fsf@assigned-by-dhcp.cox.net>
	 <46a038f905082602176f9eef5d@mail.gmail.com>
	 <Pine.LNX.4.63.0508261150320.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Darrin Thompson <darrint@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 08:50:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8uVJ-0004HT-Rv
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 08:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbVH0Gsz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 02:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbVH0Gsy
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 02:48:54 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:43283 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030328AbVH0Gsy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2005 02:48:54 -0400
Received: by rproxy.gmail.com with SMTP id i8so699297rne
        for <git@vger.kernel.org>; Fri, 26 Aug 2005 23:48:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nq0E6gQKo/wkFVpcfkJX8RcJrOFHD1jMP0ELEx7+7hHATuq7prQtpZY1xM8CE3bsk9gL0ERRroWBRxkq7jN8qwEEU3h/tz8tpsgBezZulu9qZidGTUAwVmmo7ZU+zAbAEZaj6BclfoQj626KBFOD/yg8AyGj9/ZSIrWb3bPOlHs=
Received: by 10.39.2.45 with SMTP id e45mr1349836rni;
        Fri, 26 Aug 2005 23:48:53 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Fri, 26 Aug 2005 23:48:53 -0700 (PDT)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508261150320.23242@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7842>

On 8/27/05, Daniel Barkalow <barkalow@iabervon.org> wrote:
> The problem with both of these (and doing it in the build system) is that,
> when a project includes another project, you generally don't want whatever
> revision of the included project happens to be the latest; you want the
> revision of the included project that the revision of the including
> project you're looking at matches. That is, if App includes Lib, and

Exactly - so you do it on a tag, or a commit date with cvs. With Arch,
GIT and others that have a stable id for each commit, you can use that
or the more user-friendly tags.

The project pulling the libs has the makefile, and the makefile says
'pull library-foo revision xxx'. If a later revision yyy is known to
work well, you update the makefile and commit it. Perfectly version
controlled, no need for special purpose machinery ;)

The good thing here is that a makefile will know how to handle the
situation if the external lib is hosted in Arch, in SVN, or Visual
SourceSafe. If your external lib is only available as a tarball in a
url, you can fetch that and uncompress it too. Arch configurations are
_cute_ but useless in any but the most narrow cases.

I want my SCM to be a good SCM, but this kind of interop is better
left to general purpose languages. Letting the build system do it
seems to be 'best-practice' and the right thing to do.

cheers,


martin
