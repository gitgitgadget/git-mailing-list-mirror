From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git config not expanding user home directories
Date: Tue, 30 Sep 2008 04:38:46 -0700 (PDT)
Message-ID: <m33ajhsw24.fsf@localhost.localdomain>
References: <F90667E7-6B06-4B34-B655-3C42ED236D9A@netspot.com.au>
	<48E2043A.4000501@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Lanyon <tom@netspot.com.au>,
	Git Mailinglist <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 30 13:40:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkdaD-0003vu-41
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 13:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbYI3Liu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 07:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbYI3Liu
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 07:38:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:2268 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbYI3Lit (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 07:38:49 -0400
Received: by nf-out-0910.google.com with SMTP id d3so844943nfc.21
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=BmFr+7YRbchKKOx3BpE6hmDiZmAYq5my75kkSSnZ8TQ=;
        b=Mle8YttibTghKJuLjGGYP+aAaAHl77X0FUdyBJi0Ls37KMyy7tY6tH2wHTLdyyAf6s
         8ASeqdQjS7aVDE/K0lzR1dvdxEzCq5IZDO4J/gwoe5Yf4N3dlyIMk/tcsBDLeZQWUrjr
         QNSc/FQGXH0XO2YzbCgt5eYbZvUUeNfWQKK/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=gyAkFdEXxPAddRmMSXEdwZbuIdC7/weaEqjq3z76mi4oLJAKmXqe6AurCes1yApWwh
         Ix9bAfxnX4pvRH7BxGCb5A0m1EAChmNjen3KQczKEtKT/UTqyXTCkHKO9UQI8u9pjzeQ
         1z/OwNhtOa2bO4ogFpIAZ4rZ9Dswn2OEsk6eM=
Received: by 10.103.222.12 with SMTP id z12mr4713401muq.95.1222774727441;
        Tue, 30 Sep 2008 04:38:47 -0700 (PDT)
Received: from localhost.localdomain (abvy102.neoplus.adsl.tpnet.pl [83.8.222.102])
        by mx.google.com with ESMTPS id s10sm1727285muh.12.2008.09.30.04.38.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 04:38:46 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8UBcXYZ007855;
	Tue, 30 Sep 2008 13:38:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8UBcS81007849;
	Tue, 30 Sep 2008 13:38:28 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <48E2043A.4000501@op5.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97103>

Andreas Ericsson <ae@op5.se> writes:

> Tom Lanyon wrote:
> > 
> > Is it normal behavior that git (well at least git-svn) won't expand
> > ~user from .gitconfig?
> >
> 
> Yes. You could add a patch for that though. git-daemon does ~user
> expansion since quite a long time back, so there's a function ready
> for it. I'd do it by doing something like:
> 
>    git config --path section.key
> 
> so that scripts can get the user-expanded version as well. In-core
> applications can call expand_path() or some such on their own, I
> think.

There was a patch send to git mailing list adding basic '~' support
(I think via $ENV{HOME}), and IIRC even ~user support. I don't know
what happened to those patches (check mailing list archive), but
most probably it was not accepted because it didn't provide a way
for scripts to use this functionality, for example via --path option.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
