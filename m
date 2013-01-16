From: Adam Spiers <git@adamspiers.org>
Subject: Re: What's cooking in git.git (Jan 2013, #06; Mon, 14)
Date: Wed, 16 Jan 2013 12:06:56 +0000
Message-ID: <CAOkDyE-p9WLrsFZjPb9sY+YEypkF2wDxMybBkCT-76jBbKOmCA@mail.gmail.com>
References: <7vehhn8kub.fsf@alter.siamese.dyndns.org>
	<CAOkDyE_a4R7=A318VL2TxDn6X8Tu2+m2KNWWYqwBbygRrALQzg@mail.gmail.com>
	<7v7gnd26pr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 13:07:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvRm3-000281-0r
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 13:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587Ab3APMG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 07:06:58 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33176 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3APMG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 07:06:58 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn14so3361374wib.16
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 04:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=taWYG253T000y8OhPsrvT4SMjclgcP5BIlpKJy5bQuQ=;
        b=v77p+Y5bb3A58nVfxNjAL6z8fbrnA57O2L4ekW1ZUO9AdBAayn4ayMKjkT6XZKRKdT
         r5s7mu/LWg30XoIflGAEDPVIuiwPS/i/VrAUKoALJ2jW2I2p5a6mRfvU1k5lk6ilk8dF
         h1GU3k6zAGmdOcXKz/dAjhVvUP1Ab96IaKFgF7lp0b3Mai4Lga+u/5qcfxI7dYxuJq42
         gLXICzjWSn0KuAXd3Kp1TKmIUywNAML83VipDGHUUIZFineHipZyWiyMTu6C7kyhTEZk
         fZDpQ6yHy5U/bCXetkCqjN7oR7OZUb/zyMvFdn98pFXLUGJkAfKAukO0D+8BsSp436nr
         /Eiw==
X-Received: by 10.194.85.234 with SMTP id k10mr1672541wjz.53.1358338016722;
 Wed, 16 Jan 2013 04:06:56 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Wed, 16 Jan 2013 04:06:56 -0800 (PST)
In-Reply-To: <7v7gnd26pr.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: IrJy_iZ4nHQm-qPZ6dDJARSC_xY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213748>

On Wed, Jan 16, 2013 at 2:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> On Mon, Jan 14, 2013 at 10:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> * as/check-ignore (2013-01-10) 12 commits
>>>   (merged to 'next' on 2013-01-14 at 9df2afc)
>>>  + t0008: avoid brace expansion
>>>  + add git-check-ignore sub-command
>>>  + setup.c: document get_pathspec()
>>>  + add.c: extract new die_if_path_beyond_symlink() for reuse
>>>  + add.c: extract check_path_for_gitlink() from treat_gitlinks() for reuse
>>>  + pathspec.c: rename newly public functions for clarity
>>>  + add.c: move pathspec matchers into new pathspec.c for reuse
>>>  + add.c: remove unused argument from validate_pathspec()
>>>  + dir.c: improve docs for match_pathspec() and match_pathspec_depth()
>>>  + dir.c: provide clear_directory() for reclaiming dir_struct memory
>>>  + dir.c: keep track of where patterns came from
>>>  + dir.c: use a single struct exclude_list per source of excludes
>>>
>>>  Add a new command "git check-ignore" for debugging .gitignore
>>>  files.
>>
>> The above is v4 plus the "t0008: avoid brace expansion" fix.  v4 is
>> slightly outdated and not quite the right version to merge to 'next'.
>
> Sigh.
>
> The "What's cooking" is a report of what _has_ already happened.  I
> would have appreciated if you said the above _before_ this happened.

I did, 8 days ago in the link which you just trimmed from your reply:

  http://thread.gmane.org/gmane.comp.version-control.git/212184/focus=212856

The additional issues with t0008 were discovered after I posted v4, as
reflected in last Wednesday's "What's cooking" (#04):

    "The test it adds seems to break under dash.
     Expecting a reroll or fixup."

I assumed that for brevity you had deliberately omitted mentioning the
outstanding dir.exclude_list_group[EXC_CMDL].el[0] encapsulation
issue linked above, so I thought we were aligned at this point.

However I see now that you changed the status to an intention to merge
this to 'next' in last Friday's "What's cooking" (#05).  That gave me
a window of under 72 hours in which to reiterate the need for a final
re-roll.  Unfortunately with other commitments and illness over the
weekend, I didn't catch this in time.

However, the damage is very small:

>> I'll post a v5 re-roll as per:
>
> Now the series is in 'next', it is too late to _replace_ it X-<.
> Could you instead make an incremental updates on top?  That way, we
> do not have to re-review the whole thing; we only need to review the
> changes relative to the old one, making sure that the fixes in the
> updates are better than the v4 version.

Sure, that's easy to do.  It'll be a single small patch very similar
to this one:

  http://article.gmane.org/gmane.comp.version-control.git/212852

minus the superfluous printf() debug statements.  I'll do that now.

Thanks,
Adam
