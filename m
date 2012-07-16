From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] refs: disallow ref components starting with hyphen
Date: Mon, 16 Jul 2012 10:49:26 -0700
Message-ID: <7vpq7v38bd.fsf@alter.siamese.dyndns.org>
References: <1342440781-18816-1-git-send-email-mschub@elegosoft.com>
 <1342440781-18816-2-git-send-email-mschub@elegosoft.com>
 <7v7gu34ow0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:49:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqpQN-0005i2-07
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 19:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab2GPRta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 13:49:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47475 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485Ab2GPRt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 13:49:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5E3C8329;
	Mon, 16 Jul 2012 13:49:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QbT8PbtgMeihunKnJx9CO28Pv7Q=; b=sGszSP
	2SfJDoZazMtBJEjQhlIKFlGO8TByTjmNDN0VrPzWcdAivPz2Au/8YplSV2IVTv4d
	tbMGVHBRVzInz3Y35tLHn3U8pnGZFapwdXME8Ma7oRu9fbTcv6FmHAj2uCeiOVVK
	YxOMcpemIAGZF3zeXdhl2FYhfijvd6ICF9Id8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ur61tn0uxYZPCDaJ6W17nPM2JozzTbHb
	2GeZTyvYlS16K9b367p9CwiEzyqhexK+W2yz+vjYoaWUP/UymgvLFgD3Ozn1nksp
	SpehpyZr+w+P++cQ4wFG43fOo8paAncYQKP5RE+S6Qoqre14KPly6VhP7EOs0hyU
	oTBQyayy3PA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4CC38328;
	Mon, 16 Jul 2012 13:49:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 561E28327; Mon, 16 Jul 2012
 13:49:28 -0400 (EDT)
In-Reply-To: <7v7gu34ow0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 16 Jul 2012 10:06:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96F1C1EE-CF6E-11E1-A49F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201537>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Schubert <mschub@elegosoft.com> writes:
>
>> Currently, we allow refname components to start with a hyphen. There's
>> no good reason to do so...
>
> That is way too weak as a justification to potentially break
> existing repositories.
>
> Refusal upon attempted creation is probably OK, which is why the two
> checks you removed in your patches are fine.

Just to clarify, I meant that the existing checks were OK because
they were meant to prevent creation.  I didn't mean removal of them
was OK.
