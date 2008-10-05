From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb improvements
Date: Sun, 05 Oct 2008 10:22:18 -0700 (PDT)
Message-ID: <m34p3rq7og.fsf@localhost.localdomain>
References: <00a201c92701$54ec6980$fec53c80$@se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'git'" <git@vger.kernel.org>
To: "Tjernlund" <tjernlund@tjernlund.se>
X-From: git-owner@vger.kernel.org Sun Oct 05 19:23:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmXKP-0007BX-Cu
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 19:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbYJERWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 13:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754286AbYJERWW
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 13:22:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:34679 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbYJERWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 13:22:21 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1515027ugf.37
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=N+mC+D7brgNk8+iex3RA5eZctOPOHEfYloJ1zKUn0eQ=;
        b=q0jhHlPXNW88LnvPAAPt+1cUyp4Q0U/jwSViBjjc+hTfR1GRAGm3cq+zj3l1dkvdpA
         FUfwzVoJMdBQ/c9+0FNovf3VehCw5yoVf0AipMkl0c9nLVeQJOor445A8DxTMYrZrTFW
         FwodhdcVnFNsbWiP26uWh5qpg7ZF4t/5j7vJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=fXHD5/lzkI4Gi07h4s++/IGlR4ToAXQ7roW1AUXP3kQoWv8oWCD2fJxffFX13fCwxI
         evHpn/WBbr4PdE5b/XLIE92rb4E0k3CdIbz7B8NdCAtHXCoLBYxVzE3sXcGQrufoFBdQ
         +HVbuj6EyoiFQ3Hxd96zVKTQYZNEYgQbJUkMM=
Received: by 10.210.81.10 with SMTP id e10mr4952264ebb.44.1223227339398;
        Sun, 05 Oct 2008 10:22:19 -0700 (PDT)
Received: from localhost.localdomain (abxa221.neoplus.adsl.tpnet.pl [83.8.250.221])
        by mx.google.com with ESMTPS id 3sm10025266eyi.5.2008.10.05.10.22.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Oct 2008 10:22:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m95HLpc2011500;
	Sun, 5 Oct 2008 19:22:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m95HLZas011496;
	Sun, 5 Oct 2008 19:21:35 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <00a201c92701$54ec6980$fec53c80$@se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97521>

"Tjernlund" <tjernlund@tjernlund.se> writes:

> When I browse a repo using gitweb, I miss two things:
> 1) looking at the history for a file or directory I really want
>    to see the tags there too.

Should be easy to do, but would probably wait (and be indirect result)
of refactoring/unification of log-like views code ('log', 'shortlog',
'history', perhaps also 'rss', 'atom', 'search')

I have added it to my gitweb TODO list...
 
> 2) looking at a merge like:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=66120005e65eed8a05b14a36ab448bdec42f0d6b
>    is somewhat confusing. It really doesn't tell you which commits that is
>    included in the merge.

I don't understand you there. First, you have "(merge: 0d0f3ef 9778e9a)"
in the navbar, so you can easily go to commit view for parents. Second, 
among commit headers you have two "parent", where SHA-1 of a commit is
hidden link, and there are also 'commit' and 'diff' link for those.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
