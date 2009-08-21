From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issue with gitweb + tag + branch of the same name from master
 branch commit
Date: Thu, 20 Aug 2009 17:19:02 -0700
Message-ID: <7vmy5um32h.fsf@alter.siamese.dyndns.org>
References: <1250811031.26147.42.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J.H." <warthog9@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 02:19:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeHqo-0005uN-Rh
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 02:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbZHUATR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 20:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754821AbZHUATR
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 20:19:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbZHUATQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 20:19:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3287831A04;
	Thu, 20 Aug 2009 20:19:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=Z3uaLlbitNsLuY0DypELOzxUH54=; b=vIdFhk
	AL1569nwRMOJ0tATc2frWGB+FhAZCr4r7GmI8EdDMjwGaqbkq2MRc8oiGXiWc4h2
	8lKaOyXqPAwP3QCjLECc5D1oLII+BXKD3lqYXZ3bJS2UYCEg4sR3UxepeSqJRqDm
	Eh/KsWxo15Sdo1R7L5ZxmWlAwqA1XPRjOdPL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xgqmm22onx0DX8jaH3T59qzGsdptDl3s
	CeQ8xoZxvqUi0XbIfmp/XHyga1Fw8rSPKyNCGaqdMQkXDRIRYBlt3IJ4FtSxRSla
	Mv8kK7LpxuiP9Z6FnJ4CtmZ2F4VkF/hdxSViG+A+XdQdNMyGwf6Y/YazsKu0G2wM
	7Cf0eVCcovQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EE79631A03;
	Thu, 20 Aug 2009 20:19:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5091C31A00; Thu, 20 Aug 2009
 20:19:03 -0400 (EDT)
In-Reply-To: <1250811031.26147.42.camel@haakon2.linux-iscsi.org> (Nicholas A.
 Bellinger's message of "Thu\, 20 Aug 2009 16\:30\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 41896FF6-8DE8-11DE-8FFB-3142836986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126665>

"Nicholas A. Bellinger" <nab@linux-iscsi.org> writes:

> 22:33 < warthog9> not use the same name, I think what your doing is fine just the identical naming is whats 
>                   causing the problem
> 22:33 < warthog9> like tag-lio-3.0
> 22:33 < nab> Ahhhhhh
> 22:33 < warthog9> and branch: lio-3.0
> 22:34 < warthog9> since I think somewhere in git it's got two different orders of preference for tag vs. branch

I do not speak for gitweb but we typically favor tags over heads.  The
only place "branch name" take precedence is where the command expects to
see a name of a branch, when it can also take any arbitrary object name,
and changes behaviour.  I.e. "git checkout X", when X is a branch name,
checks out the branch so that the next commit advances the tip of that
branch.
