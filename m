From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] fix weird git --paginate behavior
Date: Tue, 06 Apr 2010 00:17:25 -0700
Message-ID: <7v1vetjbi2.fsf@alter.siamese.dyndns.org>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
 <1270492888-26589-44-git-send-email-pclouds@gmail.com>
 <20100406040145.GA30403@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 09:17:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz32b-0004q2-TP
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 09:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340Ab0DFHRh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 03:17:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757280Ab0DFHRf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 03:17:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70B2BA8627;
	Tue,  6 Apr 2010 03:17:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=B0LFq9sk3pS+
	Aj7fVez4R+N0xqU=; b=O+wS5ZHtbEgaTPlK6yafTl4vw9+HsQ8CMgHPzaVZ6jwv
	4pvBBDrpK/NAuuNvRNK7Sfl7xBCfGrnjdAehWtArA2B2gkOD1N1oEZUQgJxYzn4T
	njPYimaH41Dvir+2mKm/gdpmx6gN3cVRb1Khhztfc19JqnT6zrTMxGs9Db2kyi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qIVj4u
	JTGJKZ4xmpXry5l3MyKvlCTDXE3EbLisoRiHR2qFoc+Blkkc5wpbaIka7DJh/LDn
	Xt6ytXNCs5UJebWuL6Viqz6LzTWx87tHkuegSb1QNWQNeRwFM9cOwHmyVtYcKnVn
	cUVdPQ0eqx1NrzGgcm9L9jvHSCWJTviTQb03M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EC0AA8626;
	Tue,  6 Apr 2010 03:17:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14EF6A8625; Tue,  6 Apr
 2010 03:17:26 -0400 (EDT)
In-Reply-To: <20100406040145.GA30403@progeny.tock> (Jonathan Nieder's message
 of "Mon\, 5 Apr 2010 23\:01\:46 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 76DD7BBC-414C-11DF-B02A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144110>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Thanks for posting this series.  I had not read it in full before.
>
> The series is very long and it is hard to make certain it does not
> introduce regressions.  Here is my idea for working around this: the
> idea is to grab patches from the series to form short, independently
> justifiable mini-series.

Thanks for trying out your idea.

I've been having trouble reviewing this series.  I can read bits and
pieces and find things that I mostly agree with, or things that I find
questionable.  But in either case, I cannot be sure about my judgement
without having a clear idea of where the series is trying to go upfront=
=2E

While a re-roll will certainly give us a chance to review the series
"cover-to-cover", it would make it much easier to swallow if this can b=
e
split into independently digestable bite-sized pieces.  I am somewhat
skeptical if a major part of the series will become that smaller,
though...
