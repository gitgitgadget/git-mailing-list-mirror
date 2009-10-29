From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] Provide a build time default-editor setting
Date: Thu, 29 Oct 2009 13:40:54 -0700
Message-ID: <7viqdy6ii1.fsf@alter.siamese.dyndns.org>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock> <20091029075021.GC15403@progeny.tock>
 <117f2cc80910290336k1e7b5877uc472ad511bb6f5ae@mail.gmail.com>
 <4AE98175.504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Roundy <roundyd@physics.oregonstate.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	GIT List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 21:41:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3bo6-00015E-CB
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 21:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbZJ2UlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 16:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755233AbZJ2UlG
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 16:41:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbZJ2UlF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 16:41:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13F6C8AEE6;
	Thu, 29 Oct 2009 16:41:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=jUs8ZdeRUo7zN8wWZULCcIpj21o=; b=SkaIW1VruWNUlbm3dDgyo0F
	wBEJ3xV4oOGy/DTNmTgDFYIkM8gV5eVOjSisvC4Z81KUwFhJjE5aJ7uYEsiotIj6
	m0HCcu0TsP+z0Ng3dUaggXePp6wUZwY8LVsUURWjRkYdDAEOzyAWvNO3xaV1MbTT
	jXMA7l7q2vRjxh/biT9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=RNXiOj6U/En5QvjU+XpaxOzHiyJNwX8oFK2QsprTbxHNhU/VT
	FkM/59YXLzb7ILM/azf4rpJdMM0GRxL5ziO7jGVhyRwu93MvPQvi8ZBI9mRm0Fx1
	+R7fzm2TByahUoeh78HKzgcftWGlvw+/O7szg5JVW0la1yUq73QRc0P440=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BEB2F8AEDD;
	Thu, 29 Oct 2009 16:41:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3CACE8AED7; Thu, 29 Oct 2009
 16:40:55 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 60B1D408-C4CB-11DE-8D2C-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131649>

Johannes Sixt <j.sixt@viscovery.net> writes:

> David Roundy schrieb:
>> Any chance this will be exported as plumbing? I know it's pretty
>> high-level, but it'd be handy to have be able to write `git editor
>> $FILENAME` and just have it do the right thing.  This would also mean
>> that the perl scripts below could be simplified.
>
> Something like below? Possible usage in shell scripts:
>
> 	editor=$(git var GIT_EDITOR)
> 	"$editor" "$filename"

I think we support GIT_EDITOR that is command path plus its initial
command line arguments, so you do not want dq around $editor, right?
