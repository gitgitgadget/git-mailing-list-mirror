From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] tag: support --sort=<spec>
Date: Tue, 25 Feb 2014 06:30:35 +0700
Message-ID: <CACsJy8CRe4MmkTnuChOi2SHG52tx_LZ+51vWXN9ooGmcRUN7bQ@mail.gmail.com>
References: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
 <1393039762-4843-1-git-send-email-pclouds@gmail.com> <20140222080404.GB1576@sigill.intra.peff.net>
 <xmqqy510bh2g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 25 00:31:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI4zR-000720-Mo
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 00:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbaBXXbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 18:31:08 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:43141 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbaBXXbH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 18:31:07 -0500
Received: by mail-qc0-f170.google.com with SMTP id c9so9737352qcz.15
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 15:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SMGkUxd3QgPRJ+NEcsEqgJ3KT1CBZu2/mIXPnA0jGCM=;
        b=QFL9oJd2gn3dI+aYiTsozaqDmxiF223GCrO6iBF5WV5I/nmLWEgZt/SIWsNoKf8rbD
         4Eq1jKhqkZSPxEw//vZxJDxGpNYSHCTa6qS91ztNH8PQicQVG3Ol9MAjWKbW/vMgzpkF
         82Wfv74ZMh1I6ftvqhAC25VHgqf1EowSKluWi11zzsPJKtyjL11g5Z0w/DYuQDxuwlZU
         DmAiF/6LQYJkqfuujYMwqJJHQ7/+DjIJQcFC904V8ZUXtc6MRvbJEmap3rqxbSRyx9Wm
         9FO7MW6iKwLxn8BOmz5FWIldtc0EmoCo85wR13QEkt6JutRXHR7x+Wy1PFLCafKZAQRl
         UsaA==
X-Received: by 10.140.93.130 with SMTP id d2mr31731668qge.41.1393284665816;
 Mon, 24 Feb 2014 15:31:05 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Mon, 24 Feb 2014 15:30:35 -0800 (PST)
In-Reply-To: <xmqqy510bh2g.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242653>

On Mon, Feb 24, 2014 at 11:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>>> index 1531c24..5e8c39a 100644
>>> --- a/t/test-lib.sh
>>> +++ b/t/test-lib.sh
>>> @@ -771,6 +771,8 @@ case $(uname -s) in
>>>      ;;
>>>  esac
>>>
>>> +[ "$(uname -o)" = "GNU/Linux" ] && test_set_prereq GNULINUX
>>> +
>>
>> can pick up the value from GIT-BUILD-OPTIONS as a prerequisite (see the
>> way we handle NO_PERL for an example). Though if we can just grab the
>> glibc version as a fallback, we can do away with that completely.
>
> ;-)  I like that.
>

Jeff, I'm still waiting if you agree to go with this syntax or put
version before refname before rerolling (either with build time option
like this, or implement the compat function myself).
-- 
Duy
