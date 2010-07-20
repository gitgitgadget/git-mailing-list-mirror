From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Automatically exclude hunks from the commit
Date: Mon, 19 Jul 2010 22:17:58 -0700
Message-ID: <C18AA39F-1ADD-46A8-8A10-25A6B6AF26CB@gmail.com>
References: <4C4511C8.8090405@workspacewhiz.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 07:18:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob5DW-0001sQ-Up
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 07:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198Ab0GTFSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 01:18:05 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33226 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab0GTFSD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 01:18:03 -0400
Received: by pzk26 with SMTP id 26so1567691pzk.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 22:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=eFbtVFeRwV1kW4Ir5ru9SwG0+2Esx26DumLEPAld3R8=;
        b=KijX0EFikl3h+/PhqhBkjPre2RruwgcXWHX7twU7l371oO4aOD9rEwLWf3yVj9CnkJ
         3TmiuyKbH3lqYemJzatIUhaC0yeQF8vg9yV6aN4PmBmfrAoZV9WwBK4PE8hBjjLojw26
         vBQKbepGLzgDEkO+Cf3LdS89U6b4ArU6JX/rM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=CRfn0qPNYOfqoSC9QtMB+UqVckNDeuZwok7i3vN0BN6C0yxcLV0Kvzc4Pu0Zjvn8Xr
         SKaUnyPo05ZUv4cTtQeGuQLNTnYZkYv/INwJ+ihyHDuJHjKb+RHjEXPnj4MKTfgrv9uL
         VRMrBMVH6GGaGoJBP7pFxW5TcElr0yc6Hf+30=
Received: by 10.114.24.15 with SMTP id 15mr8744752wax.32.1279603081187;
        Mon, 19 Jul 2010 22:18:01 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id c11sm17888267rvf.3.2010.07.19.22.17.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 22:18:00 -0700 (PDT)
In-Reply-To: <4C4511C8.8090405@workspacewhiz.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151303>

On Jul 19, 2010, at 8:02 PM, Joshua Jensen wrote:

> I have some files I update frequently where I have some normally  
> commented out debug code purposely uncommented during development.   
> Git's hunk-level staging saves the day.  I can stage everything but  
> the debug code without issue.
>
> This got me to thinking.  Is there a better way?  Is there a  
> facility in Git where I could mark a hunk as 'permanently frozen  
> unstaged'?  Anything marked as such would never be staged for  
> commit.  I could rest assured I would never accidentally commit my  
> debug code, be it extra printfs or a development server or a  
> password or so on.

How about keeping your debug changes in a separate branch?  I work on  
a branch called 'hack', to which I'll commit pretty much anything.   
When a patch is ready, I cherry-pick it from master and rebase hack  
onto master.[1]

Passwords which are so sensitive that they can't ever be checked in  
should be stored in ignored files or outside the repo entirely.

Josh

[1] It's actually more complicated than that.  I create 'tip' as a  
merger of master and my formal topic branches, and hack stays rebased  
on tip.
