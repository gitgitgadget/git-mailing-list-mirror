From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/WIP PATCH 11/11] Document protocol version 2
Date: Fri, 29 May 2015 14:36:26 -0700
Message-ID: <CAGZ79kbELvZ6otnNwGHsgiC9EjgS2vrDGU2KCgF2c_Azm=-rWg@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-12-git-send-email-sbeller@google.com>
	<xmqqsiafazr7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 23:36:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyRxA-0001iE-Vg
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 23:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919AbbE2Vg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 17:36:29 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36014 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbbE2Vg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 17:36:27 -0400
Received: by qkx62 with SMTP id 62so52218408qkx.3
        for <git@vger.kernel.org>; Fri, 29 May 2015 14:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5WyVD5umXmwBDhs00rDmw1tbKm5sQcplba3wi5KLJkQ=;
        b=euBkVftYaNmO7qR1qkiqn8sr0rK2qBAgk8BdxtMwAwnoYF1Q7TwCYMH+4N1/+STuGI
         H0TWsEQTc17zK/1Th/WfND0GewrR+nwGIz8OKib7//LmXh8Jw7hG44ZuBtf9r44WxyvP
         rn48vDY2sgRC0H8vsC2QOrCqIeP9MTtYUJ266b62t5Em3lBcdpQgxR6sq+shB+0NlvQ4
         +O1EbM7qrOe91E+SmQi5FfP4Y67gXG0UD0MAtEVb7jBihomcbAwZ0U34hX8T8Ix38z6P
         PsBVdAwrIta52FHpH8/MYKTCE9OdgS+m0pF/shN3hH0AQh1EJttqHr9RheHyWDuMbWgf
         ItwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5WyVD5umXmwBDhs00rDmw1tbKm5sQcplba3wi5KLJkQ=;
        b=lZau0OqC6J7qldm/bsD3NizAqNrqvu6UeRtY+THhpmM99gD4dTwGRp2eSFrEcYYF5W
         ptqjiI0cAl2t1L5K/C4VwyOh+aeRCDmwl/fRbBV/Zqcw21583EfKNnoIsRXDEDXqTb/f
         T3IFmglExgypc8EyHukh6exMSGD93RvBgrN3zGibKumyKYJCvS0MMVubc0ohY6IfYJPo
         sJZh0Fk7CQMV6ZkMJYRFHXMXT2B6MiJ2NPLlJGfZ/30D1Xwe8y6p+eb6YoJ4BePXuH2q
         hTZW+fSbSpALi7bztXdMiXzx7FnbcqeCljuLBv1OU97/ocTjykVlquHBWrtGsqcYada4
         kP/A==
X-Gm-Message-State: ALoCoQl9LfHUuaKaNUKAV155gUxhkn32Geunp5xGoN2UjtbgJef7EM7i4YyzdeDQIEhdKt7VxBJP
X-Received: by 10.140.133.9 with SMTP id 9mr12442255qhf.5.1432935386654; Fri,
 29 May 2015 14:36:26 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Fri, 29 May 2015 14:36:26 -0700 (PDT)
In-Reply-To: <xmqqsiafazr7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270273>

On Fri, May 29, 2015 at 1:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> @@ -1,11 +1,11 @@
>>  Packfile transfer protocols
>>  ===========================
>>
>> -Git supports transferring data in packfiles over the ssh://, git:// and
>> +Git supports transferring data in packfiles over the ssh://, git://, http:// and
>
> When you have chance, can you do things like this, which is a clear
> improvement of the current document even if we never had v2, as
> separate patches?

will do.

>
>> +Capability discovery (v2)
>> +-------------------------
>> ...
>> +  capability-list  =  *(capability) [agent LF] flush-pkt
>> +  capability       =  PKT-LINE("capability:" keyvaluepair LF)
>> +  agent            =  keyvaluepair LF
>> +  keyvaluepair     =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")
>
> What is the "=" doing there?  If you meant to cover things like
> "lang=en" with this, I do not think it is a good idea.  Rather, it
> should be more like this:
>
>         capability = 1*(LC_ALPHA / DIGIT / "-" / "_") [ "=" value ]
>         value = 0*( any octet other than LF, NUL )
>
> in order to leave us wiggle room to have more than very limited
> subset of US-ASCII in 'value'.  I suspect that we may want to allow
> anything other than LF (unlike v1 that allowed anything other than
> SP and LF).

Currently we can do a = as part of the line after the first ref, such as

    symref=HEAD:refs/heads/master agent=git/2:2.4.0

so I thought we want to keep this. And below I just corrected what I thought
was a difference between documentation and implementation.

>
>> +  LC_ALPHA         =  %x61-7A
>> +----
>> +
>> +The client MUST ignore any data on pkt-lines starting with anything
>> +different than "capability" for future ease of extension.
>> +
>> +The client MUST NOT ask for capabilities the server did not say it
>> +supports. The server MUST diagnose and abort if capabilities it does
>> +not understand was requested. The server MUST NOT ignore capabilities
>> +that client requested and server advertised.  As a consequence of these
>> +rules, server MUST NOT advertise capabilities it does not understand.
>
> I think it was already discussed that we shouldn't do the
> "capability:" and "cap:" prefixes in reviews of earlier parts, so
> the details of this part would be updated?

sure

>
>> @@ -154,10 +203,14 @@ If HEAD is a valid ref, HEAD MUST appear as the first advertised
>>  ref.  If HEAD is not a valid ref, HEAD MUST NOT appear in the
>>  advertisement list at all, but other refs may still appear.
>>
>> -The stream MUST include capability declarations behind a NUL on the
>> -first ref. The peeled value of a ref (that is "ref^{}") MUST be
>> -immediately after the ref itself, if presented. A conforming server
>> -MUST peel the ref if it's an annotated tag.
>> +In version 1 the stream MUST include capability declarations behind
>> +a NUL on the first ref. The peeled value of a ref (that is "ref^{}")
>> +MUST be immediately after the ref itself, if presented. A conforming
>> +server MUST peel the ref if it's an annotated tag.
>> +
>> +In version 2 the capabilities are already negotiated, so the first ref
>> +MUST NOT be followed by any capability advertisement, but it should be
>> +treated as any other refs advertising line.
>
> Sensible.
>
>> @@ -178,13 +231,28 @@ MUST peel the ref if it's an annotated tag.
>>    shallow          =  PKT-LINE("shallow" SP obj-id)
>>
>>    capability-list  =  capability *(SP capability)
>> -  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_")
>> +  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")
>
> Ditto.
>
> Thanks.
