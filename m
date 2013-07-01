From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2] submodule: add ability to configure update command
Date: Mon, 01 Jul 2013 09:48:27 -0700
Message-ID: <7v1u7ii5us.fsf@alter.siamese.dyndns.org>
References: <51D04F06.9000400@web.de>
	<1372673494-24286-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, iveqy@iveqy.com,
	stefan.naewe@atlas-elektronik.com, hvoigt@hvoigt.net
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 18:48:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UthHG-0007gL-54
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 18:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942Ab3GAQsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 12:48:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54529 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252Ab3GAQs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 12:48:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6746A2D5FC;
	Mon,  1 Jul 2013 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IFBp1NJxwe2DrXEx8oH69sYlXiU=; b=exJR8Q
	RGV0FPUqQBQJ1YwZnwmugHGYUyuSKJ/eQY7tjBPPMFAjbzOn34ZXG8mAjNU+Vl9F
	IqPsSPkIZg9XD+YJtrkAql0irtdznqCefN5WtEhtdSep+bIt2ugiIKdPaKwdzD/6
	nrBk5NGpa9DrbYEUtBQ21iNpM7WdG5sbTpvZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LOqGBlZ28sACcx/ru+c+Abr1K0sL3Ux4
	/kvuyoMLJ5ua63cS9o5boAZCxMAxmxRUGUqIuIN/623tIk7lZ+f+AE88DtUY4yWT
	rZk4/lY1rYFBiP+AfRTA2yxSdjmfPOHXsi38bH8zXm58780e3v+gX6/HeXrrC1lk
	gj2wCjMJObc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4698F2D5FB;
	Mon,  1 Jul 2013 16:48:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99FC32D5FA;
	Mon,  1 Jul 2013 16:48:28 +0000 (UTC)
In-Reply-To: <1372673494-24286-1-git-send-email-judge.packham@gmail.com>
	(Chris Packham's message of "Mon, 1 Jul 2013 22:11:34 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E35AF6E-E26E-11E2-A048-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229311>

Chris Packham <judge.packham@gmail.com> writes:

> +			!*)
> +				command="$(expr "$update_module" : '!\(.*\)')"

	command=${command#!}
