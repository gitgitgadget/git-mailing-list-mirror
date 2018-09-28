Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D921F453
	for <e@80x24.org>; Fri, 28 Sep 2018 21:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbeI2EEb (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 00:04:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37007 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeI2EEb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 00:04:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id y26-v6so3515710wma.2
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 14:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=m9r4oYmceMrzoxrR43GshknW4yEA1q4R48KHnWtqC9k=;
        b=jEuvGV1BWi4d/7agy2rmWvOGfQoe9jzux88J23gWT7AUw5M6fqzFoqwTTerXcAdEoc
         xcsjuFLUdni7AsdOIdrPSQiTso2i5Xxe6+jdL+ejoBMdeNx6SB847dCccOrnbzRnKiCJ
         tZw8yj/kuJovXugpkzanbCLSrBZwbzmC3cLZK4EI15nzBWBk5gML8vEkH1siyGb7UC1q
         6/bVXW20jlUfrpSt4CFOnhAJgYYPNq1Au5OLa7ECp/n0N2cVgnddi96BSSpVBjW+w9fh
         swEwu+S/0HGbixLZ71NaSDY1qxaPGGBsXprIB4e1a+AXnMFVoxT84niuwIBs6sWGJn3/
         f86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=m9r4oYmceMrzoxrR43GshknW4yEA1q4R48KHnWtqC9k=;
        b=M/qucmPF6hB8FX1/FNKgUqt3cj2u9KbZrj5dyuDiB5qt7WhLZMWQqkbMx24md6qCtS
         hMdbXf1PYfF7Ibdn6yp7GgCXQwtYQ8YIH4HKJQ+HOWiT6XmlslPfDrYOEQdkDOt7JAi3
         n2PBmwO0GaDSlccOqUSAHBiM5LEqMMKiL7F7VTuSqHnnUjktlaDGcNuwO9bn+RImsaxx
         WtxfIgibbzPqtHV2OvCgied2onolzgw2KC7XAVIIaOadGsvZe5S49YqAUp7BGavnEHrO
         eimmcL3Nf1DXJMQo2xKEajflGihQLh6NIR7GKx+/eiZi1SB9mmkvC77f3H2BtiqLr6RQ
         HGgg==
X-Gm-Message-State: ABuFfoiMVkWEEivck4H5VZaxznD9Z76WUP5zaWtjRVFOnyjC4IierMJ6
        Z1hAIXh1Nl6XlgEN26J7Rnc=
X-Google-Smtp-Source: ACcGV63H8x8JcPm+91pTxJxpHR13AdGdEX2ERbRqXMWOIzAr72/Uq8nTgYVO9UUrAV/HIe7QIzl4dg==
X-Received: by 2002:a1c:1252:: with SMTP id 79-v6mr2923731wms.70.1538170730652;
        Fri, 28 Sep 2018 14:38:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q135-v6sm4194774wmd.4.2018.09.28.14.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 14:38:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
        peff@peff.net
Subject: Re: [PATCH] strbuf.h: format according to coding guidelines
References: <xmqq5zypefcp.fsf@gitster-ct.c.googlers.com>
        <20180928173033.159192-1-sbeller@google.com>
        <xmqqr2hdbdp8.fsf@gitster-ct.c.googlers.com>
        <xmqqin2pbcwh.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 28 Sep 2018 14:38:49 -0700
In-Reply-To: <xmqqin2pbcwh.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 28 Sep 2018 13:11:26 -0700")
Message-ID: <xmqq8t3lb8uu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I actually do not mind the rule to be more like
>
>  * Use the same parameter names used in the function declaration when
>    the description in the API documentation refers the parameter.

Assuming that we adopt the above guideline, let's extending it to
the original patch's review.

The following is a good example.  FIRST and SECOND would have been
upcased if this followed my earlier illustration to make them stand
out as references to the parameters, but it is already readable
without upcasing _and_ naming parameters is helping here.

 /**
  * Compare two buffers. Returns an integer less than, equal to, or greater
  * than zero if the first buffer is found, respectively, to be less than,
  * to match, or be greater than the second buffer.
  */
-extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
+int strbuf_cmp(const struct strbuf *first, const struct strbuf *second);



The next one could be improved and say something like: "Remove LEN
bytes in the strbuf SB starting at offset POS", as it already had
'pos' and 'len' that are readily usable.  Notice that "Remove LEN
bytes starting at offset POS" is a sufficiently clear description
and that is why I do not think we should require all parameters to
be named.

 /**
  * Remove given amount of data from a given position of the buffer.
  */
-extern void strbuf_remove(struct strbuf *, size_t pos, size_t len);
+void strbuf_remove(struct strbuf *sb, size_t pos, size_t len);
 

The last example is a job half-done.  The original had pos and len
parameters and referred to them in the text, but just said "with the
given data".  Now we have data and data_len, "the given data" can
and should be clarified by referring to them.

 /**
  * Remove the bytes between `pos..pos+len` and replace it with the given
  * data.
  */
-extern void strbuf_splice(struct strbuf *, size_t pos, size_t len,
-			  const void *, size_t);
+void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
+		   const void *data, size_t data_len);

