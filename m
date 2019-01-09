Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30E2C1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 16:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfAIQrg (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 11:47:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46829 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAIQrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 11:47:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so8330615wrt.13
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 08:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=62+yguBX9mV6AvRgc255R6mrlKkwH36sR42ewKLIV8Y=;
        b=NQsbECiKiD95CIgVHRqfe6JnDYbaiECW/pW+gXsvvYmJe/nNgyHGJtWt6Gc4PkGj1+
         HwbuKwdpeQoyYpTI/MJQ8BfZCzmoddgeorHrsVu/OUQ3BFDUTkDvuGRikjdRgyYDrbPs
         XAStjbfw1uUqdGcvYvMQsBJ4h4Qr0t+IVa5lZ3Of5jMJFjEsmhoTS1SrKZQHhL1sUqqH
         nUaLaXSW4dudeaUtDt4KOcpHiVGkm74oDlA3bQ6fl+VTvFp1WZtJO0DV1OVrttzsZTjR
         Y2UHZMyEaTyZiThCZMT6y8Not6uMdcNPd76fdRsyZu062Bht+XyJAQDyeAAp9r7n456F
         j1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=62+yguBX9mV6AvRgc255R6mrlKkwH36sR42ewKLIV8Y=;
        b=KTJIB8r29c1DKfvFaD8TESCq8lclK/Y4OSZ1+3h0Bpq1UPjQ5jEBpeKs/hG49Rv8ma
         LrS+gYJInD5tfoLdja9hvJbjNRK3hmVecdCF+s9fPnA+JwMAg95K0XTx7LJfI8dhr+g1
         jp+bggQosSnClXxZWORsLJFPlMChO5ovIcLhd3t96H6ekwpG8Tf2ocp1sbDPYlhhSaaq
         tDEc6KrGNJyHDHfp4LUXXIxuGkk29T5+1VRxxtd4nxSSdHAHhg4QpFb0hrrmsSsYMoPb
         +9iCm8G/SOjKSSzneRUDhAkuWVmESq9HFAz/C8ZokiWUMnXZSKJYhXVyxFFR4FyJ7FV/
         7FLg==
X-Gm-Message-State: AJcUukfZ63ugUiGSmQffhn4xw7QjtoaNWCNwlTmwmmkvZkTi1i3bgTxX
        S4SICbEsr1oG+AjctW3/qk0=
X-Google-Smtp-Source: ALg8bN7rQrThWeA/ch8UsxQ90ZVbVuqBEXklrZOt/GVwYgSiWRfdc2yJsYfbOMu9fSe+hUz6yBwqLQ==
X-Received: by 2002:a5d:548d:: with SMTP id h13mr5494641wrv.80.1547052453806;
        Wed, 09 Jan 2019 08:47:33 -0800 (PST)
Received: from szeder.dev (x4db906b6.dyn.telefonica.de. [77.185.6.182])
        by smtp.gmail.com with ESMTPSA id o16sm71046700wrn.11.2019.01.09.08.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 08:47:33 -0800 (PST)
Date:   Wed, 9 Jan 2019 17:47:31 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Sun Chao <sunchao9@huawei.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 1/3] t5323: test cases for git-pack-redundant
Message-ID: <20190109164731.GJ4673@szeder.dev>
References: <20181219121451.21697-1-worldhello.net@gmail.com>
 <20190102043456.15652-2-worldhello.net@gmail.com>
 <20190109125628.GG4673@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190109125628.GG4673@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 09, 2019 at 01:56:28PM +0100, SZEDER Gábor wrote:
> On Wed, Jan 02, 2019 at 12:34:54PM +0800, Jiang Xin wrote:
> > +cat >expected <<EOF
> > +P1:$P1
> > +P4:$P4
> > +P5:$P5
> > +P6:$P6
> > +EOF

Creating the expected results could be moved into the
test_expect_success block as well.

> > +
> > +test_expect_success 'git pack-redundant --all' '
> > +	git pack-redundant --all | \
> 
> Don't run a git command (especially the particular command the test
> script focuses on) upstream of a pipe, because it hides the command's
> exit code.  Use an intermediate file instead.
> 
> > +		sed -e "s#^.*/pack-\(.*\)\.\(idx\|pack\)#\1#g" | \
> 
> This sed command doesn't seem to work on macOS (on Travis CI), and
> causes the test to fail with:
> 
>   ++git pack-redundant --all
>   ++sed -e 's#^.*/pack-\(.*\)\.\(idx\|pack\)#\1#g'
>   ++sort -u
>   ++read p
>   ++sort
>   ++eval echo '${P.git/objects/pack/pack-0cf5cb6afaa1bae36b8e61ca398dbe29a15bc74e.idx}'
>   ./test-lib.sh: line 697: ${P.git/objects/pack/pack-0cf5cb6afaa1bae36b8e61ca398dbe29a15bc74e.idx}: bad substitution
>   ++test_cmp expected actual
>   ++diff -u expected actual
>   --- expected    2019-01-09 01:53:45.000000000 +0000
>   +++ actual      2019-01-09 01:53:45.000000000 +0000
>   @@ -1,4 +0,0 @@
>   -P1:24ee080366509364d04a138cd4e168dc4ff33354
>   -P4:139d8b0cfe7e8970a8f3533835f90278d88de474
>   -P5:23e0f02d822fa4bfe5ee63337ba5632cd7be208e
>   -P6:deeb289f1749972f1cd57c3b9f359ece2361f60a
>   error: last command exited with $?=1
>   not ok 2 - git pack-redundant --all
> 
> I'm not sure what's wrong with it, though.

So, it appears that 'sed' in macOS doesn't understand the
'\(idx\|pack\)' part of that regex.  Turning that command into

  sed -e "s#^.git/objects/pack/pack-\($OID_REGEX\)\..*#\1#" out | \

makes it work even on macOS, but note that those 40 hexdigits are not
actual OIDs but file content checksums, so using $OID_REGEX is not the
right thing to do here (though I'm not sure what is supposed to be
used instead, as $_x40 hardcodes the number of hexdigits).

Alas, the test as a whole still fails with the following on macOS:

  ++diff -u expected actual
  --- expected    2019-01-09 15:54:49.000000000 +0000
  +++ actual      2019-01-09 15:54:49.000000000 +0000
  @@ -1,4 +1,4 @@
   P1:24ee080366509364d04a138cd4e168dc4ff33354
  -P4:139d8b0cfe7e8970a8f3533835f90278d88de474
  +P3:0cf5cb6afaa1bae36b8e61ca398dbe29a15bc74e
   P5:23e0f02d822fa4bfe5ee63337ba5632cd7be208e
  -P6:deeb289f1749972f1cd57c3b9f359ece2361f60a
  +P7:4ecc1eb138516a26654cd4e3570b322c0820f170
  error: last command exited with $?=1

