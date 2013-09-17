From: "Burton, Ross" <ross.burton@intel.com>
Subject: Re: Bisect needing to be at repo top-level?
Date: Tue, 17 Sep 2013 19:38:46 +0100
Message-ID: <CAJTo0LYp_FNfRYiLY3XivUxFN2JPCics=jbFsX+pVebEZ5XeSg@mail.gmail.com>
References: <CAJTo0LZ=bNNUc8O=bDDOp2vudsc_wL+-nqsXW5r1rq3H7M0e7Q@mail.gmail.com>
 <xmqqbo3rz7ca.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 20:39:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM0B7-0007mq-B0
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 20:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab3IQSjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 14:39:08 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:48783 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab3IQSjH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 14:39:07 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz11so4688315veb.31
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 11:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=FnI45OhV1aRGWDASfx8Tl1sPHiMgjHGM9YedvdaBv+s=;
        b=hS2VGBrUkqp/xHF/5cNc6g5WzOSFa14SDEQXEVElWrFEQgbxwH+346pSRqFHCCa8XM
         ASqNaPE8hZL2nYptWpXe91yqJBYTrAUm3o2W50LlKNMUFPYdYU5nyOgHesZQD9Mef5i/
         UGuf4fLBkxRtvgiTz7pMQY5so7Qs3GYcOn7LoECGQwAeo0fKPh5qJIwkVImcNys5mHos
         cuUWydBLL3yHtnCdinngxL7JPvKvp4mtpWeFe9PJmhy36M6r/Hzbw3PTyVIyUBjRJpyH
         oHQ4NiGbykoOCrV4XS79zOJWKjikkdqBwfowzYYSWxAMgyRE99LUGfHn3gUhI6h1SAEQ
         1nnQ==
X-Gm-Message-State: ALoCoQlEQrHTvMJgk43Q50fP2/TPW0QXXoazkZMuqlkg4CNn0wO226O0PfsDF0ZIbFZPP11/p+s7
X-Received: by 10.220.11.7 with SMTP id r7mr33689475vcr.12.1379443146816; Tue,
 17 Sep 2013 11:39:06 -0700 (PDT)
Received: by 10.220.71.201 with HTTP; Tue, 17 Sep 2013 11:38:46 -0700 (PDT)
In-Reply-To: <xmqqbo3rz7ca.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234901>

On 17 September 2013 18:27, Junio C Hamano <gitster@pobox.com> wrote:
> "Burton, Ross" <ross.burton@intel.com> writes:
>
>> Why does git-bisect need to be ran from the top level of the working
>> tree?  It sources git-sh-setup.sh which sets GIT_DIR, which
>> git-bisect.sh then appears to consistently use.  Is there a reason for
>> needing to be at the top-level, or is this an old and redundant
>> message?
>
> A wild guess.
>
> Imagine if you start from a subdirectory foo/ but the directory did
> not exist in the older part of the history of the project.  When
> bisect needs to check out a revision that was older than the first
> revision that introduced that subdirectory, what should happen?
> Worse yet, if "foo" was a file in the older part of the history,
> what should happen?

"git checkout" doesn't mandate that you're at the top-level, so that's
not a very strong argument.

Ross
