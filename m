From: bill lam <cbill.lam@gmail.com>
Subject: Re: combine git repo historically
Date: Sun, 11 Oct 2009 12:06:59 +0800
Message-ID: <20091011040659.GB9021@debian.b2j>
References: <20091009012254.GA3980@debian.b2j>
 <4ACED204.3000907@viscovery.net>
 <20091010140358.GA3924@debian.b2j>
 <200910110436.52653.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Oct 11 06:30:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwq4H-0000DF-2e
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 06:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbZJKEHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 00:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbZJKEHn
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 00:07:43 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:61948 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbZJKEHm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 00:07:42 -0400
Received: by pxi9 with SMTP id 9so7783124pxi.4
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 21:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MBAty+vdFPclmmx3X4iWizUfXNVThHveG6R0acejz3Y=;
        b=Kh2FUtiVhUSIBFb122JsL9pOnqPbqTiubhohfOYy0LEYSKaxmf4l43BLcafJUQqVHY
         mh8BdrCNlrAeDQZ3Ij+iHp7067J3md5zrZrnFo7gOReHcEmnTQiX/zFCKFwbIYNqD/gt
         +RQ8c2bBc1wfuW57S9eYzCeDgkz9+m+06qCiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nv/uWlt1STJYfn0yindw6dy58gv/sSuwUgmA9tHbvXuurOkd38qfazU0Dm+ZAh+XjG
         GFZtNKatk+FEG8XN/y2x4DRLdbD7rZFTw2uxGDghuje0DIQsaSXaI8gJh2PAhQ/sZlVe
         FxqfrGe4tJV4FKyxb/i7e8LoAud8bQtqIsGBI=
Received: by 10.114.69.19 with SMTP id r19mr54388waa.117.1255234026018;
        Sat, 10 Oct 2009 21:07:06 -0700 (PDT)
Received: from localhost (pcd632137.netvigator.com [218.102.164.137])
        by mx.google.com with ESMTPS id 22sm682901pzk.14.2009.10.10.21.07.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Oct 2009 21:07:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200910110436.52653.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129903>

On Sun, 11 Oct 2009, Christian Couder wrote:
> $ git checkout -b repo1-branch1 remote/repo1/branch1
> $ git checkout N -- .
> ...
> If everything is ok then you can use:
> 
> $ git replace N HEAD

Thanks for detail instruction, I tested it ok except that when trying
to checkout it reported an error

  $ git checkout -b repo1-branch1 remote/oldjproject/master
  fatal: git checkout: updating paths is incompatible with switching branches. 
  Did you intend to checkout 'remote/oldjproject/master' which can not
  be resolved as commit?

but it ran ok by omitting that 'remote/'
$ git checkout -b repo1-branch1 oldjproject/master

Does it need to purge the file system tree before
  git checkout N -- .

so that there will be no artifact leaved by M?

I found that it is necessary to do a 
   git reset --hard (original HEAD)

to complete the story. Is it correct?

git version 1.6.5.rc3.35.g3340

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
