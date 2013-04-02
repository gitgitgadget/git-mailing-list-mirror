From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] count-objects: output "KiB" instead of "kilobytes"
Date: Tue, 02 Apr 2013 10:41:06 -0700
Message-ID: <7vhajoesp9.fsf@alter.siamese.dyndns.org>
References: <1364903010-644-1-git-send-email-mihai@mihaic.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mihai =?utf-8?Q?Capot=C4=83?= <mihai@mihaic.ro>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:41:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN5DH-0008Tr-US
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757980Ab3DBRlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Apr 2013 13:41:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757112Ab3DBRlJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 13:41:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B22B212F15;
	Tue,  2 Apr 2013 17:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jDz0/CKzilPN
	3+AhLfU837OW+rA=; b=V/YEJPDt2anwQ7ACkAclcd7BnDC6s5XDcgkdIADXokZi
	zNJcdjTKxzup6MOF4YCHokyKfL6SAMWhKNL4YXTt8kcXd2N/rPJyKar1sOkDzcO2
	zIlbsfwmvpiNp2jknAfAPCrB7w23R0i13Xu0u6UPRJts2w8ljGpba/bb2F1ms3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WciaBW
	iEOu1CumNDSKgB9LLUEI9pUNbSk8YVXockkNstCxMF3eRZzjs7Hpl8XbbcU+E+sU
	hZGNyi2LO0KqcpNLY+Ap9mBb2LN5q1FrhiWZSatDLy3s+yphCDehzICo91dPTefK
	jhQMRRqldA9Www4M8DCCrJPBoO/4bCk4GXSSo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A750212F14;
	Tue,  2 Apr 2013 17:41:08 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2806512F12; Tue,  2 Apr
 2013 17:41:08 +0000 (UTC)
In-Reply-To: <1364903010-644-1-git-send-email-mihai@mihaic.ro> ("Mihai
 =?utf-8?Q?Capot=C4=83=22's?= message of "Tue, 2 Apr 2013 13:43:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80363C4E-9BBC-11E2-BB3A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219816>

Mihai Capot=C4=83 <mihai@mihaic.ro> writes:

> The code uses division by 1024. Also, the manual uses "KiB".
>
> Signed-off-by: Mihai Capot=C4=83 <mihai@mihaic.ro>
> ---
>  builtin/count-objects.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> index 9afaa88..ecc13b0 100644
> --- a/builtin/count-objects.c
> +++ b/builtin/count-objects.c
> @@ -124,7 +124,7 @@ int cmd_count_objects(int argc, const char **argv=
, const char *prefix)
>  		printf("garbage: %lu\n", garbage);
>  	}
>  	else
> -		printf("%lu objects, %lu kilobytes\n",
> +		printf("%lu objects, %lu KiB\n",
>  		       loose, (unsigned long) (loose_size / 1024));
>  	return 0;
>  }

I guess nobody reads this in scripts, so it should be OK.

Will queue. Thanks.
