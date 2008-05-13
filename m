From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: abouy git reset command
Date: Tue, 13 May 2008 01:33:37 -0700 (PDT)
Message-ID: <m3zlqu38ny.fsf@localhost.localdomain>
References: <17202423.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: amishera <amishera2007@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 10:34:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvpy2-0003y7-FN
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 10:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757548AbYEMIdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 04:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756952AbYEMIdo
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 04:33:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:38082 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757499AbYEMIdm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 04:33:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2075746fgg.17
        for <git@vger.kernel.org>; Tue, 13 May 2008 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=P/zvbSbxR3i149MfMs9cuDftLg1iorq4YPkZ2FR8R6Q=;
        b=txw/3k8f4hBn6MocA1MgSXqGzU1pUe6UOvzqK9Qk3vk27/Ku5YhTWEUC0r3H2MD4hfGhxIAjCzrNiJPT3U7f1FE2chi6HPtTRYky2Ytb345RwRODx0k7EJz8WJKf6HbKvFKlsWi/IFaWAKDF0LbTFsjMo6EBWGwFt2Gnava+rio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=uDKHGN/xF4wXvEivk4hz+2TjiKkjhds2VB+NgP+XVTmFDITPghum1MwgqKHZ6PkgTjmZUOJvHKAyfXxMh65Jdi5Sm45GrNzw+AsFnrKoPb4H/eRNrt8oCsF/d9Cb1w9uwAxtRpWXOQA7vrxvHVBLKBNjEiI3OFs6g9/9UKBSrZU=
Received: by 10.86.90.13 with SMTP id n13mr16020336fgb.3.1210667619180;
        Tue, 13 May 2008 01:33:39 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.255.15])
        by mx.google.com with ESMTPS id d4sm6751566fga.4.2008.05.13.01.33.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 May 2008 01:33:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4D8Xdps018598;
	Tue, 13 May 2008 10:33:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4D8Xca2018595;
	Tue, 13 May 2008 10:33:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <17202423.post@talk.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81999>

amishera <amishera2007@gmail.com> writes:

> I just want to make sure whether my understanding of that command is correct
> or not. I have 3 basic requirements:
> 
> 1. I have changed something after the commits and I think those are wrong.
> So I want to undo all changes and the working directory should reflect last
> commit:
> 
> git reset --hard HEAD
> 
> 2. I have some changes in the index and I want undo them.
> 
> git reset HEAD
> 
> 3. I just want to undo the last commit but not the working tree:
> 
> git reset HEAD^

If you mean by "undo last commit" reset HEAD pointer and index state,
then yes.
 
> If they are correct commands please let me know. 
> 
> Besides in the man page for git reset it is mentioned:
> 
> git-reset - Reset current HEAD to the specified state
> 
> Which means it is supposed to work with commits. But why is the same
> command work in case 2 and case 3 above?
> 
> Moreover, can any body tell me the use of
> 
> git reset --soft
> 
> The following language is confusing:
> 
> --soft
> 
>     Does not touch the index file nor the working tree at all, but
>     requires them to be in a good order.

git-reset is all about setting the HEAD pointer, or to be more exact
to set current branch (current head) reference.  There are three
degrees of it:

 --soft changes only current HEAD
 --mixed (default) changes current HEAD and index file
 --hard changes current HEAD, index file and working tree

If you don't give <commit-ish>, git-reset defaults to HEAD,
i.e. current version.  Thus "git reset --soft" is no-op, it does do
nothing.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
