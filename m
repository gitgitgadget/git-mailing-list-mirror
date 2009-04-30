From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Thu, 30 Apr 2009 09:18:08 +0200
Message-ID: <46a038f90904300018u7101943blef084dc907a04c8d@mail.gmail.com>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>
	 <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>
	 <49F8B7D1.2090903@drmicha.warpmail.net>
	 <46a038f90904291347i2ed158aaya7505e1bd11cd392@mail.gmail.com>
	 <49F8C127.4000400@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 09:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzQXF-0001D0-9Z
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 09:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbZD3HSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 03:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbZD3HSL
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 03:18:11 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:56431 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbZD3HSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 03:18:09 -0400
Received: by fxm2 with SMTP id 2so1632567fxm.37
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 00:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=quJ0f4c3H2j9BR64RdJLrnZTaTlqbfve4oUhmuiJSMY=;
        b=C9hfYBt5eb9hn2tGzHpadGj1AlJySfJ0u/+40T7LksR/eh8xIRQjj3MnRiuABHVGNH
         reMHl5/tTvGJagSmfuVwFuKUbo1McdIkCHUcTU6iuv9fPg1ecrfYJ0vY3h4RJwsByjAm
         9TIIcwfn7RJyqRRpIFqr25i90onRHAisIYO6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ba5BLKWnBzjdf/PxJZbkhSRaQXOaVOOE7YDeXlnT51CnjxNDoeXD7txSBhlW7xcGTk
         39TPzbanyDT0l70/CoWvC/0zqd6e3IMRjKmApswvOO1VIleQXyr+zBYvGzzDho99Wv/L
         4qkCwACVT49gDhX5FQKQuoUyC0Nb5ECfzMhas=
Received: by 10.223.113.9 with SMTP id y9mr572845fap.61.1241075888230; Thu, 30 
	Apr 2009 00:18:08 -0700 (PDT)
In-Reply-To: <49F8C127.4000400@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117993>

On Wed, Apr 29, 2009 at 11:05 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> But I just re-read your original report, and there's some inconsistency:
>
> git-svn triggers cat-file's usage message which says "git-cat-file ...".
> The dash indicates that it is a git cat-file before v1.6.0.1-13-g34baebc
> (where the dash was removed), so it's definitely not the current maint
> you think you are using.
>
> Do you have older ubuntu git packages installed in $PATH?

Bingo! Yes,

~$ which git-cat-file
/usr/bin/git-cat-file
~$ /usr/bin/git version
git version 1.5.6.3

now that's really weird. git from ~/bin is using git-cat-file from
/usr/bin instead of ~/libexec/git-core ... how is the libexec path set
in the PATH during the execution of the script?

the funny thing is that Ubuntu wants to have git-core in place if
you're rebuilding kernel packages. I don't need to rebuild my kernel
anymore but I am sure this is an issue for others. What's the trick?
Add the libexec/git-core to the PATH before /usr/bin? Should git
internally append libexec/git-core earlier in the search path?

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
