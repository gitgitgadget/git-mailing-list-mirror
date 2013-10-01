From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: Git counterpart to SVN bugtraq properties?
Date: Tue, 01 Oct 2013 14:24:18 +0200
Message-ID: <524ABEF2.1060008@syntevo.com>
References: <51E69612.6020201@syntevo.com> <20130717133357.GB2337@serenity.lan> <5249ACCB.5090007@syntevo.com> <20130930185513.GS9464@google.com> <CACXt3y82u3KtR7cq5Kyb1PDi1aq7095uO2-eGQTLq0yDuNZ73Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: James Sharpe <mail@jsharpe.net>
X-From: git-owner@vger.kernel.org Tue Oct 01 14:24:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQz0L-0007Pn-5j
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 14:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861Ab3JAMYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 08:24:25 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:47790 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab3JAMYY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 08:24:24 -0400
Received: from [217.91.110.92] (helo=[192.168.93.201])
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1VQz01-0004IE-Kx; Tue, 01 Oct 2013 14:24:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CACXt3y82u3KtR7cq5Kyb1PDi1aq7095uO2-eGQTLq0yDuNZ73Q@mail.gmail.com>
X-Enigmail-Version: 1.5.2
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235657>

On 30.09.2013 21:42, James Sharpe wrote:
> You could also use git notes to store the information. The advantage
> there is they can be added to commits without changing the history.
> Gerrit and jenkins can auto generate this sort of metadata via plugins.

git notes could be the preferred storage for issues IDs when the client
wants to add this kind of meta information on Commit. This would
actually solve one weak point of SVN bugtraq properties where you can
just specify to prepend or append an issue ID to the commit message
(i.e. silently altering the commit message).

-Marc


> 
> On 30 Sep 2013 20:02, "Jonathan Nieder" <jrnieder@gmail.com
> <mailto:jrnieder@gmail.com>> wrote:
> 
>     Hi,
> 
>     Marc Strapetz wrote:
>     >> On Wed, Jul 17, 2013 at 03:03:14PM +0200, Marc Strapetz wrote:
> 
>     >>> I'm looking for a specification or guidelines on how a Git
>     client should
>     >>> integrate with bug tracking systems.
>     [...]
>     > Finally, I've created a minimal spec which is sufficient to parse and
>     > display issue IDs:
>     >
>     > https://github.com/mstrap/bugtraq/blob/master/specification.txt
> 
>     Neat. :)
> 
>     It reminds me a little of Gerrit's commentlink functionality, though
>     that tries to solve a different / more generic problem (automatic
>     linking in commit messages in general, not just to bug trackers):
>     https://gerrit-review.googlesource.com/Documentation/config-gerrit.html#_a_id_commentlink_a_section_commentlink
> 
>     Some projects use more than one bug tracker.  For example, a distro
>     might have its own bug tracking system and also sometimes make commits
>     that refer to the upstream bug tracker.  I don't think that's
>     important to necessarily address in the first version of a project
>     like this, but thought I should mention it to help plans for the
>     future.
> 
>     Gerrit keeps its configuration in a file named "project.config" in the
>     tree associated to the refs/meta/config commit so a single
>     configuration can be applied to the entire repository.  Which
>     .gitbugtraq file should take effect in a repository with multiple
>     branches?
> 
>     Hope that helps,
>     Jonathan
>     --
>     To unsubscribe from this list: send the line "unsubscribe git" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
