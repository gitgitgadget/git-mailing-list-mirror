From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/7] t5520: tests for --[no-]autostash option
Date: Sun, 3 Apr 2016 16:17:30 -0400
Message-ID: <CAPig+cR3diDfn893-ExKNZps=C7Z=M7DFAy-zbJzH3wKCmxVeQ@mail.gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 22:17:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amoSm-0006qI-Lw
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 22:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbcDCURc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 16:17:32 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:33491 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbcDCURb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 16:17:31 -0400
Received: by mail-ig0-f196.google.com with SMTP id nt3so10675608igb.0
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=4Gecydc2nnxww5BsH8pHmYsbonUhnnnA1cidpVHewEw=;
        b=Mg4cE4CbwmIT5tDhj0xt4B0+5oVxUG4d8DfyFc9Ogjz+P7MTq1DZG0azKFyzLaNVQs
         VrUTshqbeyhTu+33d4F7sjzouZCklHIgBLEp0q8/jd80ziMsGR8svVTiw86WsPCB0x6R
         hzd32jiZNDhn3Ukfkd86hpCymEJmrZMIfxJvGbgx+z6R+9TEIx++QbuUIrMo4Nt7WtMF
         fDgrXXOEQPAPJgIaqHjBmwkraq5GpSPKHwFgYFS8ETnr7b7KZH67zRKmfvxfdevCKgAR
         f9ej8XjxLFMiWeY0HnHacuRXwmBF1wr3+bDQwE2NIENYNxYsqqvUlbaqVn2667FOuvgy
         Sk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4Gecydc2nnxww5BsH8pHmYsbonUhnnnA1cidpVHewEw=;
        b=V6kAM59l49ozn3fb2WbWI6TjjoTU7zTSxorF480JJxXflvJ2B7jtSXsQLMG/u/h/hI
         5YORoYhsU1fT3fJPgF2GgUlZ+nstm3PP07gaSnmQYR/4IU87gjL+e1TDUi44vcBwRHjz
         2TdxX3bRm3UQzCC06DkaR0eSmrf2V0Y7Q8v/gxo19rnQS0vwtxDqidU1zArluUGgnRXR
         8H1TqKDHa4yPdexwWs55FxaMKW1SvWOxOUd4I3zdLnGcDFr2PLTt0A8b2MrMD6IibnQI
         25+G7YbJ2tx7nlXt5RUVuuX5mHW8AtDcAxWB470JS0F/4/+jl/8L8Yl7WU8vZ9wELne4
         IcvQ==
X-Gm-Message-State: AD7BkJK2qIheWBKj+xSZK/l8FFjWcjH0eO0P4yogwHgXcXXx7sHLVUtmrwrXmmFo/lXrovZ4NjigXF9wHflvvg==
X-Received: by 10.50.97.70 with SMTP id dy6mr7054988igb.73.1459714650535; Sun,
 03 Apr 2016 13:17:30 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 13:17:30 -0700 (PDT)
In-Reply-To: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
X-Google-Sender-Auth: vLncyxJbFd7omnmIvhDGCBjBywc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290653>

On Sat, Apr 2, 2016 at 1:58 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> The following series is applicable on mj/pull-rebase-autostash.
>
> Changes made vs v1:
>         * [Patch v1 4/5] is broken into three patches to increase
>                   readability of the patches.
>
>                 * [Patch 4/5] Factor out code in two functions
>                   test_pull_autostash() and test_pull_autostash_fail()
>                   instead of test_rebase_autostash() and
>                   test_rebase_no_autostash(). This leads to further
>                   simplification of code.
>
>                   Also removed two for-loops as they didn't provided
>                   the simplicity intended for.
>
>                   For-loop was over-intended. Corrected it.
>
>                 * Commit message for patches 1/5, 2/5, 3/5 are improved
>                   as suggested by Eric in the previous round.

Thanks, this version was a pleasant read, much simpler and easier to
digest than the previous round[1]. With or without addressing the few
minor nits in my review (none of which warrant a re-roll), this entire
series is:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Mehul, feel free to add my Reviewed-by: if you happen to re-roll (or
Junio can add it if he wants when he picks up the series).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/290134
