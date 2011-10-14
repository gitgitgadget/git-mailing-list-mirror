From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix alias expansion with new Git::config_path()
Date: Fri, 14 Oct 2011 08:05:18 -0700
Message-ID: <7vd3dz1ump.fsf@alter.siamese.dyndns.org>
References: <4E982B27.8050807@drmicha.warpmail.net>
 <20111014142557.GB13680@laptop> <4E984781.6050601@drmicha.warpmail.net>
 <20111014144203.GC13680@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 17:05:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REjKB-0001ty-6K
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 17:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756925Ab1JNPFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 11:05:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753941Ab1JNPFW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 11:05:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94F2845BE;
	Fri, 14 Oct 2011 11:05:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M6zhfvxyfmdlkLlwzdTax9A/v8g=; b=r0WcDL
	OZiz3F75cr5x4G4euS5CS9yTPGznIyxfCaWWyWLDk3J6uhki8oCykRQkm/yovnHV
	njI3lcHJNuuF+9c5jMu8pfVIb8POZOidqznlhQdM/s6Ut1i3FnIo1PQMsJgodi5W
	72hmO4dyTIAcV25MdcVHG0wSZdRa6B/vVEQRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N/n98rrqY6u4xakviFRzo3w3wmF19Ocf
	5hY9sLun4fqEbMjDRywNJK4b9iPidy1wBVjyFf2HC6bnOJ2d3/2HeT/8oMb0Mvvc
	uAgmDhfP6+InhQ3XWFrzHULxdKNSED4g4CyOzhrI6NKywIouS8o5r3T3YGCEMcjR
	L3DoM9VzYIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 813F145BD;
	Fri, 14 Oct 2011 11:05:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB47A45BC; Fri, 14 Oct 2011
 11:05:19 -0400 (EDT)
In-Reply-To: <20111014144203.GC13680@laptop> (Cord Seele's message of "Fri,
 14 Oct 2011 16:42:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EED66E0A-F675-11E0-BAC3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183581>

Cord Seele <cowose@googlemail.com> writes:

> On Fri 14 Oct 2011 16:30:25 +0200, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>
>> Tested-by: Michael J Gruber <git@drmicha.warpmail.net>
>
> Great.
>
>> Thanks. (Though I'm still wondering what this is about overall.)
>
> to make '~/' work in sendemail.aliasesfile

That is not an explanation.
