From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] git rev-list: fix invalid typecast
Date: Mon, 13 Feb 2012 12:48:29 -0800
Message-ID: <7vwr7qcvdu.fsf@alter.siamese.dyndns.org>
References: <7vhazobto3.fsf@alter.siamese.dyndns.org>
 <1329164235-29955-1-git-send-email-drizzd@aon.at>
 <1329164235-29955-2-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 13 21:48:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx2pA-00009U-VC
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 21:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758052Ab2BMUsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 15:48:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44456 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438Ab2BMUsc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 15:48:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C9676ED1;
	Mon, 13 Feb 2012 15:48:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YVOo13fnyQDwM/kjEaUvIUjKuWY=; b=ffatzO
	pCbCkFnVm97Q/VI1VH241Fc2WPRchUYMLcEQ2PAjZifQ+jiZKA8zjeTvp48rPHUM
	3VffWCsqsm6QgaatafKgR8z1Bos4ev1lNz93/8wLgtpln1JEVWFGbCi134ElUt7i
	88tQ56fLxQsYaf01rbJxjhczihWUakcAH08dg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=capDz5uWdepoJIYtdrbmdMTt0yC/MBYl
	oqvCx038pV58przBFEOUf52KImrXKTsGFoUnrdtxjMX5xvDHuJGF/reLygClF3vo
	dVOb24UeDwan2axKzqW5ZVgDgZaejPhkfy/xQ8Ldm438uWv9XkZ+i0kbYokqqyn3
	AYH/pHVRuFg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 841156ECF;
	Mon, 13 Feb 2012 15:48:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CD1B6ECE; Mon, 13 Feb 2012
 15:48:30 -0500 (EST)
In-Reply-To: <1329164235-29955-2-git-send-email-drizzd@aon.at> (Clemens
 Buchacher's message of "Mon, 13 Feb 2012 21:17:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 167ABAF6-5684-11E1-BD06-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190667>

Clemens Buchacher <drizzd@aon.at> writes:

> git rev-list passes rev_list_info, not rev_list objects. Without this
> fix, rev-list enables or disables the --verify-objects option depending
> on a read from an undefined memory location.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---

Wow, I simply couldn't believe it, but you are right.

Thanks.
