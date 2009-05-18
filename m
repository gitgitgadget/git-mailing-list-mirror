From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] parse-options: add PARSE_OPT_CUSTOM_ARGH for complicated argh's
Date: Mon, 18 May 2009 15:52:21 -0700 (PDT)
Message-ID: <m3vdnyja8i.fsf@localhost.localdomain>
References: <1242557224-8411-1-git-send-email-bebarino@gmail.com>
	<1242557224-8411-2-git-send-email-bebarino@gmail.com>
	<7vd4a7ey4h.fsf@alter.siamese.dyndns.org> <4A11096B.8020208@gmail.com>
	<7vmy9aetc8.fsf@alter.siamese.dyndns.org> <4A1116FF.8030008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 00:52:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Bh8-0004nm-NM
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 00:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbZERWwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 18:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754359AbZERWwW
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 18:52:22 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47605 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbZERWwW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 18:52:22 -0400
Received: by fxm2 with SMTP id 2so3539392fxm.37
        for <git@vger.kernel.org>; Mon, 18 May 2009 15:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=OBaX0IXxUSmVdVBxVYHZb+3YohpxmMO5yzrIq+PLsqg=;
        b=c+5zhumoldIqUWzfc8fOPr0QZAAOa6T/dExQTNacsphwJd/az1i4NEf8+euo4PR34i
         6FGlOsBQ5M9Q077Ig62UJDfAREug2xAnTNHqZqkAMSelSOR0bSpW79Q2XJ9cFFXKExrT
         cN0dSmFOyWOI0dWxfoH4IsYDk4fk+C/MDps7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=eru4wT4/3EoMYcs9naLrjM5d+FTNl6V5sgQSRyhDtdIuTowVa7tRpGxXkXGYWPaCZp
         WicRWjufe5R/tbsz9jHF0yS+ud0FkyBKpKr7xCSyfhWBLdkSO3dIeZV6Em+WV3wjIERK
         RoP6CTVGgv8QxseKTFStZBfrfMfWUGF3zP2fM=
Received: by 10.103.243.9 with SMTP id v9mr4402267mur.91.1242687142180;
        Mon, 18 May 2009 15:52:22 -0700 (PDT)
Received: from localhost.localdomain (abwi178.neoplus.adsl.tpnet.pl [83.8.232.178])
        by mx.google.com with ESMTPS id s11sm1703899mue.20.2009.05.18.15.52.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 May 2009 15:52:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4IMpkX9004837;
	Tue, 19 May 2009 00:51:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4IMpQx7004826;
	Tue, 19 May 2009 00:51:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A1116FF.8030008@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119469>

Stephen Boyd <bebarino@gmail.com> writes:
> Junio C Hamano wrote:

> > You are asking a wrong person.  I am terrible at naming things; think
> > "rerere" ;-).
> >
> > But I think custom-arghelp is much better than multargs.  You are asking
> > "use this help for argument value _literally_", so another possibility
> > perhaps is PARSE_OPT_ARGHELP_LITERAL.
> >
> > After all, there probably are many other valid reasons why you may not
> > want "s/.*/<&>/" blindly applied to your string.  One reason may be
> > because the string describes multiple arguments, but I suspect that it is
> > not the only one.  It is better to name the option after what it does,
> > than naming it after one sample reason why you might want to use that
> > option.
> 
> Ok. I think PARSE_OPT_LITERAL_ARGH might be good; until someone comes up
> with a better one of course.

Well, 'ARGH' sounds a bit strange. I think I'd prefer ARGHELP. :-)
-- 
Jakub Narebski
Poland
ShadeHawk on #git
