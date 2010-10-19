From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] builtins: utilize startup_info->help where possible
Date: Tue, 19 Oct 2010 12:10:54 -0700
Message-ID: <7vlj5uyp4x.fsf@alter.siamese.dyndns.org>
References: <1287495320-27278-1-git-send-email-pclouds@gmail.com>
 <1287495320-27278-2-git-send-email-pclouds@gmail.com>
 <20101019172953.GC25139@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 21:11:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8Hae-0004By-Oe
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 21:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554Ab0JSTLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 15:11:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538Ab0JSTLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 15:11:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13675E0A16;
	Tue, 19 Oct 2010 15:11:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jfk6kRmbkP2LW/TkvHvK5wg8Q+w=; b=l6py15
	NWie06Ih3bIti8m+xnCmBxckZIIQcSxtfT1jBfwRNaOduL3nYTXZx8+5wxgnSnxy
	q/Q09J9l5JBACH8dOrpTQ8VFNZyNVKcQzWt76EFj2EJibPh5VdrWJbBLHsngsM+Y
	iavunHnO97kkov1sNFZFGc6UU97nWgS4Sm4og=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MpLRbw4EgaqGcH9IDoQx3XUEQfmWc/iO
	cHluCsG+StsnXahl9ux8wuy/eT3bSLuilNDikrduuEvAM91QhKfMH7h0pZM8h7YU
	2b1RuGmcVwpVYKGGpVo2ydoXgDACtH5HTxu/IsTuG7epWDDieJWdgQQ8EXD2UgVF
	ySz0sueiFBk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FE07E0A0C;
	Tue, 19 Oct 2010 15:11:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53184E0A0A; Tue, 19 Oct
 2010 15:10:56 -0400 (EDT)
In-Reply-To: <20101019172953.GC25139@burratino> (Jonathan Nieder's message of
 "Tue\, 19 Oct 2010 12\:29\:53 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9CCBE3A6-DBB4-11DF-9C1F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159356>

Jonathan Nieder <jrnieder@gmail.com> writes:

> In other words, I'm not sure startup_info->help is a good abstraction.
> Maybe (modulo names) it would be better to do
>
> struct startup_info {
> 	...
> 	const char *short_circuit;	/* "-h", "--help-all", "--no-index", or NULL */
> };

I am not sure short-circuit is a good abstraction either; will we have
only one aspect of whatever we can short-circuit forever?
