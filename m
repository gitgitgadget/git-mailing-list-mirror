From: Stefan Beller <sbeller@google.com>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Wed, 16 Mar 2016 16:33:03 -0700
Message-ID: <CAGZ79kYVT0cq8XgruZ+i_gGuSDySE+s3POU95PXyra9DwVGLkQ@mail.gmail.com>
References: <CAFZEwPPd2wFqFq2LFEzN2CzhTV6C420SLPcXi1SWE=z2epOYLw@mail.gmail.com>
	<20160316204912.GA1890@sigill.intra.peff.net>
	<CAFZEwPMa3GZS6pvFwr8PLVDqKm5xmMd307nbjhpZSC_ndpw8vw@mail.gmail.com>
	<20160316212308.GA4538@sigill.intra.peff.net>
	<CAPig+cRKyaUefz0qj6unkaiPg25=Xi2WorQE4Fm46CCf00UbHQ@mail.gmail.com>
	<20160316214442.GC4441@sigill.intra.peff.net>
	<CAGZ79kbbAv=PukD+sftmoO8u3GX=S1YCYGV8zcNMxrZ+E41-UA@mail.gmail.com>
	<20160316231626.GA11808@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 00:33:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agKwC-00029f-UI
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 00:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935276AbcCPXdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 19:33:07 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36207 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933155AbcCPXdG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 19:33:06 -0400
Received: by mail-io0-f177.google.com with SMTP id g184so21546495ioa.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=foQ9nz2a9IQVQD0lfB291dr43G8vmp3xcjU6tlPcrhM=;
        b=Ily0DQES/sizZYrdwd84sSGfbDE/2fN0OxZXEn2KnwhiudrGS9EqFksoB0+13OeIw0
         Lv+6wpEyvFjhfwf3T2gQJya5CojHMp4bN37oPvvSftnn6dwF3OgGVxlj2mrwJnpfd8RU
         2sJ9Unx0tiOEmCyVNasfozYbtNqVizAgST4+58A2S5TTQZe0btMnUzotwdnKOm6g6pN+
         FyAfKp9zlBIPAHjSxGfaeMkjenkVVdJhbEwBYTclXrwU0gwBqJ+0nvVO/3aAcBFQjMy2
         mP5NLONe9R5jmcWS3JcQ90bJEXPgNjzTIDEWU8PK4AFrhAc3vLztOLGG8cLNt0rXFlbV
         ZO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=foQ9nz2a9IQVQD0lfB291dr43G8vmp3xcjU6tlPcrhM=;
        b=U284lhVVC800AHqoPtdtLSsQDaZWgkqNwQZhlc80UHXo02y2/36VSy2NtEJXVQF2+O
         XerE/vZdi9tmEJk//Q/onA6g8DfR/7NamqNlY7d+B8nQ0yX0kPFscdwtrCwKXaLeZAG/
         VXDeUlV+1bOnp8CziMos+uX3IjgQ/FSOpHPP+dljhCTKRAGNmhjbo+JRqhdfxzrj3ryX
         t52HcyMFw24rJrghlCox8/HVdu9nzQXjEVPlw0YKlw/SJ0zwdCb2qNSThqTf/CToh1Ph
         bNn6BOcE4zyteGHET93ijkWeZsRLGIEX2e6143z5sg+IGzLF7aHXTHBa7w9dUegE8zXN
         tjJg==
X-Gm-Message-State: AD7BkJKWRiugLbaR2pyXjyZgPqJrrRzn8FJhY2VGY+F/jkXeAdPl7yRhqerzqyKR1xfaMccAuoirY9si8TKb3GBA
X-Received: by 10.107.135.96 with SMTP id j93mr6485324iod.96.1458171184054;
 Wed, 16 Mar 2016 16:33:04 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Wed, 16 Mar 2016 16:33:03 -0700 (PDT)
In-Reply-To: <20160316231626.GA11808@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289060>

On Wed, Mar 16, 2016 at 4:16 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 16, 2016 at 02:53:17PM -0700, Stefan Beller wrote:
>
>> On Wed, Mar 16, 2016 at 2:44 PM, Jeff King <peff@peff.net> wrote:
>> > On Wed, Mar 16, 2016 at 05:37:03PM -0400, Eric Sunshine wrote:
>> >
>> >> A much easier solution would be to update OPT_VERBOSE() to understand
>> >> that negative values are "unspecified", and then --verbose would
>> >> (pseudocode):
>> >>
>> >>     if (value < 0)
>> >>         value = 0
>> >>     value++;
>> >>
>> >> and --no-verbose would:
>> >>
>> >>     value = 0
>> >>
>> >> That should be compatible with existing clients of OPT__VERBOSE()
>> >> which initialize the value to 0, and should satisfy Pranit's case; he
>> >> can initialize it to -1, and if it is still -1 when option parsing is
>> >> done, then he knows that neither --verbose nor --no-verbose was seen.
>> >
>> > Yes, that makes much more sense to me. Thanks for the back-story.
>>
>> Is there any command which needs more than one --no-verbose?
>> (as an abuse to stacking --quiet multiple times)?
>
> I'm not sure I understand. "--no-verbose" is just about resetting the
> value. So you might get it multiple times in:
>
>    git commit -v --no-verbose -v --no-verbose
>
> but the caller would not care. Which makes me think I'm misunderstanding
> your question.
>
> You also mention "--quiet", but that is not handled by OPT__VERBOSE, but
> rather by OPT__QUIET. And there I do not think the "-1 is undefined"
> trick works as well there, because presumably "-1" is the same as one
> "--quiet".

The way I understand verbosity is this:
* You can instruct a command to be more verbose if it is supported by
adding more -v
* --no-verbose tells the command to be not verbose, i.e. no additional output.

So my question was, if there is any command, which is verbose by
default, and --no-verbose
would make it "more quiet"? Such a case would be a UX bug, as a user
would rather expect
--quiet instead of --no-verbose IMO. Would such a case ever happen,
that we'd want to give
--no-verbose to decrease the amount said by the command?

IIRC some commands use one integer variable to determine
the amount of output, i.e. --verbose increases that variable, --quiet
decreases it.
What happens for example with

  git commit -v --no-verbose -v -q -q --no-quiet

In case of commit, the quietness and verbosity is done in 2 variables,
so these are orthogonal to each other, there are even no internal checks for
(verbosity > 0 && quietness > 0) at the same time, so it seems to be a valid
command.

In case of a command where this is tracked in one variable,

  git <foo> -v --no-verbose -v -q -q --no-quiet

you'd expect:

  verbosity++ // because of first -v
  verbosity = 0 // because of the reset with --no-verbose
  verbosity++ // because of second -v
  verbosity-- // because of first -q
  verbosity-- // because of second -q
  verbosity = 0 // because of the reset with --no-quiet

Having typed that, I think my comment was not adding value to
the discussion, as --no-{verbose/quiet} would just reset it to 0 no matter
if you track verbosity/quietness in one or two variables internally.

Stefan
