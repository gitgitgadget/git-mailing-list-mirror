From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Another bench on gitweb (also on gitweb caching)
Date: Mon, 11 Feb 2008 16:44:23 -0800 (PST)
Message-ID: <m363wvdmxr.fsf@localhost.localdomain>
References: <20080210030919.GA32733@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Tue Feb 12 01:45:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOjGh-0008BQ-Sb
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 01:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbYBLAo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 19:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbYBLAo2
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 19:44:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:34944 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbYBLAo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 19:44:27 -0500
Received: by ug-out-1314.google.com with SMTP id z38so416178ugc.16
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 16:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=h6Cs5iHLI6X545IouKf6Bb0xuB8uKrtPnqZc5S2u6Yg=;
        b=Cpwk4BmdUmyLgkS4KJTpNGzonDg7xgvyKyigZegNckuzJvGUYZBBxqY+ZuofWij70P0bPaTzdwPXpM1V/WFGEx0Qw141eNYz2Hp0qSYh/xD7amsKyfsL1OMDOr3v4m2srgTrWLBgpjYS8mImf6AGS0A118MINYoz7bsOEE/7yLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Hcbsv1Tb/tNkWJeDk7Hdl1VkRFHVAwcMytHL9jLuXI/oGf16NdvtUfnyAT7pI5MqQTCIn/8JF8aIJUPqnZibK67Q+HC7/Z/csO8u+ih96gy0/zBtkRvjvICAunJ6ikHKphsdV246n2StFQrxT1UWOqyIA11uEZmoCuj6KQnv9/0=
Received: by 10.66.251.20 with SMTP id y20mr9733685ugh.67.1202777064991;
        Mon, 11 Feb 2008 16:44:24 -0800 (PST)
Received: from localhost.localdomain ( [83.8.220.23])
        by mx.google.com with ESMTPS id b30sm9850827ika.11.2008.02.11.16.44.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 16:44:23 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1C0hYBx019103;
	Tue, 12 Feb 2008 01:43:45 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1C0hCI9019099;
	Tue, 12 Feb 2008 01:43:12 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080210030919.GA32733@c3sl.ufpr.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73612>

Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:

> I made another SIMPLE bench on gitweb. Testing time on git-for-each-ref.
> 
> Using my 1000 projects I ran:
> 8<----------------
> #/bin/bash
> PEGAR_ref() { 
>     PROJ=projeto$1.git; 
>     cd $PROJ; 
>     printf "\tlastref = $(git-for-each-ref --sort=-committerdate --count=1\
>             --format='%(committer)')\n" >> config; 
>     cd -; 
> }
> cd $HOME/scm
> for((i=1;i<=1000;i++)){ PEGAR_ref $i & }
> 8<----------------

Could you please do not mix English and your native language
(Portuguese?) in shown examples? Mixing two languages in one
identifier name (unless it is ref in br too) is especially bad
form... TIA.

Besides, what I'm more interested in is a script used to generate
those 1000 projects...
 
> And at the "git_get_last_activity" instead of running git-for-each-ref i
> asked to get gitweb.lastref
> 
> Here are the results:
> "dd" means: dd if=/dev/zero of=$HOME/dd/$i bs=1M count=400000
> 
> Running 2 dd to generate disk IO.  Here comes the results:
> NO projects_list  projects_list
> 7m56s55           6m11s95        cached last change, using gitweb.lastref
> 16m30s69          15m10s74       default gitweb, using FS's owner
> 16m07s40          15m24s34       patched to get gitweb.owner
> 
> Now results for a 1000projects on an idle machine. (No dd running to
> generate IO)
> NO projects_list  projects_list
> 0m26s79           0m38s70       cached last change, using gitweb.lastref
> 1m19s08           1m09s55       default gitweb, using FS's owner
> 1m17s58           1m09s55       patched to get gitweb.owner

Those are results of running gitweb as standalone script, or your
script runing git-for-each-ref?

Besides, I'd rather see results of running ApacheBench. On Linux it
usually comes with installed Apache, and it is called by runing
'ab'. Your tests instead of adding superficial load could try to use
concurrent requests, and more than 1 request to get better average.
 
> I found out those VERY interesting, so instead of trying to think a
> new way to store gitweb config, we should think a way to cache those
> information.

Below there are my thoughts about caching information for gitweb:

First, the basis of each otimisation is checking the bottlenecks.
I think it was posted sometime there that the pages taking most load
are projects list and feeds. 

Kernel.org even run modified version of gitweb, with some caching
support; Cgit (git web interface in C) also has caching support.


Due to the fact that gitweb produces relative time in output for
projects list page and for project summary page, it is unfortunately
not easy to just simply cache HTML output: one would have either
resign from using relative time, or rewrite time from relative to
absolute, either on server (in gitweb), or on client (in JavaScript).
So perhaps it would be better to cache generating (costly to obtain)
information; like lastchanged time for projects.

Or we can for example assume (i.e. do that if appropriate gitweb
feature is set) that projects are bare projects pushed to, and that
git-update-server-info is ran on repository update (for example for
HTTP protocol transport), and stat $GIT_DIR/info/refs and/or
$GIT_DIR/objects/info/packs instead of running git-for-each-ref.
Of course then column would be called something like "Last Update"
instead of "Last Change".

The "Last Update" information is especially easy because it can be
invalidated / update externally, by the update / post-receive hook,
outside gitweb. So gitweb doesn't need to implement some caching
invalidation mechanism for this.

We can store lastref / lastchange information in repository config, as
for example "gitweb.lastref" key. We can store it in gitweb wide
config, for example in $projectroot/gitwebconfig file, as for example
"gitweb.<project>.lastref" key. Or we can store it as hash initializer
in some sourced Perl file, read from gitweb_config.perl (this I think
can be done even now without touching gitweb code at all); we can use
Data::Dumper to save such information.

The possibilities are many.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
