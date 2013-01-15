From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: fix off-by-one directory component length
 calculation
Date: Tue, 15 Jan 2013 12:49:05 -0800
Message-ID: <7vfw222mv2.fsf@alter.siamese.dyndns.org>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <201301152014.28433.avila.jn@gmail.com>
 <7vwqve2qk3.fsf@alter.siamese.dyndns.org>
 <201301152053.58561.avila.jn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:49:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvDRr-0000Qb-Bq
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 21:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab3AOUtK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 15:49:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38435 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756610Ab3AOUtJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 15:49:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2648DAFAF;
	Tue, 15 Jan 2013 15:49:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JjzF/TsF3BTL
	vsfcXhEEn4lzIZQ=; b=jaL6xpkVPe2ILO5m4pm+FjX1J4+j0wabRo5H5wo1+rGp
	KINTrl7+YDzKTqdXgOSTRs2PsqLWN9e8aqjQ6PBsyNxCVoig94hW+pZxF0/ocLQf
	u1HIJaqYd6b/1rrLoiqcaMnDCopT/zK/Ot5tqY+DwUBdLX5/wSOqqlM7N7WugrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ck3uh2
	n0nVanV0VLagpSJKPcktXM5vYLz5L8VsNKoNYRhlhDAVxjCb2/y5mI7aACMU+TsT
	R1EjxOBVahD56FNYEQcdAxYHudvJ8y0irfrPVzRmG53c/hL74hloGpb6oLN44BkN
	MXtEkoo5+V/hAMlibtccuhohKVn0QLX8vGZRU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AE5CAFAD;
	Tue, 15 Jan 2013 15:49:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9676EAFAC; Tue, 15 Jan 2013
 15:49:07 -0500 (EST)
In-Reply-To: <201301152053.58561.avila.jn@gmail.com> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message of "Tue, 15 Jan 2013 20:53:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 017B5AA4-5F55-11E2-AF3E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213674>

"Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> writes:

> Btw, the test 10 to t9902 is failing on my Debian testing. Is it a kn=
own=20
> issue?

Which branch?

If you mean "'master' with the patch in this discussion applied", I
didn't even have a chance to start today's integration cycle, so I
don't know (it is not known to me).
