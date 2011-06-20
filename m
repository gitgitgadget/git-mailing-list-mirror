From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] user-configurable git-archive output formats
Date: Mon, 20 Jun 2011 08:58:41 -0700
Message-ID: <7vsjr4cx5a.fsf@alter.siamese.dyndns.org>
References: <20110614181732.GA31635@sigill.intra.peff.net>
 <20110614181821.GA32685@sigill.intra.peff.net>
 <4DF7B90B.9050802@lsrfire.ath.cx>
 <20110614201433.GB1567@sigill.intra.peff.net>
 <20110614204521.GA12776@sigill.intra.peff.net>
 <20110615223030.GA16110@sigill.intra.peff.net>
 <4DFCBB92.5040308@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@github.com>, "J.H." <warthog19@eaglescrag.net>,
	git@vger.kernel.org, git-dev@github.com
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jun 20 17:58:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYgsD-0007tF-MM
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 17:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711Ab1FTP6p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jun 2011 11:58:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53767 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab1FTP6o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2011 11:58:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 969C756BC;
	Mon, 20 Jun 2011 12:00:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=r+TGldooFGTL
	VcGTaQ8/WhBV6EY=; b=gVUo1w61CQdVNBd4rTZ1f6hnT1WWO4FKk2yLqFiR8x9k
	ASR1xr0QY+ZByfoPBds8GN/Ngl2o9ZfuBkwzApxIY6zjHFa3ZIGUhtfr2iQC/Qiq
	j1iSqwTuKsPOGfA1sxEMwrT2Gt05ZhFYrmQ6ORkK/uRWkejqiBi+7srzqrVJ25M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WgR2DP
	YxPQpzjq4VT0w4t0vWfLRGrig+qTMvupe413z2wqkHean8WLmXrNHbgntnHBN/Ld
	9cPmslwVD9qPMQL9pf7U/N9AGw84ShL0NQZ0mk6ih+bTco+ZiiTEeTIBh22RsSyS
	vnYSIREcHV0nVywg8l5so1jvYUz7BE5e8f6GI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6AC0556BB;
	Mon, 20 Jun 2011 12:00:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 902DC56BA; Mon, 20 Jun 2011
 12:00:53 -0400 (EDT)
In-Reply-To: <4DFCBB92.5040308@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat, 18 Jun 2011 16:52:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79F04AE0-9B56-11E0-8DC7-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176077>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> I'm not sure "filter" is a good name, though.  We have core.pager, wh=
ich
> is technically a filter as well, but for a specific purpose.  And we
> have the tar.umask setting as a precedence for format specfic config
> options.  So how about tar.<extension>.compressor?
>
> 	[tar "tgz"]
> 		compressor =3D gzip -cn
> 	[tar "tar.gz"]
> 		compressor =3D gzip -cn
> 	[tar "tar.bz2"]
> 		compressor =3D bzip2 -c
>
> We don't need a compressionlevels option here because we can simply
> assume that the compressor commands do support them.  (Side note: thi=
s
> is not fully true for bzip2, as it doesn't support -0, but I don't th=
ink
> this is worth special consideration in our code, as long as errors of
> the filter are displayed properly.)
>
> And we can also add a config option to restrict the formats creatable=
 by
> upload-archive, to address concerns over DoS attacks with expensive
> compressors:
>
> 	[archive]
> 		remoteFormats =3D tar zip tgz tar.gz

Both sounds sensible, I think.
