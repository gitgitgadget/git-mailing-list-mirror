From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question regarding git fetch
Date: Thu, 27 Aug 2009 14:44:54 -0700
Message-ID: <7v7hwpors9.fsf@alter.siamese.dyndns.org>
References: <1251387045053-3527289.post@n2.nabble.com>
 <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com>
 <20090827164657.GA17090@atjola.homenet>
 <32541b130908271022i6a825198i37e2ec82ed5f833c@mail.gmail.com>
 <20090827204835.GC4399@coredump.intra.peff.net>
 <20090827213426.GD4399@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Tom Lambda <tom.lambda@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 27 23:45:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgmmY-0005JS-3x
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 23:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbZH0VpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 17:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbZH0VpM
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 17:45:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbZH0VpL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 17:45:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4561C1BBB5;
	Thu, 27 Aug 2009 17:45:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=75Hbbdi/O5LRaXh5WEToi3g+drY=; b=BnNqW3
	5ITvQBfNsoCacl032pkkyZayFAKRRucmBRLQt2hlKFQyGNXemmD6PjZKdbtnfgF2
	zDAdVGPST0E76Ng5bFASPWnu/q0TQfpu+W30cKcX05V+ecAs/u9jPXoKvze+3P0u
	BnUNuoQnyO8l3xSa/uPz9hiHH9vBSjouGBg3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bDxKz+PPlP7YEhFsmJHoKesHoWSDAWsV
	JX+JrsxEowKYw/yvCmUM1mhiuQMXzhO4+2bEPfM4SPAsxccXVZgS13KlawhYZSOj
	CKE1alkkmGdm2hgcMUlN1MxfxRfVe66E7evwp/CVWWGwrEkwn9HLHgQC8i7AkCXx
	y1oEcvVSZCA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E835E1BBB0;
	Thu, 27 Aug 2009 17:45:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17ACB1BBAD; Thu, 27 Aug
 2009 17:44:55 -0400 (EDT)
In-Reply-To: <20090827213426.GD4399@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 27 Aug 2009 17\:34\:26 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E231E34C-9352-11DE-A8B3-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127218>

Jeff King <peff@peff.net> writes:

>   # we usually fetch the remote's master straight into our production
>   # branch for deployment
>   $ git config remote.origin.fetch refs/heads/master:refs/heads/production
>
>   # but today let's demo it first
>   $ git fetch origin master:demo

I think this is a good example that any change results from this
discussion should apply _only_ to cases where command line refspecs lack
colon (i.e. used to mean "do not store this anywhere but in FETCH_HEAD").
