From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH master] convert: The native line-ending is \r\n on MinGW
Date: Tue, 13 Aug 2013 11:03:49 -0700
Message-ID: <7vioz9wjqy.fsf@alter.siamese.dyndns.org>
References: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com>
	<20100904082509.GC10140@burratino>
	<7vbp8aqtuz.fsf@alter.siamese.dyndns.org>
	<1353857940941-7571889.post@n2.nabble.com>
	<loom.20130415T220316-790@post.gmane.org>
	<loom.20130813T193141-905@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Tvangeste <i.4m.l33t@yandex.ru>
X-From: git-owner@vger.kernel.org Tue Aug 13 20:04:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Iwp-0000q5-Rj
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 20:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758743Ab3HMSDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 14:03:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47131 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758384Ab3HMSDy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 14:03:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E394638680;
	Tue, 13 Aug 2013 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rqUV9FN6B/u7Efl1r2Ql2grPmzA=; b=UzCNBj
	obMOIM9IzYjdr14Nq4N0iNVZWgPy/egB2sMHDDhddXIkGEj3HIOK0bsECz0+LuuL
	GjQQlJAP9zb7C1fNomEZIGXiosSmdiy8t6cLOZe4pTM1uj8MxMUqOl39S6XSIObK
	9ytyoLMebIcHZbDlkTj+tQ4zhAHYvt+AU0yag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IxY9mgw+wpkJMDtc2lRHIeJSJ6r89lER
	dF8cUxk+w80rNppy+V/4QZJtSNiStJOJaAbVDgBn22f1OMWJ81M+I5NxH2vuHYLM
	9B+ZiD+61ib0IAejkxLeB32ax41G9wP+UzEVCaWkwnxQy32IhO300+dh7guhrVlz
	L1lkq+r9TRU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65C663867E;
	Tue, 13 Aug 2013 18:03:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 417FE38673;
	Tue, 13 Aug 2013 18:03:52 +0000 (UTC)
In-Reply-To: <loom.20130813T193141-905@post.gmane.org> (Tvangeste's message of
	"Tue, 13 Aug 2013 17:44:35 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6391750-0442-11E3-8946-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232242>

Tvangeste <i.4m.l33t@yandex.ru> writes:

> Brice Lambson <bricelam <at> live.com> writes:
>> +1, this is a significant issue downstream in Git for Windows:
>> 
>> https://github.com/msysgit/git/issues/57
>> 
>> Effectively this renders .gitattributes useless for the scenario of 
>> enforcing normalized line ending characters.
>
> +100
>
> Folks, the problem is still there, with the very latest Git built with MinGW 
> on Windows. Having eol=native in gitattributes means *LF* EOLs on 
> Windows/MinGW.

The patch in the thread you are responding to is v1.8.3-rc0~65, so
as far as the upstream git.git is concerned the issue is closed, but
I cannot say that inter-project coordination between us and Git for
Windows are stellar (no we are not fighting against each other, but
being less intimate with what the other is doing than we could be).

Judging from how the original thread ended:

  http://thread.gmane.org/gmane.comp.version-control.git/148436/focus=221438

Eric and J6t (cc'ed) are aware of this patch that went into 1.8.3,
so...
