From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git Perl bindings, and OO interface
Date: Sun, 30 Nov 2008 06:50:38 -0800 (PST)
Message-ID: <m37i6ljmjy.fsf@localhost.localdomain>
References: <200811270258.50898.jnareb@gmail.com>
	<200811301445.18969.nadim@khemir.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: nadim khemir <nadim@khemir.net>
X-From: git-owner@vger.kernel.org Sun Nov 30 15:52:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6nf0-0005NG-Tz
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 15:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbYK3Oum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 09:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbYK3Oum
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 09:50:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:54889 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbYK3Oul (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 09:50:41 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1089922nfc.21
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 06:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=2sn4kgYIGOWGNrz7JMmPQ4wPI6gnoKVZwfbwrOeOBn4=;
        b=VaH6faUZD48GQV9dvDn9nf0A/Z9CmgZOqurs+9p5IkQQVWPAlW0XMbD2A/rOAYW8Da
         dnmiwwl/04/J8tGwq+2PMLCYaEQPUrdUHpF9yKLmWtFJQdfsC4jH81BJygwDcsfnm00g
         aBjDGHmyxR4YVwsYiw4RE6anV8iy/Ku5EjCJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Kq/KeO5jR+WoJi2i76jx/z8u++z3zvu2oCEHz4dTTF+qXcyL/RBRCoAiYkmSRLD0E5
         G8Qmpk8h+SQbAYXnmkKfTz607cxHyIbdaZuoYuCtHKy6UuEGktNpPUH6+gPGAEAPBuFT
         4h8kkS9+wikRYAlB49vdVSnF0K+r3b1Q+N/gY=
Received: by 10.210.27.20 with SMTP id a20mr11466891eba.138.1228056639568;
        Sun, 30 Nov 2008 06:50:39 -0800 (PST)
Received: from localhost.localdomain (abvs96.neoplus.adsl.tpnet.pl [83.8.216.96])
        by mx.google.com with ESMTPS id 3sm7927522eyj.51.2008.11.30.06.50.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Nov 2008 06:50:38 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mAUEo4lE001730;
	Sun, 30 Nov 2008 15:50:15 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mAUEnrYX001718;
	Sun, 30 Nov 2008 15:49:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200811301445.18969.nadim@khemir.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101974>

nadim khemir <nadim@khemir.net> writes:
> On Thursday 27 November 2008 02.58.49 Jakub Narebski wrote:
> > ...
> >
> > 7. Git::Refs
> >
> >    It is meant to represent references, mainly branches, and be filled
> >    using git-for-each-ref... and for example used for ref markers.
> >
> > There are probably a few things I have forgot about...
> 
> Thank you for writing the RFC, it's a very good start. I would like to see 
> some strategy for libgit[2] in the RFC. What is your opinion about that?

I do not know enought about libgit2 or even git unofficial internal C
API to talk about it.

I did not plan for Perl interface to be actual Perl bindings, using
libgit2.  Please remember that earlier effort of using XS (Perl <-> C
interface) failed because it relied on GCC support for -fPIC and was
not sufficiently portable... if I remember it correctly.  Calling Git
commands and massaging output would be enough for me.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
