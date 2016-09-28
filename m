Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444C920986
	for <e@80x24.org>; Wed, 28 Sep 2016 04:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750895AbcI1EnE (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 00:43:04 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33140 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbcI1EnC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 00:43:02 -0400
Received: by mail-qk0-f196.google.com with SMTP id n66so2114751qkf.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 21:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bccaBMVWRpcsia2QIIR2UYnTUj3rJb2np7mZzIzj6Qg=;
        b=qxjw/R6xuzSDFS8NuePiKAWY6jCQRajaVmshLVGx555/a+AOemu6NW3wquzF/iV4Wr
         CcSlvEHOVkDqmdByZ3/52nPAtflPAoHtudWuUsI3YJ0BQ9h0AN6/C8osPtMKKAjFYhdS
         QZ5Ifwp6AoBhSR8okcYsyrnr+XzjcV6/c13rLsXH1RL3eWNfkOl7TGrb/Eper/kkJpf/
         BCVy8be0MipXrOgr1PDvdI/IfvsxJhc/CRpWCKdPwZboh/cC/OaSrTnMlTXqrQs0UyBA
         iXXhegPiC0zPeHSunLDvElu7u/cLriqkmMQ9vL6LZ+K0Oe0Zr969liEEb0gJOyT4XaUL
         cMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bccaBMVWRpcsia2QIIR2UYnTUj3rJb2np7mZzIzj6Qg=;
        b=JTQpo66T27KVX22Wu417+5JHQXeQHFsO9po26NDl/q9fRFiAhNc35xwWIPsUHQDKuy
         scucK9gzDDsY6qR/abQA/u8R7e7r+sPPuJNIfbyLlQ2koY6iTKacG1rGVUHxFNeW8u4G
         0ROUne7xa08sq6vM7fMCj+tN2CAfZUVSC1qTwlNku/g30RNRFcC8eIRdPQNL8VPHR/qL
         XqNQqikZTZf2PVlK9mRB9P673Vg8n+1mYfS6KHQ3f5QSyaYoMY79MJoLSL9u6Y+404a1
         al1QfpBZxnZKBuzFuzwC6lzXjwbmkJ4XlOTqnuDdS5wzPOwRiU3PeVVZyQQ1nrVzUDUx
         5oEg==
X-Gm-Message-State: AA6/9RlztLcwoERr5Tspo05ZiNZR+UWXCL4yC7+VUlt89sd4MAwXwxKNKBs4d1gF/4OQjA==
X-Received: by 10.55.82.4 with SMTP id g4mr29941085qkb.220.1475037781889;
        Tue, 27 Sep 2016 21:43:01 -0700 (PDT)
Received: from kwern-HP-Pavilion-dv5-Notebook-PC (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id 48sm3040241qtu.39.2016.09.27.21.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 21:43:01 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
X-Google-Original-From: Kevin Wern <kwern@kwern-HP-Pavilion-dv5-Notebook-PC>
Date:   Wed, 28 Sep 2016 00:42:59 -0400
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Wern <kevin.m.wern@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 03/11] pkt-line: create gentle packet_read_line functions
Message-ID: <20160928044259.GB3762@kwern-HP-Pavilion-dv5-Notebook-PC>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
 <1473984742-12516-4-git-send-email-kevin.m.wern@gmail.com>
 <xmqqoa3nij5z.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqoa3nij5z.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 03:17:28PM -0700, Junio C Hamano wrote:
> Kevin Wern <kevin.m.wern@gmail.com> writes:
> 
> >  	/* And complain if we didn't get enough bytes to satisfy the read. */
> >  	if (ret < size) {
> > -		if (options & PACKET_READ_GENTLE_ON_EOF)
> > +		if (options & (PACKET_READ_GENTLE_ON_EOF | PACKET_READ_GENTLE_ALL))
> >  			return -1;
> 
> The name _ALL suggested to me that there may be multiple "under this
> condition, be gentle", "under that condition, be gentle", and _ALL
> is used as a catch-all "under any condition, be gentle".  If you
> defined _ALL symbol to have all GENTLE bits on, this line could have
> become
> 
> 	if (options & PACKET_READ_GENTLE_ALL)
> 
> > @@ -205,15 +209,23 @@ int packet_read(int fd, char **src_buf, size_t *src_len,
> >  	if (ret < 0)
> >  		return ret;
> >  	len = packet_length(linelen);
> > -	if (len < 0)
> > +	if (len < 0) {
> > +		if (options & PACKET_READ_GENTLE_ALL)
> > +			return -1;
> 
> On the other hand, however, you do want to die here when only
> GENTLE_ON_EOF is set.
> 
> Taking the above two observations together, I'd have to say that
> _ALL is probably a misnomer.  I agree with a need for a flag with
> the behaviour you defined in this patch, though.

OK, my thought is either:
	- Come up with a name for a flag, or flags, for the other cases (to
	  check in the function, i.e. PACKET_READ_GENTLE_INVALID), and still
	  pass in PACKET_READ_GENTLE_ALL, which is all those bits on plus
	  *_GENTLE_ON_EOF.
	- Come up with a better name for this single flag, like
	  PACKET_READ_DONT_DIE ... only better.

What would you suggest here?
