From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log --quiet bug?
Date: Tue, 08 Nov 2011 16:04:50 -0800
Message-ID: <7vy5vqw47x.fsf@alter.siamese.dyndns.org>
References: <1320762978.3614.YahooMailNeo@web84005.mail.mud.yahoo.com>
 <20111108212930.GA18529@sigill.intra.peff.net>
 <1320791465.67359.YahooMailNeo@web84006.mail.mud.yahoo.com>
 <20111108232043.GA21957@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Prasad Deshpande <prasadgdeshpande@yahoo.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 09 01:05:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNvf2-00020j-SX
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 01:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039Ab1KIAE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 19:04:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46399 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754026Ab1KIAEz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 19:04:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE0EA68F5;
	Tue,  8 Nov 2011 19:04:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yRWtZ5COW63Z9IqCHZig5k5+m4o=; b=AScB4G
	goXzd7ay/JDIEFmUREbApKVFNhUtkWP0BDYSU2kSZpPrylXZf7CPgqOobGq8RNxO
	I4/z7++7q9EP/0m7bj9IrZUMFEKTiSrhaJ0lvVbTL7IQHQNxcNqsJi9HXGyhhsv+
	TeYQrD57bBiRm1QAbMACCfQS6pYtwuT0RKXsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w1aRAT6/RPHz0gJnmp2mivaNhGjTRxZb
	Uw8T2UPHRB44kDva6L04B47kER8grOhWhah5tMdYFNQUxa67IlI7hKei/LqqPX0o
	kOmyRiOm4jQGwHXglC/ENiA2Zeq92iNjuOupzqKUvwt+MGejULbC7T44nbHTL2Hy
	elLoR043Wto=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A511C68EB;
	Tue,  8 Nov 2011 19:04:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E8C868E5; Tue,  8 Nov 2011
 19:04:52 -0500 (EST)
In-Reply-To: <20111108232043.GA21957@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 8 Nov 2011 18:20:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7279F16A-0A66-11E1-87E9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185119>

Jeff King <peff@peff.net> writes:

> Try:
>
>   test -z "$(git rev-list -1 origin..HEAD)" &&
>   echo nothing that needs pushing
>
> You can also use --count to get the exact number, but if you just care
> whether there is something or nothing, using "-1" lets git stop the
> graph traversal immediately.

Doesn't some variant of "branch -v" show the ahead/behind information for
all branches?
