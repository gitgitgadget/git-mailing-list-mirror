From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add "ls", which is basically ls-files with
 user-friendly settings
Date: Thu, 07 Jan 2010 10:01:32 -0800
Message-ID: <7vfx6h4ww3.fsf@alter.siamese.dyndns.org>
References: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
 <1262884076-12293-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 19:02:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSwg6-0004eh-4o
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 19:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab0AGSBn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 13:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026Ab0AGSBm
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 13:01:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab0AGSBk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 13:01:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E5EFD8EE75;
	Thu,  7 Jan 2010 13:01:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=O50kvxqDOFv8BuU+j79UJ8Ihe
	iE=; b=nDu67QkM7zm/tNJ8W74HVuNXaWcIFBTisXDL+Te/Xedk6eIZSnjuRvv25
	1fcxmRJewUDVRXpD/WnFVdKaXFR4xVOaGV6uU8WkedHqoMKqOngy2SagZiMhcPY1
	bC6jmPF3rmbrTnSruTuqehQgr6lHzgc0br6NxUXxmbwWcB3rQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Su1QZUbGKjBhRCaC4G/
	OH4N5Ezm/1Hxpoi1y33ib5sx7cUbXFsEmKoZKIAt8d4UhHKRZ/Aa3uBkYcsFbfNH
	0mcOzDUM7FlzQmS/1S5naN8z3vWy2mIamwslX0LWzciDp16Et2RzYTCtnb0iZx80
	hMl4io/DbYKzbCixrLSb6+0E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AEE6F8EE72;
	Thu,  7 Jan 2010 13:01:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEACF8EE70; Thu,  7 Jan
 2010 13:01:33 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B2996318-FBB6-11DE-BEA2-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136371>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +
> +	if (show_colums) {
> +		const char *argv[] =3D { "column", NULL };
> +
> +		memset(&cp, 0, sizeof(cp));
> +		cp.in =3D -1;
> +		cp.out =3D dup(1);
> +		cp.argv =3D argv;
> +		start_command(&cp);
> +		close(1);
> +		dup2(cp.in, 1);
> +		close(cp.in);
> +	}

I think the code for columnar output used in producing "git help -a"
output should be reusable (if not, should be made reusable and reused
here).
