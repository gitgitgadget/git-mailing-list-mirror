Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F74B1F858
	for <e@80x24.org>; Tue,  2 Aug 2016 10:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbcHBKZ3 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 06:25:29 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34605 "EHLO
	mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbcHBKZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2016 06:25:28 -0400
Received: by mail-qt0-f193.google.com with SMTP id c52so9325466qte.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2016 03:25:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elementarea-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3VjHD5ISByiW8h+4DkIZ5nfuj0LuqG3m7++pqj+h6P8=;
        b=BoOLNTlydMSi4/gy9F8JJLPzCxfxLSK0WuedVeN8DZDOfDsQuiQvARUercPd79yUFf
         MfzCVb2QFYsJodz/P+3Gs9KtWwY6SeikclJAA8yOt1zSk/ptyGvluUxlKM8nUGUabNfE
         Ng0oGFszJVPgQm8TnmGaqlBSwjyxbWuEUbRX7IF5vKE4zItxgXoQu62lb9Vf/3uLKb4S
         aONuCAWU1K3VFuEWSW/4hhfxYyPon6fGatXiMYIGgL5iu86u/L1VbplBvpq3PWPmoSPt
         Ncyyff1ljhDnZYT30s4y4ZHb91c4hAbZ9v/eoBZL5gwGd6X3mBSOuz8e0b1LEJ7u2Ype
         KtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3VjHD5ISByiW8h+4DkIZ5nfuj0LuqG3m7++pqj+h6P8=;
        b=APTtXja0Guv6U7HiZdp8Edjiq16alOrDE4eMHpwzn/BKOw3tUex//BUcBsNZgNdTj9
         14dB9HVg8LKn4XjYx6UPoKNfLvYOOYNzN5HEL/iqPkXTieCGUkPnBDDv9PnEeqSDB4Gv
         Nq2tjHzrg6EWZF2bzJJ7C5AKmUTHOE5z113loo9omR2rzJhdf1cdmuJhbsrSm8lXlGe3
         vyknHppjT6JmfwePn8m3XNa0vbFgr+ZNlhJkEDQRM9md4nBxvosh3jVM09Z9hx9qnFm6
         l/XzKSSrFzJxhzqi2YuOGySQe8icLuStWr+2434QOY9jQW7AK1v+yrdAq0Ve6AXQoZ65
         wREQ==
X-Gm-Message-State: AEkoouuWn6FolhiEaEL92aCJea/uHjE86GCcWsdSrk3gaVVlEaOaIcz9hu/jmhdCIrZuu1a9bOi71EpK/5AooQ==
X-Received: by 10.200.35.44 with SMTP id a41mr100849024qta.25.1470133527236;
 Tue, 02 Aug 2016 03:25:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.195.207 with HTTP; Tue, 2 Aug 2016 03:25:26 -0700 (PDT)
X-Originating-IP: [212.243.229.186]
In-Reply-To: <xmqq37mojme2.fsf@gitster.mtv.corp.google.com>
References: <CABnoAVcUbmvZbu7ZiEUWtq_2P6RQLVnJx1a-PiLW-r8uWQ+5vw@mail.gmail.com>
 <51785fbd-6858-c9b2-7f59-eaf7bd3ea394@gmail.com> <xmqq37mojme2.fsf@gitster.mtv.corp.google.com>
From:	Andreas Brauchli <a.brauchli@elementarea.net>
Date:	Tue, 2 Aug 2016 12:25:26 +0200
Message-ID: <CABnoAVemROJ7YN22gthqoCcDa8JsAJuQ9v+oD+-vw7ocyfHAeg@mail.gmail.com>
Subject: Re: [PATCH] gitweb: escape link body in format_ref_marker
To:	Junio C Hamano <gitster@pobox.com>
Cc:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 1, 2016 at 9:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narębski <jnareb@gmail.com> writes:
>
>> Good catch!
>>
>> Acked-by: Jakub Narębski <jnareb@gmail.com>
>
> Sigh; the contents may be good but the patch is unusable as-is
> because of heavy whitespace damage.
>
> I'll fix it up.  Thanks, both.
My apologies for that, it seems that gmail doesn't do tabs.
I resubmitted the PR as #283 on GitHub along with Jakub's Ack and
fixed the typo he pointed out in the commit message

https://github.com/git/git/pull/283

Kind regards
andreas

>
>>> ---
>>>  gitweb/gitweb.perl | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index 2fddf75..33d701d 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -2090,7 +2090,7 @@ sub format_ref_marker {
>>>                                 -href => href(
>>>                                         action=>$dest_action,
>>>                                         hash=>$dest
>>> -                               )}, $name);
>>> +                               )}, esc_html($name));
>>>
>>>                         $markers .= " <span
>>> class=\"".esc_attr($class)."\" title=\"".esc_attr($ref)."\">" .
>>>                                 $link . "</span>";
>>>
