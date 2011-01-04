From: Alexander Gladysh <agladysh@gmail.com>
Subject: Re: False positives in git diff-index
Date: Tue, 4 Jan 2011 14:46:54 +0000
Message-ID: <AANLkTikD5znEPTqR-UeLsusV6sj80vO0dOPuK9QDN6LW@mail.gmail.com>
References: <AANLkTimLW+J_rmRsqUQJO-9Gzn7aK0ZHkd1-s=Wg4Vbi@mail.gmail.com>
 <AANLkTinDSCPz-oukxzn24hj94d9WpzZ8_64TBHeNTmoG@mail.gmail.com>
 <AANLkTi=Po7zA1YG-VdN6cZEV+ZF3GYNM9W9CLVXFaE5Z@mail.gmail.com>
 <AANLkTinfbyve-k8xBzDb1sTcXhJGvL_B+auuA8BQSUy2@mail.gmail.com> <m339p8dap4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 15:47:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa8AZ-0007BV-PI
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 15:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017Ab1ADOrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jan 2011 09:47:19 -0500
Received: from mail-qw0-f66.google.com ([209.85.216.66]:47803 "EHLO
	mail-qw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab1ADOrS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jan 2011 09:47:18 -0500
Received: by qwk3 with SMTP id 3so4654964qwk.1
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 06:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dMjNkP4dlZGH+EgkQ3JGVENO4nun7b4IgAI30+77oOU=;
        b=IXqTbTigfP+PavJBo9QvpvHver0W+ZYmMNdKoUbxFNgdLC4q3L0kaxnSyMYnGrE9Im
         ux92dosijpa3pkw2HivyogB4SEZNJorPR2h1PJqGESc4YsfDvfc6H2r3Te+Pgd10l9d+
         3zO0Rzq/ubkIx7G50G9YqVgmTFFwzdNdJUw1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JNEkCU7ymlWWhL9dUNJjVClJmLRRC+15Yi94kyIVlbulFbRiEvsx5qx2hOT43BWQrh
         BWEr5hBfFc3agVpuXa0QHrIUj1XHSf8vtDWnR3gC0uHpVktkaY9wl99zdFn3Vzstvuha
         gE6AL8AWYzmojHLRnPlE3NVDL/MPa2OBoFdO0=
Received: by 10.229.182.11 with SMTP id ca11mr11624663qcb.15.1294152435010;
 Tue, 04 Jan 2011 06:47:15 -0800 (PST)
Received: by 10.229.48.5 with HTTP; Tue, 4 Jan 2011 06:46:54 -0800 (PST)
In-Reply-To: <m339p8dap4.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164495>

On Tue, Jan 4, 2011 at 14:08, Jakub Narebski <jnareb@gmail.com> wrote:
> Alexander Gladysh <agladysh@gmail.com> writes:
>> On Tue, Jan 4, 2011 at 14:47, Zenaan Harkness <zen@freedbms.net> wro=
te:
>> > On Tue, Jan 4, 2011 at 20:45, Alexander Gladysh <agladysh@gmail.co=
m> wrote:

>> > So your problem could be quite hard to debug, whilst being distinc=
tly
>> > difficult to ascertain the root causes.

>> 1. I found a reproducible case for a hard to catch bug in Git. (This
>> is a bug in Git, not in my build process.) This bug in its
>> intermittent form annoyed me for quite some time =E2=80=94 several m=
onths at
>> least =E2=80=94 and is likely to annoy other users. (I'm not *that* =
unique!)

> But it is reproductible to you: from what I understand you didn't fin=
d
> some minimal example to reproduce this issue without need for access
> your proprietary build process.

> AG> Unfortunately I can not share it or create a minimal example ? th=
e
> AG> case is triggered by a custom complicated automated build process=
 on a
> AG> private repository.

Yes, that is true. Still, much, much better than intermittent.

>> 3. I'm willing to help Git developers with catching this bug for
>> mutual benefit =E2=80=94 I will get rid of annoying issue and make m=
y
>> deployment code more robust. Git will, well, be a bit more robust as
>> well.

> To debug it, if you cannot do it yourself, you would have to find git
> developer who is both knowledgeable about fairly deep part of git
> code, and can work with remote debugging with you at remote.

I understand that. But is the second part of requirement is such a
large problem?

Anyway, as I said, if no one will step up, no problem.

> P.S. Somewhere in the depths of git maling list archive (it didn't
> unfortunately made it to "Interfaces, Frontends and tools" page on gi=
t
> wiki) there is tool/script for anonymizing git repository, to allow
> debugging of bugs which occurs in some repositories that cannot be
> made public. =C2=A0Perhaps something similar could be done for your b=
uild
> process (you need to reproduce only stat + git part)?

I remember, somebody advised me to use this tool, when I reported some
bug some time (maybe a year) ago.

But, I'm afraid, I do not know how to separate my deployment tool
logic (which reproduces the bug) from the repository data. If I did
know, I'd come up with a minimal example already. Nothing trivial
"along the lines", that I tried so far, does reproduce it.

Alexander.
