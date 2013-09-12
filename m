From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 12 Sep 2013 21:51:31 +0200
Message-ID: <CAHGBnuPejvs_zTdV52GWVCF35+Bdih2c1zNuBdHJRd_2ShcnKQ@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<xmqqd2odq45y.fsf@gitster.dls.corp.google.com>
	<20130912183849.GI4326@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 21:51:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKCvP-0003OD-Tp
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 21:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200Ab3ILTve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 15:51:34 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51947 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756194Ab3ILTvc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 15:51:32 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so1308987lbh.19
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uk4LBgLTGSK4UbRdmL8uxCvv+3yqEXY3tU+ie3NEfp4=;
        b=uLvcHxl9FxdrTcIUfqcPitA/YTBY2hZWJaMjuYMan1scK2uOTvZhaq0M73lee6I/+k
         L2v/Te+IIOnAOYS19qoTS21GsEQ11ORpFUGQD+XOq6uhVmJXYrU3+y0nRHW4O062b9qW
         arTEwnk//6xa7mtIpXPIsuNKeHFYekIq7CZnzHFfuBzLKyUkKd/CJH/0Ec/lo0jP4/TF
         OdI+7XltB1a3p9wT65r8fI9hmry4uKvGY1EtdkOmpAjeGh4qDWFnNXrcsP6OOZsjzC6b
         2KZupXekAqaN3OUcjKoO1Fgp0DCbpLdGukrUJzR9W/sUrW8CCSRnRIVvkY28Cgp9HMTo
         yZbQ==
X-Received: by 10.112.0.173 with SMTP id 13mr8553762lbf.8.1379015491475; Thu,
 12 Sep 2013 12:51:31 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Thu, 12 Sep 2013 12:51:31 -0700 (PDT)
In-Reply-To: <20130912183849.GI4326@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234684>

On Thu, Sep 12, 2013 at 8:38 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> Looks good to me, but
>
>> -- >8 --
>> Subject: [PATCH] mailmap: work around implementations with pure inline strcasecmp
>>
>> On some systems, string.h has _only_ inline definition of strcasecmp
>
> Please specify which system we are talking about: s/some systems/MinGW 4.0/

I'm not too happy with the wording either. As I see it, even on MinGW
runtime version 4.0 it's not true that "string.h has _only_ inline
definition of strcasecmp"; there's also "#define strncasecmp
_strnicmp" which effectively provides a non-inline definition of
strncasecmp aka _strnicmp.

-- 
Sebastian Schuberth
