From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Fri, 28 Feb 2014 10:07:55 +0100
Message-ID: <CAL0uuq33i6jU1A4Vv4xUO7=QZRej0vxVM12SKxvOiLk27hsD2A@mail.gmail.com>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
	<530F1F11.7060403@alum.mit.edu>
	<CAL0uuq3TGb2wjaqNxwXYa++E5rjVoozox5mZbzTaE17OKtsVTg@mail.gmail.com>
	<a8cf74b4-bae1-4511-a45e-d4ca90e3c3e1@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 28 10:08:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJQK-0003uB-St
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbaB1JIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:08:00 -0500
Received: from mail-vc0-f176.google.com ([209.85.220.176]:45471 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbaB1JH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:07:57 -0500
Received: by mail-vc0-f176.google.com with SMTP id la4so428965vcb.7
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 01:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q0nvqT+HZ8RHHzaIQ2hx4cigPUZrWbXMC3weR71xjCw=;
        b=FrLn9znb3QMYdYG87wS/YDqs7loqp66+3MmDuboFyifIyKdIHiHR66uKrN11tQ+f3F
         Neg7Tv1IPXT/Lf5+uLpp2UQApSmh2Tdm4PP4og+M/SSaTeHuw53JpixZ56vZ0hiu4Qao
         zOUqH8EeS3cdaZ/83U0RA+knkGnAQVkGT/JRR7Yl9uJzh1yXpschF6GGeMtvnWPyLlA6
         GtwaIzW4OmSpG0m9rvr6r2UGE4fac48+u4X+QYCv+z8pkb2dwpsTjyrM1mC5rcOP2UmR
         HFoJMmASVZ+fkiIAy4K81ffO+nI+bFy8/jMzdWudFb8vHuWv2+2LFeE0sjrHEl0dYDhE
         cDZA==
X-Received: by 10.221.34.211 with SMTP id st19mr1485113vcb.5.1393578475766;
 Fri, 28 Feb 2014 01:07:55 -0800 (PST)
Received: by 10.52.73.161 with HTTP; Fri, 28 Feb 2014 01:07:55 -0800 (PST)
In-Reply-To: <a8cf74b4-bae1-4511-a45e-d4ca90e3c3e1@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242912>

This email was sent privately by Michael to me as a result of my
previous error. I'm quoting it in its entirety so that he doesn't have
to submit it twice.

On Thu, Feb 27, 2014 at 8:32 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Please forgive my typos and brevity; this was typed on a phone.
>
> Michael
> On February 27, 2014 5:16:40 PM CET, Jacopo Notarstefano <jacopo.notarstefano@gmail.com> wrote:
>>On Thu, Feb 27, 2014 at 12:18 PM, Michael Haggerty
>><mhagger@alum.mit.edu> wrote:
>>> What happens if the user mixes, say, "good" and "fixed" in a single
>>> bisect session?
>>>
>>
>>I don't think that's an issue. If the user uses the label "fixed"
>>instead of "bad" she will have a hard time remembering to use it every
>>time she needs it, and maybe the output of "git bisect" will look very
>>confusing, but what can git do? This is a semantic user input error,
>>not a syntax one.
>
> - git could emit an error message and refuse to continue
> - git could interpret the command one way or the other, with or without a warning
>
> By my count that gives at least five possibilities. The feature cannot be implemented without choosing one.
>
>>> I think it would be more convenient if "git bisect" would autodetect
>>> whether the history went from "good" to "bad" or vice versa.  The
>>> algorithm could be:
>>>
>>> 1. Wait until the user has marked one commit "bad" and one commit
>>"good".
>>>
>>> 2. If a "good" commit is an ancestor of a "bad" one, then "git
>>bisect"
>>> should announce "I will now look for the first bad commit".  If
>>> reversed, then announce "I will now look for the first good commit".
>>If
>>> neither commit is an ancestor of the other, then explain the
>>situation
>>> and ask the user to run "git bisect find-first-bad" or "git bisect
>>> find-first-good" or to mark another commit "bad" or "good".
>>>
>>> 3. If the user marks another commit, go back to step 2, also doing a
>>> consistency check to make sure that all of the ancestry relationships
>>go
>>> in a consistent direction.
>>>
>>> 4. After the direction is clear, the old bisect algorithm can be used
>>> (though taking account of the direction).  Obviously a lot of the
>>output
>>> would have to be adjusted, as would the way that a bisect is
>>visualized.
>>>
>>> I can't think of any fundamental problems with a scheme like this,
>>and I
>>> think it would be easier to use than the unfixed/fixed scheme.  But
>>that
>>> is only my opinion; other opinions are undoubtedly available :-)
>>>
>>
>>I like this idea! It also looks fun to implement. A minor difference
>>is that I'd rather die with an error on point 2) if there's no
>>ancestorship relation between the two commits; if the user is asking
>>for such a thing then she has a fundamental misconception of the state
>>of her repository.
>
> That is not correct. If there is a bug on one branch but not another, it is legitimate to ask when the bug was introduced, and git bisect can indeed handle this case today (think about how this could work, and try it!)
>
>>> By the way, although "git bisect fixed/unfixed" would be a very
>>useful
>>> improvement, and has gone unimplemented for a lamentably long time,
>>my
>>> personal feeling is that it has too meat in it to constitute a GSoC
>>> project by itself.
>>>
>>
>>Oh! Then in fact, as Christian Couder said, this project shouldn't be
>>marked as "easy".
>
> Sorry for the typo; I meant to say "too LITTLE meat".
>
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
