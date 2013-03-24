From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] git-pull.sh: introduce --[no-]autostash and pull.autostash
Date: Mon, 25 Mar 2013 02:42:24 +0530
Message-ID: <CALkWK0k0Ek0Dqxrrv7dAzUgF2X2hCcz2SodcPEgiRdLFgc-gXA@mail.gmail.com>
References: <1363955399-13153-1-git-send-email-artagnon@gmail.com>
 <1363955399-13153-4-git-send-email-artagnon@gmail.com> <7vtxo374h6.fsf@alter.siamese.dyndns.org>
 <CALkWK0=oOt0teGqCjpDkerR3-t1cY=qKyK-AtoLLCz9L1-+vyw@mail.gmail.com>
 <7va9pt2r4e.fsf@alter.siamese.dyndns.org> <CALkWK0k=jei8Z+n-4O92obQOR88FR6iFCSifVhDDS8jv37rOjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:13:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJsE7-0004UX-1Q
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757Ab3CXVMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:12:46 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:49284 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab3CXVMp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:12:45 -0400
Received: by mail-ia0-f179.google.com with SMTP id x24so4979519iak.10
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 14:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ycQ5oTGBfgnNsJMX60OFotDEqTQnP1XmfwDt4MvYAf8=;
        b=g4duJPKyYERH+0R57+4RZWSbkodCSf+t3aVbHtpTVKgi65NX9x+1pBxbC+TjEct8o1
         /yEelODC9Yi07ullqPjMp/jfb7fVdP37tOHvRqpi19oZdVuZOzANpSzD4euBrkmxAFRM
         Yp+Mf1NfI/Tg4ZvNUjqwbHr9X8at56i2aYrA4cdgpiLm+3V0mxseeLc6EBU4SJoKGVcC
         rl5AdLscScAkN8YVgFsPIClpYLN+UpHgJx0ww3QgVsXvFfZFOcgSmIgljEyVnAPc3ps4
         TiC+eLcFFx5kztQPLN6LSQnwW6j2/CYnhxwNHksBXlsO7xnhEoLeITZD1r3c2xjk6JqT
         lN4Q==
X-Received: by 10.50.17.71 with SMTP id m7mr6260257igd.14.1364159565344; Sun,
 24 Mar 2013 14:12:45 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sun, 24 Mar 2013 14:12:24 -0700 (PDT)
In-Reply-To: <CALkWK0k=jei8Z+n-4O92obQOR88FR6iFCSifVhDDS8jv37rOjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218986>

Ramkumar Ramachandra wrote:
> Junio C Hamano wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>>>> +     elif test "$autostash" = false
>>>>> +     then
>>>>>               require_clean_work_tree "pull with rebase" "Please commit or stash them."
>>>>>       fi
>>>>
>>>> A safety net, after you run "git stash", to validate that the
>>>> added "git stash" indeed made the working tree clean, is necessary
>>>> below, but there does not seem to be any.
>>>
>>> Um, isn't that part of the "git stash" testsuite?
>>
>> You should always "trust but verify" what other commands do at key
>> points of the operation; and I think this "require-clean-work-tree"
>> is a key precondition for this mode of operation to work correctly.
>>
>> Especially because you do not even bother to check the result of
>> "git stash" before continuing ;-).
>
> If you think it's enough to replicate the codepath that precedes the
> actual saving in 'git stash' (which is essentially
> require-clean-work-tree), I'm in agreement with you.  I thought you
> were implying a wider safety net, that wouldn't even assume the basic
> sanity of stash.

Er, s/codepath that precedes the actual saving in 'git stash'/codepath
that precedes the actual pulling or merging in 'git pull'/

I'm feeling a little muddled up today; weekends are usually bad.
