From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined at config time
Date: Sat, 16 Feb 2008 13:11:59 -0800 (PST)
Message-ID: <m3hcg8bo9f.fsf@localhost.localdomain>
References: <20080216185349.GA29177@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Feb 16 22:12:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQUL9-00079d-F5
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 22:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758524AbYBPVMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 16:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758526AbYBPVMF
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 16:12:05 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:59054 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758474AbYBPVMC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 16:12:02 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1196875fkz.5
        for <git@vger.kernel.org>; Sat, 16 Feb 2008 13:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=ulJMFmyt2oU5P3HzA++qnkn/A6t/xAavThkiMDswIns=;
        b=G0W/zHLWC/NSVjE9m5M9aR6BRVstV/N3Q0MtA9uVX81rDavz/bQLuDCJrWdDYzjMeNYSY9ZStzEEfQzouQ+Hb5HQiG+Amrqg5cKfRL3KMUnbzTXFitFwhLfcofyJIV8H3F5awR+QF64RcdKjPzTa9l7V1vBJ9yHfTYkH+dnsUDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=euak3ocTQI/Yf/qm04uHg+/Q27JFrqH7rlhWeviYKH9IzR0CEmUS4emfHPIGrMC05iPdJ+JuIpq/4YP1yQv5ZprSjTejcFWq5rZbdymeKFXsYxX4SqHdzIHzNP+b75lLf7uKv/wl9QKwxTIQepY2YqnKmPz0ZcPHvFtn+FKNMWs=
Received: by 10.78.37.7 with SMTP id k7mr6167597huk.30.1203196320086;
        Sat, 16 Feb 2008 13:12:00 -0800 (PST)
Received: from localhost.localdomain ( [83.8.197.33])
        by mx.google.com with ESMTPS id d27sm11687857nfh.34.2008.02.16.13.11.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Feb 2008 13:11:59 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1GLBTnf014268;
	Sat, 16 Feb 2008 22:11:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1GLB9dA014262;
	Sat, 16 Feb 2008 22:11:09 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080216185349.GA29177@hashpling.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74078>

Charles Bailey <charles@hashpling.org> writes:

> Currently git mergetool is restricted to a set of commands defined
> in the script. You can subvert the mergetool.<tool>.path to force
> git mergetool to use a different command, but if you have a command
> whose invocation syntax does not match one of the current tools then
> you would have to write a wrapper script for it.
> 
> This patch adds three git config variable patterns which allow a more
> flexible choice of merge tool.

[...]

> It follows filter-branch's 'eval a user shell snippet' philosophy to
> provide the flexibility and here in lies an ugliness. It exposes
> git-mergetool.sh's private variables to the user script. The variables
> are BASE, REMOTE, LOCAL and path.

Another solution would be to use StGit merger / i2merge / i3merge
format, similar to git-for-each-ref format, namely to expand
%(branch1), %(branch2), %(ancestor), %(output) (well, StGit uses
for some reason %(ancestor)s etc.; git-for-each-ref doesn't).

Although for this would be better if git-mergetool was rewritten
in C, in Perl (or even in Python).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
