Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69D101F461
	for <e@80x24.org>; Thu, 22 Aug 2019 17:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbfHVRtH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 13:49:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53146 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393338AbfHVRtG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 13:49:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id o4so6488662wmh.2
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 10:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=w7/9xJjvciGtGwK1OGQznxGI4QrFuj8w2moPgUY9BUI=;
        b=jc9u0Pz0GtuOvkZC9IiiRCOtenzLfRA1rCQm1vWxfauwAAcOwUDAsv5knXAtCA9n5j
         QETSgC54rrEFuAxSp/m586jsrh7ns7XDgcKIaLTYBiIZspDcetVh9857zjvGZXlUaCTW
         eYR39WDFES+TGPu+KERM/Rtjrlcmq7ijCRcqEOUvBNkaWlT7DtOuKQreoqFT919rGDSW
         77GEW8+BYhtzvqmJytuCZb08pqMkkQpFqBtYnbWwxKj+gSqcR5NWegnTtpZk6gZ0FNXz
         huyvTVat/w691Ki7Bk6J5l6yNH5Ar8/0TkR2+obFCwobZV26oaZEq9J9hF3luYxwefqE
         xUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=w7/9xJjvciGtGwK1OGQznxGI4QrFuj8w2moPgUY9BUI=;
        b=K8P+IFAxj6/fUdHUXeZGFdE0fwIPZ6T0zmY//2zM8Wn/BvjplY8StdUM8OxlFTzG62
         qFtJ3C2smQPbZzVRZk8vm/Kve4Jnc9QHjHsoNi9U6pHV0ZUrteNLn7/FY++KKgKmBGLA
         VEw6wgrCJn+TvshwOevNW0ZXwEVISTb0AohLSgt5FXNeQlhqc6K1tfxOL++9on4p12iV
         nCrGdq7J/lAKF94QDlCSgMDExGE7lMfQsCr9Dpb/jO+KhCUwDjX3XTshq+g1wq2F0PYA
         nvquoZ8zw09OS8cSZ7ihtnRQpfAL3taglohqDDHWZ13PVoHMcliqAAIajPXTv8QCz0ZV
         4Uuw==
X-Gm-Message-State: APjAAAUG9n1vcAJGjrjirh1d2mJeuF99hsQ9U4ESH+0s+BksARYkMNy9
        Cb5Ra9y9itspYIAWMCGNfjA=
X-Google-Smtp-Source: APXvYqwvGtNgSllwHuDroFBct9KLic4y+L5jKlJ98kLYChV/n7j/bS37W0LIlCD4u9QcR49HrSp0Qw==
X-Received: by 2002:a1c:61d4:: with SMTP id v203mr282403wmb.164.1566496143563;
        Thu, 22 Aug 2019 10:49:03 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id k124sm318714wmk.47.2019.08.22.10.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 10:49:02 -0700 (PDT)
Date:   Thu, 22 Aug 2019 18:49:01 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        rsbecker@nexbridge.com, johannes.schindelin@gmx.de,
        larsxschneider@gmail.com
Subject: Re: [PATCH] t0021: make sure clean filter runs
Message-ID: <20190822174901.GA71239@cat>
References: <20190820065625.128130-1-t.gummerer@gmail.com>
 <aea64308-fcba-77a1-1196-182b35ad405c@kdbg.org>
 <20190821145616.GB2679@cat>
 <a8de9661-7f6a-f953-93a0-8ef88e9a490a@kdbg.org>
 <20190821220355.GZ20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190821220355.GZ20404@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/22, SZEDER Gábor wrote:
> On Wed, Aug 21, 2019 at 08:23:23PM +0200, Johannes Sixt wrote:
> > Am 21.08.19 um 16:56 schrieb Thomas Gummerer:
> > > On 08/20, Johannes Sixt wrote:
> > >> Am 20.08.19 um 08:56 schrieb Thomas Gummerer:
> > >>> Fix the test by updating the mtime of test.r, ...
> > >>
> > >>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> > >>> index e10f5f787f..66f75005d5 100755
> > >>> --- a/t/t0021-conversion.sh
> > >>> +++ b/t/t0021-conversion.sh
> > >>> @@ -390,6 +390,7 @@ test_expect_success PERL 'required process filter should filter data' '
> > >>>  		EOF
> > >>>  		test_cmp_exclude_clean expected.log debug.log &&
> > >>>  
> > >>> +		touch test.r &&
> > >>
> > >> 		test-tool chmtime +10 test.r
> > >>
> > >> would be more reliable.
> > > 
> > > Hmm, is touch unreliable on some platforms?  I didn't think of
> > > 'test-tool chmtime', but I'm also not sure it's better than touch in
> > > this case.
> > > 
> > > To me te 'touch' signifies that the timestamp must be updated after
> > > the previous checkout, so git thinks it could possibly have been
> > > changed, which I think is clearer in this case than setting the mtime
> > > to a future time.
> > 
> > touch does not guarantee that the current time is different from the
> > timestamp that the file already carries, particularly not when the
> > filesystem stores just a resolution of 1 second, and commands are
> > executed quickly.
> 
> This 'touch' must ensure that the timestamp of the file is not older
> than the timestamp of the index, and to achive that it doesn't
> necessarily have to modify the timestamp.
> 
> The file is modified first, then the index is updated, and finally
> comes this 'touch'.  Consequently, if 'touch' doesn't modify the
> timestamp of the file, then it must have the same timestamp as the
> index, IOW it's racily clean, and the subsequent 'git checkout' has to
> look at the file content and has to run the filter, and that's what we
> want to see here.

Right.

> However, I'm not sure what would happens if the system clock were to
> jump back in between, but since it's only a test I don't think it's
> worth caring about.

Yeah, I think much of git wouldn't work correctly if that happens, so
I think it's fairly safe to ignore in the test suite.

> > But when we use test-tool chmtime +10, then the timestamp is definitely
> > different.
> 
> 'test-tool chmtime +10' adjusts the timestamp of the file relative to
> its current timestamp.  So yeah, the file's timestamp definitely
> changes, but that's not enough, because it doesn't ensure that the new
> timestamp is not older than the timestamp of the index.  Just imagine
> the arguably pathological situation that right after the file was last
> modified the system miraculously comes to a complete stall, and only
> manages to resume after 15 seconds to continue with updating the
> index.  This means that the timestamp of the file will be 15s older
> than the index, and after that 'chmtime +10' it will still be 5s
> older.  Consequently, 'git checkout' will think that the file is
> clean, it won't run the filter that we expect, and the test will fail.
> So instead of '+10' it should be '=+10' to set the new timestamp
> relative to the current time, but I'm not too keen about the timestamp
> in the future either (though the file is about to be deleted anyway).

Right, the above is why I think 'touch' is a good idea here.  Short of
system clocks jumping around, which will most likely break more than
this test anyway it guarantees that the timestamp is equal or greater
than the timestamp of the index, which is what we need here.

> I think it would be best to explicitly set the timestamp of the file
> and the index sort-of relative to each other and add an in-code
> comment as well, e.g.:
> 
>   # Make sure that the file appears dirty, so checkout below has to
>   # run the configured filter.
>   test-tool chmtime =-10 .git/index &&
>   test-tool chmtime =+0 test.r &&

I think the comment is a good idea.  I personally still prefer just
using 'touch' though, as I find it slightly easier to read (I had to
go look up what the =-/=+ in 'test-tool chmtime' does, while I knew
what touch would be doing :)

That said that's a minor preference for me, if people have a strong
opinion that test-tool chmtime is really better here I'm fine with
changing it.
