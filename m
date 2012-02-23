From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2012, #08; Wed, 22)
Date: Thu, 23 Feb 2012 03:29:06 -0800 (PST)
Message-ID: <m38vjteqkj.fsf@localhost.localdomain>
References: <7vfwe26zwn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 12:29:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0WrL-0000Hf-NU
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 12:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248Ab2BWL3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 06:29:10 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52948 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab2BWL3I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 06:29:08 -0500
Received: by eekc4 with SMTP id c4so350371eek.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 03:29:07 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.202.197 as permitted sender) client-ip=10.14.202.197;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.202.197 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.202.197])
        by 10.14.202.197 with SMTP id d45mr568733eeo.128.1329996547135 (num_hops = 1);
        Thu, 23 Feb 2012 03:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=AYaOBJloRWe5x7TzDS0Z0URlDVcnCb31IFT84/U9knU=;
        b=lhUuz5Fs3ThrBnIAf6+LgvKnNNw7/w/a+xXFAqNZVeyQreyVMz4vs2dpW9Z/nihSY+
         hxjwp44NV0W1QbK8vx8WzPx44SrTbfMYWhk8nddh2UHQRrTlT2yf4Ir0Bdgitm6utGd9
         E1c3qSrOzdxFlz94XY4P0lX/pmv1pkJB+8cRA=
Received: by 10.14.202.197 with SMTP id d45mr452474eeo.128.1329996547002;
        Thu, 23 Feb 2012 03:29:07 -0800 (PST)
Received: from localhost.localdomain (abvx74.neoplus.adsl.tpnet.pl. [83.8.221.74])
        by mx.google.com with ESMTPS id a58sm4346656eeb.8.2012.02.23.03.29.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 03:29:06 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1NBT24K000832;
	Thu, 23 Feb 2012 12:29:03 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1NBT1GZ000829;
	Thu, 23 Feb 2012 12:29:01 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vfwe26zwn.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191351>

Junio C Hamano <gitster@pobox.com> writes:

> * jn/gitweb-hilite-regions (2012-02-19) 5 commits
>  - gitweb: Use esc_html_match_hl() in 'grep' search

This one is about starting unification of match highlighting in
gitweb, using esc_html_match_hl() which can show multiple matches in
line as opposed to existing hand-crafted and duplicated solutions.

>  - gitweb: Highlight matched part of shortened project description
>  - gitweb: Highlight matched part of project description when searching projects
>  - gitweb: Highlight matched part of project name when searching projects
>  - gitweb: Introduce esc_html_hl_regions

This is about adding match highlighting to project search.  Other
kinds of search in gitweb ('commit', 'grep' - both per-repository
searches) already use match highlighting.

>  (this branch uses jn/gitweb-search-optim.)

Theoretically those topics should be independent, but I think there
can be tetual conflict.  Better to build one on top of the other.

Nb. should I send those series independently?
 
> Not reviewed and do not know what this is about yet ;-).

I hope that above description helps.
 
> * jn/gitweb-search-optim (2012-02-19) 3 commits
>  - gitweb: Faster project search
>  - gitweb: Option for filling only specified info in fill_project_list_info
>  - gitweb: Refactor checking if part of project info need filling
>  (this branch is used by jn/gitweb-hilite-regions.)
> 
> The API introduced in the second step still has yucky design, but at least
> it is more clear than the previous rounds what this is trying to do.

Thanks for the comments.  I'll try to send re-roll soon.

-- 
Jakub Narebski
