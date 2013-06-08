From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 21:10:55 +0700
Message-ID: <CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
 <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
 <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
 <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
 <CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
 <CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
 <CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
 <CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com> <CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 16:11:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJre-0002Ie-Ge
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 16:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab3FHOL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 10:11:26 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:40747 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3FHOL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 10:11:26 -0400
Received: by mail-oa0-f48.google.com with SMTP id f4so427747oah.21
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0IG054csyf2CFJqdyW0hvSdyOc0qmHW3t5qFUkpxDF8=;
        b=tga5tryupgsfIoGeGkSooPt1ToTpLfSLDpcEPUeCYwt9haVkTFloqxI49XBh3bqjn5
         Es7dF+fRZWP7BPswKNnH7+aDsVIhaV0cHwm+wQPushrs1bxicmDkO+RwebNGualS/U+5
         BPcLfvo1CEzI5YEBtzC+OYBYwptsfrr4VOtyvQ8kJ9cKUe2jFLnJiSTN2dA2t1Md+c4l
         pHJ/GSoos9v+lpa4yHI0Fj60licNDZ8RRfxsDHePMx//5pfST5Csg83LyIFNajo1M104
         cFzoTzNoSfwqGackyAKtqBd5to2A6bM8AkBDJ5s3wvkGkbBZwADs/AFl4Hj/N5wyUkl2
         emUw==
X-Received: by 10.182.46.230 with SMTP id y6mr2322431obm.79.1370700685662;
 Sat, 08 Jun 2013 07:11:25 -0700 (PDT)
Received: by 10.76.76.69 with HTTP; Sat, 8 Jun 2013 07:10:55 -0700 (PDT)
In-Reply-To: <CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226829>

On Sat, Jun 8, 2013 at 8:34 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> I'm not saying that we can convert libgit.a into something that's
> usable as a long-running process by production servers tomorrow.  All
> I'm saying is that it might be possible to get ruby (and possibly
> other languages) to call into git-core, to make scripting more sane
> than shell-spawning everything like brutes.  I think this is what fc
> is aiming at, atleast in the foreseeable future.

It's technically possible. You can already call into libgit.a as fc
demonstrated with his ruby binding. Assuming that you are willing to
dig in and fix all the problems (in a non-intrusive way) when a call
into libgit.a does not work, there's still API issue. Do we want to
freeze libgit.a API so that scripts will not be audited and changed
unncessarily? Freezing the API at cmd_* level loses a lot of
flexibility. Freezing at lower level may prevent us from making some
changes. I still think that binding new languages to a clean library
like libgit2 is better than to libgit.a. Just thinking of what might
work and what might not is already a headache.
-- 
Duy
