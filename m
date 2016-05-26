From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] submodule-config: keep shallow recommendation around
Date: Thu, 26 May 2016 10:22:27 -0700
Message-ID: <CAGZ79kaFD=0ijNvs8B9V+KbhasqF1N6OoAVucR-Hf_hVN+b-dQ@mail.gmail.com>
References: <20160526000633.27223-1-sbeller@google.com> <20160526000633.27223-2-sbeller@google.com>
 <2022441346.44059.1464253372857.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 26 19:22:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5yzW-0001Mj-5D
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 19:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbcEZRW3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2016 13:22:29 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34996 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbcEZRW2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2016 13:22:28 -0400
Received: by mail-io0-f181.google.com with SMTP id p64so16279433ioi.2
        for <git@vger.kernel.org>; Thu, 26 May 2016 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RvZ1vRciBD1K5fHT4ULBYpF1XpdwfU5/+TA1gj2UwHA=;
        b=oSfKy14Ov2whf69Acbg6FaGFbIPT4ew7EklWZ6lC4tELubSxchD/Z5+R8FR5mkAbPz
         DO/mIkFJaNpua/NuptKR0gT8GgkBojurCy/blnGxxgQFQJuk+gFH5qusIyGPGwaeGyPP
         5tm1FQsCN9Pjocau5NdhxbRuRaQmqp/jjSLUeq0XTRY80VS0RVrzn+DDztTZpEQR0rbK
         ZmKyIi2sf8oDDGqYBa0xWsxQlUajYR7Ycw2xXVFBSYAftJt2UtjaZyVJgvReX0OGdoQe
         uRsYExGv622b7pU8tgwE40gXtpEOfBkSEevB6p6hrwTz9yDN6bNE0auzjMOTaV5fD0DA
         YbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RvZ1vRciBD1K5fHT4ULBYpF1XpdwfU5/+TA1gj2UwHA=;
        b=i98DAma5NOBN/Eo9AADv/s6sPtk/1UAAa+w+YNu5AWaeI8x4Na3HyuGvxgPcU9uOi2
         Smij8+cpxmrcKUX3+umHXbaveoHoUOCVj7BPFZMql/tVHUe7dNZS16RaX+ZHvedBdj6I
         rZSyc5bLZhoSDsE6yd1dW/J/W23HO+wQP2hSDJYAj0IyUm6I4jO/kLtshNgSELT5jY8h
         EyFr+KaLbIE9AzXs1IwAirP70UPGg+QaI/tFtkVcmJ2yxdnxJUUHfg/250PRUuvbb1eF
         gEJdy/WwXsK5RJ4Tc8nFFofEHTLEjK5u1RE0ShsyjHot1gGfC0vdbgPQC2BaJmssfRzn
         HUwQ==
X-Gm-Message-State: ALyK8tJSSZv2N4yKJ3tRYVsoyt34aKKYqEWzxh6UAG/rrYXIWDl71nP49RA8+dC+T98uv/Ytsx/sAgbfpEBnIW5Q
X-Received: by 10.107.173.20 with SMTP id w20mr10863903ioe.110.1464283347840;
 Thu, 26 May 2016 10:22:27 -0700 (PDT)
Received: by 10.107.136.19 with HTTP; Thu, 26 May 2016 10:22:27 -0700 (PDT)
In-Reply-To: <2022441346.44059.1464253372857.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295677>

On Thu, May 26, 2016 at 2:02 AM, Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> Hi Stefan,
>
> Stefan Beller <sbeller@google.com> writes:
>> [...]
>> @ -353,6 +354,15 @@ static int parse_config(const char *var, const c=
har *value, void *data)
>>                  else if (parse_submodule_update_strategy(value,
>>                           &submodule->update_strategy) < 0)
>>                                  die(_("invalid value for %s"), var)=
;
>> +        } else if (!strcmp(item.buf, "shallow")) {
>> +                if (!me->overwrite &&
>> +                         submodule->recommend_shallow !=3D -1)
>
> Nit: You seems to be able to keep the whole condition on the same lin=
e:
>
>                 if (!me->overwrite && submodule->recommend_shallow !=3D=
 -1)
>
> If you want to keep it in two line, you might want to align it:
>                 if (!me->overwrite &&
>                     submodule->recommend_shallow !=3D -1)

Thanks will fix!

>
> Thanks,
> R=C3=A9mi
