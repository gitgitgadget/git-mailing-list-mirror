From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 01/15] builtin/add.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 17:35:29 -0400
Message-ID: <CAPig+cTmyBzroDOnqEb_GWqhcbgbK27pT3=3VCVOnj13=C4CfA@mail.gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
	<1401118436-66090-2-git-send-email-modocache@gmail.com>
	<CAPig+cRE0LUaNLTJARBCmoDn7cR1bbgi8At0ChgSDWBjDPaNjg@mail.gmail.com>
	<CAN7MxmXVDTiQv5J9cU2E8iS=BNROw3q9NVaBuG7aQP-7=Qo_ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 23:35:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpP1z-0003hG-Lp
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 23:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbaE0Vfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 17:35:31 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:40206 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbaE0Vfa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 17:35:30 -0400
Received: by mail-yh0-f43.google.com with SMTP id v1so8067376yhn.16
        for <git@vger.kernel.org>; Tue, 27 May 2014 14:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=quc9JLKaeTWg8UZLNL9q7yNpfE1bjEzrQAPjTFn6sHw=;
        b=i2RONVWxZrjsz4p6Sp+MaTqpDWG9hY5l55Tzu9lxVHduxwKfQ5VibWOI87ASifQqWa
         dcWE9t1qVfOICcDiUZF4BOJ2ZJ5HlkFFzDl276gYiuZvml4FK5n1SUmbtSBsN1mBNovu
         MC6ebrBB1JHVcPQ9ech0RtlPIKnJ0v29YKgQoIJFwsm5djOcOZqfWLmvt+MDlomW7/La
         Zp/Gldr/+bHeyDXTC0JJRq5Zxz0P8Gg70JoRqnHw242CsPPxFqxflZoEG/4crwOk9JN1
         I877ZqkqicHUif1sV9+E8LUvL1Ln+9IPV7sOORh+AJRtf0sczkIMHesn9iYn5xnkHhX5
         ToEw==
X-Received: by 10.236.134.169 with SMTP id s29mr6378513yhi.4.1401226529856;
 Tue, 27 May 2014 14:35:29 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Tue, 27 May 2014 14:35:29 -0700 (PDT)
In-Reply-To: <CAN7MxmXVDTiQv5J9cU2E8iS=BNROw3q9NVaBuG7aQP-7=Qo_ZQ@mail.gmail.com>
X-Google-Sender-Auth: ANpUXpRkJRbURReglcPiWojNR1I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250240>

On Tue, May 27, 2014 at 7:32 AM, Brian Gesiak <modocache@gmail.com> wrote:
> Oomph, how embarrassing. Thanks for pointing that out!

Etiquette on this list is to avoid top-posting [1].

[1]: https://lkml.org/lkml/2005/1/11/111

> Would it be better if I rerolled the patches?

Junio may or may not make small fixes himself when he picks up a patch
series. If you don't hear from him and your patches don't appear in
his 'pu' branch with that fix, re-rolling might be advisable.

> - Brian Gesiak
>
> On Tue, May 27, 2014 at 12:25 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, May 26, 2014 at 11:33 AM, Brian Gesiak <modocache@gmail.com> wrote:
>>> xcalloc takes two arguments: the number of elements and their size.
>>> run_add_interactive passes the arguments in reverse order, passing the
>>> size of a char*, followed by the number of char* to be allocated.
>>> Rearrgange them so they are in the correct order.

If you do re-roll, perhaps consider simplifying the commit messages.
The patch itself states concisely and precisely what is being changed;
the lengthy prose description doesn't really add anything (and makes
more work for you and the reader of the message). It might be
sufficient to use a single-line (Subject:) commit message, like this:

    builtin/add.c: fix order of xcalloc arguments

>> s/Rearrgange/Rearrange/
>>
>> Same misspelling afflicts the entire patch series.
>>
>>> Signed-off-by: Brian Gesiak <modocache@gmail.com>
>>> ---
>>>  builtin/add.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/builtin/add.c b/builtin/add.c
>>> index 672adc0..488acf4 100644
>>> --- a/builtin/add.c
>>> +++ b/builtin/add.c
>>> @@ -248,7 +248,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
>>>         int status, ac, i;
>>>         const char **args;
>>>
>>> -       args = xcalloc(sizeof(const char *), (pathspec->nr + 6));
>>> +       args = xcalloc((pathspec->nr + 6), sizeof(const char *));
>>>         ac = 0;
>>>         args[ac++] = "add--interactive";
>>>         if (patch_mode)
>>> --
>>> 2.0.0.rc1.543.gc8042da
