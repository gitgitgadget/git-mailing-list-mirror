Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2370D1F744
	for <e@80x24.org>; Thu, 30 Jun 2016 10:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbcF3KD0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 06:03:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35351 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbcF3KDY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 06:03:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id a66so21377886wme.2
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 03:03:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2P7wnA6kRMrDLWyQnBUkTRuNRVcyXUx+isZJIOaGUU0=;
        b=IWC1Gm7QEUrkvNCV1TtHAkM2saH3ZfGGPrIylkifVGJ5olPd/zQEWyjUfi8C0SxIMk
         wiooaldd4OV5LbKxFlcoOKSxOW+6TGo6Zqki0c4iik86VBP6ms6BBvs229Jpc1DYLSy0
         BiXOLZtEgW9/t2BZvDTL5PagVEjCRCELQYM10RO1evwwMsx663dCG9NsREdiMUjJ59o2
         OhNB9uIYYV7KvfuON8J+mvN7iwtitybYrTHuAdH0Vs+ZsM6jcykP6D8iTC+knliZoWjq
         765CWL0QsW/nF0jFgmWqfJlNDEU/YV4Y43oGswjOo4FCXfpvoRIqLbhDH/ykUCXCPSX2
         +O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2P7wnA6kRMrDLWyQnBUkTRuNRVcyXUx+isZJIOaGUU0=;
        b=NENOJSZsYdYIwfXvvS8ixLQSNxrmKxx96izZxmLUsKgdVOC+Kz56CMbrXIEBRVkC8m
         eJpRxXpXq5SaBsjRkFfhAwibPuBVSCbzorngB2wAdBppGeV9YDXYRi2xQClvPqtoyLV8
         8xVcjyrWIGnQYQycc2DdxbZ86s7EIFFv39V/B9X6Y5R0Ay11UFyunj14dfUvVZHt4cQ9
         KqU464YE4tZzu2WZATuq1i7otwSv5i/15UjUifW/zjIqgVfG1GNIQO//EMmYV8PnP3gV
         /Ms6kFiRFBu9K8DJ5VKAfvFEtdfz4VebCq+vbV3BV5yvPKuaLTqUuZqdVbzgF1F7CvXL
         gIJQ==
X-Gm-Message-State: ALyK8tK8yseBcpw9ODkqx4B/qm7IO3DT6HWtO4zH1K0Oe2G3tz0E4NM482AIY1KenbQ75+crWdshUtLl9shX2A==
X-Received: by 10.28.224.69 with SMTP id x66mr14124999wmg.89.1467280161991;
 Thu, 30 Jun 2016 02:49:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.25.197 with HTTP; Thu, 30 Jun 2016 02:49:21 -0700 (PDT)
In-Reply-To: <20160629200142.GA17878@dcvr.yhbt.net>
References: <20160628181933.24620-1-chriscool@tuxfamily.org> <20160629200142.GA17878@dcvr.yhbt.net>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Thu, 30 Jun 2016 11:49:21 +0200
Message-ID: <CAP8UFD03=fy2hXrZcT_7VP630CqAOHKz61T5GDKsT2f+v5Rnsg@mail.gmail.com>
Subject: Re: [RFC/PATCH v2 00/10] Add initial experimental external ODB support
To:	Eric Wong <e@80x24.org>
Cc:	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 10:01 PM, Eric Wong <e@80x24.org> wrote:
> Christian Couder <christian.couder@gmail.com> wrote:
>> Design discussion about performance
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Yeah, it is not efficient to fork/exec a command to just read or write
>> one object to or from the external ODB. Batch calls and/or using a
>> daemon and/or RPC should be used instead to be able to store regular
>> objects in an external ODB. But for now the external ODB would be all
>> about really big files, where the cost of a fork+exec should not
>> matter much. If we later want to extend usage of external ODBs, yeah
>> we will probably need to design other mechanisms.
>
> I would also investigate switching run_command to use vfork+exec
> or posix_spawn for performance (keeping in mind vfork
> caveats documented at https://ewontfix.com/7/ )

Thanks Eric for this idea and the test!
