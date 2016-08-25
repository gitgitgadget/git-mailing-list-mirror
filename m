Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB081FD99
	for <e@80x24.org>; Thu, 25 Aug 2016 08:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932369AbcHYIq3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 04:46:29 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35779 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755671AbcHYIq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 04:46:28 -0400
Received: by mail-wm0-f54.google.com with SMTP id f65so228643738wmi.0
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 01:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UYLFo2EJidTNGaLRBRUN5RwVu+JzOFAgRjWecq8tiJs=;
        b=I3P+MC5SjHqXItlBG7wzzTks5FRwcPPeSUEVaP48CSa5aRNS3iJvibkmi4j4rFImLs
         hug+0gFL57wNSxWCKE5q80QpT8jtGO85LiI2zWc/J9H3uSbiRSdW2dyVVSxg5gjenFXl
         JNm29J7dVu/JkPuvyGAF802UUL9tVw5dy5Hqe+/Sn4jybtJAxkGuluQ2tT/NvoBzBM45
         uTVpKejzxoRcQCIDX6CmPNa0VQuioufwmTJxAfqQpLgXETMetAQyPIm+nQXedVf1+spE
         9Y6j+Ms+nMDJz6JDI+6E/dT5/TE6ya5vjzq/vswZ2sMcVQ2N+soLRCgvLMoE452xREU/
         8QxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UYLFo2EJidTNGaLRBRUN5RwVu+JzOFAgRjWecq8tiJs=;
        b=J4O7y5RnFF8jA/5g7Rt8HNrEhG8sKPhtTGoDzR+6CnNlnW+VXuWOBHjygiWx29nKBj
         Nui8Dya9HcyaUCoG6hNvyCaoXwXGi6LRZsZcUTnc1hefPXopo2cFpzRvulgAU6WpO57k
         XAgltMqxdjPIeD2aeCJOiNmbYw+YQf9m0KF6jgeZ56FxSL86ZBokOyd/SttEDDCeoflu
         v9AQJj/4/VOYhFPDsh2M3xeazZ+qp1bNwiGd1H0+Lfl5yJTinFDB86DCuTO9TjoXWuBg
         YjNZeW6FFVQ48olcbJaomnDX9wvAA8aeKj/VoWiVdy6DL4Z7A6W2++TTAKL90WZbELAg
         xBRw==
X-Gm-Message-State: AE9vXwNzajSJTUFuIOlfuc0X2O6ScWdBTsR96SdlagRdRAntVm57zVCw3KK7yGVryKl7IuAPqLdN/Vb5oS4LZQ==
X-Received: by 10.28.111.4 with SMTP id k4mr7259188wmc.94.1472114786670; Thu,
 25 Aug 2016 01:46:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.86.67 with HTTP; Thu, 25 Aug 2016 01:45:46 -0700 (PDT)
In-Reply-To: <CAOLa=ZSVgm_J9n9wBp_cPWF4kWtvq_8DMLWGoYTSVetOpEJnAQ@mail.gmail.com>
References: <20160822173528.755-1-oystwa@gmail.com> <20160824180730.mqlvhkthg4imd2vy@sigill.intra.peff.net>
 <CAFaJEqvm9Xj34t+F=KMtwRDEYhwHZ7=MRwsZ22-Gt_UPd4r72A@mail.gmail.com>
 <20160824183358.ahxcgcrg7jo2rygp@sigill.intra.peff.net> <CAOLa=ZSVgm_J9n9wBp_cPWF4kWtvq_8DMLWGoYTSVetOpEJnAQ@mail.gmail.com>
From:   =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Date:   Thu, 25 Aug 2016 10:45:46 +0200
Message-ID: <CAFaJEqs7vE4knXXOdKk+PxY2DZs=7BHGUJY_0a_aKF1ngnX+Lg@mail.gmail.com>
Subject: Re: [PATCH v2] for-each-ref: add %(upstream:gone) to mark missing refs
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 August 2016 at 07:56, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> I'm thinking more on the lines of `%(upstream)` being an atom and the
> `:track` being an option under that atom. I like sub-atom though ;)
>

On second thought maybe "quark" is better :P

> On Thu, Aug 25, 2016 at 12:03 AM, Jeff King <peff@peff.net> wrote:
>>
>> Ah, right. I was feeling like this was all vaguely familiar. I think
>> it would be better to push forward kn/ref-filter-branch-list.
>> According to the last "what's cooking", I think that topic is waiting
>> on more review. If you're willing and able to do so, that would be a
>> big help.
>>
>
> It's been waiting for review for a _long_ time now.
>

To be perfectly honest my C skills and familiarity with the git source
code is not much to speak of. I very much want to take a close look but
I cannot promise anything worth your time...

But if I do find something I'd like to point out should I just reply
directly to the e-mails containing the patches as one usually does even
though they're months old at this point?


=C3=98sse
