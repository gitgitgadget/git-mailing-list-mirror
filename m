From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] i18n: avoid conflict with ngettext from libintl
Date: Wed, 09 Mar 2011 12:55:32 -0800
Message-ID: <7v7hc89fp7.fsf@alter.siamese.dyndns.org>
References: <4D7165A3.5080308@colin.guthr.ie>
 <7vlj0u5wyw.fsf@alter.siamese.dyndns.org> <4D7223A9.6080105@colin.guthr.ie>
 <7vsjuz520w.fsf@alter.siamese.dyndns.org>
 <7vhbbf50vu.fsf@alter.siamese.dyndns.org> <20110306225641.GB24327@elie>
 <AANLkTikctSrfqKCdeYUyvUmAZjr=i7kaFhPeB-LfwgUz@mail.gmail.com>
 <20110309103104.GA30980@elie> <20110309105236.GC30980@elie>
 <7vfwqw9g9b.fsf@alter.siamese.dyndns.org> <20110309205155.GC22292@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 21:55:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxQQ8-0005Kd-Cj
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 21:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab1CIUzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 15:55:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab1CIUzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 15:55:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 55F67414A;
	Wed,  9 Mar 2011 15:57:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E7RO5T64vFhcWW5sjTJqcPXMjeU=; b=Ccoq7v
	Ex8cDTTNM9Xghd0HWlmE1jzWrH7BDoPv8MCYK9TNWPmg2SJ23x7rZHKF5f0ASmB7
	N85sip2ZYF3qbcn10uF4yOOJ8ydw220AHUhuyxoeHVupSw1u3VvysIwO4W2RziCm
	Hok8QlAyHxPIttpDiIMmoD2tC5I3uJDc82opE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A8iaBNZTQnI/d8sXJa7Za+jA7hREOnrS
	KSnUPIWuKXTWX1/L28g54XhVJqzkX5MBK1owo1BNo0wK3lxeaYeetKL0tYcp4Hp7
	MfSUcoHmKkPW712rkxpfc8tJCTZFpS4QsSwB67oC3wSWW4PbK0dWZ8uA4kq6wpeP
	T9D9hSjEwVo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 229B84149;
	Wed,  9 Mar 2011 15:57:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DC8DD4144; Wed,  9 Mar 2011
 15:57:02 -0500 (EST)
In-Reply-To: <20110309205155.GC22292@elie> (Jonathan Nieder's message of
 "Wed, 9 Mar 2011 14:51:55 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB2C7496-4A8F-11E0-AB39-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168758>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The usual convention is that the _() macro is private to each
> application.  libintl provides a gettext function or macro, and
> various programs do
>
> 	#define _(msg) gettext(msg)
>
> in some private header (that does not pollute the public namespace)
> for notational convenience.

Yeah, I am aware of that.  Is there a similar convention for [dn]gettext?
Perhaps not....
