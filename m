Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3DB62018B
	for <e@80x24.org>; Mon, 18 Jul 2016 16:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbcGRQF6 (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 12:05:58 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33627 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbcGRQF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 12:05:56 -0400
Received: by mail-io0-f169.google.com with SMTP id 38so163788619iol.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 09:05:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BEZRIGTnpLWj9T0uM+RazXeP45rSPAG9hrxiiTnjaQk=;
        b=ioYn8WahmGEdv38BZc/qL3NXweu3KG6KD+X1qV/5ffMwzFLpaZRwwvLBJJAwF3Mdc0
         8TuluLfC/PMHqlhS68L/KG61sis2twc4wKO2B87YyVsxOLKfoo16h4MgvZpxu0PCDmU3
         tfqWIXMFLpggp3RtVL/pTZRbLnWdHE7Hxlw0HKNWAOVgbWP8B0qA19GiQD9nJpbfSXtO
         3B81Lb1C1GWYeYGWFGVV8mEv/D0fUoPhfVqYtjIiahpQJVUmKLzGtAl8rlWaILRpCI8E
         athIqfaSSoFaWROrlNGuuj6HrNg4xiKgbMdbPVaRuVDVee1T4gqwL9uxEWg1EFzCyjXF
         0LBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BEZRIGTnpLWj9T0uM+RazXeP45rSPAG9hrxiiTnjaQk=;
        b=DFaLWCpr4Z2hWBsOUELCYqcmEcJ3aO1bZUEeX9gvCwJWYpRlh8UkKUYq0aORmZ+Nb1
         aMNW6AHccvDKcS9TcK7JSzOvw6fos4Zri9fFJW0XSouQ9q7PXlFahGbuZAwYZvh4nR+Z
         ZU7te/DnspDez4AcsAmXoqjAWDGWEz6XiqQAk/wgLthgm7sDg0ER2UPpqo3t2YCzBwi1
         FOW0u/4lUVULrHUb7tSUqrfd+1eORevXtclmIo1V03VQqhCSZ0rZelQOBbC9li1+dVj2
         400+D+TrPdCyv8p7Sqe1JRmH+JHiTOxx+wwdpzJrFtKAC+eEAjBBNFgtlLcRbNDSVGi0
         F+/w==
X-Gm-Message-State: ALyK8tJ/4NHTxCqjPE8oYQeQn+TdedeRQevbUaQa+4lWIOIOBpX8+2b1HcJfGySfp0IxKFFEbXbmLksc8rKbag==
X-Received: by 10.107.8.140 with SMTP id h12mr35785868ioi.95.1468857952802;
 Mon, 18 Jul 2016 09:05:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 18 Jul 2016 09:05:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607181750470.3472@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net> <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org>
 <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
 <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com>
 <alpine.DEB.2.20.1607181750470.3472@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 18 Jul 2016 18:05:23 +0200
Message-ID: <CACsJy8Ba=c+-WV2TsY768_fTDO2KesS1b6BK7kdykNY6gkh=UQ@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Herczeg Zsolt <zsolt94@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 5:57 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Zsolt,
>
> On Mon, 18 Jul 2016, Herczeg Zsolt wrote:
>
>> >> I think converting is a much better option. Use a single-hash
>> >> storage, and convert everything to that on import/clone/pull.
>> >
>> > That ignores two very important issues that I already had mentioned:
>>
>> That's not true. If you double-check the next part of my message, you I
>> just showed that an automatic two-way mapping could solve these
>> problems! (I even give briefs explanation how to handle referencing and
>> signature verification in those cases.)
>>
>> My point is not to throw out old hashes and break signatures. My point
>> is to convert the data storage, and use mapping to resolve problems
>> with those old hashes and signatures.
>
> If you convert the data storage, then the SHA-1s listed in the commit
> objects will have to be rewritten, and then the GPG signature will not
> match anymore.

But we can recreate SHA-1 from the same content and verify GPG, right?
I know it's super expensive, but it feels safer to not carry SHA-1
around when it's not secure anymore (I recall something about
exploiting the weakest link when you have both sha1 and sha256 in the
object content). Rehashing would be done locally and is better
controlled.
-- 
Duy
