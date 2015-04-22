From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/3] Another approach to large transactions
Date: Wed, 22 Apr 2015 12:14:08 -0700
Message-ID: <CAGZ79kY_1JqKBiAL14me8ktqdQMJ1UuTy1_MgBY4jy5i_qX0uA@mail.gmail.com>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
	<xmqq8udqheb5.fsf@gitster.dls.corp.google.com>
	<xmqqsibyo141.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZvE+YJeKCYXN-RD3MFmP17VkqW8WUUssk6UgK_38iWrg@mail.gmail.com>
	<CAGZ79kYEbnZvgdhjPvc2rR7QKp-CjUB3Ytqsp8JK2QBqzuUowA@mail.gmail.com>
	<CAGZ79kZWm=Mi6o4jMNthiDRcR9irs_5MyRuEmHdDSrn-JFpQ=g@mail.gmail.com>
	<xmqqzj62ifc9.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYk_3E1RMdNvA_OrCj6EdaJ2Xdps9pUxEkWwvDNazb6Gg@mail.gmail.com>
	<CAGZ79kY842JXB37++nwYjkX1WK9ja5m-G1aDj=QgLN-qKLo9Lg@mail.gmail.com>
	<20150421232112.GA28316@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:14:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl06D-00081i-5k
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966355AbbDVTOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:14:12 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35189 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966350AbbDVTOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:14:09 -0400
Received: by igbyr2 with SMTP id yr2so5521346igb.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 12:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gDhDCWhGzuskIiZViRE8RErpQTxbzenYQC/NFMv45jI=;
        b=O2oMo3soHl7C7Uq+WmVhXQwbJXBEjoeulLJyflWuRvZmf6ICKLlj/JstW9E2+ROOCs
         Yc+RhL24PIsGBX1aLWCAXmzcOcI1eMMk/c6M4tssAxJKuERkFc2p+ApOedu0brmNxuRL
         g4Pi44/KY4as8LwIXOptD/sI0gMd1SRU8Bn/wlsq5/e8zFC6ANR67qkviKyzfscSQagW
         TcUnMbYsTGVS+4DT2441/temQ+ouPHB9MbjWjggL7ALBx4bUFHKZ4JI6S/lcyKCPFTza
         ztqJf/0B2O4bE8nyutTq5+1h4LcjC6CbPE9Ub1Ci1BAP73/ho3B9F8qhGnY3zE/9HVbc
         toIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gDhDCWhGzuskIiZViRE8RErpQTxbzenYQC/NFMv45jI=;
        b=lG1aIotvXLt/0nhaHjblMGl5aN+cJGHpIOm9cXPpLT6QHSw5f0jzOgHw52VRcrg6WV
         z71WrjGalY1/+3+2ItjfkmNIG4VcbGMUuTWAHBDS7goNlJGLrnRdeaQpm2ZMqbYqJ6gE
         hbIcU/4LrdnqbUQdYUeEs7r0YRMdZabn8+5JXKBf4/aEngrJJxQ9ytWUjOI8nxNDaOwo
         O9oxUA8sG2zzXKMnxS4cRlrAwQvu5K4vF8qmvE0K2NGOFLC1CTo6GMpmaS+qhilClic5
         0jQG3+u0E0loFLSB+Cf9Z5E3IdwiefUPPqkIfC12RpCdaQLLp2Ltb6GeSsB+9KyW47Z5
         cQOA==
X-Gm-Message-State: ALoCoQl9EbF2e0bg1M7Qc8QRoMlK++uNRJq3slUeSkjQXFyoI2hob5VM+N2hs+cXMjAwHjpMgGB1
X-Received: by 10.50.102.68 with SMTP id fm4mr385008igb.25.1429730048924; Wed,
 22 Apr 2015 12:14:08 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Wed, 22 Apr 2015 12:14:08 -0700 (PDT)
In-Reply-To: <20150421232112.GA28316@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267613>

On Tue, Apr 21, 2015 at 4:21 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 20, 2015 at 05:31:11PM -0700, Stefan Beller wrote:
>
>> When running the test locally, i.e. not in the test suite, but typing
>> the commands
>> myself into the shell, Git is fine with having just 5 file descriptors left.
>> The additional 4 required fds come from beign run inside the test suite.
>>
>> When strace-ing git, I cannot see any possible other fds which would require
>> having some left over space required. So I'd propose we'd just take a reasonable
>> number not too small for various test setups like 32 and then go with the
>> proposed patches.
>
> FWIW, we already use a magic value of "25 extra" in open_packed_git_1. I
> don't know if that means the number has been proven in practice, or if
> it is simply that nobody actually exercises the pack_max_fds code. I
> suspect it is the latter, especially since d131b7a (sha1_file.c: Don't
> retain open fds on small packs, 2011-03-02).

25 is equally sound as I could not find any hard calculation on that
number in the
history or code. I will change it to 25 in the next version of the patch.

Thanks!
Stefan
