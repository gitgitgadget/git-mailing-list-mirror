From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Specifying multiple refspecs in remote.{remote}.fetch
Date: Sat, 20 Jun 2009 00:42:34 -0700 (PDT)
Message-ID: <m3eitfgxln.fsf@localhost.localdomain>
References: <2cfc40320906192337g66db81f0w92e06adfc6a189c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 09:42:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHvDp-0003JB-I6
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 09:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbZFTHmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 03:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbZFTHme
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 03:42:34 -0400
Received: from mail-fx0-f214.google.com ([209.85.220.214]:52405 "EHLO
	mail-fx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbZFTHme (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 03:42:34 -0400
Received: by fxm10 with SMTP id 10so46415fxm.37
        for <git@vger.kernel.org>; Sat, 20 Jun 2009 00:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=iD51OnrP99XZHNpdZlwrBU3qgs1YJ0VIM2HTRbipeGA=;
        b=Gr122GDWPS7GRueA7l9so7IarQQUNCdUMyfujG3yFXl/hiIfUQcxxefWTsid5RiEVe
         5AwnPzhf4YycJ369CiHTqntIGVoI5UZd6AZ2DFul1KQ2WhEKz/3CXCB5za2YhGSbuK4K
         cY+MvFH/GePK34Dxld+paZm/0oqJadANaF7dE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=FXRCrruJfNyquyKJOSAJG8qYyyMxT8Cpv6TpCbZHPSul00FfDpKDiww2oF/J7WOqb6
         Ra5g56qHKgP5LdhLU5ZysoBQVCa8MG84Fa0bF+R+kEU9HcgICIUIWht40gToEuZTcyer
         DA2mKvUkchbjkbrjc1tiK0Ul3PqEchSZSgxI4=
Received: by 10.86.59.18 with SMTP id h18mr3928930fga.14.1245483755710;
        Sat, 20 Jun 2009 00:42:35 -0700 (PDT)
Received: from localhost.localdomain (abwr61.neoplus.adsl.tpnet.pl [83.8.241.61])
        by mx.google.com with ESMTPS id e11sm524522fga.16.2009.06.20.00.42.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Jun 2009 00:42:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5K7gVIb031248;
	Sat, 20 Jun 2009 09:42:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5K7gTHL031245;
	Sat, 20 Jun 2009 09:42:29 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2cfc40320906192337g66db81f0w92e06adfc6a189c9@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121936>

Jon Seymour <jon.seymour@gmail.com> writes:

> It doesn't seem to be possible to specify multiple refspecs in a git config.
> 
> I want to do this:
> 
> remote.hub/pub/release.fetch=+refs/heads/*:refs/remotes/hub/pub/release/*
> +refs/tags/*:refs/tags/hub/pub/release/*
> remote.hub/pub/release.tagopt=--no-tags
> 
> but git fetch complains:
> 
> fatal: Invalid refspec '+refs/heads/*:refs/remotes/hub/pub/release/*
> +refs/tags/*:refs/tags/hub/pub/release/*'
> 
> Now, in theory, I could use a file in remotes/ to specify multiple
> Pull: lines. This works if my remote doesn't have slashes in its name,
> but it doesn't work if my remote does have slashes in its name since
> git doesn't recognize remote files located in sub-directories of
> ${GIT_DIR}/remotes.

And you can put multiple values for the same remote.hub/pub/release.fetch
key, using "git config --add".  

  $ git config --add remote.hub/pub/release.fetch \
        +refs/heads/*:refs/remotes/hub/pub/release/*
  $ git config --add remote.hub/pub/release.fetch \
        +refs/tags/*:refs/tags/hub/pub/release/*
  $ ...

You would get the following config:

  [remote "hub/pub/release"]
        url = ...
        fetch = +refs/heads/*:refs/remotes/hub/pub/release/*
        fetch = +refs/tags/*:refs/tags/hub/pub/release/*
        tagopts = --no-tags

You don't put many refspecs in a *single* value.
 
> Is it a reasonable expectation that:
> 
> * git should support multiple refspecs specified via git config?

It does.

> * git should support subdirectories in ${GIT_DIR}/remotes?

It does.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
