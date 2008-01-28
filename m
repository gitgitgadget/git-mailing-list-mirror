From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Configuration overrides via environment variable
Date: Mon, 28 Jan 2008 14:58:39 -0800 (PST)
Message-ID: <m3tzkx8smg.fsf@localhost.localdomain>
References: <ee77f5c20801271708k124dc9d7n942b3c95299cb7fb@mail.gmail.com>
	<20080128205837.GB5788@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Jan 28 23:59:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJcwd-0000lN-6t
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 23:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbYA1W6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 17:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752706AbYA1W6o
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 17:58:44 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:33040 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbYA1W6n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 17:58:43 -0500
Received: by nf-out-0910.google.com with SMTP id g13so190196nfb.21
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 14:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=XuUWYKI3LpuApg/SIau4PhjSh9r3MS6oiWiQuXZ+jyA=;
        b=B31dMGHq//zoo7uajzO3qROnlO+6gqRGbqrQG1V6OToG5D9Pm/ghY8BCpbN7L2u34/62cq/7THntu3qCGVULwXp33VURurQiJrHXh8J2ZRWDMb3BWrHnXARbqsOU3NL0UtqzvDpdS4nFcJ9FBALhbYp8y8owAiPFgD75J484pSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=NhsttyRuGAy3tMh1xOZrrsJcg8FlsyoiwM5xO7vIBR3kE5qyx+X5xUopEiwK22EPyz4LU1oobo5KcqU/tR97fgKbNxTHx96M6rKcq668WTqQEIz+CSYaVKo4WZ3OvS5R1FBr2e0h6C2dYTalvVJaEGC5znn2TrVSiQCW0HbDWMM=
Received: by 10.78.21.7 with SMTP id 7mr8380515huu.5.1201561120775;
        Mon, 28 Jan 2008 14:58:40 -0800 (PST)
Received: from localhost.localdomain ( [83.8.198.108])
        by mx.google.com with ESMTPS id i7sm29604nfh.18.2008.01.28.14.58.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Jan 2008 14:58:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m0SMwWj7021869;
	Mon, 28 Jan 2008 23:58:33 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0SMwVFN021866;
	Mon, 28 Jan 2008 23:58:31 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20080128205837.GB5788@efreet.light.src>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71906>

Jan Hudec <bulb@ucw.cz> writes:

> On Mon, Jan 28, 2008 at 12:08:10 +1100, David Symonds wrote:
> > 
> > I'm using Git in some scripts, and wanted to get its colorised output
> > even when it is not going to a tty. I don't want to permanently change
> > ~/.gitconfig or the per-repo config; I just want to set color.status
> > (and perhaps others) to "always" for a one-off run. I suppose I could
> > munge the config files, storing the previous value and restoring it
> > later, but that's messy.

Cannot you just use --color option?
 
> > Ideally, an environment variable like GIT_EXTRA_CONFIG or something
> > would be nice, so I could just do:
> > 
> > GIT_EXTRA_CONFIG="color.status=always" git status | ...
> > 
> > Thoughts? Does this already exist, and I've overlooked it?
> 
> Quickly looking at the git-config manpage, there does not seem to be a way to
> provide alternate config file via GIT_CONFIG and/or GIT_CONFIG_LOCAL
> variables. I don't know how good match for your problem that would be.

GIT_CONFIG_LOCAL *replaces* repository configuration file; the global
and the system-wide configuration files will still be read. GIT_CONFIG
is the only config file read.

So you could I guess concatenate repo config with "[color] status=always",
although you would get warnings if color.status is already set...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
