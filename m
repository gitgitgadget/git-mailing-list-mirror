From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Tracking the untracked
Date: Thu, 07 May 2009 01:22:43 -0700 (PDT)
Message-ID: <m33abhnx01.fsf@localhost.localdomain>
References: <93c3eada0905051819l92dc7ey331d69f009cc9c8b@mail.gmail.com>
	<200905061522.56981.trast@student.ethz.ch>
	<93c3eada0905070058g7f619a56jfb9b49f02bb92f9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Thu May 07 10:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1ysa-0005YJ-OA
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 10:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757042AbZEGIWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 04:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756759AbZEGIWq
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 04:22:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:28029 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106AbZEGIWp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 04:22:45 -0400
Received: by rv-out-0506.google.com with SMTP id f9so497846rvb.1
        for <git@vger.kernel.org>; Thu, 07 May 2009 01:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Gp7/ZmmOeYv6qY5mWyOBTP1i8tPxDWjyWYFrsEUwMi8=;
        b=ujGfRNDVV+JzyaObLGRtAbtzpa91Wq61To4qdH4UljjACTJF2KTo5GTv7Ugqd5s/Z1
         nezqf30O08q4ojBW7l1wDzRM5aqgA3Fi/4/c8jNJzjHipA0FkKRFLGtEV/BSWZpSIr36
         xkcgAAN0j2Wv9rpw7lwoCn17vPXktMsuBZIIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ZAK7cMPusGNVb8EcIFDLJMyHgANCQwK+P/wf7mpyCv0AJ4MxBuRzGh7z70v7IgRjFp
         jwUnUW6qusPCc4jlRvKdHERjbGj3ERgCNH8KIBZOEn0va0b93lZJWFCTCfuXP0EP9Iz7
         UDx/V6PTG66NyU+T5ErwUmhi2Cd1ciIMXeBC4=
Received: by 10.141.50.11 with SMTP id c11mr980111rvk.45.1241684564748;
        Thu, 07 May 2009 01:22:44 -0700 (PDT)
Received: from localhost.localdomain (abwu219.neoplus.adsl.tpnet.pl [83.8.244.219])
        by mx.google.com with ESMTPS id k41sm23337023rvb.27.2009.05.07.01.22.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 May 2009 01:22:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n478MIXw020527;
	Thu, 7 May 2009 10:22:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n478M6pg020518;
	Thu, 7 May 2009 10:22:06 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <93c3eada0905070058g7f619a56jfb9b49f02bb92f9b@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118439>

Geoff Russell <geoffrey.russell@gmail.com> writes:
> On 5/6/09, Thomas Rast <trast@student.ethz.ch> wrote:
> > Geoff Russell wrote:

> > > Bug or feature? I don't know.
> >
> >
> > Feature.

[...]
> Ok, its clearly a policy choice.  But suppose I have an untracked
> file and I do "git some-command" then I don't expect git to touch what
> it doesn't know about. I.e., "git add x" shouldn't delete the untracked
> file y. That seems sensible. But now "git checkout branch" behaves
> quite differently in just deleting stuff that it doesn't own (i.e., is
> untracked).
> 
> Anyway, I'll rethink.

First, did you consider just .gitignore'ing untracked files,
and if they are compilation products use cc-cache instead?

Second, the way git treats untracked files is simple: do not
lose information.  If a file is tracked, or to be more exact
specific contents of a file is in repository, then deleting
it would not remove information.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
