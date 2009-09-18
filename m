From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-push: add option --repo-all
Date: Fri, 18 Sep 2009 01:52:49 -0700 (PDT)
Message-ID: <m3r5u43a8h.fsf@localhost.localdomain>
References: <1253258222-11475-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Fri Sep 18 10:52:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoZD9-0006R8-Ek
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 10:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbZIRIwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 04:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbZIRIwt
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 04:52:49 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:54500 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbZIRIws (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 04:52:48 -0400
Received: by bwz6 with SMTP id 6so548505bwz.37
        for <git@vger.kernel.org>; Fri, 18 Sep 2009 01:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=4/TMlDSB1Jb8hk8NNNu5q0piWfOwjKeV0SOyVCRKB/s=;
        b=tYYiIYl6PcRg4otnMrYF4Tj5QKRAVv9D7f3ncojY1AaD41XL4LbUnY9MBc7iiESsp1
         3tQ4f5UuMH4iZtpkAuCGZC1CTsfXb/PVt2v0UZ76UD47DmHSfTdOXYRe+0qGjhFEXFs6
         6FdxDjDhYQxtlKAuxaBiV0H8Jz1oeyhL9VvWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=wmVuDDAHAnF8CSk3EWExX3hSndvGu8oj6oXvK26I+fAf+BtHg/t7zvO2rj8RdYkAlF
         gMlIyWys8GRcbxmSSCBhS7XdQ0iqfE/eBoBT79ZASdnUCnSo/0YsOhYrS/H90s75MPRr
         B0gxg4Y4cncute+dwR0obXHe7r3m2OWIQaqss=
Received: by 10.86.225.38 with SMTP id x38mr1504752fgg.59.1253263971427;
        Fri, 18 Sep 2009 01:52:51 -0700 (PDT)
Received: from localhost.localdomain (abvh88.neoplus.adsl.tpnet.pl [83.8.205.88])
        by mx.google.com with ESMTPS id d4sm1744563fga.8.2009.09.18.01.52.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Sep 2009 01:52:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n8I8r5W1005096;
	Fri, 18 Sep 2009 10:53:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n8I8r3xp005090;
	Fri, 18 Sep 2009 10:53:03 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1253258222-11475-1-git-send-email-catap@catap.ru>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128792>

"Kirill A. Korinskiy" <catap@catap.ru> writes:

> Example of usage: I write some software on my laptop and some time
> pushing to my home/private server for backup. Some time ago my
> software is done and I openin it on github, but I'm don't like kill my
> private repos. Now update a two remotes repo is'n sexy, because I'm
> need using a some shell wrapper:
> 
>     git remote show | while read repo; do git push $repo; done

Signoff?

> ---
>  Documentation/git-push.txt |    4 ++-
>  builtin-push.c             |   34 +++++++++++++++++++++-----------
>  t/t5523-push-repo-all.sh   |   46 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 13 deletions(-)
>  create mode 100755 t/t5523-push-repo-all.sh

I have created 'pushall' *alias* for that purpose, but I think that
such functionality would be better added to "git remote" rather than
to "git push".

-- 
Jakub Narebski
Poland
ShadeHawk on #git
