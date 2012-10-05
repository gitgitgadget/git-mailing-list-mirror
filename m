From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Ignore on commit
Date: Fri, 5 Oct 2012 12:44:48 +1000
Message-ID: <CAH5451ki_JFntWZwxcUqvWKwZn62Vfg=MkF3xwiX1p3ARULQfA@mail.gmail.com>
References: <CAKRNd4w4Z-LS9O5ffkbTSZ0Guv4KCmWR=AtW3EpxQ2sSgazG=Q@mail.gmail.com>
 <506DEC50.7090402@obry.net> <CAKRNd4wbT_boRyFOOL_95FBW4ws8Zzz2ubVCfXuRSevzPdhW9g@mail.gmail.com>
 <CAH5451mpJw4+noUF+FkZJS+Y2oq2ThFeG7wSOCdbVaMQPNgUJA@mail.gmail.com>
 <CANgJU+XSYWObCsGVnWwaaSB9iZQnfU_y095uzEm5-YXMaUoU_w@mail.gmail.com> <CAMK1S_jfdW3BepELgPPoUf3qWwmU-o3o8OpMVimdfkERUJkymQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: demerphq <demerphq@gmail.com>,
	Marco Craveiro <marco.craveiro@gmail.com>, pascal@obry.net,
	git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 04:45:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJxul-0005T7-6E
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 04:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775Ab2JECpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 22:45:11 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:39679 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756650Ab2JECpK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 22:45:10 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so754186wey.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 19:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GmpWazdM8FzbSY62OJh2lJMhE4ijkAJO1NxBOX24etU=;
        b=bTAfPMQe5pr9lKku6OIFURa+L9YG1PlDc59EEkw8wke+6Re04taL7Aufv+1RlIepad
         qCIlPKgGIOb2I4hFropguX2ogedyrQZ+xVw66qdi3NJGJDxg/3mXwJSqQjYP08LC3cye
         NASecDfP6n8mFARv5u5V4h2+xDLklOzDRqen9aN9H+LRo821d2YGQG+B44MlOLg/DJz7
         Sx713P8kr2eKS0Y4z9SmlTdHE6S+om3nO4Bm9sec2mKjxkWF3p2lpRq2+PD4WqfQ/2BY
         sa5sh5w0bGcZHGJ9tXy/WuY5VN+YDC2W3ibQNmNPEqWFwCPthvdTZ79tJQR1d79kUUi7
         Ae3Q==
Received: by 10.180.93.33 with SMTP id cr1mr42397727wib.8.1349405108368; Thu,
 04 Oct 2012 19:45:08 -0700 (PDT)
Received: by 10.216.231.169 with HTTP; Thu, 4 Oct 2012 19:44:48 -0700 (PDT)
In-Reply-To: <CAMK1S_jfdW3BepELgPPoUf3qWwmU-o3o8OpMVimdfkERUJkymQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207066>

On 5 October 2012 12:20, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On Fri, Oct 5, 2012 at 7:05 AM, demerphq <demerphq@gmail.com> wrote:
>> On 5 October 2012 03:00, Andrew Ardill <andrew.ardill@gmail.com> wrote:
>>> On 5 October 2012 07:20, Marco Craveiro <marco.craveiro@gmail.com> wrote:
>>>> ...
>>>> Similar but not quite; the idea is that you know that there is some
>>>> code (I'm just talking about files here, so lets ignore hunks for the
>>>> moment) which is normally checked in but for a period of time you want
>>>> it ignored. So you don't want it git ignored but at the same time you
>>>> don't want to see these files in the list of modified files.
>>>
>>> What is the reason git ignore is no good in this case? Is it simply
>>> that you can't see the ignored files in git status, or is it that
>>> adding and removing entries to .gitignore is too cumbersome? If it's
>>> the latter you could probably put together a simple shell wrapper to
>>> automate the task, as otherwise it seems like git ignore does what you
>>> need.
>>
>> Git ignore doesn't ignore tracked files.
>
> would 'git update-index --assume-unchanged' work in this case?  Didn't
> see it mentioned in any of the replies so far (but I have never used
> it myself)

>From the help page:

--assume-unchanged, --no-assume-unchanged
    ...

    This option can be also used as a coarse file-level mechanism to
ignore uncommitted changes in tracked files (akin to what .gitignore
    does for untracked files).

Seems like it does everything required. I tested and it correctly
hides changes that I want hidden. The only thing I can't see how to do
is get git status to show files with the assume unchanged  bit set. I
think there is no way currently, but that might be a nice addition to
make the initial request feature complete. It could show either all
files with the bit set, or files with the bit set that have been
changed (or this could be configurable).

Regards,

Andrew Ardill
