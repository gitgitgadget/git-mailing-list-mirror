From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-svn and svn:externals, was Re: Hackontest ideas?
Date: Tue, 29 Jul 2008 12:08:55 -0400
Message-ID: <32541b130807290908l13e753d8t1357db452a04f491@mail.gmail.com>
References: <20080729000103.GH32184@machine.or.cz>
	 <m3myk1t54c.fsf@localhost.localdomain>
	 <alpine.DEB.1.00.0807291354130.4631@eeepc-johanness>
	 <200807291428.32072.jnareb@gmail.com>
	 <alpine.DEB.1.00.0807291502450.4631@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, "Petr Baudis" <pasky@ucw.cz>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 18:09:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNrls-0003Fe-PO
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 18:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757598AbYG2QI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 12:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754729AbYG2QI6
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 12:08:58 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:11592 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbYG2QI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 12:08:57 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5109993rvb.1
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=d/gFCuz30oZjQVpDUN+Kv0hJLEMxyj0W5Xq6reXzDpk=;
        b=uArYQNs31iWVyviz3fBbNlWmxVBpNoDUfF7b6teqpwpQ/Mh1h4k2XGVyMcl3BRBv+V
         GGqmN4F8Y4wo3jtuyZtA7UK5czNiHU7UYjMLSAhyBrBaAwAN4DQ8iZ9C6a9oBiG5unBV
         CJ+A8MxuW3eT1Qt1OtXSabWmnDrZcZf+3FbB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=x0XcAxzJD+55VgUZgz/4JE/hDB036FzykFliGJzxa0zUFCs7YP5IqCUczLLB8J0sqr
         fwq9Nyo10A4WwAzUr+zSSiEp1LTCSIt9tjBRMLZBpCvAq7Ir7yhdCkVhHidqB4Vqa+BL
         u8IvSd8o6UzYjVNsrIZ75lUjO+IXEQvfpAZPo=
Received: by 10.140.170.12 with SMTP id s12mr3311068rve.83.1217347735722;
        Tue, 29 Jul 2008 09:08:55 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Tue, 29 Jul 2008 09:08:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807291502450.4631@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90651>

On 7/29/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  On Tue, 29 Jul 2008, Jakub Narebski wrote:
>  > If I understand correctly with version 1.5 svn:externals can be
>  > specified using "peg revisions", so they could refer to some specific
>  > revision of 'external', like git submodules.
>
> ... which only means that if they had done that from the beginning, it
>  the git-svn enhancement would be easy.
>
>  But as they did not have it from the beginning, anybody tackling git-svn
>  and svn:externals will have to come up with sensible semantics for the
>  hard case.

One option would be to simply attach the submodule to the "latest
commit of the svn:external at the time the supermodule svn commit was
made".  Basically, enforce git-submodule's precise revision feature
retroactively onto svn:externals.

I think this would be perfectly fine in my own projects, for example:
it's what I wanted in the first place, but svn didn't have this
feature, so I faked it by branching/tagging the external repo whenever
I wanted to link to a particular revision.

Have fun,

Avery
