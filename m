From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH 00/95] Add missing &&'s in the testsuite
Date: Fri, 24 Sep 2010 15:54:50 -0600
Message-ID: <AANLkTimdp1+urRt5kwo=1OEg5X-2mAZ6OWQvdyyAWZRt@mail.gmail.com>
References: <1285362413-18265-1-git-send-email-newren@gmail.com>
	<UA25cdpM3towJy13l2VNc8pgKHGybUWr88Zc0C9kQjUCExhj5gXkCQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Sep 24 23:54:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGEL-0007dd-Na
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 23:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758193Ab0IXVyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 17:54:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61233 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab0IXVyw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 17:54:52 -0400
Received: by fxm3 with SMTP id 3so1002018fxm.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 14:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=7iFf0W6oWo34tyiWKd5ooGN/RC6pgvb8Xa9zAqyP2wk=;
        b=OtghdgfqWefPBRQYBPBQ7j1reqrowH8OwdLV9OmOun7it2xjH7l9bGqN9/aaMJqXpO
         ZFQrJjkC/pB61YkZu+1wsrpp53AAOZsWK6BCOMNbMn9d2wygldW4qBnGFlLmcRerTGMl
         i02v1h5tYPS+sRscN/zZfT3xjVngMlqH52fOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ux88SSknp+HMyQ7HSiitCc9mpRvXqchuLIGl3XKBMQoQu+FJgEhpO+CnHLzXlKh/TM
         EHi7/yI30D0Ff9ndXtykBYMPRtxwgmywZI4mWqTOWDDlx2s1bsMywjh2hlMURa/hn73j
         GmjEFZrrBIJcLRuL5yveU7O1PLaEBKlo9971A=
Received: by 10.223.125.70 with SMTP id x6mr4175492far.85.1285365290893; Fri,
 24 Sep 2010 14:54:50 -0700 (PDT)
Received: by 10.223.119.209 with HTTP; Fri, 24 Sep 2010 14:54:50 -0700 (PDT)
In-Reply-To: <UA25cdpM3towJy13l2VNc8pgKHGybUWr88Zc0C9kQjUCExhj5gXkCQ@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157068>

On Fri, Sep 24, 2010 at 3:32 PM, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> Sounds like it should be about a 16 patch series.
>
> The first 15 patches should rework the tests that will fail when
> they are hooked together properly with &&'s.

Actually, only 9 of the tests fail when hooked together with &&'s and
needed extra fixes because of this.  4 of the tests modify the code
slightly in order to chain it together (e.g. replacing "a_command ||
return 1; command_that_fails" with "a_command && test_might_fail
command_that_fails &&"), 1 removes a stray "1" at the end of the file,
and one fixes lack of chaining by modifying tests to use
test_exit_code instead of test_expect_success (namely tests that did
nothing but check the exit code of a single command).

> And then one patch to mechanically add the missing &&'s.

Sure, I can include that change for the next round.


Thanks for the feedback.

Elijah
