From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Tue, 23 May 2006 11:23:06 +1200
Message-ID: <46a038f90605221623g25325e71hf3faf0a6a6ca628a@mail.gmail.com>
References: <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
	 <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>
	 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
	 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>
	 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
	 <44720C66.6040304@gentoo.org>
	 <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
	 <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
	 <20060522214128.GE16677@kiste.smurf.noris.de>
	 <Pine.LNX.4.64.0605221516500.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Matthias Urlichs" <smurf@smurf.noris.de>,
	"Donnie Berkholz" <spyderous@gentoo.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 23 01:23:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiJjz-0003Mt-UO
	for gcvg-git@gmane.org; Tue, 23 May 2006 01:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWEVXXI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 19:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWEVXXI
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 19:23:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:23372 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751298AbWEVXXH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 19:23:07 -0400
Received: by wr-out-0506.google.com with SMTP id 50so730940wri
        for <git@vger.kernel.org>; Mon, 22 May 2006 16:23:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X23UsAZXmRXEKyKJHGeYXWtdwvsm/ALiPBY783rXHNf1QvcmbJE5rM+Tz/EqHbIbuKYhqLZ7N4twnM/R5JABlhpIbP4ZXsDSZgOBp3JoK42OLoCsZOvaRlRaYE5YcXsmbEdJPmTUotFIvJzpPE+WHtQMIOCyJgjJHkFLU+g24MA=
Received: by 10.54.101.13 with SMTP id y13mr5349371wrb;
        Mon, 22 May 2006 16:23:07 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Mon, 22 May 2006 16:23:06 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605221516500.3697@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20551>

On 5/23/06, Linus Torvalds <torvalds@osdl.org> wrote:
> I don't think the remote usability is valid, except for some really small
> repositories. The fact that it takes hours even when the CVS server is
> local doesn't bode well for doing it remotely for any but the most trivial
> things.

I really don't think that using the local cvs binary is a problem at
all. In my experience, the thing is fairly fast and optimized when you
ask it to perform file-oriented questions and that's all we do,
really.

If you want to try it, you'll see that local checkouts of large trees
(like this gentoo one) are fairly fast. Not as fast as GIT itself, but
good enough. I think Donnie has hit a bug with a bad version of cvs,
but other than that, my experience with it is that it is fairly well
behaved -- even if the tool is bad, ubiquity has lead to resiliency
over the years.

> I really think it would be better to have local use be the optimized case,
> with remote being the "it's _possible_" case.

Agreed, but I think we won't see much benefit in direct parsing. And
we'll have to take the hit of double-implementation.

In any case, we have it already -- parsecvs does it quite well (modulo
memory leaks!) and I've used it several times in conjunction with
cvsimport. Just perform the initial import with parsecvs and then
'track' the remote project with cvsimport.

The problem is that they lead to slightly different trees. So their
output is not consistent, and I don't think that'll be easy to fix.

cheers,


martin
