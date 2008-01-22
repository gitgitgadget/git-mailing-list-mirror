From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Using email between 2 developers to keep git repositories in sync
Date: Tue, 22 Jan 2008 05:53:32 -0800 (PST)
Message-ID: <m3k5m2klmh.fsf@roke.D-201>
References: <7A02F7D1-9EB0-43AB-96F9-DDD71D4EF5FE@mac.com>
	<alpine.LSU.1.00.0801221255530.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ab_lists@mac.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 22 14:54:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHJZp-0003Zq-8W
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 14:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbYAVNxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 08:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbYAVNxj
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 08:53:39 -0500
Received: from mu-out-0910.google.com ([209.85.134.185]:42201 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbYAVNxi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 08:53:38 -0500
Received: by mu-out-0910.google.com with SMTP id w8so1991675mue.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 05:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=eQNtagZ0nceF8v+AUKo1pEBXLKcs9qxri6I7+8CuOHo=;
        b=eOswOoE2av8VLb8A4e/RUdgqlbb3PHh/u75nL2JxY121cNpJO+En/Nk/Qwc3U+MZ5NvBbRa885MwhX5j8fJmMbs+/oxIgh99ZwWMJG1oEZZHaI1KraKFQSamEHhwjxtSwwv5ZYOsfW1YtV6KcVtmKpGpBPqYlUQseuph+teidqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=OOnnwUcKVK2eN0STPXSQghYkrPCdIUcksW87Nq0zvMFoiFBYReDt1d0J24geXslUgSRD/Ie/HWsF4njEvx0x3eCKiLP6lZ9fxKNbLNWLN3FYap/kXgoL4xvFQ8THS52W/iEoJZDSH7FQhSCroSXn7JhwkT36PlDLzZS5AeSYZsk=
Received: by 10.78.139.14 with SMTP id m14mr11140365hud.25.1201010014194;
        Tue, 22 Jan 2008 05:53:34 -0800 (PST)
Received: from roke.D-201 ( [83.8.211.135])
        by mx.google.com with ESMTPS id s34sm2887834hub.31.2008.01.22.05.53.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Jan 2008 05:53:32 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m0MDwXa3001618;
	Tue, 22 Jan 2008 14:58:40 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0MDwVbT001615;
	Tue, 22 Jan 2008 14:58:31 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <alpine.LSU.1.00.0801221255530.5731@racer.site>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71449>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 22 Jan 2008, ab_lists@mac.com wrote:
> 
> > However I need to share code with a co-developer. He also has a code 
> > base that I need access to. For several reasons, a shared server will 
> > not work so I was thinking of using email to send patches back and 
> > forth.
> 
> My recommendation: Use bundles.  Just make the initial "clone" like this:
> 
> 	$ git bundle create initial.bundle --all
> 
> Send the file "initial.bundle" (which you just created) to your 
> co-developer.  He should now initialise his repository:
> 
> 	$ mkdir my-new-workdir
> 	$ cd my-new-workdir
> 	$ git init
> 	$ git pull /path/to/initial.bundle master
> 
> (Someone tried to get "git clone /path/to/bundle" to work, but I don't 
> know if that work was ever completed, so I assume it was not.)
> 
> Whenever he wants to send you an update, he has to do something like this:
> 
> 	$ git bundle create update.bundle --all --since=2.weeks.ago
> 
> and send you the resulting file named "update.bundle".

If I remember correctly either in GitFaq or GitTios at GitWIki 
(http://git.or.cz/gitwiki/), or in "Git in Nutshell" guide there
is description how to generate incremental bundle containing all
objects you created since last bundle and only those objects.

Besides, after initial setup IMHO it is much better to exchange
patches for review. Although usually there are more than two
developers in such case...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
