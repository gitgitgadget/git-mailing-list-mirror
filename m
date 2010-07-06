From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Convert the users of for_each_string_list to
 for_each_string_list_item macro
Date: Mon, 05 Jul 2010 19:35:50 -0700
Message-ID: <7v4ogd8hh5.fsf@alter.siamese.dyndns.org>
References: <AANLkTilj7MiqiCmptDw0PLM5QqKZOOSZnSsxMlELS_5_@mail.gmail.com>
 <20100702205417.GA4941@blimp.localdomain>
 <20100703124004.GA5511@blimp.localdomain>
 <20100703124154.GB5511@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	jrnieder@gmail.com, srabbelier@gmail.com,
	Jay Soffian <jaysoffian@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 04:36:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVy18-0006fH-VW
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 04:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797Ab0GFCgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 22:36:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab0GFCgF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 22:36:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28613C2B29;
	Mon,  5 Jul 2010 22:36:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=LS01OoEyYoytUlBgaqWlz0Qk3MU=; b=Z5Ni5oCkF87cPE2tSFUaTAw
	8loDKbwSGPLxtpg0jBd0lf2la/1qe3DTc4INokkzkq/ww/XyDScuGcS4abLdL4nI
	UMpDFTvXpcBVY2E/ZIO+W7GqhfHMkYHwGlA7hAJcd2SuV0CmhoRUYyuGV1OlM1cm
	PMOWTBr3WUfz6qRVdp5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Rztld/fSFPEU5b7cNyx59V0nQd/W8CKs8zEKxd8gGwGqO0XtU
	K/S0riIv7dnrUacT696KxxYEcs6ikC0hxePZ00HVozclxdNV1LWxeIvfow3mL5oA
	vPod2KjFSOH1pMteYDZF+RkZa+4kkRnqkav6RXLk9yZvZEb1nl2bSUscts=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B8199C2B24;
	Mon,  5 Jul 2010 22:35:58 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF9FFC2B1F; Mon,  5 Jul
 2010 22:35:51 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 35C29516-88A7-11DF-AA1D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150309>

Alex Riesen <raa.lkml@gmail.com> writes:

> The rule for selecting the candidates for conversion is: if the callback
> function returns only 0 (the condition for for_each_string_list to exit
> early), than it can be safely converted to the macro.
>
> A notable exception are the callers in builtin/remote.c. If converted, the
> readability in the file will suffer greately. Besides, the code is not very
> performance critical (at the moment, at least): it does output formatting of
> the list of remotes.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

Both patches look very sane.  Thanks.
