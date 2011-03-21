From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Makefile: Cover more files with make check
Date: Mon, 21 Mar 2011 10:27:55 -0700
Message-ID: <7vhbawqt7o.fsf@alter.siamese.dyndns.org>
References: <1300700704-22674-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 18:28:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1itn-0004i1-4i
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 18:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921Ab1CUR2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 13:28:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab1CUR2E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 13:28:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 535CD4EA4;
	Mon, 21 Mar 2011 13:29:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RUgOGCGQvxQrUHm8BxrvkJq4860=; b=qdflxj
	3TRd5NUpv7QL97ilmSW3q1z8ft6kQhe9LBJN7XnlzdXVWnEi8LswxvxC5usv740w
	SaJS/Wxwd3ElVYzYRT/SQrt/hVpovjzZq0t5OlMtD8kGWdNYNVIGNhBJDFaME0su
	VemvyE7YPxAirVxMfp4cjCCCpmq+uhn46O7rs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XpNw2fwFnQoZ0o6JBCThDsmkrwYsH8i9
	tIf7g/GHtSgIdMr9dOatMh891+Bl9OMEfZ+FKlW2a2joSOihnXe/QB9yESIFTHKn
	eLRUigKLwEOQF5QBvDJwZBmiUJasUi2MtueQY3mhhl52LkOpg8V69/kAg/gyyyz9
	zAavU/MvHwI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 30B4D4EA3;
	Mon, 21 Mar 2011 13:29:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4F0E44EA2; Mon, 21 Mar 2011
 13:29:35 -0400 (EDT)
In-Reply-To: <1300700704-22674-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Mon, 21 Mar 2011 02:45:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBFC0F44-53E0-11E0-9CD1-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169616>

Stephen Boyd <bebarino@gmail.com> writes:

> After the builtin/ move 'make check' doesn't cover the builtin/
> directory. We could just add builtin/*.c but lets just use GIT_OBJS
> instead so we cover future movement of the source files.

Thanks for being considerate and not use $(OBJECTS) that would feed sparse
a lot more crap ;-)  GIT_OBJS is sensible (and when vcs-svn graduates from
contrib/ status, hopefully it would be included in GIT_OBJS).
