From: skillzero@gmail.com
Subject: Re: rebase --continue confusion
Date: Sun, 30 May 2010 17:14:36 -0700
Message-ID: <AANLkTinjyaIndGmu1yiJI_Nwbyq3pB5ef0w9BgDmDpeh@mail.gmail.com>
References: <4C01B855.7080409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dale Rowley <ddrowley@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 31 02:16:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIsgc-0000by-TL
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 02:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab0EaAOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 20:14:38 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:65123 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab0EaAOh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 20:14:37 -0400
Received: by gwaa12 with SMTP id a12so2303858gwa.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 17:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=r1S3rcvU1B3jXIDVFEftY7e9Qr6BWsxtPvGBYnNnNZU=;
        b=DkAK/hFlgGBJZG2/kXkt+aos3xWrUZCXo1wU2Yi171foODiSAnh1MnlybUG1OtGPbX
         X0GRUTTtJb40SRjwmK5rbb9loarGpY9N4FKFBW7+sVkW02YCCry0iayYuiZ0kX9dPMJO
         ZkIqeF4UPGGRgePA7K6INoud78vLpr4se/Z7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VXrnnyG1vN4ZkG2G9wXz+rsJ9y20FtviB+DNW5XH9Go7ua6HPpkW7EIt50D8r4FC1j
         tFgHv1Lk4Y7JlXTrbNm9FxU+7D4901REZEDpvbswPEQ4XJOvKX9eNTKC/1VIidfl7EKi
         ECYhOR8gbNm4Q5+eM2s3qZCyRiOz1c1OGaECo=
Received: by 10.91.204.19 with SMTP id g19mr1959303agq.144.1275264876586; Sun, 
	30 May 2010 17:14:36 -0700 (PDT)
Received: by 10.90.35.5 with HTTP; Sun, 30 May 2010 17:14:36 -0700 (PDT)
In-Reply-To: <4C01B855.7080409@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148029>

On Sat, May 29, 2010 at 5:59 PM, Dale Rowley <ddrowley@gmail.com> wrote:
> I ran into a conflict while running 'git rebase branch1 branch2'. So I edited
> the file and resolved the conflicts, and then ran 'git add <file>; git rebase
> --continue'. This printed out a message 'No changes - did you forget to use git
> add?'. I thought 'No, I'm pretty sure I ran git add' and I assumed I had run
> into a bug in git because I didn't see how this conflict was different than any
> others I had successfully resolved. The next time this problem came up, the
> light finally came on and I realized that I should just run 'git rebase --skip'
> because when I resolved the conflicts, I had basically undone all changes that
> the patch would introduce.
>
> OK, so there isn't a bug in git, but since then I've seen co-workers stumped by
> this same problem. So maybe it would help to clarify the message? Maybe
> something like "The index is in the same state as it was before the patch was
> applied - refusing to make an empty commit. Did you forget to use 'git add'? Or
> maybe you should use 'git rebase --skip'?"

I agree. I actually wasn't as smart as you when I saw that message in
the past. I didn't know what the problem was and I didn't know about
git rebase --skip (or I probably ignored it when I tried git rebase -h
since skipping didn't sound like what I wanted at the time, but thanks
for pointing it out if run into this in the future). I think I'd like
git to just skip automatically in this case.
