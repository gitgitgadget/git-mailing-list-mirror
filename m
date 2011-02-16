From: Junio C Hamano <gitster@pobox.com>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 13:46:01 -0800
Message-ID: <7v39nnirfq.fsf@alter.siamese.dyndns.org>
References: <20110216032047.GA2858@elie>
 <7v1v37kb3p.fsf@alter.siamese.dyndns.org>
 <20110216195931.GA22884@sigill.intra.peff.net>
 <201102162203.40480.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 22:46:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PppCZ-00057y-7n
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 22:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab1BPVqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 16:46:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab1BPVqR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 16:46:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5CE6C45D8;
	Wed, 16 Feb 2011 16:47:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/AzlCrOVY0rWPU+tmJ44UiofR3g=; b=NGXtLN
	nmkfnIvUcqkULWZLLMvLcjB1oSCrwhlhCPILjdhNYT3UKcJmnidLX4VUD6YLVw3U
	E7VUGNCwjyBcsEPtgC94j+oj/I5PN0bTWaNjFflxmI3SpLzSyDCpzCOZ7z3ReL8L
	knCs3xrQ5KWFpE/2wqfP0opyIogYEZ7FkCJ/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=slTORUPslqmB0jj5V3mGdGF1eCUv8jCR
	7qEPidaBeQlMuvMQbJyIwwqttnhiNz2/XpuI4MAvGkna+jJRjN1jCqkmVJBriA+3
	213xr4jApOTNktmvkJt5IViivxSPoIuU1eF0C/4k2r8x+Z4pBipKqejamxb+ZJQs
	XaPny5NLylM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B53F45D3;
	Wed, 16 Feb 2011 16:47:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B9D1D45D1; Wed, 16 Feb 2011
 16:47:08 -0500 (EST)
In-Reply-To: <201102162203.40480.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed\, 16 Feb 2011 22\:03\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5281C0C0-3A16-11E0-8A15-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167008>

Jakub Narebski <jnareb@gmail.com> writes:

>> So I think we are really on the same page. :)
>
> Also it would be not as easy as reflogs - you would have either to save
> copy of index, or create a tree out of it and save reference in reflog.

Also note that "Create a tree out of it" is not always a useful way to
save the state of the index.  The "stash" shares the same issue, but you
would need an equivalent of a tarball that consists of the index file
(with conflicted state) and the files in the working tree that corresponds
to index entries with conflicted states if you want to be useful for
storing a state away in case you botch the conflict resolution you are
attempting.
