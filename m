From: Baz <brian.ewins@gmail.com>
Subject: Re: gmail smtp server and git-send-mail. Is this combination working?
Date: Fri, 11 Jan 2008 17:22:14 +0000
Message-ID: <2faad3050801110922idf6f39as6b0f2fb2614e8b46@mail.gmail.com>
References: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
	 <fm1h7t$nnr$1@ger.gmane.org>
	 <4d8e3fd30801091509q49c02e1dua4ca42805ba891d6@mail.gmail.com>
	 <fm44ck$299$1@ger.gmane.org>
	 <4d8e3fd30801101449u11aabd73mba233301df157160@mail.gmail.com>
	 <2faad3050801110419h20acbda8me1cbdb4c6e06a086@mail.gmail.com>
	 <fm85u3$mbd$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Douglas Stockwell" <doug@11011.net>
X-From: git-owner@vger.kernel.org Fri Jan 11 18:22:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDNag-0001Ll-3M
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 18:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761067AbYAKRWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 12:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760995AbYAKRWS
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 12:22:18 -0500
Received: from nz-out-0506.google.com ([64.233.162.230]:53866 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848AbYAKRWR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 12:22:17 -0500
Received: by nz-out-0506.google.com with SMTP id s18so689163nze.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 09:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oPeYZguB7kERyx1lbk8BuWwLVtb1z7bHPRrpbgPwcm8=;
        b=PS+YZu1mZKG5TCW1Fr47xtoEAV9na+XEY6KtlPDTBZge1sz3XNQzxUCev27wWTOW5LUE51VekC6cXmEsAzDMgQ6+c+Ak41MkW8b+YuuUFPLuD1kPwivD0Kv8WpLodnb+6It18zX4zbZdaYr8+Uu2Yyl87UpqXT5NP/gphGkPn00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e2e01l6TkfGf9UW0ZWbpo3XxIaXpv4pbT2yL32KiGJxZPM9AKciiWmrKyi41IYMYa395e8HFGavdyEmSUm2z/lzxWh+lanjrsMF/1xgc/NEOEHjTsLG1pF2AAIShDdG0ye3EsISzHrB4iqJjT9LYR6s8E7pt2l/3Q/voGVnuhQ0=
Received: by 10.142.237.20 with SMTP id k20mr1794056wfh.227.1200072134410;
        Fri, 11 Jan 2008 09:22:14 -0800 (PST)
Received: by 10.142.43.18 with HTTP; Fri, 11 Jan 2008 09:22:14 -0800 (PST)
In-Reply-To: <fm85u3$mbd$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70177>

On Jan 11, 2008 4:36 PM, Douglas Stockwell <doug@11011.net> wrote:
> Baz wrote:
> > On Jan 10, 2008 10:49 PM, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> > With Authen::SASL and Net::SMTP::SSL, you can get 1 patch at a time in
> > via gmail. The alternative connection mode which git-send-email
> > doesn't support yet is to connect over smtp then negotiate TLS using
> > 'STARTTLS'. If you do this then you can send multiple patches via
> > gmail with a single call to git-send-email.
>
> I just tested this. I *was* able to send multiple patches in a single call?

I'm not going to question the bearer of good news :). The error simon
was getting with this was:
> Well, it seems that this only works when sending only 1 patch, when
> sending multiple patches the second one fails with this error:
>> 5.7.0 No identity changes permitted. c14sm2136541nfi
(this was off-list at the tail end of the thread). IIRC I confirmed
that this happened to me but I've used msmtp ever since. Maybe
something's changed at the google end in the meantime.

And looking back at Paolo's problem I see its not going to be the
Authen::SASL problem, its too early in the code; its possible that
he's still trying to connect to port 587 (requires smtp/starttls) not
the default ssl port.

>
> Doug

Cheers,
Baz
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
