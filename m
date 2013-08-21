From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document the HTTP transport protocols
Date: Wed, 21 Aug 2013 11:45:33 -0700
Message-ID: <xmqqsiy2uble.fsf@gitster.dls.corp.google.com>
References: <1377092713-25434-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, rctay89@gmail.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 20:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCDPZ-0000dW-9x
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 20:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508Ab3HUSph convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Aug 2013 14:45:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39037 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752116Ab3HUSpg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Aug 2013 14:45:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E7AD3B1AC;
	Wed, 21 Aug 2013 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Raz7/uYHPy/X
	q6KVmvi3ZeHw8Cw=; b=AW+YSg95MfmnVa5+1jOlFVV52SyRY6cYpsLmkI70ZxXy
	VutXZUkr69LXjPL1mUPtO1jORVLig7FNJd4sqHOQ1HxQluy9YALhIzyU3KQRxs/Z
	Z19b8bO6zCNsyMAdIvimhqra+12Lyi5vdVyGO5ddx07qJCOI3+jPSfi/MEhu8hU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=w/18V8
	ycu+ppQUko0CrK86Ag2BbswpPIgNNIG6Ty2TFtWEuB7kOFmpWTj5ajSG+thP9Qzh
	S1rvH/haFDLeTLnJkMfH+3nfyMpjx1/8pAERFpBpNHQ9BEKROi1rSxJYHGvD69NV
	0e3Yp5+c49KERnU7hUhY+a9z/cewU+TEi75eU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01DA83B1AB;
	Wed, 21 Aug 2013 18:45:36 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 514643B1AA;
	Wed, 21 Aug 2013 18:45:35 +0000 (UTC)
In-Reply-To: <1377092713-25434-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 21
 Aug 2013 20:45:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DD784AE8-0A91-11E3-A96F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232713>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

>  This is basically the version from Tay Ray Chuan [1] with one more
>  proofreading round from me. My changes besides realignments are belo=
w.
>  There are TODOs remain but I think the document is valuable as it is=
=2E

Thanks.

>  On the topic, C Git's (maybe) violations on this spec are:
> =20
>   - The client does not strip trailing slashes from $GIT_URL before
>     sending to the server, as described in section "URL Format".
> =20
>   - The client does not check that HTTP status code is either 200 or
>     304 when receiving response in discovering references phase.
>
>   - The client verifies the first 5 bytes against pattern
>     "^[0-9a-fA-F]{4}#" instead of "^[0-9a-f]{4}#" as described in
>     section "discovering references".

Perhaps add these to "small projects ideas"?  The last one may want
to be phrased a bit better, though.  I needed to read it twice to
realize that you are saying "the client accepts hexadecimal using
uppercase alphabets where it should not".
