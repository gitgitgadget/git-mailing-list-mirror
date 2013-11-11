From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 03/10] transport-helper: add 'force' to 'export' helpers
Date: Mon, 11 Nov 2013 15:28:26 -0800
Message-ID: <xmqq7gcejyuc.fsf@gitster.dls.corp.google.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
	<1384210507-26561-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 00:36:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg11a-0004EV-Ps
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab3KKXgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:36:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33222 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754114Ab3KKXf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:35:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB80151428;
	Mon, 11 Nov 2013 18:35:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=WtrAvQTLnED0kMVHkePe9l6K+dI=; b=idPLR3IRT46/UVostv2U
	KPWPOmvCxQXuOiXHe2vtDBFn241lvwFoUgwR90zzTdRli+GfEaoLpeNSsoa1b1F1
	TK1b1fvFeziCO66fKYcDOG1B56sVvkdF31p8FU+8jqkDbHkyd+NUl+pT1uU8KbBr
	qWUv3SwPDs4axUUDhYNnG/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mdk3tMhsju8+PrffpuF3luZgbykB+awO8D1RnAYc8v0xAK
	zthgo5GabRiwzgN1NTZkUJqH5tNnK4zamrnHoPoay2A8rAtXG0hCCi8LsDLcGc4u
	Bphm1fj1zEcWfCE8/sleGz+2ix5U8P+y3RkIYbFlq3BMBfPEglpzjqAJkO/cY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97F1B51427;
	Mon, 11 Nov 2013 18:35:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB0EA51426;
	Mon, 11 Nov 2013 18:35:56 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0371273C-4B2A-11E3-95CF-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237678>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Otherwise they cannot know when to force the push or not (other than
> hacks).
>
> Tests-by: Richard Hansen <rhansen@bbn.com>
> Documentation-by: Richard Hansen <rhansen@bbn.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Didn't we agree that this should be warn, not die?

> +	if (flags & TRANSPORT_PUSH_FORCE) {
> +		if (set_helper_option(transport, "force", "true") != 0)
> +			die("helper %s does not support 'force'", data->name);
> +	}
> +
>  	helper = get_helper(transport);
>  
>  	write_constant(helper->in, "export\n");
