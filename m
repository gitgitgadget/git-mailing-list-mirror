From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 00/19] Index-v5
Date: Wed, 17 Jul 2013 10:12:29 +0200
Message-ID: <87oba1siz6.fsf@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <CACsJy8AhmYBjzqPtF3f9Gk8hq2bk8-PtFCto9_4AkRePomvhAQ@mail.gmail.com> <87ehb0cgqt.fsf@gmail.com> <CACsJy8AiRCRvGmj4ZV+sc68d1z=S7YrRgPtPgEK+-zzNg7HcsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 10:12:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzMqr-0006mc-BD
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 10:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab3GQIMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 04:12:38 -0400
Received: from mail-ea0-f175.google.com ([209.85.215.175]:55035 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab3GQIMd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 04:12:33 -0400
Received: by mail-ea0-f175.google.com with SMTP id z7so854168eaf.20
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=b1LfMkCliQWqo1paQAaC10LxDhMaUe1+YS2MVTGE3xU=;
        b=1BrvcqvuzKAOq8LI2KTkNfnhPAKcfSO5vk1EKSBfQQdKULevCFGpw3lvxkz7ivELTg
         5RXdz/i6azfweYgfVdxp+rK6tfRlVdmn7JaYfR18ePyFK5A5g5z2Nm52WCSKivA3ONv2
         gqnMFWtv3QpLGoRiVakTw3mzFT254n1r7qfGNx9PlQvZWjCh7bNGiimawyDHo1WlWNeU
         Gh+KgZgoX6lusPUmWFeySYibLandktQ1mxKKKiGzyv0xVoYVjM7mc/fpOOf7lSSd7esX
         DRctXuiVMEC8+Kz1Zg7MvnGsvgvRUBX3awGW4qzJtKqiuaZat0qLP4qDn9qFlGUjYkIh
         ZNPw==
X-Received: by 10.14.148.133 with SMTP id v5mr5241902eej.81.1374048752393;
        Wed, 17 Jul 2013 01:12:32 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id a4sm8907775eez.0.2013.07.17.01.12.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 01:12:31 -0700 (PDT)
In-Reply-To: <CACsJy8AiRCRvGmj4ZV+sc68d1z=S7YrRgPtPgEK+-zzNg7HcsA@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230609>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jul 15, 2013 at 4:30 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>>>  t/perf/p0003-index.sh                            |   59 +
>>>>  t/t2104-update-index-skip-worktree.sh            |    1 +
>>>
>>> For such a big code addition, the test part seems modest. Speaking
>>> from my experience, I rarely run perf tests and "make test" does not
>>> activate v5 code at all. A few more tests would be nice. The good news
>>> is I changed default index version to 5 and ran "make test", all
>>> passed.
>>
>> I was using the test suite with index version 5 as default index version
>> for testing of the new index file format.   I think that's the best way
>> to test the index, as it covers all aspects.
>
> We need other people to run the test suite with v5 to catch bugs that
> only appear on other platforms. Perhaps an env variable to allow the
> test suite to override the binary's default index version and a new
> make target "test-v5" maybe.

Ah ok, I understand.  I think it's best to add a GIT_INDEX_VERSION=x
config option to config.mak, where x is the index version that should be
tested.  This is also the way other test options are set
(e.g. NO_SVN_TESTS).  In addition this allows testing other versions of
the index file too.

>> Maybe we should add a test
>> that covers the basic functionality, just to make sure nothing obvious
>> is broken when running the test suite with index-v2?  Something like
>> this maybe:
>
> Yep. v5 specfic test cases can cover some corner cases that the rest
> of the test suite does not care. Haven't read your t1600 though.

Ok.  I can't think of any corner cases right now that would be in v5,
but not in other versions, but if I catch some I'll add tests.
