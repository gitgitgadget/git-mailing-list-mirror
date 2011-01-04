From: Alexander Gladysh <agladysh@gmail.com>
Subject: Re: False positives in git diff-index
Date: Tue, 4 Jan 2011 12:45:33 +0300
Message-ID: <AANLkTinDSCPz-oukxzn24hj94d9WpzZ8_64TBHeNTmoG@mail.gmail.com>
References: <AANLkTimLW+J_rmRsqUQJO-9Gzn7aK0ZHkd1-s=Wg4Vbi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 10:46:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa3Sq-0004XM-SH
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 10:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840Ab1ADJpz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jan 2011 04:45:55 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44457 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab1ADJpy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jan 2011 04:45:54 -0500
Received: by qwa26 with SMTP id 26so14290508qwa.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 01:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9w+cMwuRW7skSjtKfCbv9GJgGP7BWLdW3saRmZ7O8eE=;
        b=PqIouXcgTRR1rR6TiGm9yMVWJAExV7kN7GjhD3by0R87GH0Ors8CbU6YdTLFjITo8S
         rdlY1r5AKov1GhIuMqIlR73YNKP6EtyBlc87UUVE1fFqcViee3NwSTJKYzVXMJvGnJiM
         DRmDAab2Djgm5Ncmv9GlkH3ZraV4yKD6OwzBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Js+EyguvSDP4cgZdnfmpUiu3NLR49jKyZhmtG58onksX3YlE7i+YABUHfGWQukS6bT
         NPzrCa1w4jJXfPi3oc3k2yuMBQSZOIDlU/R3CoWNgY72HniuKOCViN8I4ysEWLeFKc94
         MonM4cZQoHWtmDgMT90i8VmXx0JcL5ccFnHEo=
Received: by 10.229.95.211 with SMTP id e19mr19096050qcn.53.1294134353261;
 Tue, 04 Jan 2011 01:45:53 -0800 (PST)
Received: by 10.229.48.5 with HTTP; Tue, 4 Jan 2011 01:45:33 -0800 (PST)
In-Reply-To: <AANLkTimLW+J_rmRsqUQJO-9Gzn7aK0ZHkd1-s=Wg4Vbi@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164481>

Nobody is interested?

Is there a way I can get some help with this issue?

Thanks,
Alexander.

On Mon, Dec 27, 2010 at 11:49, Alexander Gladysh <agladysh@gmail.com> w=
rote:
> Hi, list!
>
> I wrote about the related issue earlier:
>
> http://lists-archives.org/git/731516-false-positives-from-git-diff-in=
dex-when-used-with-git-dir.html
>
> Now I've got a case when I can reproduce this problem each time I try=
 to.
>
> Unfortunately I can not share it or create a minimal example =E2=80=94=
 the
> case is triggered by a custom complicated automated build process on =
a
> private repository.
>
> Anyway, I'm ready to debug this issue if someone will guide me.
>
> Workflow:
>
> <...change files in /path/dir1/...>
> (cd /path && git add </path/dir1/>)
> (cd /path && git commit -m <message1>)
>
> ... repeat change-add-commit several times for various directories
> (can be the same directory or not) ...
>
> <...generate file /path/dirN/foo...>
> # Accidentally the file is generated the same as it was
>
> (cd /path && git add </path/dirN/>)
> (cd /path && git status) # Refresh index
> (cd /path && git diff-index --exit-code --quiet HEAD -- /path/dirN) #
> Incorrectly reports that there are some changes
> (cd /path && git commit -m <messageN>) # fails, saying that there is
> nothing to commit
>
> If I insert sleep 10 between git status and git diff-index, the
> problem goes away.
>
> Any help?
> Alexander.
>
