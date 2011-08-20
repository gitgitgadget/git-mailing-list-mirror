From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: Add AUTH LOGIN support
Date: Fri, 19 Aug 2011 18:01:31 -0700
Message-ID: <7vsjowzyj8.fsf@alter.siamese.dyndns.org>
References: <c1be0c3bd05779897fdc92907fe65d84c88ac72b.1312591104.git.joe@perches.com>
 <7vzkjn16n6.fsf@alter.siamese.dyndns.org>
 <1312608114.6419.18.camel@Joe-Laptop> <1313716585.11178.2.camel@Joe-Laptop>
 <7v1uwh0zj4.fsf@alter.siamese.dyndns.org>
 <1313796280.11178.25.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Graham Barr <gbarr@pobox.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 03:01:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuZwS-0004ZE-Oc
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 03:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777Ab1HTBBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 21:01:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60316 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156Ab1HTBBe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 21:01:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71A2D5AE5;
	Fri, 19 Aug 2011 21:01:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jfmDfCmU1vQZftmi50X9g/Wo9kE=; b=ie3wsB
	lsloEfDWGy/lHSHiMfg/apoOAJiFrPzBCCLv2hVbd1S8Ngf9OpXO/6/CiFgK0l3r
	v4mpTzesOf4CyCeAQB05AmaDvq1gR2SdtE5RBOx3EEV6VVx3KXoNSNrngr1L0e0M
	4fjspaf4BU5aC3GTdaelKHo/S1gBDn/ugqmZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W+zFJtKwg5JfeWg/nVquEmU+VC1fxTuA
	jqMQeRJF3vW9cSR+aHTCOvKNS1paBrntmB30IELT8bZAcl3C2ZmK6coZJFFfwxI+
	AIcKT8orblCaYMLA8r3eRDSEoWaIDofMPv/LVetEmnm4i6ccybcs+b0SbveLlbxD
	cnVYI4D31to=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68A185AE4;
	Fri, 19 Aug 2011 21:01:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E26AE5AE3; Fri, 19 Aug 2011
 21:01:32 -0400 (EDT)
In-Reply-To: <1313796280.11178.25.camel@Joe-Laptop> (Joe Perches's message of
 "Fri, 19 Aug 2011 16:24:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F20D699A-CAC7-11E0-B7C0-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179747>

Joe Perches <joe@perches.com> writes:

> I've sent a couple of other patches to git-send-email.
>
> http://marc.info/?l=git&m=131190328311281&w=2
> http://marc.info/?l=git&m=131131975804893&w=2
>
> Any comments or plans to ack/nack those?

Sorry, but I am not personally interested in send-email enough to go to
marc.info archive that does not give me the message in ready-to-apply
format with "git am". 


On-list discussion is the most important signal I use to convince myself
that the issues that discussed patches attempt to tackle are worth
addressing. When I do not see any discussion, I myself may decide that
they are important, or I may not.

Re-sending them might get others with similar needs for the patches
involved in the discussion.

Here are what _I_ think about the above two.

 - I've seen enough complaints that send-email sends too many Cc:s to
   unintended parties, and of an opinion that these extra recipients should
   be added to the files you feed to send-email as headers, instead of adding
   noise to commit log messages, so adding new Cc sources and then giving a
   way to suppress them didn't look like a good change to me.

 - I think I saw a few positive responses to the "editor cruft" patch, but
   the way the patch was implemented, it will invite low-value "my obscure
   editor uses this pattern, so add it" follow-up patches, and compared to
   that downside, I didn't like the benefit of the patch well enough to pick
   it up.
