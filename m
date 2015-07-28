From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 01/11] ref-filter: add "%(objectname:size=X)" option
Date: Tue, 28 Jul 2015 21:25:14 +0530
Message-ID: <CAOLa=ZS4jeDXy35B=cLin-3e-owfV1g04Z6=kE1Ovjuh-H1qhA@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <xmqqzj2gffth.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 17:55:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK7EK-0007mI-Ut
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 17:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbbG1Pzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 11:55:45 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33727 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbbG1Pzo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 11:55:44 -0400
Received: by obdeg2 with SMTP id eg2so87616577obd.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 08:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2QRD72deNvdZi072bmIgL0gdHDpNRvKGXssCR/xPgvs=;
        b=RFwBhat0mtw5tI/1iZDrDK9ymUSLBvZKWeCkg2xq5+xchGRZBrxEfGLlsgbasneVw9
         lLKDgVTumK9lw4S0adFbQKaAjiZvL4cFQNmnoXhSZExd6gyoVku/z3DyBpIJodBJcWu9
         abDuCqVAQPlhTnrk+3TNcbd3Qa11/Km9LIJpuUV0F8Tnsh+VAYlKVNOwBoVjESenI6A9
         Q6HKAnYhTtgHKn6ZnbtCjVPtWH7gZhOUoG3DMBRfhOnFkVct/Ygl6RZVlyTOxlUZhSYn
         yuz2v3ABIMb6Yj1rQIioEIlL7OpCYoAguJtjYFzB5ejmbiRrIuRTyWkn/EQRhiQV/nXi
         cjvg==
X-Received: by 10.60.177.195 with SMTP id cs3mr34810035oec.37.1438098943914;
 Tue, 28 Jul 2015 08:55:43 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 08:55:14 -0700 (PDT)
In-Reply-To: <xmqqzj2gffth.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274780>

On Tue, Jul 28, 2015 at 9:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Add support for %(objectname:size=X) where X is a number.
>> This will print the first X characters of an objectname.
>> The minimum value for X is 5. Hence any value lesser than
>> 5 will default to 5 characters.
>
> Is the reason why you do not call this "abbrev" because you are
> allowing it to truncate to a non-unique prefix?
>
> If so, wouldn't it make more sense to treat this kind of string
> function in a way very similar to your earlier "padright"?  I.e.
> "%(maxwidth:5)%(objectname)" or something?
>
> If not, and if this is really an abbrev, then it makes sense to make
> it specific to the objectname, e.g. "%(objectname:abbrev=7)".

It is finding unique abbrev, I just named size as it was smaller. But
abbrev seems better, will rename, thanks :)


-- 
Regards,
Karthik Nayak
