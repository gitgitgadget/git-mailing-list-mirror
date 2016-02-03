From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] submodule-config: drop check against NULL
Date: Wed, 03 Feb 2016 15:09:10 -0800
Message-ID: <xmqqr3gtl7c9.fsf@gitster.mtv.corp.google.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
	<1454435497-26429-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 00:09:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR6YA-0005HA-0z
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 00:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbcBCXJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 18:09:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755702AbcBCXJN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 18:09:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 964AE40E96;
	Wed,  3 Feb 2016 18:09:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=qpi/D0aMk4wJMaHU1dpFdQae5do=; b=Aa5JYaYIP11EsZGqAvUZ
	S7kar26oWe8/WVHzW2FIt3bB0mblfaj/KY/B8aD600j0vj7Kmb5CzJVHujVrPrT3
	EuxrDaG3uHaBRqoaRDd+E+eh6UanbFj9AfMXv67iGZiiJI4RU/Krm+GaP7rrK2pX
	1Tp/zWIcHuSoWmhjlIvUhR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=xXxt0TxN15ugF8EOzNCWECqB2v15rpAcxYtl1+ioGC/JQ9
	ua8REX4y61pwDS4fAZ73Hb2lZ+0b58/C8B4Sp0kQbT8ASy3Szi3j7/n7gqQIqHPN
	DP9Q3T1KUuoK7EkuNaSSqo5rvr0nR8ayujts4sEG5kcoqOv82Z+odxO7qtfyE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8C34640E95;
	Wed,  3 Feb 2016 18:09:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 09B4040E92;
	Wed,  3 Feb 2016 18:09:11 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 23171556-CACB-11E5-B582-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285377>

Stefan Beller <sbeller@google.com> writes:

> Adhere to the common coding style of Git and not check explicitly
> for NULL throughout the file. There are still other occurrences in the
> code base but that is usually inside of conditions with side effects.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

>  submodule-config.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index 4239b0e..6d01941 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -265,7 +265,7 @@ static int parse_config(const char *var, const char *value, void *data)
>  	if (!strcmp(item.buf, "path")) {
>  		if (!value)
>  			ret = config_error_nonbool(var);
> -		else if (!me->overwrite && submodule->path != NULL)
> +		else if (!me->overwrite && submodule->path)
>  			warn_multiple_config(me->commit_sha1, submodule->name,
>  					"path");

Good.
