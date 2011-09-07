From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Wed, 07 Sep 2011 15:40:21 -0700
Message-ID: <7vliu00yei.fsf@alter.siamese.dyndns.org>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <CACsJy8Cy_Nn3EExV0D=RWtft+1pc9RBdJgpmES4AeQgYsUfU3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 00:40:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1QnH-00076t-9v
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 00:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757374Ab1IGWkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 18:40:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58333 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756985Ab1IGWkY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 18:40:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A0324716;
	Wed,  7 Sep 2011 18:40:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gQ7IRRtSM28UcbNlA4/8IWHwP0Q=; b=yhWfrA
	FFn3yTSaIzEtCSY5XRiSnl2Ybpsp1+jUi2ZRPTSrHUlLsBYd2MPcBtufuREtpW53
	iLjmzmMgh55dhH2TpSZz0XYHoBrIKCyUzoZfHrmgANQwNWioQwygykPWYG0IUXB2
	UElNlEpvthgjEfB/hcCARZhHHlQmQKMupcIls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G8kICDnFvE2vCYG46Pn4Z5BNP/KpEZU3
	EgB4CVcwybnObSdSz+8HMViBSN88D/BHK8hzqKjNCoEZGwdHi4IRNYU12ZUyjouN
	lsT6jc3lOKxLqGFVomZrxPSWTy6c77pthButw2d2GwfC267fBfYpSWScxyoT4Wbi
	iB61DWwtQXI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 706DE4715;
	Wed,  7 Sep 2011 18:40:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07CC74714; Wed,  7 Sep 2011
 18:40:22 -0400 (EDT)
In-Reply-To: <CACsJy8Cy_Nn3EExV0D=RWtft+1pc9RBdJgpmES4AeQgYsUfU3A@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 8 Sep 2011 08:21:05 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F73534E-D9A2-11E0-A59A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180924>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> ...
>>  4. A new phase to record the push certificate is introduced in the
>>    codepath after the receiving end runs receive_hook(). It is envisioned
>>    that this phase:
>>
>>    a. parses the updated-to object names, and appends the push
>>       certificate (still GPG signed) to a note attached to each of the
>>       objects that will sit at the tip of the refs;
>
> I recall Gentoo wanted something like this (recording who pushes
> what). Pulling Robin in if he has any comments.

As the beauty of this approach is that we can update and tailor what the
receiving end does using the information given from the server, it is a
strange thing to do to chomp this list in the middle at a funny place
here.
