From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 12 Jun 2009 09:56:47 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.0906120943560.5566@yvahk2.pbagnpgbe.fr>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com> <ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com> <20090612084209.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 10:09:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF1pG-0003UY-2w
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 10:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbZFLIJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 04:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753496AbZFLIJO
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 04:09:14 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:47912 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613AbZFLIJM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 04:09:12 -0400
X-Greylist: delayed 856 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2009 04:09:11 EDT
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n5C7sgJe030852;
	Fri, 12 Jun 2009 09:54:43 +0200
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <20090612084209.6117@nanako3.lavabit.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121396>

On Fri, 12 Jun 2009, Nanako Shiraishi wrote:

> It would be ideal if you can inspect the certificate and decide if you need 
> to ask for decrypting password before using it (and otherwise you don't 
> ask). If you can't do that, probably you can introduce a config var that 
> says "this certificate is encrypted", and bypass your new code if that 
> config var isn't set.

Is this really a common setup? Using an unencrypted private key sounds like a 
really bad security situation to me. The certificate is never encrupted, the 
passphrase is for the key.

And for the libcurl not supporting this, I figure it _could_ be done by simply 
letting libcurl prope the remote and see if it can access it without a 
passphrase as that would then imply that isn't necessary.

I'm not familiar enough with the code and architecture to deem how suitable 
such an action would be.

-- 

  / daniel.haxx.se
