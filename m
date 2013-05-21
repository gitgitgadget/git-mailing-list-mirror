From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: trivial fix for zsh
Date: Tue, 21 May 2013 09:28:31 -0700
Message-ID: <7vbo84qouo.fsf@alter.siamese.dyndns.org>
References: <1369096383-28733-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s04oKBtjnF-+5hjPM+-krZA=m-4=Mb=vzU65GsTNhR3vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 18:28:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UepQV-0003hC-LF
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 18:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854Ab3EUQ2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 12:28:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49284 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754846Ab3EUQ2e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 12:28:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABD7620A36;
	Tue, 21 May 2013 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bFeQpvSyRIdZ0euD+dY3cKyE0r4=; b=S00SBD
	CnHUlhFoM4hZdQJ/CpapmE9Fn+UUFYWEwY22sz8Mwhv4VB35TyLc+o+ieYFQ7ZP/
	BVsJH9gVXkmtQ1UZtE7TKSv+UyTt0S4m/4zYLAutMZtYR/kXZq0l2R7+2B94pv3n
	AylFDEBp4qU7CCK0s6PBLbX0BIjDUltZB95M8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lcn3Wj8nrBAPk65pd6GhuQFCKpmkJi7l
	ZbFmdekcqrKJXwkRKOdcgnhdaBWBpOlbrNHXb0dwDXPHd1lA67BGMz+Fx1uq5tf8
	Et15OiXMF+eswOLBSesYIFXG053Z9FlB7AyHXW1MGMR9mW89UAjbGB6W5jvHXD5u
	3V8OaPlQ2vU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2BE620A35;
	Tue, 21 May 2013 16:28:33 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CCEF20A33;
	Tue, 21 May 2013 16:28:32 +0000 (UTC)
In-Reply-To: <CAMP44s04oKBtjnF-+5hjPM+-krZA=m-4=Mb=vzU65GsTNhR3vA@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 20 May 2013 19:38:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A9A8B3A-C233-11E2-B67A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225037>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, May 20, 2013 at 7:33 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> zsh completion wrapper doesn't reimplement __gitcompadd(). Although it
>> should be trivial to do that, let's use __gitcomp_nl() which achieves
>> exactly the same thing, specially since the suffix ($4) has to be empty.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> This is probably v1.8.3 material, I just noticed it's probably a
> regression introduced by 1ce23aa (completion: add new __gitcompadd
> helper).

Great.  That is not in v1.8.2.X, but was already in v1.8.3-rc0, so
we would need to do something about it.

I am not very happy about the latter "probably", though.  If it is a
regression, at this late in the cycle, it is often safer to revert
the original.

Will apply directly to 'master'.  Thanks.
