From: Junio C Hamano <gitster@pobox.com>
Subject: Re: measuring the % change between two commits
Date: Thu, 23 Feb 2012 12:09:18 -0800
Message-ID: <7vty2h2txt.fsf@alter.siamese.dyndns.org>
References: <CAMK1S_gXQaE+RZxe4S7vqAyPka9N9PAoe+557FaLO+JJoJFshA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 21:09:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0eyj-0006j6-MM
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 21:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756804Ab2BWUJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 15:09:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47917 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756147Ab2BWUJV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 15:09:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9061F7FE3;
	Thu, 23 Feb 2012 15:09:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x4Z7Al68XWCJuXgIv/3UDWZ0Vzo=; b=nMnmRw
	DlPw9/ZbKflsP6Y0VmCwTwjSYJhWs+Nb239c5rv48ai8ti9l1QGFS1K4h8TnBsPk
	+wfIiV1DqefHIjB4e1OUkWSG/Gv7oUQeB+7xnobaO79+D1iNwOOQc4PRTckc7Rik
	y7NBX9QzOyQa4K4Mrj3sqdN+XOa155EjqCA48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IFCCIF2AWp+OMkK0ymwDjYDgM1CQwhqg
	EPr/QuUx9Md4PhsTMdC9VySCBIYowIgDd3Lx4D4abUef9zut+ItounP4PgUiNn7u
	3Bf/hIuXAOcV3KwIQIInWJHzUTKpmHlky/jH53ua6BmMQtDayrzlcFx+JwGdz5/q
	Isaw61pDSgA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8659F7FE2;
	Thu, 23 Feb 2012 15:09:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18C0D7FE1; Thu, 23 Feb 2012
 15:09:20 -0500 (EST)
In-Reply-To: <CAMK1S_gXQaE+RZxe4S7vqAyPka9N9PAoe+557FaLO+JJoJFshA@mail.gmail.com> (Sitaram
 Chamarty's message of "Thu, 23 Feb 2012 17:00:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45554E80-5E5A-11E1-AC9F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191392>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> I could do a --numstat and then do a 'wc -l' on each file I guess, but
> I was hoping to avoid that.

Either you do it or the git core does it, but I am not sure if the use
case is common enough to warrant additional code on the core side.
