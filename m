Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F39C2095B
	for <e@80x24.org>; Mon, 20 Mar 2017 12:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbdCTKlh (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 06:41:37 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35433 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753664AbdCTKkn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 06:40:43 -0400
Received: by mail-wm0-f43.google.com with SMTP id u132so59726211wmg.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5RVcmG7MAsq+Hbzf3aEhIZKmujdZJXVbG3NyXL9oPs=;
        b=2BFIrp2VQeXdySIUmIpGt38OcFaOtEfrx5B/BkhZ7s2u/is4RABw3x42Tdl6crA1Bk
         sj4QxVox+JiUcJq3mgvnMa2FOsgJKTUVORT54zyem9KQaGkHCTMKRooXfXEFxDQk4qZq
         CadYh5sEJblsFsbsiolbubE4AvYRoqRbWnTs3P+P1315M3uONK3U9yylRLeHDssAUzHj
         RASG44UrPhDyrYnGfrjzXP+4ONLXTUXgozBiuFD2h72r2sq0kWAX+C3mXbQ3mv7xYV3V
         zBnCLar5UCHWGtIIM/UKQyHTYvoFph8VMOv++wpC0OBPvq3f1UPBbJ3YKx+80HZD7A5Q
         Qh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5RVcmG7MAsq+Hbzf3aEhIZKmujdZJXVbG3NyXL9oPs=;
        b=CSsUkLk52RII7ATs88ymDpZPxXEOUvdSmDRaC7yn1yqCWHC+zsZtGQWo9skrf+HrK9
         /X0jNCm3++AgfjnJshYqrzDBXxWpZNLy7LTKgXmpXZzAt8k1NAQ7ESwWXATJHEE7wI9y
         VLN+m7KMB624NbBLYSzMq0KPXrFoO5Y4sRUVvdthBZDgmdValAMw7uzUAtz+ycpQp91E
         yYBsFXvSIBtfKDYzIVJPM3M1HGxHWagLeSTtLVV2nlBvnU8f1VgCZJn/nvm/v6+Wgj3J
         x98ZsncUWUQytIvUJstdIkekYps/uE4hAgAD7hAf/2TMnr/JXPQWFlf0Do5Y4aKSVPst
         +ZeQ==
X-Gm-Message-State: AFeK/H3hnCazBvPdd7c8tpVg0YHx78eMmUqjI2yTYmj2rnx3xHbG043v8ghG78ZM9CkU1Q==
X-Received: by 10.28.208.7 with SMTP id h7mr9448844wmg.79.1490006406164;
        Mon, 20 Mar 2017 03:40:06 -0700 (PDT)
Received: from seahawk (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id 53sm20288374wrt.52.2017.03.20.03.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Mar 2017 03:40:05 -0700 (PDT)
Message-ID: <1490006404.15470.12.camel@kaarsemaker.net>
Subject: Re: [PATCH v3 0/2] diff --no-index: support symlinks and pipes
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Mon, 20 Mar 2017 11:40:04 +0100
In-Reply-To: <xmqqo9wwzzpl.fsf@gitster.mtv.corp.google.com>
References: <20170318210038.22638-1-dennis@kaarsemaker.net>
         <xmqqo9wwzzpl.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-03-19 at 15:08 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > Normal diff provides arguably better output: the diff of the output of the
> > commands. This series makes it possible for git diff --no-index to follow
> > symlinks and read from pipes, mimicking the behaviour of normal diff.
> > 
> > v1: http://public-inbox.org/git/20161111201958.2175-1-dennis@kaarsemaker.net/
> > v2: http://public-inbox.org/git/20170113102021.6054-1-dennis@kaarsemaker.net/
> > 
> > Changes since v2, prompted by feedback from Junio:
> > 
> > - A --derefence option was added and the default is no longer to dereference
> >   symlinks.
> 
> I do agree that it makes sense to have --[no-]dereference options,
> but I do not think it was my feedback and suggestion to make it
> optional (not default) to dereference, so please do not blame me for
> that choice.

Then I misinterpreted your message at 
http://public-inbox.org/git/xmqqk29yedkv.fsf@gitster.mtv.corp.google.com/
No blame inteded, my apologies for coming across as blaming.

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
