Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402381F404
	for <e@80x24.org>; Tue, 27 Mar 2018 17:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755418AbeC0Qk2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:40:28 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36919 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755389AbeC0QkW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:40:22 -0400
Received: by mail-oi0-f67.google.com with SMTP id e8-v6so6033802oii.4
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+EgV+BBjAomwusFigsbWXMpsELWdtOSnrYB8Y8CFi8k=;
        b=ONUYQAt6vIJ+Zg9GxTPmH5KL97LNCC8cBJ7O+bduzc5wlNPix5EOrslyWP0rt0vX+e
         7qZ8aXZjMNB0vaVYaY7b3HE4H18UxQB/xPIWSZtegyKfQHzyrdGwOVrhNd3DLon/31js
         ZJDtU+91t75qXoIQEDsUCCCKUfTrrSqQ6sG3LAWbKlXCDU3BmYCAw4wHNNa3PrXid0fV
         p5e7C9enChjioqdI2UDmhaEItOb/cgE3EyCFjFnGSRqevCYpdOg642x8yVseU8flXuTb
         8GtKkk/Uil2HrrNlq60GZDFfK76eQhq0hP21kbyUukNvPQukQRF0hEjnU7OAlD0kEEBn
         t1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+EgV+BBjAomwusFigsbWXMpsELWdtOSnrYB8Y8CFi8k=;
        b=uWB1rZ6HIvZnwwOwULC4gXHSx5lNqjFh8IBBjG/dyyX4WOGetx3UbE1uu8p0BZdYsL
         li4/kw6THVuvYu4uq8OHYBsGPkrBKqCd7styqfr8vq/QZVRcH6ufQUn/c+nyimKnKxYj
         93e2n8vHFFPUarS52ouAhEQ5yRBFFqO92Fsx7IPg4sztgu4Ogo6Ha1yjvEurSkJ0E96Y
         p782yuOV8DHgTab6+nkYaHnVwJY2naoK7aWXjm79gZvbeOnSKiRilo74l430x/l9GUsI
         BljF6Cm/AtJhDjmCVwAe6dGR5002lZRy621VnT+Vu2lc3jdCP9/R51LJPEcMMTnRs25Q
         v/LA==
X-Gm-Message-State: AElRT7EIN3TxpZpRg1jsigPLROqybHmbEg2l/EK4TOdKjq1SzyDhsOBr
        jujQn6bOd03zntHtv4Ig5dyzkaj2OXKOilIe+c0=
X-Google-Smtp-Source: AIpwx4+MbHb6cymZM0ywLVkJIJTKIt9O7um/MDHLM7rOnBj93zk0Qk/Sb9ij/+8Vewu12H9BUve1YzFtAPjlwJy93jY=
X-Received: by 10.202.243.84 with SMTP id r81mr24180oih.281.1522168821639;
 Tue, 27 Mar 2018 09:40:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Tue, 27 Mar 2018 09:39:51 -0700 (PDT)
In-Reply-To: <CACsJy8B7Da7ubTti_NL46uejo_OMgx5pkFvk4My5g7RZDmAK7g@mail.gmail.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
 <20180315173142.176023-8-bmwill@google.com> <20180327152714.GA27050@duynguyen.home>
 <20180327161110.GA24747@sigill.intra.peff.net> <CACsJy8B7Da7ubTti_NL46uejo_OMgx5pkFvk4My5g7RZDmAK7g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Mar 2018 18:39:51 +0200
Message-ID: <CACsJy8CvDRGUX9LmY-jjH=BT5V3qWo8YnU1jqan-6ZbhS+tbQQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/35] connect: convert get_remote_heads to use struct packet_reader
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 6:25 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Mar 27, 2018 at 6:11 PM, Jeff King <peff@peff.net> wrote:
>> On Tue, Mar 27, 2018 at 05:27:14PM +0200, Duy Nguyen wrote:
>>
>>> On Thu, Mar 15, 2018 at 10:31:14AM -0700, Brandon Williams wrote:
>>> > In order to allow for better control flow when protocol_v2 is introduced
>>> > +static enum protocol_version discover_version(struct packet_reader *reader)
>>> > +{
>>> > +   enum protocol_version version = protocol_unknown_version;
>>> > +
>>> > +   /*
>>> > +    * Peek the first line of the server's response to
>>> > +    * determine the protocol version the server is speaking.
>>> > +    */
>>> > +   switch (packet_reader_peek(reader)) {
>>> > +   case PACKET_READ_EOF:
>>> > +           die_initial_contact(0);
>>> > +   case PACKET_READ_FLUSH:
>>>
>>> gcc is dumb. When -Werror and -Wimplicit-fallthrough are enabled (on
>>> at least gcc 7.x), it fails to realize that this die_initial_contact()
>>> will not fall through (even though we do tell it about die() not
>>> returning, but I guess that involves more flow analysis to realize
>>> die_initial_contact is in the same boat).
>>> [...]
>>> @@ -124,6 +124,7 @@ enum protocol_version discover_version(struct packet_reader *reader)
>>>       switch (packet_reader_peek(reader)) {
>>>       case PACKET_READ_EOF:
>>>               die_initial_contact(0);
>>> +             break;
>>
>> Would it make sense just to annotate that function to help the flow
>> analysis?
>
> Yes that works wonderfully with my gcc-7.3.0

And this changes things. Since this series is 35 patches and there's
no sign of reroll needed, I'm going to make this change separately.
Don't reroll just because of this
-- 
Duy
