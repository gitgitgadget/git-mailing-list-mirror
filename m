From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCH] i18n of multi-line messages
Date: Thu, 22 Dec 2011 23:40:07 +1300
Message-ID: <4EF30907.8070101@gmail.com>
References: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org> <4EF2D436.3080303@viscovery.net> <7vaa6ldpk6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 22 11:40:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rdg4i-0004eB-SB
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 11:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133Ab1LVKk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 05:40:28 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40578 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119Ab1LVKkE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2011 05:40:04 -0500
Received: by iaeh11 with SMTP id h11so13333478iae.19
        for <git@vger.kernel.org>; Thu, 22 Dec 2011 02:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=m/grAi5XKWVD+Fj5oTY43FRTaQMjuAMQPg0InlFBjss=;
        b=a6vjewCItDR+u/AEkfTgnsKZFzdpLAVKoYXZcIuZI4uqbbI1oW956S8NGETvdehxtP
         Ka1u73k2uqF2tHuFYXclYCqDaUAHtaeXNjT+bN9Fu7cFxMByLAurY8eZppUkQXZ/KEIh
         PD1BGLOCiBvswRbh2vR0ryXnnIYiBcb21sarI=
Received: by 10.50.157.131 with SMTP id wm3mr8129459igb.13.1324550403996;
        Thu, 22 Dec 2011 02:40:03 -0800 (PST)
Received: from [192.168.0.150] (222-153-33-227.jetstream.xtra.co.nz. [222.153.33.227])
        by mx.google.com with ESMTPS id l35sm27766549ibj.0.2011.12.22.02.39.59
        (version=SSLv3 cipher=OTHER);
        Thu, 22 Dec 2011 02:40:01 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <7vaa6ldpk6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187606>

Hi Junio,

On 12/22/2011 08:38 PM, Junio C Hamano wrote:
> +	for (cp = buf.buf; *cp; cp = np) {
> +		np = strchrnul(cp, '\n');
> +		/*
> +		 * TRANSLATORS: the format is designed so that in RTL
> +		 * languages you could reorder and put the "prefix" at
> +		 * the end instead of the beginning of a line if you
> +		 * wanted to.
> +		 */
> +		strbuf_addf(&line,
> +			    _("%s: %.*s\n"),
> +			    prefix,
> +			    (int)(np - cp), cp);
> +		emit(&line, cb_data);
> +		strbuf_reset(&line);
> +		if (*np)
> +			np++;
> +	}

Forgive my ignorance if I've missed something, but how is this going to
work for RTL languages? Translators can change the format string but
they can't change the order of parameters passed to strbuf_addf.
