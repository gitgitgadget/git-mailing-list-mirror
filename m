Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6131F404
	for <e@80x24.org>; Tue, 27 Mar 2018 16:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeC0Q6X (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:58:23 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43822 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbeC0Q6U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:58:20 -0400
Received: by mail-pg0-f68.google.com with SMTP id i124so1423876pgc.10
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PEJw71D7rlII8FSUpOb3W+v5g1umtubP1B7feXlhFsQ=;
        b=gWB4dRYLfzHGJKNeL0EQSgkAiZpge9fOSCJBZiQceWww1O4uzoW0amiDIiDaV5M95P
         9kkpImU6fOna6zcaLdGwozgBkbcSpz9BuXcoyUET+uWLOyagccCHQ2PBz4lJ1YqoTW+i
         yH/prRzgNx+oonJvOof8i/XXOuAA9EElnEkddYmpU1RpkCzIEo+WzXakJWwDAix0vPdT
         BZm13TQX6bFQjKGzY+3m8JYDye2gwrFR9Myqdg15MGI6o+ALWgzfggGGweORqVNXHmto
         MOrsB3LUhe+VZzAxT3XRPM/rla/5vO4UEFFDyuSs6hqru0VBCVhazRRa0N72vnIUIT58
         EgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PEJw71D7rlII8FSUpOb3W+v5g1umtubP1B7feXlhFsQ=;
        b=JzBoKxX7sGuG8IwpRYBjhJYgOlJ7aXyFo8mHluK7RD1C5UKkygP9Zh1SnGY1/Iqzyn
         Gf57JoX17N2vHtn2hGNe/gFKW0XierLYbgzVvaN8/Y3+cm1oSSOt1YKZ9j3QzXqKgwJt
         9VdE5/vapgSdt6WTvmbMABX41tbwgEhmua7/f0CpGlu3LrGH1W7KdwoVqHjC4pdd1Cos
         qlMqm8iyDYmeuZBNWVYjhfXTYP6U/SzKmsDgVkjEzEcdS1JY0dNmKWoX/bQO05nu61HY
         6yIpRpXNIPWvGKcs2tAPu/gbA65rSIfZarYvhOyaLV4ZqfHlhoaKogNwrQgA8LtLkRNZ
         w5MA==
X-Gm-Message-State: AElRT7G4g4o9fTO9d1FpA/VMBHts5VJc7FhQgTGiWSBJ4uq0HsjErtgn
        fUcoo4WIQg9CdtlJF/jpOIQ33wqMO0s=
X-Google-Smtp-Source: AIpwx489qCtPNrORpKH0L9idrH4fBF/m2QFKzljr/75oVcXN1a/QwwbvrZdGWpPWSc7kOOOqs3+o9Q==
X-Received: by 10.99.111.78 with SMTP id k75mr72661pgc.414.1522169899929;
        Tue, 27 Mar 2018 09:58:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p14sm3672879pgu.44.2018.03.27.09.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 09:58:18 -0700 (PDT)
Date:   Tue, 27 Mar 2018 09:58:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 07/35] connect: convert get_remote_heads to use struct
 packet_reader
Message-ID: <20180327165817.GA226477@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
 <20180315173142.176023-1-bmwill@google.com>
 <20180315173142.176023-8-bmwill@google.com>
 <20180327152714.GA27050@duynguyen.home>
 <20180327161110.GA24747@sigill.intra.peff.net>
 <CACsJy8B7Da7ubTti_NL46uejo_OMgx5pkFvk4My5g7RZDmAK7g@mail.gmail.com>
 <CACsJy8CvDRGUX9LmY-jjH=BT5V3qWo8YnU1jqan-6ZbhS+tbQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CvDRGUX9LmY-jjH=BT5V3qWo8YnU1jqan-6ZbhS+tbQQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/27, Duy Nguyen wrote:
> On Tue, Mar 27, 2018 at 6:25 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Tue, Mar 27, 2018 at 6:11 PM, Jeff King <peff@peff.net> wrote:
> >> On Tue, Mar 27, 2018 at 05:27:14PM +0200, Duy Nguyen wrote:
> >>
> >>> On Thu, Mar 15, 2018 at 10:31:14AM -0700, Brandon Williams wrote:
> >>> > In order to allow for better control flow when protocol_v2 is introduced
> >>> > +static enum protocol_version discover_version(struct packet_reader *reader)
> >>> > +{
> >>> > +   enum protocol_version version = protocol_unknown_version;
> >>> > +
> >>> > +   /*
> >>> > +    * Peek the first line of the server's response to
> >>> > +    * determine the protocol version the server is speaking.
> >>> > +    */
> >>> > +   switch (packet_reader_peek(reader)) {
> >>> > +   case PACKET_READ_EOF:
> >>> > +           die_initial_contact(0);
> >>> > +   case PACKET_READ_FLUSH:
> >>>
> >>> gcc is dumb. When -Werror and -Wimplicit-fallthrough are enabled (on
> >>> at least gcc 7.x), it fails to realize that this die_initial_contact()
> >>> will not fall through (even though we do tell it about die() not
> >>> returning, but I guess that involves more flow analysis to realize
> >>> die_initial_contact is in the same boat).
> >>> [...]
> >>> @@ -124,6 +124,7 @@ enum protocol_version discover_version(struct packet_reader *reader)
> >>>       switch (packet_reader_peek(reader)) {
> >>>       case PACKET_READ_EOF:
> >>>               die_initial_contact(0);
> >>> +             break;
> >>
> >> Would it make sense just to annotate that function to help the flow
> >> analysis?
> >
> > Yes that works wonderfully with my gcc-7.3.0
> 
> And this changes things. Since this series is 35 patches and there's
> no sign of reroll needed, I'm going to make this change separately.
> Don't reroll just because of this
> -- 
> Duy

Looks like a good change, but yes, it should work fine as a patch on
top.

-- 
Brandon Williams
