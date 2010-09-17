From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-rebase--interactive.sh: replace cut with ${v%% *}
Date: Fri, 17 Sep 2010 14:57:42 -0700
Message-ID: <7v8w302fu1.fsf@alter.siamese.dyndns.org>
References: <7vsk182p2q.fsf@alter.siamese.dyndns.org>
 <0eafa42f1da5f66465a1eb9da170416363cf72e0.1284759770.git.chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Brandon Casey <drafnel@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 23:58:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owiwd-00070C-Sb
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 23:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321Ab0IQV54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 17:57:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab0IQV5z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 17:57:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 43CFCD6BF7;
	Fri, 17 Sep 2010 17:57:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U7fQwH5dLUHeVplVsZpTMUU3wC0=; b=ltiaqo
	4SBz7UYUBL05cBmVxFJjeXf36HzdeI6bzJ4x7b4U844ZQEvgYd8Lg8hZtmBKyFfY
	aMcbXl6R9WNDWO3nb3nUiQqxNCmd2SS+ax80x/ls62+2Lxu7qQMsQ+M/wvVFhGT8
	Nj8a87q1enkU+y6eglOuVELb88fdmxzqnSSio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZzcUmH1kTdrjR2HhlwP6aU9PkrLcU5Al
	CP9i3G1KaGT3gDcHOeiyVXUXdnhlnbnbV91/mVxFhie+MzsYp4nlWLOmSdO+M6Yv
	wqBgBEbqNZzxzIxVQRgf/6RPxckiO1wgXue76dCs198yAr3gUshdxW2WA5l1gnQ/
	remGiaAzNJA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6766D6BF5;
	Fri, 17 Sep 2010 17:57:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CDFED6BF4; Fri, 17 Sep
 2010 17:57:43 -0400 (EDT)
In-Reply-To: <0eafa42f1da5f66465a1eb9da170416363cf72e0.1284759770.git.chris_johnsen@pobox.com> (Chris Johnsen's message of "Fri\, 17 Sep 2010 16\:42\:51 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9D05BC56-C2A6-11DF-87D3-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156417>

Chris Johnsen <chris_johnsen@pobox.com> writes:

> It seems like the other uses of cut in git-rebase--interactive.sh
> would be more awkward if they were replaced with equivalent
> processing done in-shell with parameter expansions...

More importantly, they are fed output from rev-list and do not have
breakage you observed on your Mac OS box, do they?

IOW, I don't see anything that needs fixing in other uses.

In any case, thanks for the fix.
