From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] some sequencer loose ends (Re: Fix revert
 --abort on Windows)
Date: Mon, 12 Dec 2011 00:15:40 -0800
Message-ID: <7vzkey6w9f.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
 <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net>
 <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net>
 <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net>
 <20111211195836.GA25482@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 09:15:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra135-00074R-Mp
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 09:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945Ab1LLIPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 03:15:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49664 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904Ab1LLIPm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 03:15:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 181E8259A;
	Mon, 12 Dec 2011 03:15:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a6iqGhIAQyNGTTQ5wlMvjL6ky1o=; b=YXt6oD
	TR7o5c/MOqs1J8ILpAtV31NSzeuQbYdg2yEQTSXBc1vreuyrmxnnOj9brTo5vPDG
	JbSyM0Kd17C3035BS2LFtm/j7iZMuVQDeTZN8yVYL45CpCPD7UuzNre2omMo0m9X
	3UasswRiw0smeySfkipEPZvUzyMsvFgXxK+AY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z/q9OkR7L7S/ck82tzbvCYEmGg3A8sYY
	vhcnAppa+kJAKkYmT0gF4m9mbQZdhJlCzfSfHotNMGPrpQAWZeW8FxpkUmbCCI6L
	XaK/avKXO7evvTH5CmRoww3dTx2c4VOvqEnMPsVA5f+9p6IqILqt1YdCa+qAgKEF
	R3nJd8k7up4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ED492599;
	Mon, 12 Dec 2011 03:15:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97D702598; Mon, 12 Dec 2011
 03:15:41 -0500 (EST)
In-Reply-To: <20111211195836.GA25482@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Sun, 11 Dec 2011 13:58:36 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B6081FC-2499-11E1-A560-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186887>

Jonathan Nieder <jrnieder@gmail.com> writes:

> How did we ever let this in?  "git reset" already has well defined
> semantics that have nothing to do with this.  Patches 6/7 and 7/7
> would help us forget this UI mistake (and I believe it was a mistake)
> ever happened.

Thanks for catching this. Let's review this quickly and queue it for
maintenance track as necessary.
