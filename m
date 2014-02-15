From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git GSoC 2014
Date: Sat, 15 Feb 2014 15:47:15 -0800
Message-ID: <CAJo=hJsk=m-R+pGf3rT+7BLBnAYsXd-xw-ztbjw4uHd_mO=-cQ@mail.gmail.com>
References: <20140213091037.GA28927@sigill.intra.peff.net> <87bnya8z6q.fsf@thomasrast.ch>
 <87d2iq58qk.fsf@fencepost.gnu.org> <87fvnk4ljl.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
	git <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sun Feb 16 00:47:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEoxc-0005SR-Qn
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 00:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbaBOXri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 18:47:38 -0500
Received: from mail-wi0-f176.google.com ([209.85.212.176]:40276 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbaBOXrh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 18:47:37 -0500
Received: by mail-wi0-f176.google.com with SMTP id hi5so1413501wib.9
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 15:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7aWs3FTBIq5wzDVdU+xlPne+HU0xEOFbxBFN0eeyA1E=;
        b=GWi4YKmzBQ/Da4BqTg5Vyt7eAHIAXx0e4at45BTInBZ7Oc3FJ/CTkKnXyLlm5j9d9A
         6wTpaqsz/JjJDCPDelOBmDCBUhktC+pWBE6djNmh2nQp6enhhIXrM5YfBpSN3xFjW9G0
         7VBaOwMdpJU4OShGcVtS9d7K8g8uoHzy608ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=7aWs3FTBIq5wzDVdU+xlPne+HU0xEOFbxBFN0eeyA1E=;
        b=HQ1MAi22Cz1kli/70mpA+5dSxLadrjIuFYoyIMJzA7WQOqobQjBcyRWdvQZTsNBH5n
         ZnXz24R6zGTKvMMlTNP8kztO8K3W/Hm26zgnCVTTR3rnrKqZAo7YJRBdfHbdT3QZBAdx
         PjcUEvn/TnygEsiw4YebvB2R26yJfFJH7mAndOlfuTJfh7FfY8ItUKzRpBPDz5h9yIAj
         NR6V74WY+5aeJdmnoJ/MSAJWTz9EddNrzM4fLyhA7gjBGleYOjFh1kq3hdEoy88FqE0O
         BHo6l+qiZ0YI1JMfphy1yFbeu/4yyLCzslBbJmRWmUReoTop3XUxuxOWtP1BfVvk4+t3
         CW9Q==
X-Gm-Message-State: ALoCoQlfEaRFruz5f909ktofW6RJgc/bNIMXcs2ReeDYG2GBevdlp5fV9bct5jiDhIsEwC1ZG/W5
X-Received: by 10.180.101.166 with SMTP id fh6mr7465872wib.2.1392508056199;
 Sat, 15 Feb 2014 15:47:36 -0800 (PST)
Received: by 10.227.7.132 with HTTP; Sat, 15 Feb 2014 15:47:15 -0800 (PST)
In-Reply-To: <87fvnk4ljl.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242202>

On Sat, Feb 15, 2014 at 4:17 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> David Kastrup <dak@gnu.org> writes:
>
>> Thomas Rast <tr@thomasrast.ch> writes:
>>
>>> Motivation: I believe that migrating to libgit2 is the better approach,
>>> medium term, than rewriting everything ourselves to be nice, clean and
>>> thread-safe.  I took a shot a while ago at making the pack reading code
>>> thread-safe, but it's adding mess when we could simply replace it all by
>>> the already thread-safe libgit2 calls.  It also helps shake out
>>> incompatibilities in libgit2.
>>
>> That would either require forking libgit2 for Git use or stop dead any
>> contributions to that rather central part of the git codebase from
>> contributors not wanting their contributions to get reused in binary
>> proprietary software.
>>
>> It would also mean that no serious forward-going work (like developing
>> new packing formats or network protocols) can be done on a pure GPLv2
>> codebase any more.  So anybody insisting on contributing work under the
>> current Git license only would be locked out from working on significant
>> parts of Git and could no longer propose changes in central parts.
>>
>> Now this can all be repealed by the "developing the atomic bomb does not
>> mean that one has to use it" argument but even if one does not use it,
>> the world with and without it are different worlds and occupy mindshare
>> and suggest "solutions" and "diplomacy" involving it.
>>
>> So this is definitely a large step towards a situation where erosion of
>> the existing license and related parts of the community becomes more
>> attractive.
>>
>> There is the rationale "we can always say "no" at the end".  How do you
>> explain this "no" to the student who invested significant amounts of
>> work into this, in a project proposed by the Git developers?
>>
>> This definitely should not be "we'll think about it if and when that
>> project is finished" material.
>
> Yes, all of this is true.  However, you are painting a big devil on the
> wall.
...
> Second, how many contributions would actually have been prevented by
> GPLv2+LE licensing?

Interesting data point, I helped get libgit2 started in the first few
days of its existence and discussed the license on the mailing list. I
eventually stopped contributing, partly because of the GPLv2+LE
license it uses.

:-)

I am not as interested in using the GPL for my work as David Kastrup
is, but I wasn't really thrilled with GPLv2+LE.
