From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] t7006: modernize calls to unset
Date: Thu, 18 Aug 2011 14:05:41 -0700
Message-ID: <7v7h6a8ikn.fsf@alter.siamese.dyndns.org>
References: <20110818045821.GA17377@sigill.intra.peff.net>
 <20110818050044.GA2889@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:24:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuB0N-0003Go-M3
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959Ab1HRWX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:23:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754740Ab1HRWX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:23:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D51564354;
	Thu, 18 Aug 2011 18:23:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=9j9NWdMT145umw1sRAJ3Z1QyZpc=; b=NHTMK2vMcTpL5xVbs1ME
	gw5VxkDEmNgg1OOFfB515yhRhs6Ja99TsQ+HgEWR8//YRudlks9FywFNnGBV4b1a
	nY6toVWQp6Dla8bUhxtC1S6Pjwo+zcXbWcDQE1y0nyubXH5DOGzWS9UX9dftnST2
	bkVPTmGTmk0Ab4lNGc7LOvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Uo1p7l4Chs6xVOxJMDg76iJqsi7T7eFS7gkA4GIGlFcGW8
	BFHyPlrM7uB4sXgEDUFUJZ3w0z3n2u/FU7Odc3AishdztzLSTE19awMS3rMaiBjU
	ncMqeonnhgxClMfN1yYDdPs9y/cgMYmsDfZDcxkAopvEEuAd/TGbt7Or73/zI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3CCC4353;
	Thu, 18 Aug 2011 18:23:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51EF74352; Thu, 18 Aug 2011
 18:23:54 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1E10FEA-C9E8-11E0-B7D8-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179641>

Jeff King <peff@peff.net> writes:

> These tests break &&-chaining to deal with broken "unset"
> implementations. Instead, they should just use sane_unset.

Thanks. I checked with POSIX again, wondering if I should tone the
"broken" down a bit, but it says:

  Unsetting a variable or function that was not previously set shall not
  be considered an error...

so they deserve "broken" label.
