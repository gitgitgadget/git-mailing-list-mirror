From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Bug Report: git add
Date: Sun, 10 Apr 2011 00:48:49 -0700 (PDT)
Message-ID: <m31v1a4keq.fsf@localhost.localdomain>
References: <4D9BA35E.6040204@dcook.org> <20110406055200.GA12547@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Darren Cook <darren@dcook.org>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 09:49:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8pON-0001Ni-JG
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 09:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978Ab1DJHsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 03:48:52 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52445 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab1DJHsv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 03:48:51 -0400
Received: by bwz15 with SMTP id 15so3773117bwz.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=c80N5EQG5KSECtdMBm0VQJHUN+fRXhJHSsmXALYWmwM=;
        b=cV3mSNPxmrKab9MvjmLT8kmc/5p1eaMlkPVuIZyWo4FZNJ9uuF1o9WIJw7MA8g6B4A
         kAk/+OcfLOTjFVsP0ylIqkhQqFiPek8HsqjQr5gzX/ckdFBCtCuaQfBUkSDbWFzYhFqz
         6UlhaLpFMtalaY0XjcA2Vi7qb+swYJTk23Njk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=t42wNkOMpNpjLHQHNKgMQmravj4C2sLOgL4iqptxucLdWLGPTaYNVLN9sa8HwSrUYB
         hSwjLcyd4VcxQpOFlhHLC7KmsI2WNusnc3LKtiDgVoB4Bjfw5UUW3beE6rKPLrJXBhGP
         p+WiNxoMiJTR6+EcFUa1Kzt7tHa9VHvHxvfEw=
Received: by 10.204.144.194 with SMTP id a2mr3371723bkv.93.1302421730158;
        Sun, 10 Apr 2011 00:48:50 -0700 (PDT)
Received: from localhost.localdomain (abwa66.neoplus.adsl.tpnet.pl [83.8.224.66])
        by mx.google.com with ESMTPS id l1sm2532657bkl.1.2011.04.10.00.48.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 00:48:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3A7mFu1023729;
	Sun, 10 Apr 2011 09:48:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3A7lwi0023724;
	Sun, 10 Apr 2011 09:47:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110406055200.GA12547@kytes>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171242>

Ramkumar Ramachandra <artagnon@gmail.com> writes:
> Darren Cook writes:

> > PROBLEM: "git add" adds sub-directories without checking to see if there
> > is already a git repository already there.
> > 
> > WHY BAD: This causes files to be in two repositories (leading to a mess
> > if you don't notice for a while...)
> > 
> > ONE SOLUTION: When adding files from a directory (except root of the
> > repository, of course) look for a .git subdirectory, and complain if
> > found. Allow --force to override this.
> 
> This is a good suggestion.  It already has a way to handle gitlinks
> (for submodules), so this seems like a very reasonable feature.

I just hope that a suboptimal workflow that I use won't stop working.

Currently I have TODO file in gitweb/ subdirectory, which is stored in
gitweb/.git repository.  Still it doesn't prevent me from "git add"-ing
e.g. 'gitweb/gitweb.perl' to git repository itself.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
