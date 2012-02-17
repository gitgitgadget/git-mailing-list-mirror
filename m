From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Fri, 17 Feb 2012 14:25:25 -0800
Message-ID: <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
 <CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
 <8762f9k5sg.fsf@thomas.inf.ethz.ch>
 <CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
 <20120215190318.GA5992@sigill.intra.peff.net>
 <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 17 23:25:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyWFB-0006tV-Lq
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 23:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab2BQWZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 17:25:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64065 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab2BQWZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 17:25:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB41E6AFC;
	Fri, 17 Feb 2012 17:25:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/bL2t7YYWV0fYV5smJD+EaA8Efs=; b=lUGhcY
	u7/hekLtt4Oq2BY1EPyITkPoi5Zg10OxzLpgNcMmhD0pbXPSZn/uGUn3tJr5E/si
	QYfi7Y4g0D85bUcX4yaLTrerwlQ8SJITK8eVhzAvSWCZLOyfc/mUfmvfzlXDBJGk
	9pvIeum1LwPYPfTplQLGgtasScytKLg+lu09c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r0v+q0oh4FymudvKzFT/sYUk+nQz1BNb
	jRyZpu3WEDTVrdTDZfExCfcw9YlpteURVH/ZI33ctD8caCxqEtz5CtrgJtIxVHIS
	Li4MjjR9M9ft9qcNQeoFPChm/eDbo/yrbcBv7obuP+7l/LdaN3SBg5CWcIkcvJ5F
	IWuOi/1w/l0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1AA46AFB;
	Fri, 17 Feb 2012 17:25:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49CDF6AF7; Fri, 17 Feb 2012
 17:25:27 -0500 (EST)
In-Reply-To: <20120217203755.GA30114@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 17 Feb 2012 15:37:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AE320DC-59B6-11E1-B660-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190981>

Jeff King <peff@peff.net> writes:

> That being said, we do have an index extension to store the tree sha1 of
> whole directories (i.e., we populate it when we write a whole tree or
> subtree into the index from the object db, and it becomes invalidated
> when a file becomes modified). This optimization is used by things like
> "git commit" to avoid having to recreate the same sub-trees over and
> over when creating tree objects from the index. But we could also use it
> here to avoid having to even read the sub-tree objects from the object
> db.

Like b65982b (Optimize "diff-index --cached" using cache-tree, 2009-05-20)
perhaps?
