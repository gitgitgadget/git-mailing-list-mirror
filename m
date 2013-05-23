From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Thu, 23 May 2013 16:58:12 -0500
Message-ID: <CAMP44s3LcEkTghg-cBRux7sA54L-U93w5Znqa1jz2MnUWj8Rhw@mail.gmail.com>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
	<CAMP44s1_=HSgZA=abHJ3sgDbUyfkF78qO+sR1+Aact3o7bAgLA@mail.gmail.com>
	<7vvc6ah81g.fsf@alter.siamese.dyndns.org>
	<CAMP44s37a0_wVVef+QVnLNvc8Uos_XpCZAtpX0RmQyMcuJHUHw@mail.gmail.com>
	<CAMP44s18ps9JtY7+mvXVbuZu3cm7bHnK1vCzMWqBdvawLr+zzA@mail.gmail.com>
	<7v8v35hc11.fsf@alter.siamese.dyndns.org>
	<CAMP44s0X-79Pn4gq_rqBbti-xUobyYDc8Gy-3-g=sq8siZqq8g@mail.gmail.com>
	<7vppwhcqjq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 23:58:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfdWc-0003lt-Sp
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 23:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759694Ab3EWV6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 17:58:15 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:45745 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759653Ab3EWV6O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 17:58:14 -0400
Received: by mail-la0-f52.google.com with SMTP id fo13so3729299lab.25
        for <git@vger.kernel.org>; Thu, 23 May 2013 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PNdN1ICGNhoeGlz/U35mG/T+VnSdck1DG7kMwdS0VvQ=;
        b=nPyfktYd5VzljH31PGLX75PQfstPHw3j6lq293wyDzjDGqcobYU7OmbLYIyI89zFkv
         LXTcf9GsP81gjkymDwTkirrXV5iczxWQkEUIfnEXujXZ7GA+yTIVKqwKMBiW/Mg1e0Cx
         zaVdJlIhfBGVGZAXOf0jWl3sZ2Pyw0n5+AvLNdAYvALg+HLtbIb7IcHQHaZw+5ZUXIYE
         YP7uIM6esD9QNPCFy+SmZhfTo2aX2LNxQnfbGl7j78j+sxDseedtb0/QoWj0zRQGo+pP
         VL1Hb4fbzjx8EPtM/Z3SqJAJ5pB1is0ItslOHNVYqUCqRxIxhhTC8mo2hXW16vbUJt5W
         fpDw==
X-Received: by 10.112.218.102 with SMTP id pf6mr7439917lbc.77.1369346292558;
 Thu, 23 May 2013 14:58:12 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Thu, 23 May 2013 14:58:12 -0700 (PDT)
In-Reply-To: <7vppwhcqjq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225306>

On Thu, May 23, 2013 at 4:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> Imagine that your scoreboard originally has three blocks of text
>>> (i.e. blame_entry) A, B, and C, and the current suspect for A and C
>>> are the same, while we already know what the final guilty party for
>>> B is (which may be some descendant of the "suspect").
>>
>> I don't see how that's possible, but whatever.
>
> The tree in your latest commit HEAD has a file with block of text A
> followed by block of text B followed by block of text C.  The latest
> commit was the one that added B (perhaps new lines were inserted, or
> perhaps existing contiguous block of text was replaced, there is no
> difference between these two cases).  You start digging the history
> of this file from HEAD.
>
> Your scoreboard begins with a single blame-entry that covers all
> three segments, with its suspect set to HEAD.  Then pass_blame()
> discovers that top and bottom segments are older than this latest
> commit, and splits the originally-one blame entry into three blame
> entries.  The first and the third blame entries cover the block A
> and the block C respectively, and their suspect fields are both set
> to HEAD^.  The second blame entry covers the block B and its suspect
> does not change (it still is HEAD).  Then it returns to the caller.
>
> The caller of pass_blame() looks at the scoreboard and finds these
> three blame entries.  The second one's supect is still the original
> suspect the caller asked pass_blame() to exonerate blames for, and
> the suspect failed to do so for block B.  The final blame for the
> middle block is now known to be HEAD.
>
> After all of the above, the next iteration of while(1) loop begins.
> That is how you arrive to the "whatever" situation.  You have three
> blame entries, A, B and C, and suspect of A and C are the same,
> while B has a different suspect.
>
> Then in that "next iteration", we pick blame entry for A and decide
> to see if HEAD^, which is the suspect for A, can be exonerated of
> blames for _any_ (not just A) blame entry it currently is suspected
> for.  We call pass_blame() and it will find and process both A and
> C with a single "git diff-tree", attempting to pass blame to HEAD^^
> and its ancestors.

All right, my code still works in that situation.

-- 
Felipe Contreras
