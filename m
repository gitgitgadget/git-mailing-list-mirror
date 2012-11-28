From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] svnrdump_sim: start the script with /usr/bin/env python
Date: Wed, 28 Nov 2012 09:03:10 +0100
Message-ID: <CAMP44s17Gycr2tWOLYAxMG7-CGP3SpFf7XTWf94qGg3WfVpT-A@mail.gmail.com>
References: <20121128025734.21231.47468.chriscool@tuxfamily.org>
	<7vy5hmgovt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 09:03:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdccB-00024S-0X
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 09:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357Ab2K1IDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 03:03:11 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34550 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab2K1IDK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 03:03:10 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so7767010vbb.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 00:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hH/NlxXtZo2geYiUh+ACElrpx3COC40xPVMZQb4bYD8=;
        b=epIRvjMb1fWD9g0Uwn0BUVuRy8TafSdMD42CWBy2SbDhWDYvX4lvNkk3fEeW6Jpiua
         5I9aNOvGTCNg1xeuvHIvS6GrieWqGcXxmG3TkQGDnTjFLes7YtBQaoLpaxxvDOO1au4c
         aR1t34rNgxhjSDzAKMr2ift/zfdq99FAKncQcCIAlQTt1xrjmmSH/M/O1+RBO4QMy3tX
         QqGbNYrMtCrg0lzS9yRQSEgfV62aFmVeqQjYr4rsKrpRfhJOBfuUsM70/WfypWY767KS
         TKMBcmaJ6i0JPwdWXpdjufaOFNgahckgc4sC7wIihAK6gQbVNSo8aYBJ3LcDdiD9nHU5
         v+OA==
Received: by 10.58.180.7 with SMTP id dk7mr28790296vec.30.1354089790117; Wed,
 28 Nov 2012 00:03:10 -0800 (PST)
Received: by 10.58.34.51 with HTTP; Wed, 28 Nov 2012 00:03:10 -0800 (PST)
In-Reply-To: <7vy5hmgovt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210718>

On Wed, Nov 28, 2012 at 8:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> All the python scripts except contrib/svn-fe/svnrdump_sim.py
>> start with "#!/usr/bin/env python".
>>
>> This patch fix contrib/svn-fe/svnrdump_sim.py to do the same.
>
> I suspect you need a bit more than that.
>
>     $ make git-p4
>     $ diff -u git-p4.py git-p4
>
> shows you how we tell the scripts how to find their interpreters
> (that way, there is no need to rely on the existence of
> /usr/bin/env).

That works if somebody managed to export PYTHON_PATH, which very very
often is not the case for me.

./git-p4
zsh: ./git-p4: bad interpreter: /usr/bin/python: no such file or directory

In this case git-p4.py is correct, and git-p4 is not.

Either way, this is for contrib, and we don't have a standard
procedure for python scripts there. /usr/bin/env is better than
nothing, and in the vast majority of cases, more than enough.

Cheers.

-- 
Felipe Contreras
