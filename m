From: Avi Kivity <avi@redhat.com>
Subject: Re: Symbolic refs and the git protocol?
Date: Mon, 26 Sep 2011 17:49:09 +0300
Message-ID: <4E8090E5.4030809@redhat.com>
References: <4E7F29EB.8000800@redhat.com> <CAMK1S_joYUKPXDKyomFdbDP4H0UhcwtNQbC89gvNZOTHowYrLw@mail.gmail.com> <4E7F313A.2050103@redhat.com> <CAMK1S_g1Co8vogBuObQVsr+nT09urYs+qifJn1X+eGrkgUQZCA@mail.gmail.com> <CAMK1S_gfw4WUdhdCzFMNbJXJP7762tp62fpmQ_-qJLwvD1hR-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	John Hawley <warthog19@gmail.com>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 16:49:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8CUg-0005yz-9h
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 16:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257Ab1IZOtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 10:49:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21844 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965Ab1IZOtN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 10:49:13 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8QEnBwP026539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 26 Sep 2011 10:49:12 -0400
Received: from balrog.usersys.redhat.com (dhcp-1-24.tlv.redhat.com [10.35.1.24])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p8QEnAiI022959;
	Mon, 26 Sep 2011 10:49:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <CAMK1S_gfw4WUdhdCzFMNbJXJP7762tp62fpmQ_-qJLwvD1hR-A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182117>

On 09/26/2011 05:23 PM, Sitaram Chamarty wrote:
> On Sun, Sep 25, 2011 at 7:40 PM, Sitaram Chamarty<sitaramc@gmail.com>  wrote:
> >  On Sun, Sep 25, 2011 at 7:18 PM, Avi Kivity<avi@redhat.com>  wrote:
> >>  On 09/25/2011 04:42 PM, Sitaram Chamarty wrote:
> >>>
> >>>  On Sun, Sep 25, 2011 at 6:47 PM, Avi Kivity<avi@redhat.com>    wrote:
> >>>  >    With the old kernel.org setup, practically the only think I needed to
> >>>  >  do on
> >>>  >    the server itself is the 'git symbolic-ref' command (used to point
> >>>  >    refs/heads/linux-next at the correct stream).
> >>>  >
> >>>  >    Now it looks like kernel.org will no longer offer shell access.  Is it
> >>>  >    possible to support symbolic-ref via 'git push'?
> >>>
> >>>  Can I assume you mean specifically for HEAD, as in 'git symbolic-ref
> >>>  HEAD refs/heads/some-branch'?
> >>
> >>  No, I use them for ordinary branches, for example
> >>
> >>    git symbolic-ref refs/heads/linux-next refs/heads/kvm-updates/3.2
> >>
> >>  from this point on, any update to kvm-updates/3.2 will be reflected in the
> >>  linux-next ref.
> >>
> >>>  Although gitolite disables shell access by design, it provides several
> >>>  (optionally installed) features to allow specific shell commands to be
> >>>  executed.  One such command is "set-head", which does exactly what you
> >>>  ask.  You run it like 'ssh git@server set-head reponame.git
> >>>  refs/heads/foo' and it ends up running 'git symbolic-ref HEAD
> >>>  refs/heads/foo' in the repo.
> >>>
> >>>  I realise that does not answer "can it be done via git push" but I
> >>>  thought it might help...
> >>
> >>  Well, if set-head can be extended a bit, it would suit me perfectly.
> >
> >  no reason it can't; shorn of all the argument/access checking, it's a
> >  very simple shell script
>
> Done.
>
> https://github.com/sitaramc/gitolite/commit/a2fd597c51a086a0f7298c1641337faa0f296a62
>
> I like this much better actually, so thanks for the idea.

Thanks very much for the rapid response and update!

John, can we get this into the new kernel.org infrastructure?

-- 
error compiling committee.c: too many arguments to function
