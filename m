From: Chris Angelico <rosuav@gmail.com>
Subject: Re: Configuring a third-party git hook
Date: Sat, 22 Mar 2014 04:48:00 +1100
Message-ID: <CAPTjJmodV0djvYJ9MWqdH4MvkrmauTJoWZFu0+RrR9ATdZBepQ@mail.gmail.com>
References: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
	<CAO54GHC1B6hj-OvibHn2=-B25Xd5EmfWsphJ1S7vE4bgUUX3Bw@mail.gmail.com>
	<CAPTjJmpAcmVGgJK8iUvFuXJq_ZukisRZ6OD9TM=feuxDYm5iPQ@mail.gmail.com>
	<20140320233816.GC7774@sigill.intra.peff.net>
	<CAPTjJmpYREHy1cufZMuyOoXrO1Oy7QwXR+wBvm9cbgkT7SqC4Q@mail.gmail.com>
	<20140321034334.GA29683@sigill.intra.peff.net>
	<CAPTjJmqRFbKxe8MODtBDDC0SUYGoaFmQj2724YmKnMmdbrgOUA@mail.gmail.com>
	<xmqqha6rv4og.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 18:48:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR3Y7-0000sk-Tq
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 18:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbaCURsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 13:48:03 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35204 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbaCURsB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 13:48:01 -0400
Received: by mail-pd0-f172.google.com with SMTP id p10so2649583pdj.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=i9qmGcnZTZk5fToGs8xHCwE+oJTv4hDsxaCxYxTQmiI=;
        b=OVOkC+813ZTWsVTrXm7qy37Y6LXCby2dUqtJ7xe7myGLoI4c5LC+qa8N9dAvYhyaJl
         BZIPPUEceVnY9io22LTlOcuXaqxF3NHzlThpqX45DRCBQbn4KBfrfsU4VaV+YoleoCXH
         NubzxRR5nhlDvhSPbCd4rZSzXmrH6T6J+wJJ9QGhsm9Df/pfwrZL505GXDFbbi0wWZV9
         spQf8T8oqiueyXeaKKvXhCLb7Vi484VtnC4hBmJcymHTb0jmu8SmkWkH2/sOVGiQCYaS
         gbMSt9Ny8qTy1/qw7PViJxAMCREg13hy3LRqmUQ5ZeMrCRcnMdTWrhll5jxsPlZ8Qi9v
         59XQ==
X-Received: by 10.68.200.74 with SMTP id jq10mr2542330pbc.169.1395424080923;
 Fri, 21 Mar 2014 10:48:00 -0700 (PDT)
Received: by 10.68.33.7 with HTTP; Fri, 21 Mar 2014 10:48:00 -0700 (PDT)
In-Reply-To: <xmqqha6rv4og.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244709>

On Sat, Mar 22, 2014 at 4:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Angelico <rosuav@gmail.com> writes:
>
>> On Fri, Mar 21, 2014 at 2:43 PM, Jeff King <peff@peff.net> wrote:
>>> Thanks, the new text looks good to me. Please follow SubmittingPatches
>>> (notably, you need to sign-off your work, and please send patches inline
>>> rather than as attachments).
>>
>> Ah, didn't see that file.
>
> It appears that we might need to be more explicit in that file,
> though.
> [chomp specifics]

Please do. I read through the file as a set of instructions, and would
have followed them if they'd been there. Fitting into a project like
that is what those sorts of guides are for.

> Also I'd title the commit with the area it touches, i.e. starting it
> with "Explain blah" is suboptimal.

Interestingly, this is exactly what my hook is for! It searches for
previous commits touching that file, looks for something separated off
by a colon, and pre-fills the commit message with that. (If there are
multiple options, they're all listed, commented out. Otherwise, it's
put in without a leading hash, so I just hit the End key - I use nano
for commit messages - and start typing.)

> Will queue with a minor tweak, with retitling the change and
> rephrasing the "ideally" part, which invites people to say "well it
> may be so in the ideal world but the rule does not apply to me".

Awesome. I tried to keep it brief (and the "ideally" was from the
point of view of someone trying to configure someone else's tool), but
explicitly talking about creating new variables makes that even
clearer. Thanks.

ChrisA
