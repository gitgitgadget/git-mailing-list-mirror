From: Raja R Harinath <rharinath@novell.com>
Subject: Re: [PATCH] C implementation of the 'git' program.
Date: Fri, 11 Nov 2005 12:28:08 +0530
Organization: Linux Private Site
Message-ID: <m3lkzv4qnz.fsf@harinath.blr.novell.com>
References: <20051110182631.3C5615BF90@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 11 08:01:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaSt7-000419-MO
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 07:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVKKG7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 01:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVKKG7v
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 01:59:51 -0500
Received: from main.gmane.org ([80.91.229.2]:48520 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751127AbVKKG7u (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 01:59:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EaSrt-0003jE-G3
	for git@vger.kernel.org; Fri, 11 Nov 2005 07:58:37 +0100
Received: from 202.144.95.245 ([202.144.95.245])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Nov 2005 07:58:37 +0100
Received: from rharinath by 202.144.95.245 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Nov 2005 07:58:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 202.144.95.245
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:MYezVAJ2/1vglE2dwC9FDgY8ePs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11565>

Hi,

exon@op5.se (Andreas Ericsson) writes:

[snip]
> As a nice side-effect, the patch also fixes the problem with
> 	make
> 	make prefix=/usr install
>
> Signed-off-by: Andreas Ericsson <ae@op5.se>
[snip]
> +# Force rebuild so that "make prefix=<something> install" Just Works.
> +.PHONY: git

This is bad, since it does the wrong thing for the correct way:

  make prefix=/usr
  sudo make prefix=/usr install

With your patch 'git' will be compiled as root.

- Hari
