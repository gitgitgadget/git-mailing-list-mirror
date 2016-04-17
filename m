From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 2/6] t7030-verify-tag: Adds validation for multiple tags
Date: Sun, 17 Apr 2016 14:53:28 -0400
Message-ID: <CAPig+cTS8KBtAg9q9ToXO4c2kZMgm3WGC-_vrPyHDdRHk0T9Yg@mail.gmail.com>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
	<1459872449-7537-3-git-send-email-santiago@nyu.edu>
	<CAPig+cSOLnCoX77O7khEX1cTh0Hu29d6MRdcpfN8ytTkUSVU=A@mail.gmail.com>
	<20160417173155.GA1014@LykOS>
	<CAPig+cQYAAG7hVe6Li3-TZb99etkE22QzcWbKBCzr8L0SP5LXg@mail.gmail.com>
	<20160417183815.GC1014@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Sun Apr 17 20:53:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arrp9-0002xN-75
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 20:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbcDQSxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 14:53:30 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32962 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbcDQSx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 14:53:29 -0400
Received: by mail-io0-f196.google.com with SMTP id g185so21053173ioa.0
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=VS8ks2C4jxTNhAP9o10D+Kg90HqgNKMQYkBH93iU22U=;
        b=ZTy0WxRIXJQOF4PojCcHVOhM4k9c9w54gXZdtRpLSMGZ3R2mTjd2VW0gLA11Xg05M1
         7GN46lhwcx45qlLvqkyPctxJnbxPWqMIfx0EesAPV/qnP61kEh6FCv7mOpaujJRLmXXu
         CcyQ5NZluNiva7eFO22iBoMkZzI8GzFWSNiFiGPREE4UfTGu3KbOpIePxaWCdX3mWw3S
         rONYl3KdTIt+gyfJt10nVGR0YJMT8BxJ4uTII/XF0gLd3HIY7l+F54M7ba+vI4Uuoay6
         PMIlEcBO0RxFPT6O+gST8XxRYK9eIRoQzPmDmzcfvqLRf5hnMJIn2MRc0FwBb/VU9nAz
         WUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=VS8ks2C4jxTNhAP9o10D+Kg90HqgNKMQYkBH93iU22U=;
        b=hbWfL06aQ9lxfhpdUIZ3gLVh4Ps5PR7iRp2feARmPKljnNCcItGHodtuM7Pk5aPf+4
         M5dL7qMQGwkTBTSoAGwr6NN51BnNmRMtb6ncKb7zj+dok5HHcLfa49873NNU/BDTGiYT
         +tXuz8TxWqKnkTYI1OxkBo1UOJEUImb54OndGecAcCFvOp2jA0kPR0rh/NvrJXUi6paf
         OZ6PEIVWgy9MWcNJqmxRedIk69HFJ1/W+sk/zvQeFfa5vm0QXx6iYjYAw2ORyfJ13EHb
         zXiDA/z+N0DjJp0DS6mKX10OPmsXxYYX50tzZ6Z/91Pk1SafrUkS9vMNbfFMhbgcfLRA
         d0IQ==
X-Gm-Message-State: AOPr4FWqCib9VUCf/2iCgT3YYQL+Ggs1RqlPF3ubkUgh1QsT45azXuMGdVWETXnzsg4qYwjmFF7keREzDnXqOA==
X-Received: by 10.107.9.28 with SMTP id j28mr32929482ioi.104.1460919208655;
 Sun, 17 Apr 2016 11:53:28 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 17 Apr 2016 11:53:28 -0700 (PDT)
In-Reply-To: <20160417183815.GC1014@LykOS>
X-Google-Sender-Auth: mN0UIavTIdsp05CiS-yiTOkbLAY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291771>

On Sun, Apr 17, 2016 at 2:38 PM, Santiago Torres <santiago@nyu.edu> wrote:
> On Sun, Apr 17, 2016 at 02:19:00PM -0400, Eric Sunshine wrote:
>> Junio already made this correction and others in the three patches he
>> queued on his 'pu' branch. It's possible that he also made other
>> tweaks not mentioned in the reviews, so it's a good idea to compare
>> what he queued against what you plan to send for the re-roll to ensure
>> that nothing is missed. Thanks.
>
> Oh, I'm looking at the patches in pu, I didn't know they were there yet.
> Thanks for the heads up.
>
> Also, would it make sense to copy the commit messages as they are on the pu
> branch? for consistency? Or should ommit those three patches and work
> on 4+ for the re-roll instead?

I just re-read the commit messages as Junio queued them on 'pu', and
they are all good, so yes it would be plenty sensible to copy the
commit messages from the three queued patches (along with whatever
other tweaks he made).

Since the patches are only in 'pu' (but not in 'next'), when you
re-roll, resubmit the entire series, not just the patches he didn't
queue.
