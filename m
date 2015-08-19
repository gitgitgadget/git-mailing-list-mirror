From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 10/11] branch.c: use 'ref-filter' APIs
Date: Wed, 19 Aug 2015 21:22:50 +0530
Message-ID: <CAOLa=ZQqewSJtf-4WWY=gr3e0sU5TyBK3gcy-b4YXdS8jXCDZg@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438067468-6835-1-git-send-email-Karthik.188@gmail.com> <vpqh9oov017.fsf@anie.imag.fr>
 <CAOLa=ZR6Cu_AgB4sOBX3Tf_M0w8XN57ej8d_fZo+h7pwFDZs+A@mail.gmail.com>
 <vpq3807gdp0.fsf@anie.imag.fr> <CAOLa=ZTHRLTbmB7iadc3z7=-pshjR0QS8R_StZb7xOyu_gJ=Sw@mail.gmail.com>
 <vpqbneucddv.fsf@anie.imag.fr> <CAOLa=ZTNv7bRMZL_yAGSKxDyBPUBuMQKsybQBg3sKbLzM=m0YQ@mail.gmail.com>
 <vpq37zf2s84.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 17:53:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5g5-0000oM-OX
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbbHSPxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:53:21 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34343 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbbHSPxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:53:21 -0400
Received: by obbfr1 with SMTP id fr1so7843274obb.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yGId81Dgs7/zoijGU0o6KfpRhFeDQI5Ihdpe/ZvG2Io=;
        b=rmaO1t169zHKx9bxibwvn5FQHd09umFU0O11YKTV2xTZqn6gqUaClNl9pfAXwlCJLv
         R81H7KMx4GwQeW3eCphsvUNSX7Q7xh5cQFnAJPvwCHjzP8vu+XSuluyML/QoeoiXTlxh
         nSzASg9WR3fPyFxzqF8XfOrBELfONmIBX3Z92Ad/xxrcAXyesDamQo4vm8Cxly8hxAGl
         6w8CKlJl4lNCxS1Oh7XoD7rSprEvgUVpw0NOxsrx95trCu1dyt2Ktk3cvUrmKcTzO+bS
         1jA0+3U3DiJuJDa4UF1xgMqrSpz+SDz2LUCCR9VYILu3CdhNVRfELoDoSaiZiCxhBLNB
         QfHw==
X-Received: by 10.182.81.98 with SMTP id z2mr11206696obx.70.1439999600343;
 Wed, 19 Aug 2015 08:53:20 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 19 Aug 2015 08:52:50 -0700 (PDT)
In-Reply-To: <vpq37zf2s84.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276200>

On Wed, Aug 19, 2015 at 9:19 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Thu, Jul 30, 2015 at 12:59 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>
>>> IIRC, historicaly Git allowed some weirdly named refs which made some
>>> commands ambiguous (e.g. a branch named after an option like '-d').
>>> We're forbidding their creation so people shouldn't have any, but we
>>> it's important to continue showing them in case some people have old
>>> bad-named branches lying around.
> [...]
>> Agreed. But then again the warning tells about the broken ref, as in it's name
>> So I think It's ok?
>>
>> for e.g. t1430 :
>> [trash directory.t1430-bad-ref-name] ../../git branch
>> warning: ignoring ref with broken name refs/heads/broken...ref
>> * master
>
> [ Late answer, I'm still catching up with my holiday's emails ;-) ]
>
> OK, the warning gives a different interface but it seems as good as the
> old one.
>

Ah! yes :)

-- 
Regards,
Karthik Nayak
