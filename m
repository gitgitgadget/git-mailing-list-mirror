Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50632018B
	for <e@80x24.org>; Mon, 18 Jul 2016 16:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbcGRQIT (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 12:08:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33981 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbcGRQIR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 12:08:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so13400285wma.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 09:08:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PsZyxiXUTZ5EdJpDIFCx5LJkK1651POm9YL4pTGecrk=;
        b=ZJvNSPA/2MB5aN80oLNpyVOFWS4guQjDXUInK0UUuN/Tf+OSPasK91uSaEie3/mDDl
         lHq8Q4WNBYtu9pP77hMT06vUp5u99Q9RGwqrC/lZ+nR7Cx+JnqdvPdIBB9flMj/vlC1N
         IwvfoV/J3mGOUIv0VyJYouXzttAC1772b6qR3247qlFB0NkDSRjcBQbKgiA7xQ8vKvCz
         502VlUScNG2FS03YBpZW9Y7XnY+eMfxavONNifQyVg1obMfhA6qVBaAjGwb+cOzqulG6
         +tkbG3KbdXiIiQhhpyABC+evrsvWoBnxtUJQpZF/yM4r7IS4t1PoKJrOYuKma5d0Zb6n
         OcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PsZyxiXUTZ5EdJpDIFCx5LJkK1651POm9YL4pTGecrk=;
        b=HkmD+ZURHzc6UpGiR8mGNtFvYRAvhe7HLYvMZtTYWt5k5/cFXbsrANgot79GYf5fVc
         6ByqNHfALRSOSgWfhOCGIHsT7p2tT6oR5D3KHZSqx/iLDULzcxwRVKszUQvSzPJ5z1fb
         VSaIAdbMWsMtliL5GXOjwe01vSTPj4NGVzMTlpYsbWoBYexTmnkJuko6QPVfF+EP9QsX
         l1ENUIJJZyM0lQK/ytn3w4uEoa2YOdRYk4DtXxCspFSolVqEjQk8ENAPV3pXWnAgI84R
         Q3d9pPPKm8AL/36dKtrSus2QZx9Jfz0Pn7oonUqwr/js65qc5sSrGPDlNa+yLOLMuqxH
         44XQ==
X-Gm-Message-State: ALyK8tJUbLbO4G/fSAnpyAOPf5Xff1krHIxRlriUXbe2B2jgZx+dqpzYGsYSMgZmce4rGg==
X-Received: by 10.195.3.67 with SMTP id bu3mr1990186wjd.148.1468858094175;
        Mon, 18 Jul 2016 09:08:14 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id j3sm1996634wjv.34.2016.07.18.09.08.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jul 2016 09:08:13 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] list: avoid incompatibility with *BSD sys/queue.h
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160717002533.GA14200@whir>
Date:	Mon, 18 Jul 2016 18:08:12 +0200
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FA45931D-E1F2-4132-8D0D-C35339DA230D@gmail.com>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com> <FB76544F-16F7-45CA-9649-FD62EE44B0DE@gmail.com> <20160716210454.GA7849@starla> <20160717002533.GA14200@whir>
To:	Eric Wong <e@80x24.org>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 17 Jul 2016, at 02:25, Eric Wong <e@80x24.org> wrote:
> 
> Eric Wong <e@80x24.org> wrote:
>> Lars Schneider <larsxschneider@gmail.com> wrote:
>>> It looks like as if this topic breaks the OS X build because 
>>> it defines LIST_HEAD. LIST_HEAD is already defined in 
>>> /usr/include/sys/queue.h. 
>> 
>> Oops, I suppose GIT_LIST_HEAD is an acceptable name?
>> (looks a bit like a refname, though...).
>> 
>> Or maybe CDS_LIST_HEAD (since I originally took it from the cds
>> namespace under urcu)
> 
> Naming things is hard; I think it's better to just undef an
> existing LIST_HEAD, instead, since it's unlikely we'd ever use
> sys/queue.h from *BSD.  (sys/queue.h is branchier, and IMHO
> sys/queue.h macros are uglier than list_entry (container_of))
That sounds like the best solution to me, too.


> I also wonder where we use sys/queue.h, since I use
>> LIST_HEAD from ccan/list/list.h in a different project
>> without conflicts...
> 
> Still wondering... Checking sys/mman.h in an old FreeBSD source
> tree I had lying around reveals "#include <sys/queue.h>" is
> guarded by "#if defined(_KERNEL)", so it mman.h wouldn't pull
> it in for userspace builds...
> 
> -----8<------
> Subject: [PATCH] list: avoid incompatibility with *BSD sys/queue.h
> 
> Somehow, the OS X build pulls in sys/queue.h and causes
> conflicts with the LIST_HEAD macro, here.
> 
> ref: http://mid.gmane.org/FB76544F-16F7-45CA-9649-FD62EE44B0DE@gmail.com
> 
> Reported-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
> list.h | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/list.h b/list.h
> index f65edce..a226a87 100644
> --- a/list.h
> +++ b/list.h
> @@ -36,6 +36,8 @@ struct list_head {
> 	struct list_head *next, *prev;
> };
> 
> +/* avoid conflicts with BSD-only sys/queue.h */
> +#undef LIST_HEAD
> /* Define a variable with the head and tail of the list. */
> #define LIST_HEAD(name) \
> 	struct list_head name = { &(name), &(name) }
> -- 
> EW

This patch compiles without trouble on my local OS X.

Thanks,
Lars

