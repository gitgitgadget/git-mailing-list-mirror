From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to restrict gitk to show only branch/merge commits?
Date: Wed, 06 May 2009 00:51:16 -0700 (PDT)
Message-ID: <m37i0uoej7.fsf@localhost.localdomain>
References: <20090506072053.GL15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Wed May 06 09:51:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1buX-0006CN-Dn
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 09:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbZEFHvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 03:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbZEFHvS
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 03:51:18 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:54311 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbZEFHvR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 03:51:17 -0400
Received: by gxk10 with SMTP id 10so10278719gxk.13
        for <git@vger.kernel.org>; Wed, 06 May 2009 00:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=dSgrKsjyfBfJ4VEZEQ449StXzne4h+o+FFZtCWGnmpQ=;
        b=lEDG0XX2AUXTRU58O28i5ySQSJ7lRBDv4OGx3lUemIt2520NqmXhNgT/WMe/6/NP2Z
         lMkxziM48pfAbQm+TApygf1VvSYPXrC4VmJbzG3cUt4LK+FnIQ4VTZEQrxEh0K9145Wk
         jp+4EU8mn2j93l0QqflMHSYHOz1HfptgP4I3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=M8997G7RsoWhswqD9PM2M8BnY82JU568145BbDFwDO45G7xC27FnwyCrlf/ktLfzXO
         VPd+UgNMUKKuIwK8yIzG3z9tRuSvchFtvcje3VRxnrDllTtM4BqU/aKK+NaFr30XVlKS
         Zqx/TIq53731ZVqjV2sYH3DEXV9UgSjFsZ0uU=
Received: by 10.90.105.17 with SMTP id d17mr830051agc.68.1241596277244;
        Wed, 06 May 2009 00:51:17 -0700 (PDT)
Received: from localhost.localdomain (abwa249.neoplus.adsl.tpnet.pl [83.8.224.249])
        by mx.google.com with ESMTPS id 39sm1182908agb.71.2009.05.06.00.51.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 00:51:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n467pAdA005156;
	Wed, 6 May 2009 09:51:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n467p86r005153;
	Wed, 6 May 2009 09:51:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090506072053.GL15420@raven.wolf.lan>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118332>

Josef Wolf <jw@raven.inka.de> writes:

> I would like gitk to show me only the heads, branch-points and
> merge-points of branches.
> 
> For example, given a history like this:
> 
>                    d...e--F--g...h--H
>                   /        \
>  a1--a2...an--b--C          N--o...p--P
>                   \        /
>                    i...j--K--l...m--M
> 
> I would like to see only
> 
>  - a1     because it has no parent
>  - C,F,K  because they are reachable from multiple heads
>  - N      because it has multiple parents
>  - H,M,P  because they are heads
> 
> Ideally, there would be a possibility to add some "context" to the
> list of commits to be shown: with $context==1, all the commits shown
> in the above history would be shown, but the commits indicated by
> the triple-dots would be omitted.
> 
> The reason is that I have some repositories with several really long
> linear history.  It is hard to get a global overview about the branch
> history if you have to scroll constantly.
> 
> Is something like that possible with gitk?

I am not sure if it would give you exactly what you want, but if I
understand correctly gitk accepts arguments for git-log (and you can
set them somewhere in options, too).  Take a look at section "History
Simplification" in git-log/git-rev-list manpage, in particular at
option '--simplify-by-decoration' there.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
