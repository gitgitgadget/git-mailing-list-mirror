From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Prompt for merge message?
Date: Thu, 6 Oct 2011 15:09:26 -0700
Message-ID: <CAJo=hJvFytscxyx2z+Fdw9E1DS02wSXgoE3SHkxKq2OYOMQHgQ@mail.gmail.com>
References: <6eb7acc7-f4be-4b90-a2fa-a0c91ed9a5a8@t11g2000yqk.googlegroups.com>
 <7vsjn5ye0x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Todd A. Jacobs" <nospam+listmail@codegnome.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 00:09:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBw8W-0001aR-Ea
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 00:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935889Ab1JFWJr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 18:09:47 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39840 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935612Ab1JFWJq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 18:09:46 -0400
Received: by ywb5 with SMTP id 5so3067016ywb.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 15:09:46 -0700 (PDT)
Received: by 10.42.247.195 with SMTP id md3mr7791351icb.46.1317938986070; Thu,
 06 Oct 2011 15:09:46 -0700 (PDT)
Received: by 10.42.4.68 with HTTP; Thu, 6 Oct 2011 15:09:26 -0700 (PDT)
In-Reply-To: <7vsjn5ye0x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183044>

On Thu, Oct 6, 2011 at 15:02, Junio C Hamano <gitster@pobox.com> wrote:
> "Todd A. Jacobs" <nospam+listmail@codegnome.org> writes:
>
>> I often find myself using "--no-ff -m foo" for merging short-lived
>> branches, because the merge commit usually needs to say something
>> about having finished a feature rather than referring to a branch th=
at
>> will be deleted shortly anyway....
>> ... Is there currently a way to get git to prompt for the merge mess=
age,
>> rather than using the default or requiring the -m flag? If not, isn'=
t
>> this a common-enough use case to have that ability added to the merg=
e
>> function?
>
> Others commented on the current practices and gave their own useful t=
ips
> already, but an additional hint is to name your branch more sensibly,=
 so
> that you do not feel it is useless to record it in the history.
>
> As to a real longer-term solution, I wouldn't mind a patch that teach=
es
> "git merge" an "-e" option just like "git commit" has.
>
> =A0 =A0$ git commit -m "Finish frotz feature" -e -a
> =A0 =A0... editor opens with the first line filled already here ...
>
> is something I find myself using fairly often.

What about adding something like:

  if (isatty(0) && isatty(1) && isatty(2)) {
    do_interactive_commit();
  }

to git merge? I know the reason we don't want to do it all of the time
is because git merge is already used in a lot of scripts. But how many
of those are running with an active terminal on all 3 standard fds
when it runs git merge?
