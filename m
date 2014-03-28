From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/8] ls-files: support --max-depth
Date: Fri, 28 Mar 2014 21:15:21 +0700
Message-ID: <CACsJy8DtW_uUf+G4krc5=EPATNRST3aG9o-bhE34Yb7pw_dXSQ@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395310551-23201-8-git-send-email-pclouds@gmail.com> <1457323768.788823.1395737758945.JavaMail.zimbra@imag.fr>
 <CACsJy8Awu6oNOS-m5_DNh_HGeHKgcnowUY+iz4efo3s1HYycnQ@mail.gmail.com> <vpqtxaiqvl9.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 28 15:16:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTXZf-00080U-1G
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 15:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbaC1OPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 10:15:53 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:58339 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbaC1OPw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 10:15:52 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so5254066qaj.21
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=j0f0YvbV06gdWHyKek4TDu+WFivbawmlDqrhJq1oznA=;
        b=Qo8scNe+FebQfqwu9HML2BuOA1jpGTemnahOK10eB/ddGGAtDYMz8Pd2ggszafJg8x
         l2dJftbkayy1ZTucGVMlZobsluuXy7stetMpHb0kmJJzHIvhIQpSeZ8lBRld09UIGDZZ
         BMlbrxWhBwQ6fwexXhRWRhK9nnpDgAHZXoQqWhnj9crieYUt4v+QNJ8Q0r/NKv4dlMzf
         leG986JDs+RpS+vBHckvn41tJBvpnBXnex9zoUXDUklf+NOiUpQY+cgZp9I+vue4hv5e
         viwEgsanzLh8vYlShp/x37rUInMOM2sZ7rd+Y1hUtzawWDPyr+h51irwd00yp5A4eO84
         Ecgg==
X-Received: by 10.224.130.9 with SMTP id q9mr2214179qas.89.1396016152100; Fri,
 28 Mar 2014 07:15:52 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Fri, 28 Mar 2014 07:15:21 -0700 (PDT)
In-Reply-To: <vpqtxaiqvl9.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245389>

On Fri, Mar 28, 2014 at 8:52 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> I'd rather go with no trailing slash by default and add -F (which
>> seems to be more than just '/')
>
> ... and then add a configuration variable to let users enable it by
> default.
>
> For GNU ls, I have "alias ls='ls -F --color=auto'" in my shell's
> configuration, but I cannot push the analogy by aliasing "git ls"
> because Git doesn't allow aliasing existing commands.

I can do that but I want to push for a general solution instead
of ls-only. How about config key defaults.<cmd>, containing a list of
arguments, that will be prepended to git-<cmd>? Only some commands are
marked to support this by adding USE_DEFAULTS in the array commands[]
in git.c. And "git --no-defaults <cmd>" will ignore defaults.<cmd> (or
"git -c defaults.<cmd>= <cmd>" but it's less obvious). GIT_NO_DEFAULTS
can also be set, which has the same effect for all commands.
-- 
Duy
