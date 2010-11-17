From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Support relative path in <blah>:path syntax
Date: Wed, 17 Nov 2010 09:54:08 -0800
Message-ID: <7vk4kbg7jz.fsf@alter.siamese.dyndns.org>
References: <1289484484-8632-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Matthieu.Moy@grenoble-inp.fr
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 18:54:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PImDN-0007Cv-Gh
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 18:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935179Ab0KQRyV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Nov 2010 12:54:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935165Ab0KQRyT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Nov 2010 12:54:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 952DB3CF5;
	Wed, 17 Nov 2010 12:54:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=FYTLcQLDoQorca4PsVRhkupeS
	u4=; b=XYiN5HoY0/hzYchZda46HtTkrBKjkDKCAKSwBS9rorjNZrLW8nmHOHTds
	SmVaOc0VnCjVAHelGo6gonTfhPVwr3Gs9vFjATTuG7m3EAVpGmrN2H0XXpYTOU9a
	zKyQQOw2RcmEYdCbmEgHuZF1pG7k3cjLDbYn8PrIRmoUufcrvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=FInQqqEwIGBtReHr7w/
	NRqgEmJkw+TH1UuVK8kKBqy0d6ysI1bxlGOnbF1al0ixf2fke87bIq8SAawrLS6d
	XxchQ2lksZfV0j2ee8iIh8lteSg8DSuWDBtrEnUW6JnKlVP9Jq02dtXs80Z2xN1h
	1U8Qc7pg+rVNUJmZoYpKakJw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 558AE3CF3;
	Wed, 17 Nov 2010 12:54:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 112093CF2; Wed, 17 Nov 2010
 12:54:18 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B69A1598-F273-11DF-96F7-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161628>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Sorry Jonathan I lied. I did not pick up your fast-import changes.
> Could not find how to test it. And it seems fast-import only cares
> about commits, not the target audience of this syntax.
>
> Document is not updated because I think it's intuitive enough.

When you say <tree>:<path>, you would intuitively expect that the path =
is
relative to <tree>, but this patch deliberately breaks (in a good way)
that expectation by introducing a magic token "./".  Once you know that
"./" magic _exists_, it is obvious what it means, but people may not ev=
en
imagine that such a magic may exist in the first place (certainly old
timers won't), and would not know what the magic token is if you do not
tell them.

It needs to be documented.
