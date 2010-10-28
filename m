From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/10] Change remote tracking to remote-tracking in
 non-trivial places
Date: Thu, 28 Oct 2010 13:39:19 -0500
Message-ID: <20101028183919.GD14212@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288290117-6734-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Oct 28 20:39:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBXNt-0005Uh-6f
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 20:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761383Ab0J1Sj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 14:39:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43135 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761382Ab0J1Sj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 14:39:26 -0400
Received: by fxm16 with SMTP id 16so2235258fxm.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yqS0WLtoWCnoKnHNDnz49ocF/1wUANZCKbw2E3GqSjA=;
        b=w7h4mopppddAHDzbSYrmvGx5WcPjrtjmfSk4lwJtaRIA3g1t76lTiWPNmHq4W9OAGH
         0tpp5cwyyAMxIyszRthzIgnynSIBco1i0Rnt4pX+6vXJjog5mAZqVfqByJnE7HTCyTnD
         NSCwvkPBhUo+BarER06ey5FRKZkeIQf526mBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=d0oH4ivpPRpczF53uBxZQMoU+frgnGzxUFniZjWgg/R4qlp4gytQPmpcTEZPQLz84a
         U6yAigFJ4DmovdstIVqVnDPFMT0ZrIIvxaWQY3MI4XjVJKkA++U7LafwZLOETl72LDEa
         ZpK1UDkoI80/yWgn6tNpE++L/+gDbxZ46tfNk=
Received: by 10.223.101.142 with SMTP id c14mr4348683fao.94.1288291164902;
        Thu, 28 Oct 2010 11:39:24 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 10sm645286fax.18.2010.10.28.11.39.23
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 11:39:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288290117-6734-4-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160206>

Matthieu Moy wrote:

> --- a/Documentation/everyday.txt
> +++ b/Documentation/everyday.txt
> @@ -180,12 +180,12 @@ directory; clone from it to start a repository on the satellite
>  machine.
>  <2> clone sets these configuration variables by default.
>  It arranges `git pull` to fetch and store the branches of mothership
> -machine to local `remotes/origin/*` tracking branches.
> +machine to local `remotes/origin/*` remote-tracking branches.
>  <3> arrange `git push` to push local `master` branch to
>  `remotes/satellite/master` branch of the mothership machine.
>  <4> push will stash our work away on `remotes/satellite/master`
> -tracking branch on the mothership machine.  You could use this as
> -a back-up method.
> +remote-tracking branch on the mothership machine.  You could use this
> +as a back-up method.
>  <5> on mothership machine, merge the work done on the satellite
>  machine into the master branch.

Just for the record: I still don't think this hunk fits with the rest
of the patch, and I think it just switches from one bad wording to
another.

This is the "Everyday git" document, one of the first pages a new user
might read.  Using jargon that does not explain itself (whether it is
"tracking branches" or "remote-tracking branches") is not really a
good idea.

Wouldn't it be possible to split this into a separate patch, so it
does not hold back the other "add hyphen" changes?
