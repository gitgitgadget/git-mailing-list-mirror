From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] git-diff.txt: group the [--] and [<path>...] templates
Date: Wed, 24 Apr 2013 11:43:14 -0700
Message-ID: <7vbo93db25.fsf@alter.siamese.dyndns.org>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
	<1366821216-20868-4-git-send-email-artagnon@gmail.com>
	<7vtxmvdc4d.fsf@alter.siamese.dyndns.org>
	<CALkWK0nU-iTSF2DnmJAB=kj6w+VFv3rQrixEnHz0vyXf2d2=Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 20:43:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4f4-0001aR-7E
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 20:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041Ab3DXSnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 14:43:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41970 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755963Ab3DXSnR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 14:43:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C64F6197F0;
	Wed, 24 Apr 2013 18:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tUCuJQi+I775vkXBsRLGDlOPiEU=; b=vUvgz1
	GW3YHkSdg419Lfjjvb88Zc3p7o+MZGPUUVO6WVBVdT+KTNAY2zwi58rtf1z15OhY
	+DGeWcx5zBESzOcPoY9ini+eYJ/HpsyK77xDaAtLa13LS+i2xlY7/UOZLjH1+Ey/
	44QuHRGj/ezmvGVeZg+LbL+Uq4Uo3nNa8aoFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y5t35z7Qqc1MA2nW9H9C1ctzdggKNfT9
	+RGzpcP3yeD3aRq5GVzLn/tMtO2iFdIbZKg1/5iIvqYUtbtFQc+t/qIjuBieMUsX
	bbU4lKZX1fMYSOFa95amk7NtWS+GIRhGYma8Wm4e5vzaaVo3HOe6zXV7Yf7OYqDh
	10tHNRriQDU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD30B197EF;
	Wed, 24 Apr 2013 18:43:16 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30F57197EE;
	Wed, 24 Apr 2013 18:43:16 +0000 (UTC)
In-Reply-To: <CALkWK0nU-iTSF2DnmJAB=kj6w+VFv3rQrixEnHz0vyXf2d2=Mw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 24 Apr 2013 23:53:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D361A2CE-AD0E-11E2-B6B6-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222291>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>> -'git diff' [options] [--] [<path>...]::
>>> +'git diff' [options] [[--] [<path>...]]::
>>
>> While the update might be logically more correct, it looks to me
>> that the only end-user visibile effect of it is to make the end
>> result harder to read.
>
> Hm, I thought it improves readability.  I'm trying to say that -- is
> used to separate [<path>...] from [everything else].

The same logic would apply to this semi-nonsense rewrite, no?

	git diff [[options] [--]] [<path>...]

Everything else comes before "--" (if exists) that separates it from
the list of pathspecs.
