From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2] fast-import doc: cat-blob and ls responses need
 to be consumed quickly
Date: Wed, 11 Apr 2012 14:32:28 -0700
Message-ID: <7vobqyhs43.fsf@alter.siamese.dyndns.org>
References: <20120411143249.GA4140@burratino>
 <7v1ununtb2.fsf@alter.siamese.dyndns.org> <20120411171707.GD4248@burratino>
 <7vlim2kwcv.fsf@alter.siamese.dyndns.org> <20120411212501.GH4248@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:32:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI59Y-0004cR-4n
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030Ab2DKVcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 17:32:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46296 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004Ab2DKVcb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:32:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 366286BF8;
	Wed, 11 Apr 2012 17:32:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u6CmHRtXHsXvVwubn7JWx8wMiJg=; b=mO5Tga
	/fbbrDa/jDhDhx7ER+DMm1YFkBcpMVB4gPt2efyzKQqyeKgYaVnKpz3DD9kRWLNV
	7r/b0PLRDi4it+ZAODvnEUci7RkP6GyqOExFmhw76RFcTM8vG1sPAyfRiLRuYqmz
	5vj6KfadiX+GZrJTW5PIroRPapUIDMIA2uhNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vBmUsRc6vrMEGeJqg21s1kngu4GYM2le
	KY99Cku8av5aSQ8q67fb2MP0ZQe5cCq+dmw2fTk/zxf9w6duE3Bd2Y7vOhEa0eqI
	+wk93EUUM7Y/gR2TsxDq1AqMJlI6OuEOF2Tx8T0w/kz03NxfBIWldHsI0MtgkGaR
	Eqo7BjF/TNc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DCA06BF7;
	Wed, 11 Apr 2012 17:32:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B70F56BF6; Wed, 11 Apr 2012
 17:32:29 -0400 (EDT)
In-Reply-To: <20120411212501.GH4248@burratino> (Jonathan Nieder's message of
 "Wed, 11 Apr 2012 16:25:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D73C0742-841D-11E1-BF3E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195266>

Jonathan Nieder <jrnieder@gmail.com> writes:

> True.  Here's a rough attempt (again against "master").

Looks good.  Do you want me to queue it, or would it be of not much use
outside the context of the other patch that actually does create the
loop-back?
