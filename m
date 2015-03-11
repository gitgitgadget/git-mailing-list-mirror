From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: git commit --amend safety check?
Date: Wed, 11 Mar 2015 09:37:09 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1503110931100.26355@ds9.cixit.se>
References: <CAJo=hJuwdOzNZSVBRAPDz97Gdoi6JWvYxE0ufY+Hd9K8jjCqfA@mail.gmail.com> <xmqq8uf46ru8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 09:37:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVc8r-0003qj-EK
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 09:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbbCKIhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 04:37:20 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:58383 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751256AbbCKIhR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 04:37:17 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id t2B8bANH026687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 11 Mar 2015 09:37:10 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id t2B8b9ML026684;
	Wed, 11 Mar 2015 09:37:09 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <xmqq8uf46ru8.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Wed, 11 Mar 2015 09:37:10 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265316>

Junio C Hamano:

> Having said that, disabling --amend and forcing to use --force or 
> something when it is clear that the user is attempting something 
> unusual is a good idea.  But I am not sure what the definition of 
> unusual should be.

For commit --amend, I would say it would refuse to amend if the commit 
you are trying to amend

  1. was not authored by yourself (and --reset-author was not given), or
  2. is reachable (or is the tip?) from an upstream branch.

Of course, you should be able to do the amend commit, but then you 
would need to say something like "git commit --amend --force" to 
indicate that you really want to do that.

At least (1) would have saved myself from mistakes that take time and 
effort to clean up (I have used Git for eight years or so already, and 
I *still* do that kind of mistake every now and then).

-- 
\\// Peter - http://www.softwolves.pp.se/
