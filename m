From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/PATCH 07/11] branch: move 'current' check down to the
 presentation layer
Date: Tue, 28 Jul 2015 17:46:51 -0700
Message-ID: <CA+P7+xrGjeXPg3Fbp3A3gJbFeK2E-CP0uXQHWBb3NbNVUHUe2g@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-7-git-send-email-Karthik.188@gmail.com>
 <vpqbnewxwcx.fsf@anie.imag.fr> <CAOLa=ZTy+KX4K_inpDoMy+thzFdF2RF93yMEHJUExzT4OvjPww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 02:47:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKFWf-0000q2-Aa
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 02:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbbG2ArM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 20:47:12 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38161 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbbG2ArM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 20:47:12 -0400
Received: by iggf3 with SMTP id f3so2671363igg.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 17:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XZ6aSaBbiOngkshjjJLLddMt56f6xMR+8wkw2OQJFO4=;
        b=EytTkUouP8tSiwS66X/iVW/CkR3wGpBmELVimTMcqAT5Eur1aid4CQW9KgdKP28lSl
         ZebU0ErdfQoVb+MPo79EptQcbz+mwbASVGfYAxBaZ+Qd7HzHlnHktbhouTA+zYiPdWlQ
         EXcbB47qV2XYOAJ1fOUnWJ9WwW9/undP9/+2CwKizuS7wNl0DEeQRJB8VdtHDfxMTfzm
         4ghxPFTV3rQBgtmFDLgJp7Y3hY5YiIO7/Yl6w4GOpLp6FxiuUXUBt+mG3ElatmuIPFbA
         K/eyJuRJ9R603VLR6jOelhRYE/EfqBqlpumP9TUCW6qPg6Vp7fRLTac8Qtt7co2HVJa+
         roeQ==
X-Received: by 10.50.61.179 with SMTP id q19mr421073igr.24.1438130831326; Tue,
 28 Jul 2015 17:47:11 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 28 Jul 2015 17:46:51 -0700 (PDT)
In-Reply-To: <CAOLa=ZTy+KX4K_inpDoMy+thzFdF2RF93yMEHJUExzT4OvjPww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274869>

On Tue, Jul 28, 2015 at 1:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 6:39 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> We check if given ref is the current branch in print_ref_list().  Move
>>> this check to print_ref_item() where it is checked right before
>>> printing.
>>
>> This means that the '*' and the different color are coded in C, hence
>> it's not possible to mimick this using "git for-each-ref --format ...".
>>
>> I do not consider this as blocking, but I think the ultimate goal should
>> be to allow this, so that all the goodies of "git branch" can be made
>> available to other ref-listing commands.
>>
>
> Not sure what you mean here.
>

He means to make sure that any feature that was in tag, branch,
for-each-ref, etc should be available as part of ref-filter and in all
of them

Maybe he misunderstood code or maybe you misunderstood the comment here?

Regards,
Jake
