From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t9902 fails
Date: Thu, 17 Jan 2013 16:12:12 -0800
Message-ID: <7vwqvbs61v.fsf@alter.siamese.dyndns.org>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <20130115232400.GA16147@sigill.intra.peff.net> <50F64597.2070100@web.de>
 <201301172347.50157.avila.jn@gmail.com> <20130118000454.GI13449@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 01:12:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvzZX-0001Lm-6m
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 01:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685Ab3ARAMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 19:12:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33430 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754064Ab3ARAMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 19:12:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD2C0B437;
	Thu, 17 Jan 2013 19:12:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Y/xi5hkYOyhdW3kyW4wQ92W3ho=; b=gWKy1D
	ytFjeAUj9afzVEB/TetZhF/SlMQjzg7ccbCx9mJocKI9WtwBkcGEu4B6fqqqCbuT
	sP0SvH7JZxXIsQRiA0iF6L2EYxFem+QcsdZPf8nasrXrGxc4uoirrSsCROrRW1AX
	gyXKXKrFupglMq2gj0M9VdPtN1FR+pO3Hrkjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nhg1g4iLsRjgKbjF4y93JJ2Qlj+BQtwm
	bvIltxL+DN3Gk833oWZcWUdhQf691jYn55gG7wUw8kktvwdxmE5Y8MnNtNV7dcQg
	k3CySPBD4OfD/iGw/JMPfzLsN3GVmiiO5kSd7kARRgOqa0DUjLQ4AGSqpaF0TPGA
	w1y+VfyxRiU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D154DB436;
	Thu, 17 Jan 2013 19:12:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F684B433; Thu, 17 Jan 2013
 19:12:15 -0500 (EST)
In-Reply-To: <20130118000454.GI13449@google.com> (Jonathan Nieder's message
 of "Thu, 17 Jan 2013 16:04:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6BFB568-6103-11E2-B668-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213893>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thoughts?  Maybe it would be enough to check that the intended get
> commands are present in the completion list and other git commands are
> not, ignoring binaries that might live elsewhere on the $PATH?

Yeah, it would be a robust alternative approach to verify that (1)
output is a superset of what we expect, and (2) they all share the
string we fed to the machinery as the common prefix, I would think.
