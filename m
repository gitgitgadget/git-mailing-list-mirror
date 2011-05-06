From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH for maint] git-completion: fix zsh support
Date: Thu, 05 May 2011 21:51:55 -0700
Message-ID: <7v7ha44ej8.fsf@alter.siamese.dyndns.org>
References: <20110505185907.GD1377@goldbirke>
 <1304625144-5206-1-git-send-email-felipe.contreras@gmail.com>
 <20110505232503.GA7507@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 06:52:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QID1S-0005vY-4v
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 06:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570Ab1EFEwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 00:52:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab1EFEwI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 00:52:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AF2F15E93;
	Fri,  6 May 2011 00:54:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=byVzhjGOoFSMgazFWaUdHbAMGpk=; b=qhjskc
	l7eIY7+FVhLYjUpWHQx5r1rihAJMKA5kzMkTiE04iS4Ob2Nrnn51WmzINvlo8LQC
	Da9sKe1A0at/89lWQ4PfU8GP9hJ7DwQtpBIkaKZpOOPRePJRjkT/yi22IR8niLJZ
	sH17jxIUCwZT27WNR3a00H5D+YlgoRUJogdT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YtyaBawcEfFLlhC1pgAgtBV1rpItM6vi
	SgsIbZMQvR2jP+F6BTc6zc8hoIr5Nn+oC6c4+FYL+yQZd8fOEXM4/mFjDzEbY0Zk
	xTPUD5Noh+HiHmIkjlt/BYDiik8zNzbXTk3eU+qmSTS0NCf7Id1g/oLYToGzr0pI
	H82IVcRUMa8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6FA765E91;
	Fri,  6 May 2011 00:54:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0C77C5E90; Fri,  6 May 2011
 00:53:59 -0400 (EDT)
In-Reply-To: <20110505232503.GA7507@elie> (Jonathan Nieder's message of "Thu,
 5 May 2011 18:25:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE916408-779C-11E0-A512-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172938>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Maybe simplest would be to use Szeder's fix + make the zsh version of
> _get_comp_words_by_ref not overwrite "words" at all?

I do not use zsh myself, but it appears to me that these three-patch
series can graduate and if real zsh users find problems after using it
they can be fixed independenty in-tree.

Would that risk too many patch ping-pong among zsh users on 'master'?
The "don't declare 'local words' in zsh" patch seems to be the right
work-around for the peculiar semantics of "words" array, at least to me.
