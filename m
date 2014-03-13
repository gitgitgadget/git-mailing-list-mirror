From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Microproject idea: new OPT_* macros for PARSE_OPT_NONEG
Date: Fri, 14 Mar 2014 06:34:21 +0700
Message-ID: <CACsJy8C5QtgPNxoBvF5nxs47rD1MGgL+2nkZ3WONB6iBZkbyAw@mail.gmail.com>
References: <CACsJy8CBVVJN3V8N_djLF4XKfTbxvdcJCnWmZJxVZOwy8AMQWA@mail.gmail.com>
 <531977AF.4060907@alum.mit.edu> <CACsJy8AUhHE8=Yaj6_G46V6w5ZbA3z403GkBfsbZL7MxgeA3RQ@mail.gmail.com>
 <xmqqzjl1u87n.fsf@gitster.dls.corp.google.com> <CACsJy8Dw=43m_4KzAxwCqLsFq2E23rT=bT3zmGUue6RYTnrOYg@mail.gmail.com>
 <xmqqfvmlj54n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 00:34:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOF9N-0002Ft-S7
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 00:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113AbaCMXex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 19:34:53 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:34134 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092AbaCMXew (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 19:34:52 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so2040972qcx.41
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 16:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zA1jRgQQ8bHJVpY+kccpX7t+MDrS5jOKxW0/SKIdvRQ=;
        b=wVpg+TLLMHHJsAtfyabpWcgFFlJvcJVmsPiabImgkJ/17fBacIJ8pUcrkCnvwBo/e6
         e7WxK/mq6VkDd+w26iMy9+N19q3peUchAPtSQCTwesW6KSmUwAAI5IYO/6nlqu0f/KcU
         ESWc5T5xvioq9kYUcOAD2OdB3b2WLJPAUUQSQRsx0E0yCH7DVbttugNdTRUV/dniYM2e
         TI4XtBy+zfT+wnpLCOTm/l/LD8b8kVZvEIoFvgWTKdu4cpOI5tladw52zRkV47bE6vMz
         vgKr3dEDlBmBTjOuTBHCu+xrrcUsvAjfzptjwFRJTQlyokzMXjRo/QzG+D97Hnpfkyn/
         xXRw==
X-Received: by 10.224.161.4 with SMTP id p4mr5915082qax.89.1394753691534; Thu,
 13 Mar 2014 16:34:51 -0700 (PDT)
Received: by 10.96.215.102 with HTTP; Thu, 13 Mar 2014 16:34:21 -0700 (PDT)
In-Reply-To: <xmqqfvmlj54n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244061>

On Fri, Mar 14, 2014 at 2:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sat, Mar 8, 2014 at 2:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Looking at "git grep -B3 OPT_NONEG" output, it seems that NONEG is
>>> associated mostly with OPTION_CALLBACK and OPTION_SET_INT in the
>>> existing code.
>>>
>>> Perhaps OPT_SET_INT should default to not just OPT_NOARG but also
>>> OPT_NONEG?
>>
>> There are OPT_SET_INT() that should not have NONEG in current code. So
>> there are two sets of SET_INT anyway. Either we convert them all to a
>> new macro that takes an extra flag, or we add OPT_SET_INT_NONEG() that
>> covers one set and leave the other set alone.
>
> Are you forgetting the third alternative, of swapping the default,
> if the ones that do not want NONEG are in the minority, to reduce
> the number of spelled-out instances?
>

There are 12 SET_INT with NONEG and 81 without (though I suspect some
of them should have NONEG). So NONEG is not exactly the majority. And
swapping does not go well with git development style, some in-flight
topics may introduce new OPT_SET_INT() that uses the old behavior.


-- 
Duy
