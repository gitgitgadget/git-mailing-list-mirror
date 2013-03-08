From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Adding "--ignore-submodules" switch to git-describe
Date: Fri, 8 Mar 2013 21:04:30 +0100
Message-ID: <CAC9WiBhHmqn7QZMLFcLjqGPamHmbMFNxvQ6Yzv5dr=+fe+F3_g@mail.gmail.com>
References: <CAC9WiBjHEoX154Y2q1NxEB1my78Gqf__+v-KR5jNVqT-MN9ZaQ@mail.gmail.com>
	<7v621bggi5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 21:04:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE3XF-0005xu-KM
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 21:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab3CHUEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 15:04:31 -0500
Received: from mail-ve0-f176.google.com ([209.85.128.176]:64440 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab3CHUEb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 15:04:31 -0500
Received: by mail-ve0-f176.google.com with SMTP id cz10so1527484veb.35
        for <git@vger.kernel.org>; Fri, 08 Mar 2013 12:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=gD9Q5UIKue9oyAvv/9UodEMz66tqGzj8KMlu25aEkNQ=;
        b=jnyBQeHfuZZ2+vwej9xVeB13Qjm0PMUss16oelP39qs4KiAICRQnbGPsCcVk65pcxv
         rs+DUpvkm0zPr+YmAVrXRPW1DGdTOzaHJfxhSUCwDRD0ZVDp1i43nucjxz96cOk7uEDa
         OiXhe30fflx3i18wixXdyVDtSUjE93E7brY2E+Qt9nNE9alpD7SrTvMvcY2GCvc4w17x
         JGE0PLjJz/TY86vYDRtL+lk3KxR1yPTt9iBx+C8LuqnljKeFIHy0yftt96jsNb55LPAD
         hEFkBdUIkXhqfA/2M4863fFzFl6aBJ/95JyWgOSZHxzFWeAKTnVhSXVtDBzAl5Ix/2OE
         NtpA==
X-Received: by 10.52.90.39 with SMTP id bt7mr1232856vdb.110.1362773070492;
 Fri, 08 Mar 2013 12:04:30 -0800 (PST)
Received: by 10.59.3.229 with HTTP; Fri, 8 Mar 2013 12:04:30 -0800 (PST)
In-Reply-To: <7v621bggi5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217680>

Hi,

Sorry for the long delay, I somehow missed your answer...

On Fri, Mar 1, 2013 at 6:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Francis Moreau <francis.moro@gmail.com> writes:
>
>> Would it make sense to add the option --ignore-submodules (currently
>> available in git-status) to git-describe when the later is used with
>> --dirty option ?
>
> I think the spirit of "describe --dirty" is to allow people who
> gives out binaries this assurance:
>
>         The version string I got out of "describe --dirty" does not
>         say dirty. If the recipient of the binary later reports
>         issues, I should be able to reproduce the same binary by
>         starting from a pristine checkout of the version (provided
>         if I didn't screw up and depended on an untracked file when
>         I initially created the binary, or used a custom build
>         option, or lost the toolchain, ..., of course).
>
> With that in mind, does --ignore-submodules make sense?

Well, I wouldn't have thought about this definition of "describe
--dirty". I would have thought that, by default, this command look
only at the files that git knows/tracks. There're too many external
(to the git repo) parameters that could influence the build of a
project: environment variables, components of the toolchain, version
of each components etc... that git doesn't know about.

[...]

>
> But when we ignore untracked paths in the superproject, we should
> ignore untracked paths in submodule working trees consistently.
>
>

yes I agree.

But in the short term, could you suggest a method to workaround this
inconsistency ?

Thanks.
-- 
Francis
