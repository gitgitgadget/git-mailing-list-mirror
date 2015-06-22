From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 04/19] for-each-ref: add '--points-at' option
Date: Tue, 23 Jun 2015 00:57:10 +0530
Message-ID: <CAOLa=ZRTn34K8j5dVKm1szfc6UBUvjR-a9f9cQSc25KnUMZ39Q@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com> <1434919705-4884-4-git-send-email-karthik.188@gmail.com>
 <CAPc5daVNapbjAHwiUq5PXfCnWii4Cs1v6dvDAGFfnVkAJhFZnA@mail.gmail.com>
 <CAOLa=ZSd8KftLrRHBXY7Ch2KpVuFSb2DzCq0eLibAx1+bR9M1Q@mail.gmail.com>
 <vpqpp4nblc2.fsf@anie.imag.fr> <xmqq7fqvh7g6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 21:27:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z77Nh-0001sJ-UM
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 21:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbbFVT1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 15:27:42 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33638 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbbFVT1k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 15:27:40 -0400
Received: by obpn3 with SMTP id n3so36953832obp.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 12:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ki5kAL4chTieavMYbJjrU0a/2b8aCJRRKzSetf5R8T4=;
        b=aLEPHc9SGQpfLcYBW59LeKrJDtwOUXV92c1WDP+M2ZPwL3OZPM+WjOI5PCVPARPpDX
         CKg3/+8+VF1wP7ri/fRuQBbU+scS66msA6R0d3IayU7SjabGwewk0KO7aSrtpN3R3ZDK
         SB1SciLh/bz2ukAhvhGXgnVtAZZfjlmCRiw+XmktH2yQA4gpkAlqeGqIiQX5jLCkzKxd
         ZADRRFXvK8IeHlwyxB2w4FXObQoqJ+sOvH6y8oJtb6oi0xP7sTtQBQiH4xtIZBmtNwhs
         oY/UUbNcHcDhU9YoRRRAQszJf0ODOQJqy5F19i9LejMKyjTlOHzR4YprPQQBErEdb2ZP
         GzVA==
X-Received: by 10.60.58.136 with SMTP id r8mr26659014oeq.30.1435001260270;
 Mon, 22 Jun 2015 12:27:40 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Mon, 22 Jun 2015 12:27:10 -0700 (PDT)
In-Reply-To: <xmqq7fqvh7g6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272406>

On Tue, Jun 23, 2015 at 12:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> On Mon, Jun 22, 2015 at 6:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>  3 & 4 as a single patch may make more sense, if we were to tolerate the
>>>> "let's copy & paste first and then later remove the duplicate" as a way to
>>>> postpone touching "tag.c" side in order to first concentrate on for-each-ref.
>>>>
>>>> I have not formed a firm opinion on what the right split of the series is, but
>>>> so far (assuming that the temporary duplication is the best we can do) what
>>>> I am seeing in this series makes sense to me.
>>>>
>>>> Thanks.
>>>
>>> That would mean squashing 3&4, 6&7 and 10&11 also on similar lines.
>>
>> I have a slight preference for keeping the pairs not squashed. This way,
>> we have a clear separation "write reusable library code" / "use it". But
>> I'm fine with squashing if others prefer.
>
> As I cannot firmly say that "copy & paste first and then later
> clean-up" is bad and we should split them in different way, I
> am fine with leaving them separate as they are.

Even I think it's better to leave them separate, on the lines of what
Matthieu said.

-- 
Regards,
Karthik Nayak
