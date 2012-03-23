From: Hitoshi Mitake <h.mitake@gmail.com>
Subject: Re: [PATCH v0 0/2] git-less: a specialized pager for git-log
Date: Sat, 24 Mar 2012 02:15:16 +0900
Message-ID: <CAMO-S2gUaek83ACtLLBsLFYBpHuj=ePZRPzEPav+uP6igjN7oA@mail.gmail.com>
References: <1332441744-5142-1-git-send-email-h.mitake@gmail.com>
	<7v1uokxxzh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 18:15:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB85G-0002D3-M7
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 18:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759291Ab2CWRPW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 13:15:22 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34305 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759206Ab2CWRPR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2012 13:15:17 -0400
Received: by qcqw6 with SMTP id w6so2144630qcq.19
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 10:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tvOoEtPUQAC2i3cSInrDApf4FaVGh42QPxShDm6CcqY=;
        b=iFqM3pfvhw8j7lIKJpjapRxnUxOqVXF0+dd8KpivvT3f9wXGoEivXvzgc2ZZvh1S+Y
         r3lKr7G+bPm3PLK9fFwKDEKVdot/vzEOHWNbZY3CIqgRwZ7vkMi66y8KcloeGFJcIY4p
         e/FVZmOtMJunzXG36ujB/s4NMIeIb+W4OHHqia1Q14YCwlqapVmWiOZAJ5Ney6UzbDZy
         dzicKceasuJ3rRezYepafMbLEmiL6634sXUY1IfclNqTKq1JGN6xzKWiTHVBJ7/XPwCL
         AYLTHZkzksa1F/Ls1N5Ipu0hiZ55bFHXANyTq/kO0utadCqmoPF38fK+3pRz1A1/ZLTG
         kf0A==
Received: by 10.224.173.72 with SMTP id o8mr16736076qaz.76.1332522916961; Fri,
 23 Mar 2012 10:15:16 -0700 (PDT)
Received: by 10.229.169.137 with HTTP; Fri, 23 Mar 2012 10:15:16 -0700 (PDT)
In-Reply-To: <7v1uokxxzh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193773>

On Fri, Mar 23, 2012 at 04:00, Junio C Hamano <gitster@pobox.com> wrote=
:
> Hitoshi Mitake <h.mitake@gmail.com> writes:
>
>> If the pager can recognize the end of each commit, more confortable =
viewing of
>> git-log's output will be possible.
>
> I think people just use "/^commit .*<RET>" once and then nagivate wit=
h "n"
> (and to change direction, "?<RET>") for this.

Yes, but less cannot search regex with specified range of text
(in this case, from the beginning to the end of the commit).

>
>> For implementing this feature, I had to make modification of git-log
>
> I do not think the change to "log" is necessary nor worth it. =A0If t=
he
> pager is so specialized to be tied to git, it should learn to recogni=
ze
> the output from "git", namely, "git log" and "git log -p" would never=
 have
> a line that begins with "^commit " that is not the beginning of one r=
ecord
> for a commit.

This rule is useful for detection of each commit from pager. I didn't
have to modify git-log... With this rule, the pager can be independent =
from
the tree of git, thanks!

>
> If you are not comfortable using "less", perhaps a program like "tig"=
 that
> is very specialized for working with git might help you better.
>

Thanks for your information. I didn't know about tig. I'd like to test =
it or
modify my pager for more comfortable git-log viewing.

Thanks for your feedback,
--=20
Hitoshi Mitake
h.mitake@gmail.com
