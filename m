From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/8] merge-recursive: -Xindex-only to leave worktree unchanged
Date: Sun, 23 Feb 2014 13:42:29 -0500
Message-ID: <CAPig+cQt8R81vc777fvBi_XECoP9Mn=MYDwTX2auUpNRA2z8XQ@mail.gmail.com>
References: <cover.1393059605.git.tr@thomasrast.ch>
	<2e56b258bca6cf83c322da4be85c42c7b54f6a3e.1393059605.git.tr@thomasrast.ch>
	<CAPig+cSWhbunMtQ8=sXqwR7Ps+c0DY2SqVKpu_draaieSJrEPA@mail.gmail.com>
	<87vbw6qbxg.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sun Feb 23 19:43:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHe0y-0008MQ-LS
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 19:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbaBWSmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 13:42:31 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:58478 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbaBWSma (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 13:42:30 -0500
Received: by mail-yk0-f169.google.com with SMTP id 142so12043184ykq.0
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 10:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Jf+mwxG8C8AMuQTtDo4M/7JwaGMzRJgNp25tN/1yfZw=;
        b=L49UQ3ckhV1IeYNZczIRYFxw3sbcIWMw89oWuLHtg+AZQRfnrtzHQUevaN5oRpTEM1
         98c30rjPbvs0wx/jwE11XyGwcwHHIKfyxUp3xFbEM/cJAPUkSvn0FjwM6e5UufxPxL5l
         svN7QYqhfqnujMXoC6zBPiC375cFGas0699t8kiZ3RLoGrE2pTu4Pzloz3itpqmRBzgf
         oA7vUi1/UXE/KktymQk7c87JYWzq5Wg+D1JjzGVpBNH824z47mqJXvOBLW+Rc1K8+Inx
         UEPJxmOmmRBEc+SkqCEIjUI3A3rIcl4n1HN3TTeGswhWVB/uo3odvI5rNJQbusRGJrzQ
         bwVA==
X-Received: by 10.236.126.81 with SMTP id a57mr26316658yhi.95.1393180949940;
 Sun, 23 Feb 2014 10:42:29 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 23 Feb 2014 10:42:29 -0800 (PST)
In-Reply-To: <87vbw6qbxg.fsf@thomasrast.ch>
X-Google-Sender-Auth: NswKCwR79ryBdGp_FVu00J7h5Nw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242545>

On Sun, Feb 23, 2014 at 6:57 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Sat, Feb 22, 2014 at 4:17 AM, Thomas Rast <tr@thomasrast.ch> wrote:
>>> Using the new no_worktree flag from the previous commit, we can teach
>>> merge-recursive to leave the worktree untouched.  Expose this with a
>>> new strategy option so that scripts can use it.
>>>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> ---
>>> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
>>> index fb6e593..2934e99 100644
>>> --- a/Documentation/merge-strategies.txt
>>> +++ b/Documentation/merge-strategies.txt
>>> @@ -92,6 +92,10 @@ subtree[=<path>];;
>>>         is prefixed (or stripped from the beginning) to make the shape of
>>>         two trees to match.
>>>
>>> +index-only;;
>>
>> s/;;/::/
>
> I think ;; is actually correct: this continues the sub-list of options
> to the recursive strategy.  The :: level lists the available strategies.

Make sense. Thanks for the explanation.

>>> +       Write the merge result only to the index; do not touch the
>>> +       worktree.
>>> +
>>>  octopus::
>>>         This resolves cases with more than two heads, but refuses to do
>>>         a complex merge that needs manual resolution.  It is
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Thomas Rast
> tr@thomasrast.ch
