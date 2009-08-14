From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git config -> "fatal: bad config file"
Date: Fri, 14 Aug 2009 07:28:23 -0700 (PDT)
Message-ID: <m3ocqio4gz.fsf@localhost.localdomain>
References: <A5CDBB91-E889-4849-953A-2C1DB4A04513@gmail.com>
	<4A85724C.5060406@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Reitter <david.reitter@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 14 16:28:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbxli-0005MD-GG
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 16:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbZHNO20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 10:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbZHNO2Z
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 10:28:25 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:39233 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299AbZHNO2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 10:28:25 -0400
Received: by bwz22 with SMTP id 22so1173171bwz.18
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=fCGrtsxWAi++wDoxmPHMj7rvbgMTQMhG1t1CjdvsoV4=;
        b=saQQF3QnkTRlyOm2F6A5e75FsALgBfG/fT6Vx+M6E+BiiwLOr6Ko28fmLpUK07++7b
         IQKnVtwIpNDS1ug3p97cCvGyIeU9NKgB+qoCSveJs9oUUDnw6blCFZv+uZZ6o4S1h1HU
         CyUbQsHkUcIeyXdZBZVNGLUxa/cW6w5qZByNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=e4Hygbj08xpe45YoqWnaTPr66wj5QDFT6dAjmyHbkMBXUVuyx6P5JLwcriS+XA24ZZ
         oq18PGHYqpvFUoxIiqjfrKHLSMqny8qxd2+wL2tXljkg4TU3Uhk/D/rfWJE5dn+daL1X
         wLHE97sgeFgwA4CeJOBB+/k4N0y4/BLHP+BXc=
Received: by 10.102.197.11 with SMTP id u11mr654545muf.97.1250260104483;
        Fri, 14 Aug 2009 07:28:24 -0700 (PDT)
Received: from localhost.localdomain (abwe173.neoplus.adsl.tpnet.pl [83.8.228.173])
        by mx.google.com with ESMTPS id e8sm6943188muf.36.2009.08.14.07.28.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Aug 2009 07:28:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7EERvTi016891;
	Fri, 14 Aug 2009 16:28:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7EERfmb016886;
	Fri, 14 Aug 2009 16:27:41 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A85724C.5060406@drmicha.warpmail.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125928>

Michael J Gruber <git@drmicha.warpmail.net> writes:
> David Reitter venit, vidit, dixit 14.08.2009 15:38:

> > I made a mistake editing my config file using "git config -e".  This  
> > caused git commands to fail.
> > 
> > Trying to fix the problem, I did
> > 
> > git config -e
> > fatal: bad config file line 7 in .git/config
> > 
> > I think the refusal to edit a broken config file is not a good idea.   
> > It's easy to fix for me of course by editing .git/config directly, but  
> > git-config should probably not read the config file at all.
> > 
> > Thanks for your consideration.
> > 
> 
> git needs to read the file because the editor could be configured there!
> The only option would be to make git config -e continue past that error.

Well, it shows you which file the error is, but I think as a special
case "git config [file] --edit" should show also (absolute?) pathname
of the file it tired to open.

core.editor can be in any place.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
