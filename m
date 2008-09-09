From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Tracking OpenOffice files/other compressed files with Git
Date: Tue, 09 Sep 2008 13:07:10 +0200
Message-ID: <48C658DE.3070001@gmail.com>
References: <Pine.LNX.4.64.0809090715520.19359@ds9.cixit.se> <48C61F94.3060400@viscovery.net> <loom.20080909T085002-376@post.gmane.org> <48C6569C.60000@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 09 13:08:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd15D-00054s-1R
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 13:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbYIILHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 07:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbYIILHQ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 07:07:16 -0400
Received: from el-out-1112.google.com ([209.85.162.179]:49269 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbYIILHO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 07:07:14 -0400
Received: by el-out-1112.google.com with SMTP id z25so239459ele.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=/XHL3OCzAst1yRUIUreXWV8ooeeEaKY0mwacUk1Sp0U=;
        b=lzKRO5FwzX/mouPvsXbsdQr3j4zwQlY9pvc2AAotTqdL+shUcSZ5HRmbin/OxcEyoh
         4UzIC8qoY5VU8wUxaZVmZevElAuxhsS1JI2wXOfUTlCA2NCA/1JLfVDpKwi1BL34P8Fu
         H+O2OQkWLM/baUvXufyc4hPZSyqIbTMVqcFYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=j+wn434nN1FCjeLEiRypuMaOAA8j8Y+pDulEOBt9nlCnchvl8C6gkAKCGlQv7WLuim
         v7WlkVuUitzl7ZaP/6XOQO2Qt3i647j2uOoEbs+H/Xs4JJw9UhZGhkXEXnS7jFxh/wos
         6dj5qIng94ldfdjYoANIkXPMRoHSIkoxeYlXQ=
Received: by 10.103.247.5 with SMTP id z5mr11131178mur.31.1220958432241;
        Tue, 09 Sep 2008 04:07:12 -0700 (PDT)
Received: from ?137.204.201.149? ( [137.204.201.149])
        by mx.google.com with ESMTPS id s10sm8646052muh.12.2008.09.09.04.07.10
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 04:07:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <48C6569C.60000@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95373>


> You don't need to smudge the OOo file on checkout iff OOo can read a file
> that is "compressed" at level 0.
>
>   
I will check again then, since my first attempt at this was not very 
successful and I think I was getting dirty files even cleaning only.  
But it was a long time ago right after clean was introduced.

But in any case it would be preferable to smudge on checkout since 
uncompressed OO files can be quite huge.
Also to have uncompressed OO files in the worktree means that if you 
ever need to send one as an attachment to somebody you need to reopen 
and resave it before making the attachment, which is a bit uncomfortable!
> A file that you have just 'git add'ed must not show up as dirty even if it
> was processed by a "clean" filter. If it does, then this indicates a bug
> in git, and not that a corresponding "smudge" filter is missing or
> misbehaves. Yes, I have observed this with my own "clean" filter some time
> ago, but I have not yet tried hard enough to find a reproducible test case.
>
>   
But am I correct in saying that it will show dirty if you clean and then 
smudge in a non symmetric way?

Sergio
