From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-fetch should not strip off ".git" extension
Date: Wed, 22 Oct 2008 09:55:15 +0200
Message-ID: <48FEDC63.8090104@op5.se>
References: <ee2a733e0810180459m5fd20365s3c27bea5c1f3f704@mail.gmail.com>	 <48FC5F1B.1050608@op5.se> <7vzlkz2jv7.fsf@gitster.siamese.dyndns.org>	 <ee2a733e0810210323j249c3460x881af6d6aefc647c@mail.gmail.com>	 <7vej29zy2r.fsf@gitster.siamese.dyndns.org>	 <81b0412b0810211506y400ba750k2613ba19f01fb57@mail.gmail.com>	 <7vd4htwp6v.fsf@gitster.siamese.dyndns.org> <81b0412b0810211543p6cb8c4ej49fb7fe70c3e2917@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, SLONIK.AZ@gmail.com,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 09:56:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsYaC-0001pd-4Q
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 09:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbYJVHz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 03:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbYJVHz0
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 03:55:26 -0400
Received: from mail.op5.se ([193.201.96.20]:41652 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbYJVHzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 03:55:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6E9DB1B80048;
	Wed, 22 Oct 2008 09:49:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.904
X-Spam-Level: 
X-Spam-Status: No, score=-3.904 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.495, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oQiRj29YojKX; Wed, 22 Oct 2008 09:48:58 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 6E4EB1B8006F;
	Wed, 22 Oct 2008 09:48:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <81b0412b0810211543p6cb8c4ej49fb7fe70c3e2917@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98837>

Alex Riesen wrote:
> 2008/10/22 Junio C Hamano <gitster@pobox.com>:
>> "Alex Riesen" <raa.lkml@gmail.com> writes:
>>> FWIW, I support Leo on that. The "established" behavior is stupid.
>> I am not inclined to respond to such an emotional argument.  On the other
>> hand, it is fair to say that the existing behaviour is established,
>> because it is backed by a long history, which you can objectively verify.
> 
> I found it illogical (well, stupid) and inconvinient
> 
>> *1* It would be a different matter if the patch at the same time removed
>> the fetch/clone DWIMmery.  At least such a patch would be internally self
>> consistent.
> 
> Good idea.

No. Bad idea. That would not only break people's fetch configurations if
they've done clone on repos without passing .git, but also mean users
would have to remember if a particular server names their bare repos
"project.git".

If you remove *all* DWIMmery from fetch/clone, you'd also break people's
expectations when they're fetching from each other, as they'd have to pass
"git://devpeer/project/.git" instead of just "git://devpeer/project", which
is what *looks* sane.

A good idea would be to always report the name the user used. 'git clone'
already does that, recording the non-DWIMmed URL in the remotes config.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
