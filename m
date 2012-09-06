From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 5/9] Refactor excluded and path_excluded
Date: Thu, 6 Sep 2012 11:59:15 -0300
Message-ID: <CACnwZYe19r9mefDmAQtuE5NU4jw033fc_i4JvMZUgtMUkNgEOw@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
	<1346544731-938-6-git-send-email-git@adamspiers.org>
	<CACsJy8A-P0RziZt1_PajFrzqmq9ZbkyaxwUCeDAO3XteQ0gAag@mail.gmail.com>
	<7vr4qhbt3d.fsf@alter.siamese.dyndns.org>
	<CACsJy8D23tDa3SJO6yegHFs2hT+bTr6mLTn16ZU3kiT1dtj4vw@mail.gmail.com>
	<7v627r7s5c.fsf@alter.siamese.dyndns.org>
	<CACsJy8Aq7Sodm1_k2kAmfajHG4wP76xHCshDGPfiLYfzuNwWaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 16:59:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9dYG-0002U2-1U
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 16:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757477Ab2IFO7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 10:59:18 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48931 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757438Ab2IFO7Q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 10:59:16 -0400
Received: by lagy9 with SMTP id y9so1160815lag.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SHodqh1gKiiUWTHxW6Hxn9VcrUUfioe3yTrZ3mSrAL8=;
        b=dQfkji3xi+VgI/MghxepXCjte7/CNaeaCVFRWEtLMD3tygDDtjDhadYvjaHHsfS0yP
         Li0AshPOXSc5/Z4nSIs7uLyKky2TozkhyxsnQEi06EhjF5cPCn8GZmaZnvhJrobQK2A9
         NJjIyhHM6CslYNzwThmy7EnhXfaWJpSoVmYhGrXCErTKM+EqIdHlYqWjnfCQDUDBQQGx
         P53VvspZhOPTYDDk8W2ktcrSa6y/edv9DOaTI5Dq0++SRFWNj9EYvHMGJzpTxJSmydRf
         XQuOQJ9z54fhSNUsIV4ESr6YoOre/U3flsuJcD4HNRJR7chvntJ8HxJxqGfiyCQDYvcS
         I8AQ==
Received: by 10.112.30.34 with SMTP id p2mr981092lbh.85.1346943555466; Thu, 06
 Sep 2012 07:59:15 -0700 (PDT)
Received: by 10.112.110.163 with HTTP; Thu, 6 Sep 2012 07:59:15 -0700 (PDT)
In-Reply-To: <CACsJy8Aq7Sodm1_k2kAmfajHG4wP76xHCshDGPfiLYfzuNwWaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204893>

On Thu, Sep 6, 2012 at 9:13 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Thu, Sep 6, 2012 at 10:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> We could introduce exclude_path() and kill path_excluded() then. There
>>> are just about 5-6 call sites to replace.
>>
>> The name path_excluded(... path ...) sounds like it is asking a
>> yes/no question "is this path excluded?", which actually is what is
>> going on.
>>
>> The name exclude_path(... path ...) sounds as if you are requesting
>> somebody to exclude the path.  Does that meaning match the semantics
>> of the function?
>
> I'm not great at naming. And path_excluded() cannot be reused to avoid
> problems with other ongoing series if any. So path_is_excluded()?

is_path_excluded()?
