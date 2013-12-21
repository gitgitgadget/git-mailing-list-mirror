From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 02/12] Convert starts_with() to skip_prefix() for option parsing
Date: Sat, 21 Dec 2013 11:44:08 +0700
Message-ID: <CACsJy8A0TAyBoTdyrRDb54j9uoZ0=cOuxgTfFavRiUOpHTV_ag@mail.gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
 <1387378437-20646-3-git-send-email-pclouds@gmail.com> <52B3E8D4.1030805@viscovery.net>
 <20131220070449.GA29717@sigill.intra.peff.net> <xmqq38lndxae.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 21 05:45:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuEQu-0001j1-V6
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 05:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab3LUEok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Dec 2013 23:44:40 -0500
Received: from mail-qe0-f42.google.com ([209.85.128.42]:48215 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab3LUEoj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 23:44:39 -0500
Received: by mail-qe0-f42.google.com with SMTP id b4so3356144qen.1
        for <git@vger.kernel.org>; Fri, 20 Dec 2013 20:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8YlwW1/edmMTn+asHX1qam4Ew0e8n7TsK6kwIRYz2d8=;
        b=BOsq+c/0mdXJuZQih8zx6KjcHQDMS96re7c4mkHiLM/7C0y6/2opOdya8CAFaj35yb
         sPeqquLhHEutq6SK+ypY8LyqpjHpQUUyulP+o3Uxo58QaxgjbfJGpKo4l+iC4jgD2Bee
         FNIPqU6+0HsY8mP3zngyU9Wh1NMsYUI0Pu5qREUlde5g1EyVah2Fk/XeuOWFXTYhUwtn
         f2dXkPEGimUlBIurT+xsJ1+8lq7/GUNxruJf3RVXRyskQc17AcEx/xft9BGmH2cGomtg
         Ln4bcC2dmUbo43o4FuXlTrb47NViWfQLk7Oq1qEkYgPDzk/64PLpbRDtLWanxe8n0mBI
         +jkg==
X-Received: by 10.224.168.13 with SMTP id s13mr21413965qay.18.1387601078638;
 Fri, 20 Dec 2013 20:44:38 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Fri, 20 Dec 2013 20:44:08 -0800 (PST)
In-Reply-To: <xmqq38lndxae.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239585>

On Sat, Dec 21, 2013 at 4:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>>   /* here we care if we saw the prefix, as above */
>>   if (parse_prefix(foo, prefix, &the_rest))
>>       ...
>>
>>   /*
>>    * and here we do not care, and just want to optionally strip the
>>    * prefix, and take the full value otherwise; we just have to ignore
>>    * the return value in this case.
>>    */
>>   parse_prefix(foo, prefix, &foo);
>
> Sounds fine.  I recall earlier somebody wanting to have a good name
> for this thing, and I think foo_gently is *not* it (the name is
> about adding a variant that does not die outright to foo that checks
> and dies if condition is not right).
>
>         starts_with(foo, prefix);
>         strip_prefix(foo, prefix, &foo);
>
> perhaps?

I still need consensus on the name here guys, parse_prefix.
remove_prefix or strip_prefix? If no other opinions i'll go with
strip_prefix (Jeff's comment before parse_prefix() also uses "strip")
-- 
Duy
