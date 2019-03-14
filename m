Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBF0720248
	for <e@80x24.org>; Thu, 14 Mar 2019 15:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfCNPTm (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 11:19:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45633 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfCNPTm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 11:19:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id h99so6267300wrh.12
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=24WaLeeTDTfFQ7fvO68Sgen7qR+8k6HhkU499ef2MS8=;
        b=KwD8MXKaMGhi9kblOgUgrWb4O7K6CN4dKh79lm9WyTDmvKa241vSUWrufZV57VZgkN
         /SQvhCLqBH1vtZLD4PY87snIrh/4KSbnQPPhO9/Xy4+s9CdaYhoSm2ksSluW16Wh/hnz
         urdQOsOrcwXOUbj0Kr+GbshG+kBEPugMTguDWlGQwSCWki/ARQAYzNv59WQ2NeQYwo/h
         2hOy8Q1jIVmxAYmUOksyrbyrfkU7CSTYYfaEVz4Y4M1EEHX0zPPnRwrXf5Rms+cBUYDM
         kJ5BXqCJdk5EmsgtMuAKo58zvkmtDHc9BJnfVSL0G+4Ud1WFJhcXgnRDTn8/Ce5OGGvK
         EF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=24WaLeeTDTfFQ7fvO68Sgen7qR+8k6HhkU499ef2MS8=;
        b=MfDi850doPIwymMcYUrjLrxdJcRMaLK8IyfEzSKcICpf3yzkXxsZtHVjOnd8QAa/7W
         H45fLHI1nKMym9q6jU5kLDDTrT3ya8caxef+iQG2z8q4s3KKKHWBCRCO/cY11HiUo+i0
         x698Jxa781pk/cbYK4WqYZ0RyeQuFgxW8DfdkNWjDBHua1Yc9FuL7P0QI5IEF2g3U2cP
         8kvXbJ+RJP+1YVoa70AZ1DwEEQCRJhYU2kNXKqPyrJoie2SSP5eOFGB7eIpsjBqHnHyn
         XiZVk7lkXd3luOj8dkxehJq4uUzsmbPRAJRFIAhCdcrgw05t8IOjPLzQDRmBlUXkdvca
         z0IQ==
X-Gm-Message-State: APjAAAWSriO/MPpmCBMg7+Jo2TmjFvQ1f7Yqu5sOt3mPbNYsRdUYsiHv
        DJy+p2gNmPjCM/TE68X7qdU=
X-Google-Smtp-Source: APXvYqx2a/Z/XglXxAqkVWPaS8ZTjRp3pGNcYUs8ba9dedd8nT2pr5gwPf/dQPJXYfFrcTYOKrSg5w==
X-Received: by 2002:adf:f343:: with SMTP id e3mr30394258wrp.205.1552576780366;
        Thu, 14 Mar 2019 08:19:40 -0700 (PDT)
Received: from szeder.dev (x4d0c0ea6.dyn.telefonica.de. [77.12.14.166])
        by smtp.gmail.com with ESMTPSA id z10sm2325718wml.39.2019.03.14.08.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 08:19:39 -0700 (PDT)
Date:   Thu, 14 Mar 2019 16:19:37 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 05/11] tests: use 'test_atexit' to stop httpd
Message-ID: <20190314151937.GG28939@szeder.dev>
References: <20190313122419.2210-1-szeder.dev@gmail.com>
 <20190313122419.2210-6-szeder.dev@gmail.com>
 <xmqqd0mub0d8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd0mub0d8.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 12:28:35PM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:

> I see most of these changes are removal of stop_httpd because it is
> done as part of start_httpd() to arrange it to be called at exit.
> 
> But ...
> 
> > @@ -176,7 +175,7 @@ prepare_httpd() {
> >  start_httpd() {
> >  	prepare_httpd >&3 2>&4
> >  
> > -	trap 'code=$?; stop_httpd; (exit $code); die' EXIT
> > +	test_atexit stop_httpd
> >  
> >  	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
> >  		-f "$TEST_PATH/apache.conf" $HTTPD_PARA \
> > @@ -184,15 +183,12 @@ start_httpd() {
> >  		>&3 2>&4
> >  	if test $? -ne 0
> >  	then
> > -		trap 'die' EXIT
> >  		cat "$HTTPD_ROOT_PATH"/error.log >&4 2>/dev/null
> >  		test_skip_or_die $GIT_TEST_HTTPD "web server setup failed"
> >  	fi
> >  }
> >  
> >  stop_httpd() {
> > -	trap 'die' EXIT
> > -
> >  	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
> >  		-f "$TEST_PATH/apache.conf" $HTTPD_PARA -k stop
> >  }
> 
> ... I see we lost many "trap 'die' EXIT" in the orignal.  Is that
> something we want to lose as part of this commit?  It does not make
> sense, at least to me, to add a "test_atexit die" and I am mostly
> wondering what these traps were trying to do in the original.

It restored our test framework's default EXIT trap, because without it
'stop_httpd' would have been invoked after 'test_done' as well.  While
invoking it twice is probably not that big of a deal (though arguably
not the cleanest solution), invoking it after 'test_done' is
definitely bad, because at that point the trash directory and thus
$HTTPD_ROOT_PATH has already been removed, resulting in an ugly error:

  $ ./t5561-http-backend.sh
  <....>
  ok 14 - server request log matches test results
  # passed all 14 test(s)
  1..14
  apache2: Syntax error on line 11 of /home/szeder/src/git/t/lib-httpd/apache.conf: Cannot load modules/mod_alias.so into server: /home/szeder/src/git/t/trash directory.t5561-http-backend/httpd/modules/mod_alias.so: cannot open shared object file: No such file or directory

'test_atexit' doesn't overwrite the test frameowork's default EXIT
trap, so we don't have to restore anything.

