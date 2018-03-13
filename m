Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773AA1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 19:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932445AbeCMTwY (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 15:52:24 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:37071 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCMTwX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 15:52:23 -0400
Received: by mail-pl0-f44.google.com with SMTP id w12-v6so422547plp.4
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MpIHMREXNdA4Xy0D22ROPjtGp4SmZeOy/3NK7fxBrAA=;
        b=HEsAOZkvVmal6VlB2XNa0ejOBdU4d6oYhPweDQJ4JWB8NVGldgK5vtmZTGEQlPT44s
         a3bfR07ZcDmtco7tAMz+mEHxJPphF+FH66DkbolAquYgugUYkYSYjgjP6GtcD74ZLJfh
         VVQaEL0XtLvYjwKHf3QGJJcA+ausW14noucBuwXqhzv/SAZzi7u5KA95xUL8Wo5HK/EE
         DedPVlSV46KI467Krc6FvmnGRq06LWDpVpk7BlKiM/38iXqubDHmz24bR4Ge6lGGX5fu
         4+ipVsRVrzd9GxDAUOJeXUAILuKXLXk//DX9NRLTwiM7DpWXD2BdFWuTAP2+b0pvUGG1
         9fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MpIHMREXNdA4Xy0D22ROPjtGp4SmZeOy/3NK7fxBrAA=;
        b=fby8fFHQz2PGxm+HevueaiUtNmagh0EEOt5YJ128wafkKqVuJHJPbTnVvA1aQNdrfU
         T/SlEQU5NJwqibr8OG9+IgNqBp1s1LZgOGY/9iCdhFSUev7pqOhbwBlHiDzQdTdvAjQV
         Sop1E8PgC2aVuVUFnQozLy0h8yvd/LbEAc09ItPUrt0eJIIJBIX06t5czeWCs76npWew
         laSyz8fy1O0CNXo+hV9h3OAV3Ud8i3s/g0bggNwbPb4TFnxjETk1I8Db5gvroo8cKBjC
         PFOsXcQWbF+sk5aWPb3rdMlLXEurpw3si2pnI1wH7aeauHYsS8LBATM4S+IFASQqjHvg
         1wjQ==
X-Gm-Message-State: AElRT7FcTFqnCEe4XKVhJWRABX84Zv7lq11STw+tFO9xvl9ZeRlytPLM
        Jpgy+tW3m1h8EVlyYTrRqBhTQA==
X-Google-Smtp-Source: AG47ELvpo3GRpr+2+exEMf1ByktM/HR7Wul4xV5oCWxMFwaRVpQbkAnLQqjQAMnm3k5w15MfShnedg==
X-Received: by 2002:a17:902:20c9:: with SMTP id v9-v6mr1645796plg.41.1520970742250;
        Tue, 13 Mar 2018 12:52:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 76sm1929568pfm.124.2018.03.13.12.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 12:52:21 -0700 (PDT)
Date:   Tue, 13 Mar 2018 12:52:20 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, peff@peff.net,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 01/35] pkt-line: introduce packet_read_with_status
Message-ID: <20180313195220.GB7638@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-2-bmwill@google.com>
 <20180313123540.d6e416220329bdc172472dc6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313123540.d6e416220329bdc172472dc6@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/13, Jonathan Tan wrote:
> On Wed, 28 Feb 2018 15:22:18 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > +	if (len < 0) {
> >  		die("protocol error: bad line length character: %.4s", linelen);
> > -	if (!len) {
> > +	} else if (!len) {
> >  		packet_trace("0000", 4, 0);
> > -		return 0;
> > +		return PACKET_READ_FLUSH;
> > +	} else if (len < 4) {
> > +		die("protocol error: bad line length %d", len);
> >  	}
> > +
> >  	len -= 4;
> > -	if (len >= size)
> > +	if ((unsigned)len >= size)
> >  		die("protocol error: bad line length %d", len);
> 
> The cast to unsigned is safe, since len was at least 4 before "len -=
> 4". I can't think of a better way to write this to make that more
> obvious, though.
> 
> > +/*
> > + * Read a packetized line into a buffer like the 'packet_read()' function but
> > + * returns an 'enum packet_read_status' which indicates the status of the read.
> > + * The number of bytes read will be assigined to *pktlen if the status of the
> > + * read was 'PACKET_READ_NORMAL'.
> > + */
> > +enum packet_read_status {
> > +	PACKET_READ_EOF = -1,
> > +	PACKET_READ_NORMAL,
> > +	PACKET_READ_FLUSH,
> > +};
> > +enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
> > +						size_t *src_len, char *buffer,
> > +						unsigned size, int *pktlen,
> > +						int options);
> 
> jrnieder said in [1], referring to the definition of enum
> packet_read_status:
> 
> > nit: do any callers treat the return value as a number?  It would be
> > less magical if the numbering were left to the compiler (0, 1, 2).

yeah i'll do this.

> 
> I checked the result of the entire patch set and the only callers seem
> to be packet_read() (modified in this patch) and the
> soon-to-be-introduced packet_reader_read(). So not only can the
> numbering be left to the compiler, this function can (and should) be
> marked static as well (and the enum definition moved to .c), since I
> think that future development should be encouraged to use packet_reader.

The enum definition can't be moved as its needed outside this file.

> 
> The commit message would also thus need to be rewritten, since this
> becomes more of a refactoring into a function with a more precisely
> specified return type, to be used both by the existing packet_read() and
> a soon-to-be-introduced packet_reader_read().
> 
> [1] https://public-inbox.org/git/20180213002554.GA42272@aiede.svl.corp.google.com/

-- 
Brandon Williams
