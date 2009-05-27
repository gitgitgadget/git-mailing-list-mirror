From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 07:37:33 -0700 (PDT)
Message-ID: <m3y6siboij.fsf@localhost.localdomain>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christopher Jefferson <caj@cs.st-andrews.ac.uk>
X-From: git-owner@vger.kernel.org Wed May 27 16:37:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9KGH-00082p-MV
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 16:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760585AbZE0Ohg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 10:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760295AbZE0Ohf
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 10:37:35 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:45142 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759849AbZE0Ohe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 10:37:34 -0400
Received: by fxm12 with SMTP id 12so2931541fxm.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=mNQ3dFAl6MWf02ntLjK7b2jCsDJ32QR3Bcv9TOynuZ4=;
        b=E7IA3CVzimDGk8kup4iJEWq4v33rhY8uB3lIuKNZsrd1zC+byl1JRf+K8j5eqbyeGQ
         5owjP1krFb+3r05LraRwR0C/Gns9jzc1eh/3EfLTmGeKVSHtKNw3ngc8Lg7iNny529sl
         Zh1R3yVZYRQqwXZPtR74B18FnTUAzM28+9Wws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=BxIK4+HBHRW2Gcb63QNqTWgzp9ehFzPeu+h042b2ocwEDPD3tB/33kTjjo6dt075+S
         AyWtAivlulyMYuMVLDeyOfq214S75QpMGR41rnPzActi6MZFNXUZpCtH++n7+LlHIi3g
         WvxVBlc29m1SpaKOyUupwFMpdgKgfZzVszoiY=
Received: by 10.216.54.83 with SMTP id h61mr29785wec.69.1243435055223;
        Wed, 27 May 2009 07:37:35 -0700 (PDT)
Received: from localhost.localdomain (abvl57.neoplus.adsl.tpnet.pl [83.8.209.57])
        by mx.google.com with ESMTPS id f13sm3840987gvd.23.2009.05.27.07.37.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 07:37:33 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4REbVt1015551;
	Wed, 27 May 2009 16:37:31 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4REbPrr015546;
	Wed, 27 May 2009 16:37:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120070>

Christopher Jefferson <caj@cs.st-andrews.ac.uk> writes:

> I recently came across a very annoying problem, characterised by the
> following example:
> 
> On a recent ubuntu install:
> 
> dd if=/dev/zero of=file bs=1300k count=1k
> git commit file -m "Add huge file"
> 
> 
> The repository can be pulled and pushed successfully to other ubuntu
> installs, but on Mac OS X, 10.5.7 machine with 4GB ram git pull
> produces:

Do seting `pack.packSizeLimit`, or adjusting values of
`core.packedGitWindowSize` and/or `core.packedGitLimit`
(see git-config(1)) help in your situation?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
