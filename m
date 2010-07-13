From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git am mangles commit author name.
Date: Tue, 13 Jul 2010 00:49:49 -0500
Message-ID: <20100713054949.GB2425@burratino>
References: <AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel F <nanotube@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 07:50:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYYO8-0001Tg-VD
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 07:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825Ab0GMFug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 01:50:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44101 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab0GMFuf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 01:50:35 -0400
Received: by iwn7 with SMTP id 7so5484541iwn.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KRXh0/v5DX1+iPHpbmoGlGSJWly4XUZ8KROx5evdeEE=;
        b=kqP76gQQc12Ga21e31uOkaNpvu9a2TNt9zx/YIp2QJGPjys8pP9FiEEqIyzxgM+9+f
         gAFrSu4bZeT58gNCbKDZ4GCll8cDGlLHGafYIKop9Flk1uKefFgGO1odw5lo3GrA6iP3
         FpOmwnCZkp4Dl9kpgsx77kYGwGLf+1u7eaYeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=T4/oFe7D0+JiMKjxLGoexGgibc6N9f6o89SCxVMi0E13CxLEojDzskJ8EH1CiEBhKW
         rgddjmnq3rTy0RhlxyvdsFJc9BuqRlh4PuzoV+QepJV/FrJKS4H3GxB2NwDIN0+yb3qM
         78C3fbpVoTK5osFt5t8rP19nARZHYIV8mcWZY=
Received: by 10.231.192.144 with SMTP id dq16mr16483490ibb.28.1279000234639;
        Mon, 12 Jul 2010 22:50:34 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm23361730ibk.3.2010.07.12.22.50.33
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Jul 2010 22:50:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150877>

Hi Daniel,

Daniel F wrote:

> The file contains the line (along with the rest of the patch, of course):
> From: username <emailaddress>
> 
> So I do the following:
> git am --signoff < patchfile.patch
> It applies just fine, but the commit author shows in in git log as:
> emailaddress <emailaddress>
> (i.e., the username is nowhere to be seen)

Because I am lazy I tried with the latest 1.7.2 release candidate.
Here is what I did:

 $ git fetch git://repo.or.cz/git/jrn.git rr/svn-fe
 $ git checkout FETCH_HEAD
 $ git format-patch HEAD^..HEAD
 $ git reset --keep HEAD^
 $ git am --signoff <0001-*

The commit author showed up with name and email address as I expected.
What did I do wrong?

Alternatively: could you send the first few lines of your .patch file?

Thanks,
Jonathan
