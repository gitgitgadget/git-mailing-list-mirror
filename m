From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Do not print "log" and "shortlog" redundantly in commit view
Date: Sat, 7 Oct 2006 16:05:22 +0200
Message-ID: <200610071605.23277.jnareb@gmail.com>
References: <eg51fi$7rs$2@sea.gmane.org> <20061006221603.50873.qmail@web31815.mail.mud.yahoo.com> <20061007132457.GB20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 16:04:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWCnP-0002Jg-9G
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 16:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWJGOEi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 10:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWJGOEi
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 10:04:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:42094 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751796AbWJGOEh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 10:04:37 -0400
Received: by ug-out-1314.google.com with SMTP id o38so429019ugd
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 07:04:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uvCrN4QN9xBoyoCM5ANepWziGZmgSYE7+wioiv7tnaBcM6Fxo8onmIh2C/XMb+KMYHzYozgL1mXraDBQ/lmmFdU2DzDmu0HRdS4ZnOdfvfQjwNjhK4U6UH07BZZYdjM5VHp0LvXJ6XS6QtKB1WLtay74Av4TOBeizR3Snn5vOcg=
Received: by 10.67.101.8 with SMTP id d8mr4547913ugm;
        Sat, 07 Oct 2006 07:04:36 -0700 (PDT)
Received: from host-81-190-22-223.torun.mm.pl ( [81.190.22.223])
        by mx.google.com with ESMTP id 29sm2996522uga.2006.10.07.07.04.35;
        Sat, 07 Oct 2006 07:04:35 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <20061007132457.GB20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28483>

Petr Baudis wrote:
> Then it will be impossible to get snapshot of any subtree (apart of
> manually constructing the URL). Hmm, and it's a bug that we don't show
> the snapshot link when listing tree entry in tree listing, I thought
> we did in the past...?
> 
> I think we should make it more clear what each of the bars concerns,
> perhaps doing some more significant redesign:
> 
> [summary] is redundant, you have this big project name link in the top
> left corner. All the other navbar options concern commit, so why not
> merge it with the awkward commit box below the navbars?
> 
> All the "views bar" options concern the currently selected object, so
> why not merge it with the object "descriptor", that is the path?
> 
> Patches will follow up.

I think that "summary" has it's place rather in the bottom navigation 
bar, in the "views bar", because it is related to current object not 
current commit (the "tree" entry in top navigation bar, "actions bar", 
is somewhat misleading because it actually is the tree of the commit, 
not any tree). But the refactoring of "views" navigation bar is a good 
idea. For tree it would be
	tree | _history_ | _blame_ | _snapshot_
(when there would be tree_blame back - there was short experiment, patch 
on git list; snapshot of course only when enabled).

I'd leave "summary" view, because the uther, especially with custome 
$home_link_str might be not obvous that it leads to summary view.

-- 
Jakub Narebski
Poland
