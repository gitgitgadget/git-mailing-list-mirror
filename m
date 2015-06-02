From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2 06/16] remote.h: add new struct for options
Date: Tue, 02 Jun 2015 14:18:50 -0700
Message-ID: <xmqqh9qp24hx.fsf@gitster.dls.corp.google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:18:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YztaL-0001Rg-8q
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbbFBVSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:18:53 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35870 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbbFBVSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:18:52 -0400
Received: by ieclw1 with SMTP id lw1so47959398iec.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=i1pmcZX/lzXpEkhxNBGzHB6kW1oTgQIjRMDbpXEZURc=;
        b=hhAXf5/2Nz//acFFygTAw+Ej5pJVwzpxVpS9AMRQkqZZJ+iZRXwHUpUYwgY2O2n3MJ
         UYs8QTYUwC5sP9ITWcKCXrOOomXoMPrRbcEIMnumysM2ePDVcQ4h3OE2tD7xWY61DWy+
         WDQaEjAySN4Ab1S4x7osF4h3HaCFAZFllrg2c/9sxoGt02ze0Hc4Yj4EZ1tj66rsy+93
         RC38mGbXogoEiC2vdubCH+c3ekmSSfoKBOYRFnkUJCp777k5FDyV1ezfcYnm7flt/sp+
         newECtTBuRnx41N/APFrQrM/hReOt4EetoTnjewov49caJyXPzOt9Ih+4zXRycZ2fHh9
         quEQ==
X-Received: by 10.43.65.19 with SMTP id xk19mr37660518icb.20.1433279931609;
        Tue, 02 Jun 2015 14:18:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id j3sm9585089ige.0.2015.06.02.14.18.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 14:18:51 -0700 (PDT)
In-Reply-To: <1433203338-27493-7-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 1 Jun 2015 17:02:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270602>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Why?

>  remote.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/remote.h b/remote.h
> index d5242b0..16cacfe 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -56,6 +56,20 @@ struct remote {
>  	char *http_proxy;
>  };
>  
> +/* todo: discuss if this should be merged with
> + * git_transport_options in transport.c */
> +struct transport_options {
> +	unsigned multi_ack : 2;
> +	unsigned no_done : 1;
> +	unsigned use_thin_pack : 1;
> +	unsigned no_progress : 1;
> +	unsigned include_tag : 1;
> +	unsigned prefer_ofs_delta : 1;
> +	unsigned agent_supported : 1;
> +	unsigned allow_tip_sha1_in_want : 1;
> +	unsigned use_sideband;
> +};
> +
>  struct remote *remote_get(const char *name);
>  struct remote *pushremote_get(const char *name);
>  int remote_is_configured(const char *name);
