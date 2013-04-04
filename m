From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug: Git submodules can get into broken state
Date: Thu, 04 Apr 2013 14:07:35 -0700
Message-ID: <7vr4iqgg2w.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1304041758140.965@lap-x201.fen.aptivate.org>
 <7vmwtei1wu.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.02.1304042138100.965@lap-x201.fen.aptivate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wilson <chris+gitscm@aptivate.org>, git@vger.kernel.org
To: Chris Wilson <chris@aptivate.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 23:08:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNrOB-0003MP-QQ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 23:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762977Ab3DDVHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 17:07:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762830Ab3DDVHi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 17:07:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B49A13B57;
	Thu,  4 Apr 2013 21:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cjfRNQNwX5IP4MZD65qofitMvEs=; b=NLxFKK
	JsyMyW+7Fs3M+QmwymITeS2L2QvK16+nYtoHr8sPMDZbh9540hlPIC5ql4xwajkL
	LtfW7AMwl2eq+2llB2EILmQk9MaEXDk/X395ilPicKZHu/BRtE/H/jQqL25uuPOS
	gc6Sht2s/2WSPaVo+axM2RKtwQi9/GLachGBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DnPQ+Mn6FgDW1rlXNwYw4lIDtA0yo370
	v9dti17TQsEUZowjVm41key7+18xs1yiDaRqTHkXhlfKqlLKnVB37TSr8xZkBhVX
	867c0plHfPPVRk7lxZJE2ncyNHww1b7N1qB5QPIIrQgBbMU3rIKISszFgbohaIGY
	TT5370eIDKU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9130D13B56;
	Thu,  4 Apr 2013 21:07:37 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B04613B53; Thu,  4 Apr
 2013 21:07:36 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.02.1304042138100.965@lap-x201.fen.aptivate.org>
 (Chris Wilson's message of "Thu, 4 Apr 2013 21:40:13 +0100 (BST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD633478-9D6B-11E2-95F9-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220103>

Chris Wilson <chris@aptivate.org> writes:

>  I do not want to write an
> awk/sed script to remove all the submodules from .git/config ...

Don't do it then ;-)

I think "git config" was added exactly because people wanted to
customize their configuration from their scripts.

> I do, it seems bizarre that git submodule init can create this
> situation but cannot rectify it.

I do not see there is anything to rectify in your situation.

Whoever wrote .gitmodules may have supplied a URL you cannot access,
and the configuration mechanism is the way to use custom URL in
place of it.
