From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 0/2] Allow detached forms (--option arg) for git log options.
Date: Thu, 29 Jul 2010 11:16:42 +0200
Message-ID: <201007291116.44859.jnareb@gmail.com>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr> <m37hkhklll.fsf@localhost.localdomain> <20100728130610.GG6895@madism.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 29 11:17:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OePFF-0006fe-0n
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 11:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660Ab0G2JRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 05:17:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65429 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755584Ab0G2JRe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 05:17:34 -0400
Received: by fxm14 with SMTP id 14so68160fxm.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VXUW4I8Oi7oC2HLhr9WhlKod3d2dOCzBU3mYC6aMEEY=;
        b=XScU3mVTgy2Z5A/A+nvk8pPazRnZBv0IsIUWyha88w6pyrQ21tD7m9pMBFBO8Kn2hp
         Qnhb6wj6+NQVlq8fhDTIEkjp1OvjNXbnEtvULFqotm2M7FX0bPtajxps/KVrs0iMRsjx
         sN164Nlqc9M0hCQzOamvL4l+lEWK4qDhrWLB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=smVI2e9osskMJtx5l7Rg6x/jWoe6DQFNgzSSz5J/ygydYNUBll1FT+5VHrK+GC3VDL
         EjMKKznp0bbdsFASVxMd5hjZmaQ7W+NmAPWX/2N51WQKnu9gdf0+GzvPDaPASbjnbgJR
         D2Gw10xTir8hlDn+8vh1P7cF1ZiYRiBpV7Jyc=
Received: by 10.223.115.201 with SMTP id j9mr11380342faq.48.1280395053528;
        Thu, 29 Jul 2010 02:17:33 -0700 (PDT)
Received: from [192.168.1.13] (abve207.neoplus.adsl.tpnet.pl [83.8.202.207])
        by mx.google.com with ESMTPS id l12sm226708fan.1.2010.07.29.02.17.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Jul 2010 02:17:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100728130610.GG6895@madism.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152170>

On Wed, 28 Jul 2010, Pierre Habouzit wrote:

> you cannot take the address of a bit portably in C, so you can't let
> parseopt set/clear bits through bitfields (as in unsigned field : 1 in a
> struct in C I mean).
> 
> So to use parseopt OPTION_BIT feature, you have to convert them to C
> flags as in "unsigned flags" and explicit masks defines/enums.
> 
> IOW:
> 
>     struct foo {
>        unsigned bar : 1,
> 		...
> 		  baz : 1;
>     };
> 
> Must be converted into:
> 
>     struct foo {
>     #define FOO_FLAG_BAR (1U <<  1)
>     ...
>     #define FOO_FLAG_BAZ (1U << 18)
>       unsigned flags;
>     }
> 
> so that you can use parseopt.  that's what I meant.
> 
> 
> This was done for the rev-list parsing stuff e.g.

e.g. what?

-- 
Jakub Narebski
Poland
