From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 14/14] wt-status.c: Initialise variable to suppress msvc
 warning
Date: Sat, 4 Dec 2010 14:52:06 -0600
Message-ID: <20101204205206.GB3170@burratino>
References: <4CFA92A2.4030801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Dec 04 21:52:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POz5n-0005Sc-TT
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 21:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982Ab0LDUwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 15:52:25 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46728 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755860Ab0LDUwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 15:52:25 -0500
Received: by ywl5 with SMTP id 5so5369568ywl.19
        for <git@vger.kernel.org>; Sat, 04 Dec 2010 12:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gLoUl2nf76DpY4w0pABzqtq2tmqiSRvyulERiYpB2sE=;
        b=d1Fg1CTNLyMUdbfNun3Y8e5LkBYPREuwZqLUaXNplRdUvoo4HXSBDcjAMi18bFFPsI
         yuXTjH003JUiNzu1RwpyI9TgGbjC3BemraJslg0GqNEfKvt7nhthhd3e1dQ5WlFvkWdm
         LqRfFldw+WHKdiiZZGMWGPk/i4ea894Kw4+7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SBBrJodYLbcAF3adaf0RkRXmT4/RmhtxdUlOmIx6bdaekyL7waxTMHWFD0I4LEzigt
         Q0MltluDLJL0XR6wq3TMJWtocESY/pKUI9l3EUny76WBBt7BM9GGOoiM/1cVYrX7wMgo
         FKJdhn0L52rnwjK/9AdrQj70dYu5w8GYGq61s=
Received: by 10.150.136.16 with SMTP id j16mr6317862ybd.442.1291495942909;
        Sat, 04 Dec 2010 12:52:22 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id v8sm1994920yhg.40.2010.12.04.12.52.21
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Dec 2010 12:52:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CFA92A2.4030801@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162907>

Ramsay Jones wrote:

> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -149,7 +149,7 @@ static void wt_status_print_change_data(struct wt_status *s,
>  {
>  	struct wt_status_change_data *d = it->util;
>  	const char *c = color(change_type, s);
> -	int status = status;
> +	int status = 0;

Just for the record (I assume you are already aware of this):

 http://thread.gmane.org/gmane.comp.version-control.git/133278/focus=133422
 http://thread.gmane.org/gmane.comp.version-control.git/124676/focus=124803

I personally feel lukewarm about this kind of change.  Is it possible to
suppress this warning from msvc?
