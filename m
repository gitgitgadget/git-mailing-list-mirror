From: Roy Lee <roylee17@gmail.com>
Subject: Re: How to add daily tags for a central repo?
Date: Tue, 1 Jun 2010 17:45:16 +0800
Message-ID: <AANLkTinpmkLhbBeqtdK9auG6NfqEsHqPWhrpUL18nFsG@mail.gmail.com>
References: <1275369711233-5124575.post@n2.nabble.com>
	<4C04AC1E.7040502@drmicha.warpmail.net>
	<AANLkTim02FQ3BfV88iylMqbHA5sBbJvp5TmWg52OXCzn@mail.gmail.com>
	<4C04BF33.70300@drmicha.warpmail.net>
	<AANLkTinHU5z5njEpx1S_6DIR5ECauJbzWlcM95wNUVxf@mail.gmail.com>
	<4C04CA4F.40106@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 01 11:45:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJO2G-0002sK-OU
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 11:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265Ab0FAJpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 05:45:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62799 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab0FAJpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 05:45:17 -0400
Received: by gye5 with SMTP id 5so939222gye.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=yQxbVfPd3xP144+/XPPQdD+2Ni/k8rPylJoy1P0yd68=;
        b=tM/Hd9bm5zk0JRdJC6Hen0KjpiJncM/ph+SgsAVQE01DQNv6MBLtUXl9Lv513zpTVG
         /aakvig8uJzf2fMiRsklUs3Lpb+JCKYndHPdWhuq5UFKQou1MMYVYPpAIx90gUm3PvqX
         77AK0TCwpgV62fl5/pzQvv/JY6+5J7q63sREY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YBuj88kNWtADZdm5Snhyx9QeI+VtJxoqdpWaKb7FpbgIgDsHQaaIio29f21uaJSA16
         GE6StU6kAUK5r3mCmRWakcO80HY2RSzfX9uthZjGyFJJKiEdLVkti93NrTCeLarwTluP
         X6ZDWTi7GTBEkIQeRgHx5ml1gn06Az7y54TtQ=
Received: by 10.42.4.139 with SMTP id 11mr5651693ics.30.1275385516461; Tue, 01 
	Jun 2010 02:45:16 -0700 (PDT)
Received: by 10.231.33.69 with HTTP; Tue, 1 Jun 2010 02:45:16 -0700 (PDT)
In-Reply-To: <4C04CA4F.40106@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148103>

On Tue, Jun 1, 2010 at 4:52 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Roy Lee venit, vidit, dixit 01.06.2010 10:25:
>> On Tue, Jun 1, 2010 at 4:05 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Roy Lee venit, vidit, dixit 01.06.2010 09:55:
>>>> Hi Michael,
>>>>
>>> Well, as I wrote: HEAD@{datetimespec} for the HEAD,
>>> branchname@{datetimespec} for a branch "branchname". datetimespec is
>>> decribed in git rev-parse's manpage but can be what you'd think (e.g.
>>> "date time") and more ("yesterday").
>>> If you really want to inspect the reflog (not the commits listed in the
>>> reflog) use "git log -g" or, unsurprisingly, "git reflog".
>>>
>>>> Or any alternatives for developer to query this information.
>>>
>>> The reflog is local to the repo, which is why you would create tags on
>>> the central repo based on the reflog there, if that is your "trusted
>>> time and push reference source".
>>
>> Does this mean the tagging must be done on the server?
>
> Yes.
>
>> Is there any way to query this information from a client repo,
>> do the tagging locally, and than push the tag back to the server?
>
> No.
>
> This answer assumes that what you want to do is the following:
>
> * Create a tag for the state of a ref (such as HEAD) on the central repo
> at a specific date and time.

Yes, for the daily build stuff.

> No client can know this. Reflogs are local. The point of your tagging
> (as I understand it) is to create an authoritative date based tag, and
> only the central repo has the necessary info.
>
> If you want to do something different you should say so ;) But note that
> committer and author dates are completely bogus from the point of view
> of "was in the central repo at a certain date", they have nothing to do
> with that.
>
> Michael

I've been using reflog locally for some time, but never thought that
it could be used in this way -- combining with timespec to get the
timestamps of updates to the server. :)

The only problem now is that the tag creator might not have the access
to shell on the central server. To grant the shell access for the tag creator
may be a quick way to circumvent this. But I think I'll try if git can export
the reflog to the client in a native way or with some trickery.

Thank you so much, Michael.

Regards,
Roy
