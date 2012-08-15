From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 11/16] When debug==1, start fast-import with
 "--stats" instead of "--quiet".
Date: Wed, 15 Aug 2012 12:50:06 -0700
Message-ID: <7vwr103pg1.fsf@alter.siamese.dyndns.org>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 22:27:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1kBR-0000Mf-MA
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 22:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540Ab2HOTuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 15:50:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47577 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756536Ab2HOTuK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 15:50:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EABC390BC;
	Wed, 15 Aug 2012 15:50:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5nOzb56denFYZBokBDGskeWFrT8=; b=ReqKBk
	sOEqRm5q8Hqfh9y+NKQoCZN+33FycIgYjEWBIfzggMkKdbljGnUQKnDP+oP9AYyM
	KhhQnVReLVYcvaCMKZW4fRZe+VsmgLR0mupQpDTjLGCLKWEMsL52QM2LbouI+3f1
	YXwJY+LkKSeq8065nScT+lDwLAKvpRLorWx4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=avnOrNaNK4pMWkLYncUB7B8idaLBeOEo
	l5KcjJi0Z6/P64AgbQgpjxoDGi3uH45AB47Yu02Ns/tzrl5TRvbP9FPFFLfRM6sV
	zFKPi3IKf5cHIcdqWs74JH/Yq2KNx56Mu+EWGv7/6sC+EYe5pijOot1oZdfJZGOA
	RyhVcZ2poAY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2C6690BB;
	Wed, 15 Aug 2012 15:50:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CCD990B4; Wed, 15 Aug 2012
 15:50:08 -0400 (EDT)
In-Reply-To: <1344971598-8213-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Tue, 14 Aug 2012 21:13:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AA6C704-E712-11E1-AA86-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> fast-import prints statistics that could be interesting to the
> developer of remote helpers.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> ---

Sounds sensible and could be useful outside the context of this
series.  Perhaps place it earlier in the series?

>  transport-helper.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 257274b..7fb52d4 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -386,7 +386,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
>  	memset(fastimport, 0, sizeof(*fastimport));
>  	fastimport->in = helper->out;
>  	argv_array_push(&argv, "fast-import");
> -	argv_array_push(&argv, "--quiet");
> +	argv_array_push(&argv, debug ? "--stats" : "--quiet");
>  
>  	if (data->bidi_import) {
>  		cat_blob_fd = xdup(helper->in);
