From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: maintainer question: config http.<url>.* patch administrivia
Date: Wed, 17 Jul 2013 11:15:53 -0700
Message-ID: <CCADBC71-B5F4-4D69-B359-AF45F15F2816@gmail.com>
References: <68EA6AFC-D90D-4704-AF1A-92AF15617E23@gmail.com> <7v7ggp6qdf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 20:16:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzWGf-0000u0-Dw
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 20:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab3GQSP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 14:15:57 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:49015 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621Ab3GQSP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 14:15:57 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl14so2243755pab.6
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 11:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=u3wc3A4InLrjw4nNRfWUzGlJj9W0pzT8gLtmaaUSkDU=;
        b=pjSNYG5EPmDyA0TaRL52bmHwW4eJvq0TXj7EoMefUJma7xgJw0vklKpjqSOYhQd7Hh
         R3wsY3Epzbzzb+LDoMIe5Pag+IW7I0KfKh4WlBNzW/nQUwoltpo34PuWEF2oG3j7nzpp
         YqHR1pH+e0ux1OKySZ+fyZcgxF0kI1/9LeXOYldZfWKlk64dj4m6lJkRZ1MEZx1N0D9i
         0Sj/ggeTfakrtOMPA6T2QT6c7GhKs2c+JRHhErOFxxMYyVXXwuGoPQOKLmZDl5jXwGGI
         anNkCXX5y5yJTG0uDnK149w8ZIWRuMesb6U+iOP0Ur7f1zOUCcAZvGTNaqteCkL7dGoF
         PD7A==
X-Received: by 10.68.28.232 with SMTP id e8mr8171009pbh.94.1374084956561;
        Wed, 17 Jul 2013 11:15:56 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id re16sm11815131pac.16.2013.07.17.11.15.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 11:15:55 -0700 (PDT)
In-Reply-To: <7v7ggp6qdf.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230641>

On Jul 17, 2013, at 10:35, Junio C Hamano wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> perhaps it would be more convenient for you if I re-released the
>> following patch series:
>
> If "These build on top of each other in this order", then it is
> easier for me to manage if they were in a single series.

Yup.  They build on one another so each requires the previous.  Will  
keep them in a single series.


> If f1ff763a (http.c: fix parsing of http.sslCertPasswordProtected
> variable, 2013-07-12) is already solid and need no further tweaking,
> it would be wise not to include the patch in any of your reroll in
> any case.  Instead, just build your series on top of that commit,
> and make it clear that the series is meant to apply on top of that
> commit in the cover letter [0/n] of the series, or after "---" line
> of the first patch [1/n] in the series.

Got it.  Will do.  f1ff763a looks solid to me:

Reviewed-by: Kyle J. McKay <mackyle@gmail.com>

And earlier:

On Jul 12, 2013, at 12:05, Jonathan Nieder wrote:
> Subject: Re: [PATCH] http.c: fix parsing of  
> http.sslCertPasswordProtected variable
>
> this change looks good.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

so I will drop it from any future series and just refer to it in the  
cover letter as you suggest.


> As to allowing GIT_SSL_CERT_PASSWORD_PROTECTED=no, I agree that it
> does not belong to the http.*.<var> configuration series


Agreed.  Will not include it in any future http.*.<var> series.


> If the other patches have any textual dependency, you can
> make it [1/n] of your series and we can treat it just like f1ff763a,
> that is, make sure it is solid regardless of the rest of the series,
> and make it advance before the remainder of the series, so that we
> can still replace http.*.<var> implementation on top of these two
> freely.

Got it.  Will do that and keep it in a single series.

Thanks for the direction,

Kyle
