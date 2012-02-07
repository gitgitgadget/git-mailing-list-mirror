From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: cloning a tree which has detached branch checked out
Date: Tue, 07 Feb 2012 02:08:33 -0800 (PST)
Message-ID: <m362fjklb7.fsf@localhost.localdomain>
References: <20120207070628.GA24698@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 11:08:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ruhya-0004NQ-Ps
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 11:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046Ab2BGKIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 05:08:36 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:34216 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609Ab2BGKIf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 05:08:35 -0500
Received: by eekc14 with SMTP id c14so2478863eek.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 02:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=UtGJw6sPlaNuip5XQyGFZCLaZ+2rStfEiLkADvXevGU=;
        b=h6sQ0WdCQb6myas1bFqmsIgYHVerI6ma1Clz7syjjCkNhRBBdiQ9U0NZVRSSz2lKRN
         L7EuSyuPrQc+munNoMPr9LRzujT3zvmejDimg/pYjpbE+1qddTmg0atQwDDboS6Kehv1
         perFyb6pXtLu+MKl9Q9jBJUOvrIu+dmv8+NIc=
Received: by 10.14.186.134 with SMTP id w6mr3630049eem.96.1328609313872;
        Tue, 07 Feb 2012 02:08:33 -0800 (PST)
Received: from localhost.localdomain (abrz152.neoplus.adsl.tpnet.pl. [83.8.119.152])
        by mx.google.com with ESMTPS id y12sm71695616eeb.11.2012.02.07.02.08.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 02:08:33 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q17A8TTT029180;
	Tue, 7 Feb 2012 11:08:30 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q17A8SCr029177;
	Tue, 7 Feb 2012 11:08:28 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120207070628.GA24698@redhat.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190160>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> I have a tree where I checked out a remote, without
> creating a local branch, this detaches the HEAD:
> # git branch
> * (no branch)
>   master
> #git log|head -1
> commit cec64082f689f949a397cb9b39423dc41545fa0e
> #git log master..HEAD|head -1
> commit cec64082f689f949a397cb9b39423dc41545fa0e
> 
> 
> Now if I try to clone it:
> #git clone -n lab:/home/mst/scm/linux
> Initialized empty Git repository in /home/mst/scm/linux/.git/
> remote: Counting objects: 1693446, done.
> remote: Compressing objects: 100% (277054/277054), done.
> Receiving objects: 100% (1693446/1693446), 418.16 MiB | 7.63 MiB/s,
> done.
> remote: Total 1693446 (delta 1414353), reused 1681280 (delta 1402358)
> Resolving deltas: 100% (1414353/1414353), done.
> error: Trying to write ref HEAD with nonexistant object
> cec64082f689f949a397cb9b39423dc41545fa0e
> fatal: Cannot update the ref 'HEAD'.
> 
> Looks like a bug, doesn't it?

Which git version?  IIRC there was some bugfix recently in that
area...

-- 
Jakub Narebski
