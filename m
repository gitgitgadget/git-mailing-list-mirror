From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 09/12] branch: add --column
Date: Mon, 06 Feb 2012 09:31:16 -0800
Message-ID: <7v7gzz98d7.fsf@alter.siamese.dyndns.org>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328371156-4009-1-git-send-email-pclouds@gmail.com>
 <1328371156-4009-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 18:31:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuSPe-0002PR-JN
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 18:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721Ab2BFRbW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 12:31:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755717Ab2BFRbV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 12:31:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B8687FA4;
	Mon,  6 Feb 2012 12:31:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=E1L16QqCvqFx
	/7V9sFoVpKbSsBY=; b=QDYW2n1pNoNPcd7r1PJ1lKq+VYX9gAIl22R6wEtUtTvJ
	nQUJ0W3QYwZVipozfr80AYGy1ekFe3kpUNfVv5Hzj1QNyGnSMfUHZvC87mFRVDcQ
	yEYIepAaWKD6GDJageuG2DbGob3ZvwW/6OZM0sdjVfa612sVr61mNB2hlPq3n1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rABsYV
	NAuAuTf4tmcm3OxrOEEN9KGdc3e6v5sLQDLNdbWiyuCUlqh1GQ45X9QC+NKze9kL
	uzWlOcHTc1cR2u9FkQ2Mhmge4T/+X4r965IuPdMLA0vkRibqttv2XZn+oYjD+l/d
	kuVQ7szsGQf5GIVGiF2sbz70w2bMdnoTCo97w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 431107FA3;
	Mon,  6 Feb 2012 12:31:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A245C7FA2; Mon,  6 Feb 2012
 12:31:17 -0500 (EST)
In-Reply-To: <1328371156-4009-10-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 4 Feb
 2012 22:59:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60569A4C-50E8-11E1-A912-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190081>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> +test_expect_success 'git branch -v with column.ui ignored' '
> +	git config column.ui column &&
> +	COLUMNS=3D80 git branch -v | cut -c -10 >actual &&
> +	git config --unset column.ui &&
> +	cat >expected <<\EOF &&
> +  a/b/c  =20
> +  abc    =20
> +  bam    =20
> +  bar    =20
> +  foo    =20
> +  j/k    =20
> +  l      =20
> +  m/m    =20
> +* master =20
> +  master2=20
> +  n      =20
> +  o/o    =20
> +  o/p    =20
> +  q      =20
> +  r      =20
> +EOF

=46or a test like these where you expect whitespaces at the end, please=
 make
sure that these whitespaces are visible to people who read test scripts=
,
by doing something like this instead:

	sed -e 's/#$//' >expected <<\EOF
          a/b/c   #
          abc     #
          bam     #
          bar     #
          foo     #
        EOF

Thanks.
