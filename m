From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Document clone of clone loosing branches?
Date: Sun, 15 Jun 2008 01:03:01 +0200
Message-ID: <200806150103.02260.jnareb@gmail.com>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz> <4853D967.5080903@gmail.com> <20080614.233645.71097102.hanzl@noel.feld.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: lewiemann@gmail.com, peff@peff.net, git@vger.kernel.org
To: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>
X-From: git-owner@vger.kernel.org Sun Jun 15 01:04:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7en3-00054P-Ld
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 01:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509AbYFNXDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 19:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755527AbYFNXDP
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 19:03:15 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:4515 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755507AbYFNXDO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 19:03:14 -0400
Received: by ik-out-1112.google.com with SMTP id c28so3524657ika.5
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 16:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8dKYje85Nuz4dfjeTmQGdh8oNtvVuDsqIY0OwLSJzjo=;
        b=MgnGJQqtooaHOpkqlWZs9PKELWnf18lFcH2pVGXq6X8/LX5chI2tvNyf8zcjDfvAgw
         +q9ILA1Yg/KUHLckWsy7cn1DwyN6hLLDAvz8i80Xp1xgow624DL4qU8Fo7ut9VaQihGb
         IMHLDB4XO3swQDOXHxCeRIaVIYeP3MWwcmXd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=r/m5dhSXcFGXWwFr9fpjckYjkZjrZ3BjvsrFdV+E94RdVLjWctnVeaSVYIjb9jjm6I
         F6KPe5RETLUdB8EkWdMHDDynBi23NHhHxE/opFCOQNXY9/vegX+xVXoSfkogfJ1XsSit
         p72BmeLfJDhIwI8zW9l7eJFHSOr1XhxlJHJFc=
Received: by 10.210.80.2 with SMTP id d2mr4458921ebb.7.1213484590281;
        Sat, 14 Jun 2008 16:03:10 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.239.84])
        by mx.google.com with ESMTPS id y37sm6080665iky.8.2008.06.14.16.03.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 16:03:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080614.233645.71097102.hanzl@noel.feld.cvut.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85051>

Vaclav Hanzl wrote:
> Jakub Narebski wrote:
>>
>> The idea is for git-clone to clone (by default) _your_ work, not sb
>> else work.  Think about two repositories, fetching from each other:
>> you don't want for branches to proliferate like mad, remote of remote,
>> then remote of remote of remote, and ad infinitum.
>> 
>> Besides there is I think implicit assumption that public repositories
>> one might want to clone are _bare_ repositories, 1:1 or mirror
>> refspecs, which simply do not contain remote tracking branches. 
> 
> Yes. It would be no shame if an explanation like this made it to 'man
> clone'?

The question of course is _what_ to put into git-clone(1), what to
generic documentation in git(1), and what in "Git User's Manual".

> After all, how many other commands do distinguish regular branches and
> remote tracking branches?

Errr... many of them? git-branch treats regular branches (refs/heads/*)
and remote-tracking branches (refs/remotes/<remotename>/*) differently
(compare "git branch" and "git branch -r", and "git branch -a").
git-checkout treats regular branches (can checkout) different from
other refs, including remote-tracking branches (result in detached
HEAD).

> Even if there are any other (I do not know), 
> git-clone is likely the most prominent of them and 'man git-clone' is
> quite good place to document this. Unless it is explained in 'man git'
> itself (I think it is not now).

I'm not sure how it is put in documentation, but I wouldn't wonder
if it is not dicumented, because most of gitters who can write this
documentation do know the difference between regular branches and
remote-tracking branches, and know recoomended workflows and best
practices.
 
> (Thought I am quite happy with UNIX tradition of very exact and very
> condensed man pages, up to the point of being a hard puzzle, and I
> agree that man pages are no tutorial, in this case I would be happy to
> see 'regular branches' and 'remote tracking branches' clearly
> distinguished in 'man git-clone' itself, without an implicit reference
> to 'usual' meaning of words among geeks.)

So, what should be mentioned ar two facts, I think.  (a) that git-clone
copies only regular branches and tags; it does not copy remote-tracking
branches, it does not copy stash, it does not copy reflogs, it does not
copy StGIT stacks...  (b) that recommended workflow (best practice) is
to have public published repository which is bare clone
(1:1 correspondnce) of interesting subset of refs.

-- 
Jakub Narebski
Poland
