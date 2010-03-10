From: Junio C Hamano <gitster@pobox.com>
Subject: Re: wishlist: git gui not listing untracked files in unstaged list
Date: Wed, 10 Mar 2010 14:30:17 -0800
Message-ID: <7v3a07q07a.fsf@alter.siamese.dyndns.org>
References: <loom.20100310T203316-38@post.gmane.org>
 <7vaaugrlqs.fsf@alter.siamese.dyndns.org>
 <20100310200728.GD21994@spearce.org>
 <loom.20100310T225229-469@post.gmane.org>
 <20100310221228.GA4223@sigill.intra.peff.net>
 <20100310221403.GF21994@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Patrick Higgins <patrick133t@yahoo.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 10 23:30:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpUQD-0007Ak-TF
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 23:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab0CJWa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 17:30:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698Ab0CJWa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 17:30:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C92DFA0B4D;
	Wed, 10 Mar 2010 17:30:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=no4xX11dkllUMVliX+0382by8MM=; b=nFR2c7
	c9RHIqaCM6XQ5cKcrBRk0mujKVym0M3P9IK3Jbc2qXz2iFG1Gc32bx9OE9PTQrvZ
	n0eY0sLF3eVRwy0TFRwmw6tM8MJEKD4VRVvDYFWuBoAtcvMeVEVVP24Yx3NKlInt
	tD2gUI0GVemOZ6FS+C/Jm7B8TXBvxSegkJAQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=heg35Z2hOmBju2bg8uTVIp9JkUMqKOxD
	hiVHECdlh1pOaUz7kxxlVp2PdvtqR7ZElhVLkWAz0QpheXNfnk7HTCCrBRJTn24h
	l8NWzkK28tr+aHI0mKiOVUUlinqN6Ksz5fLcIjQdrp9HXoE0NivFh3w5ZuSiRf6N
	+1VKhy2l8WY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 86D84A0B4C;
	Wed, 10 Mar 2010 17:30:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C45CFA0B49; Wed, 10 Mar
 2010 17:30:18 -0500 (EST)
In-Reply-To: <20100310221403.GF21994@spearce.org> (Shawn O. Pearce's message
 of "Wed\, 10 Mar 2010 14\:14\:03 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 849018CC-2C94-11DF-91F0-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141928>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Jeff King <peff@peff.net> wrote:
>> This is an inconsistency in the way that tilde-expansion is handled. The
>> core.excludesfile config variable is expanded internally with the
>> "pathname" magic (git_config_pathname). But handing the filename
>> directly to ls-files --exclude-from does not do that expansion.
>> 
>> So either there is a bug in ls-files, which should expand from the
>> command line, or one in git-gui, which should be using "git config
>> --path core.excludesfile" to get the path.
>
> I'd say its git-gui, yes?  Doesn't my shell automatically do
> --exclude-from=~/my.list for me?  Its not the command's job
> to do that expansion.

I'd agree.
