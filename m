From: Andreas Ericsson <ae@op5.se>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 09:21:36 +0200
Message-ID: <4816CC80.9080705@op5.se>
References: <200804281829.11866.henrikau@orakel.ntnu.no>	 <alpine.LNX.1.00.0804281515480.19665@iabervon.org>	 <200804282329.21336.henrikau@orakel.ntnu.no> <4816C26D.9010304@op5.se> <f9d2a5e10804290009p17d291d5wf14e2bb58bedca63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Henrik Austad <henrikau@orakel.ntnu.no>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 09:22:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqkAa-0001FR-CO
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 09:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbYD2HVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 03:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbYD2HVp
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 03:21:45 -0400
Received: from mail.op5.se ([193.201.96.20]:48312 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054AbYD2HVo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 03:21:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 214881F08028;
	Tue, 29 Apr 2008 09:21:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hISQtTR8VGds; Tue, 29 Apr 2008 09:21:41 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 1C4F21F08063;
	Tue, 29 Apr 2008 09:21:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <f9d2a5e10804290009p17d291d5wf14e2bb58bedca63@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80664>

Russ Dill wrote:
>>  Colliding objects can never enter a repository. Git is lazy and will reuse the
>>  already existing colliding object with the same name instead.
>>
> 
> I think you are missing the point. One of the pluses behind originally
> using SHA-1 and the signed tags is that the system as a whole is
> cryptographically secure. You can verify from the public key of
> whoever made the tag that yes, this really is the source and history
> they tagged. Not only can DNS attacks be made, fooling users into
> thinking that they are really connecting to kernel.org, or whatever
> else server they expect to be connecting to, but also, the server
> itself may be hacked and objects replaced.
> 

If the server is hacked and objects are replaced, they will either
no longer match their cryptographic signature, meaning they'll be
new objects or git will determine that they are corrupt, or they
*will* match an existing object, but then that object won't be
propagated to other repositories since git refuses to overwrite
already existing objects. Either way, gits refusal to overwrite
objects it already has plays a part in making malicious actions
futile, since malicious code is only worth something if it's
propagated and actually used.

> I'm just not sure how much time it would take to find a collision.

Even crypto-experts are arguing about that, so I'm not surprised.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
