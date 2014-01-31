From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 05/17] strbuf: add strbuf_isspace()
Date: Thu, 30 Jan 2014 22:09:58 -0500
Message-ID: <CAPig+cRutsBug5cg+Xb-4uxJyAKYz+n4ri80KTmu+kzq67opDg@mail.gmail.com>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.74582.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jan 31 04:10:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W94UW-0000Qj-QF
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 04:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbaAaDJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 22:09:59 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:60970 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbaAaDJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 22:09:58 -0500
Received: by mail-yk0-f176.google.com with SMTP id 131so20932330ykp.7
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 19:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KanouOA8XOYI3cWlKL4P8EJcXlXXNxJmMdxM+a+ILlM=;
        b=g4/Ks/lgFsvpdWjXSE6iDenK1g19aLSkA1OgfZ9n16ulPOlyQwgAhaK+iXXFGUM3Zh
         fb4I/3cF28sJnEGIYRXiDO7YanWEfXuBpxE22wjB+mhmxOEcF1hsV7K0WHFk3J6xnqTj
         dFcFsg6n90XXjYYKLzxv1jreEI3OO6J03npBJ7A2TZPeBhMGq1mBGK3pDGLPpAObOKmj
         yP2eKuK3oqMuDb1pV45Bpx46yWWhGpBHDd1nUuKVcE8z89Bf06iwb2d9OpG9XhiMNtNz
         BViOUeNH/FOKhXlG1KdIxIEuQV74G3nny3TPPFCHifJou7HJqDHTnCIH3t1plcMnoqKT
         TVWg==
X-Received: by 10.236.105.236 with SMTP id k72mr17124701yhg.30.1391137798144;
 Thu, 30 Jan 2014 19:09:58 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Thu, 30 Jan 2014 19:09:58 -0800 (PST)
In-Reply-To: <20140130064921.7504.74582.chriscool@tuxfamily.org>
X-Google-Sender-Auth: rJnP4Y4INTqW6GhjUCU_3L4Qlc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241290>

On Thu, Jan 30, 2014 at 1:49 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> This helper function checks if a strbuf
> contains only space chars or not.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/strbuf.h b/strbuf.h
> index 73e80ce..02bff3a 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -42,6 +42,7 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
>  extern void strbuf_trim(struct strbuf *);
>  extern void strbuf_rtrim(struct strbuf *);
>  extern void strbuf_ltrim(struct strbuf *);
> +extern int strbuf_isspace(struct strbuf *);

Updating Documentation/technical/api-strbuf.txt to mention this new
function would be appropriate.

>  extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
>
>  /*
