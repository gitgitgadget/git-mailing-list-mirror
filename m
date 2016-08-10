Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57DC61FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933593AbcHJSRf (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:17:35 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38412 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933197AbcHJSRd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 14:17:33 -0400
Received: by mail-wm0-f53.google.com with SMTP id o80so121559266wme.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 11:17:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+5YKQkeg0GcYo/l0FHavZDzw+2pVrytln6hKM9mXZkw=;
        b=m37zTpT3VgUjC0eVJ9i7pBdY89NSwN2bxOuOEtVOD/a+xMkTQQFtFBPdxaQ+fZ+eoC
         Q/QQCgNgXhh9W5gq9cGBu7+J3ibQQA2EcQX4KnYN0gnWytfIBYVMM73aWFvfX1o4hPTB
         TLKGy0SAEKZ2x1IQUN5xVzS3iSi/vV2xFMp5C+PTHpuDmu0CypIevzR11TjM1epasIpP
         94mfD1SJFUWxWAn2ZgF5OPK4aGy+5cgF52B7Qv8upY3XA72p+/dD6EnvzbDHPFwTVnjh
         xYvhShaRvDPwgfFCj8Ek5V16ZGdbHi7cigQygbd9Y2AtLHCw0JS53N9cnKun0yZv2cJR
         d9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+5YKQkeg0GcYo/l0FHavZDzw+2pVrytln6hKM9mXZkw=;
        b=TNmXVpWGK2A6ryJzerwG2iSaBL9lLsJNq6yOH2tzAOiuAEZ4fYZmaj87hfKi8bYYg7
         SUCCAphTIV+cXx85wcvNbMo5JnN8ySaUk7T4LNiSkXRkj/BMtkPHyxoBHYj92aQ9V6M7
         CBc/U3xvsjDC0Knl0vjokRvj8rm9iyalhpm1qHjzNJ2UrqEsBqIKIgSf98FFX09Hznp4
         lCZIs6ZP/RhMeZLcyUbnB7wcIxeC4s5TqhLTCZrbToa8Agd8IoZFUw/6GU0BWg0C+IG3
         OuMCQoU1Ap5Z8zsKu8jNe8uiKk2IVc412tLbCVeal1GN8iUYa3i5ZnVefwxbw5zIf0j+
         dnIA==
X-Gm-Message-State: AEkoouset3sogwqu4gsspsXFfIuZdcAU/po6ej1mu25qS9cyB/rPtGcUrWoJvjkPYyeHTg==
X-Received: by 10.194.41.194 with SMTP id h2mr6077890wjl.2.1470851389364;
        Wed, 10 Aug 2016 10:49:49 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id b123sm9444716wmg.17.2016.08.10.10.49.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 10:49:48 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 04/15] pkt-line: add packet_write_gently()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqtwes5ysb.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 10 Aug 2016 19:49:48 +0200
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Content-Transfer-Encoding: 8BIT
Message-Id: <13CB2673-7C7D-4982-9725-27D4091AAD84@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/> <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-5-larsxschneider@gmail.com> <20160810132814.gqnipsdwyzjmuqjy@sigill.intra.peff.net> <434CB5D7-3FC0-4398-9028-135701121E55@gmail.com> <20160810134003.q6mzgkcrwmkxv5fw@sigill.intra.peff.net> <xmqqtwes5ysb.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 10 Aug 2016, at 19:17, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Jeff King <peff@peff.net> writes:
> 
>> On Wed, Aug 10, 2016 at 03:36:45PM +0200, Lars Schneider wrote:
>> 
>>>> So now we have packet_write() and packet_write_gently(), but they differ
>>>> in more than just whether they are gentle. That seems like a weird
>>>> interface.
>>>> 
>>>> Should we either be picking a new name (e.g., packet_write_mem() or
>>>> something), or migrating packet_write() to packet_write_fmt()?
>>> 
>>> Done in "[PATCH v5 08/15] pkt-line: rename packet_write() to packet_write_fmt()"
>> 
>> Ah, OK. Generally I'd suggest to reorder things so that each patch looks
>> like a step forward (and so the early patches become preparatory steps,
>> and the justification in them is something like "we're going to add more
>> write functions, so let's give this a more descriptive name").
> 
> I am guilty for saying "packet_write() should have been similar to
> write(2)".  We may want to have a time-period during which there is
> no "packet_write()" in the codebase, before we get to that stage.
> I.e. rename it to packet_write_fmt() to vacate the name and add
> packet_write_mem(), and then later rename packet_write_mem() to its
> final name packet_write(), or something like that.  The two-step
> process would reduce the chance of misconversion.

OK. Does this mean I can leave the "packet_write()" to "packet_write_fmt()"
rename as is in this series?

Thanks,
Lars

