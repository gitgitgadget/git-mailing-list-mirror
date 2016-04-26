From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v6 0/4] Add --base option to git-format-patch to record
 base tree info
Date: Tue, 26 Apr 2016 15:56:36 -0700
Message-ID: <CAGZ79kbTqW82Tj3KvXwYYhSWxuGvaGeYoAZrJkkM6FR4rhwC+Q@mail.gmail.com>
References: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
	<CAGZ79kajpAtbHaKLaLHN5+qUOvBofFs-q-vUYWua49GWK7FO9Q@mail.gmail.com>
	<xmqqlh40gs9o.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZg3OpR8k45=q1m-g=t+aGGs8VDYBrBYaBU_DbfuuoBig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xiaolong Ye <xiaolong.ye@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Fengguang Wu <fengguang.wu@intel.com>, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 00:57:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avBuc-0002WP-Um
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 00:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbcDZW4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 18:56:39 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35938 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbcDZW4h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 18:56:37 -0400
Received: by mail-ig0-f177.google.com with SMTP id u10so56844451igr.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 15:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=LmPbj8MP++QlDpFNRB86xtMHAslLVsL4peENqX9h4Yg=;
        b=crYAG08e2T/xpBfQUtjkaNM49d5QETr4kBCcPDugSHwXJbccYga0rAasnvo0gTZrF5
         10lhiO4LcMa/SYqYBQOoX+xyCwRzFyoOvIUkYPrnj61NmB1Ib00inFUEHAK/+vI4AqWn
         poB4QsB1sOI4RUwlzVPYcrnK3Bn6/kNiulvLRnhLG5MjQVcfTkUxt/KZ429TNnKn3Zzo
         UUG5572oSz984IQ4wqCT6Or+xu9DtePMrsjjC74WkA625me+5E1f4NFemCxC6F1X5W9q
         Q2ayrRvnIe8XAJLB4LMHv7XGDNNmEnUQCaVVbwUeMpkVZS1w5OzNBV4++LAi3BLho/bZ
         CuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=LmPbj8MP++QlDpFNRB86xtMHAslLVsL4peENqX9h4Yg=;
        b=YvKskGfGPzB2xGCYs2CZ2RHe2YjfvJxrhmjF8UiAd4RlmLQBBRtThotfdG9YE+OJLk
         KypqG/Sl8ycawSx31lpGzfdTWbcWEe658Cjn/24DCJEON/Qs2JkaLOJOPt6pOv63Omvd
         XWLl2KBBFMi6M5BZHSExbqi8biGTovz+iPs++x4zKiJrKs0pLQcKLC9Ko5w66qmx/RWL
         t/2K5PjI2ZgQUEUs2C9ttSn9upynWetA4VrKq8WPLLP52+QVfjl/pcnRPqW4tyPFJsxs
         JTcuKfUmM3L8F351RDsX8MGLaSPtQYYdhJkFJZwRWCiAd4ry11z81Wq8L3ppp4DmPL8p
         xVGA==
X-Gm-Message-State: AOPr4FWDlohNJW/lfjly7xQ7YhwMAfEE6uWuWBRH+UJ12Dp6x9SxGOsBQHHoVu+la3JPtFZgcXfg5MVcEbZ+rHwV
X-Received: by 10.50.57.50 with SMTP id f18mr22681559igq.93.1461711396748;
 Tue, 26 Apr 2016 15:56:36 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 26 Apr 2016 15:56:36 -0700 (PDT)
In-Reply-To: <CAGZ79kZg3OpR8k45=q1m-g=t+aGGs8VDYBrBYaBU_DbfuuoBig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292695>

On Tue, Apr 26, 2016 at 11:20 AM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Apr 26, 2016 at 11:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I think the way for you to indicate that desire expected by this
>> series is to use "git branch" to set upstream of new-shiny-feature
>> branch to origin/master.  Shouldn't that work, or is that too much
>> work?
>
> I can totally do that for longer series which require some back and forth.
>

So the submodule groups series is an example with some back and forth,
so I'll try to take that workflow with setting an upstream there for now.
As the groups stuff is based on origin/sb/submodule-init I set that as the
remote upstream branch. Upon checking that out I get:

    Switched to branch 'submodule-groups'
    Your branch is ahead of 'origin/sb/submodule-init' by 15 commits.
      (use "git push" to publish your local commits)

The first 2 lines are correct, the third however is not correct. (I cannot push
to your repository, but only email patches)

So I wonder if
 * I configured the wrong upstream branch
 * the upstream branch concept is extended to more/other use cases by the
   format.useAutoBase option. (In an email based workflow you would use the
   a remote branch to a remote, which is not owned by yourself, so the push
   advice is invalid from now on and we patch that message)
 * using an explicit upstream branch is the wrong approach here and the
   base should be implicit, i.e. Take the base sha1 and see if there is
   (one/any) remote branch matching that sha1.
   If there is, use the sha1 just fine.

Thanks,
Stefan
