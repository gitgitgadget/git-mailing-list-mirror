From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What should a user expect from git log -M -- file
Date: Thu, 26 Nov 2009 09:14:37 -0800 (PST)
Message-ID: <m3ocmpmcoq.fsf@localhost.localdomain>
References: <20091126163654.GA14509@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 18:14:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDhvZ-0007c3-Ku
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 18:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755680AbZKZROe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 12:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755424AbZKZROe
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 12:14:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:22659 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbZKZROd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 12:14:33 -0500
Received: by fg-out-1718.google.com with SMTP id e12so374548fga.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 09:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=R8iKQEiMfMQLf/nUL40Ljjb4OGWTfRCrceXRrTuuzTo=;
        b=ASTCj/4AuLR/htWh8gB4muq7pJWN/O3hpWyU50F1F/kP4XG4ZREv4ihuA0zYET5FCq
         vrGPa7dTJb6CYPZ++nrquTrQCKAB4nvXCbg0/L3ZFx9/rDHS/xnKYqnIOE9h5HrdBr99
         i4EyZIbtO2lKFMPILhs/rjnZ8EPSdZdwe8DO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=khfRh4npax4BwKk4m5fnfnqlMYaYm1VLflYKAohp93kC9EzR4QnO1s4JtmUY4J2oMT
         jTp4BIgQLz24hYdWQWYHBDXrQN1RGmScjJEEP0oUwXdOMP25F8dJ34yvKYtySTHeaJgc
         051jtpMX5r42q43VpXYhh+m0jff/ZoaFEoP60=
Received: by 10.87.73.4 with SMTP id a4mr20481fgl.76.1259255678672;
        Thu, 26 Nov 2009 09:14:38 -0800 (PST)
Received: from localhost.localdomain (abvg159.neoplus.adsl.tpnet.pl [83.8.204.159])
        by mx.google.com with ESMTPS id e11sm3135586fga.24.2009.11.26.09.14.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 09:14:37 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAQHDw77003927;
	Thu, 26 Nov 2009 18:14:08 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAQHDg2i003918;
	Thu, 26 Nov 2009 18:13:42 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20091126163654.GA14509@glandium.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133812>

Mike Hommey <mh@glandium.org> writes:

> I recently reorganized a project of mine, and the result is that a lot of
> files moved from the top directory to a sub directory.
> 
> Now, I innocently tried to 'git log -M' some of these files in the
> subdirectories, and well, the history just stops when the file was
> created. Obviously, if I put both the old and the new location it works,
> but shouldn't users expect 'git log -M -- file' to try to find the
> previous path and continue from there ?

What you want is not

  git log -M -- file

but

  git log --follow file

"git log -M -- file" IIRC first applies path limiting, simplifying
history, *then* does rename detection, and finally filters output
(unless --full-diff is used).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
