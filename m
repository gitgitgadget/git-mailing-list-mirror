From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] wt-status: remove unused field in grab_1st_switch_cbdata
Date: Thu, 13 Jun 2013 10:54:06 -0700
Message-ID: <7vzjutucap.fsf@alter.siamese.dyndns.org>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
	<1371130349-30651-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 19:54:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnBix-0006DH-I9
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 19:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758853Ab3FMRyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 13:54:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56201 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758829Ab3FMRyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 13:54:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1C0827EFD;
	Thu, 13 Jun 2013 17:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HmVxqRrW2Rpt6yJtuWQSVWMjpgw=; b=gTcff6
	Vfe97RDS4uvgve7H4uMnzDtEP6vsqwOlvKDAPuV1gxp0wlSmYA+/znet1bwdLFLq
	YYB0+wij6Kh9/NNB6hpslStHV4GZXme4ULsX/TgpI2+PPukqH1jtv+YCThUoCG45
	Chzb2rd9OCkeCM0T24Kv38bsbRGkJDsb63WLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gdS6n633hwF+NlE9X0iLJzvQYbpMtg7k
	s1kKXwOpLuJKMAh6349lUh8Rd3F1AKwXkwrJ1NfnBLj96Zy/pH/Lbm4Dym6bmRIx
	7d54CHWYC4LIeiLTRzLx4oAwQ2JGRRf07W7XTVOUiRVHSnxtnQDy0agbF+xijXUn
	4HkVQpNHB78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9910527EFC;
	Thu, 13 Jun 2013 17:54:08 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CFB927EF9;
	Thu, 13 Jun 2013 17:54:08 +0000 (UTC)
In-Reply-To: <1371130349-30651-5-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 13 Jun 2013 19:02:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3ED7B1A0-D452-11E2-BDA1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227758>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The struct grab_1st_switch_cbdata has the field "found", which is set in
> grab_1st_switch() when a match is found.  This information is redundant
> and unused by any caller: the return value of the function serves to
> communicate this information anyway.  Remove the field.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

Good.

>  wt-status.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index bf84a86..2511270 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1035,7 +1035,6 @@ got_nothing:
>  }
>  
>  struct grab_1st_switch_cbdata {
> -	int found;
>  	struct strbuf buf;
>  	unsigned char nsha1[20];
>  };
> @@ -1059,7 +1058,6 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
>  	for (end = target; *end && *end != '\n'; end++)
>  		;
>  	strbuf_add(&cb->buf, target, end - target);
> -	cb->found = 1;
>  	return 1;
>  }
