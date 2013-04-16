From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/13] pretty: support padding placeholders, %< %> and
 %><
Date: Tue, 16 Apr 2013 13:43:32 -0700
Message-ID: <7vwqs2jjez.fsf@alter.siamese.dyndns.org>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-12-git-send-email-pclouds@gmail.com>
 <7v1uaaky2q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 22:43:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USCj8-0002cC-Bs
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 22:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965327Ab3DPUnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 16:43:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965319Ab3DPUng convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 16:43:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E705616F3A;
	Tue, 16 Apr 2013 20:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4LFCwReR7/2X
	TwEEtx9aYxXedZo=; b=SKl6OJ+Tvmdrr5UKf7HqcIcQNfGiUMGy1qtZv86mgMP9
	nGjkTb9G6y6Pdi6wHeIxq8zQGavW9ljVk8Dpho8y1X3GHZGM72uEMzXJpgGvkzjh
	fWxaZY96D7GxMC7poN8gy6o4p/AXfAfNrXGJEemNDAJAMez/ieyerAvI1ZERth0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rNTxUd
	E/+S7yTn9YfMRO3LSihAl6hzAnBCPGU2W6GSHpfXxD1otoVb2CIU5ZJ0jx5oAG8h
	W95FS7Eyo5KNRfRwNEzyvQIPSFQjAS/TabTlIb+5pMrqdyt/xeASnWvat8bn13ZJ
	RGMiE5bxMAji9hgUsC7f7fbAGJUjWhm1ujcJE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE76B16F38;
	Tue, 16 Apr 2013 20:43:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6541816F1D; Tue, 16 Apr
 2013 20:43:35 +0000 (UTC)
In-Reply-To: <7v1uaaky2q.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 16 Apr 2013 13:41:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F1088FC-A6D6-11E2-B1DB-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221468>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> +delete_trailing_dollar() {
>> +	sed 's/\$$//'
>> +}
>
> This is what we have qz_to_tab_space for, isn't it?  With it, you
> can not just avoid "trailing whitespace", but also "indent with
> spaces", like this:
>
> Q         message thousand    Z

Sorry, the above needs s/Q/Z/;
