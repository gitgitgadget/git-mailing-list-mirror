From: Luke Hutchison <luke.hutch@gmail.com>
Subject: Re: git leaves repo in bad state in out-of-space situation
Date: Sun, 17 Apr 2011 15:09:18 -0400
Message-ID: <BANLkTimVBVwz7c4=U0-zHhAWztewWYs7Qw@mail.gmail.com>
References: <BANLkTi=4EvRZK_bK=JrwiZgfaeHvNgj-dQ@mail.gmail.com> <BANLkTim4=eKQ2wq73Lf5zrjOND-r1n0XCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 21:10:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBXMC-0000oC-1O
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 21:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326Ab1DQTJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Apr 2011 15:09:59 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58519 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292Ab1DQTJ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2011 15:09:58 -0400
Received: by pvg12 with SMTP id 12so1838564pvg.19
        for <git@vger.kernel.org>; Sun, 17 Apr 2011 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Aid+grpO+7Cw30RLPK/MqcOr0RhZttuv20YxXll91qc=;
        b=pCeMwowaPL+ZIcwCJDOMcThIJfXh/kLYZy0b1tZto6z9osH8OCpavUYhQdbpr6KmdD
         zlogV0ucwzy6j/AjI5jM1zB4697E4PIS7HYcgjWpZElg/OIBIGNz2zha7PKdjtp94sCg
         kzLhEXOwBvdzkrjLkGvNnku7PJWjtD8gAHf5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xQe3+axTBusG9+xIw066CcEsoRsOPtH42y+C1Ea7tCA17mL9xwyl87oS/SbLV2BOFO
         St+tYbBDev9MjjS0WyoTqzgdq8jR9N4o6pv4ShBu9RuWRubmTz4cISPrBRbbR73zRrQo
         ER9kzD7h1Q5GXe0N8eKk9H0eNmalL8ImLRkNo=
Received: by 10.68.42.65 with SMTP id m1mr4638865pbl.511.1303067398118; Sun,
 17 Apr 2011 12:09:58 -0700 (PDT)
Received: by 10.68.64.229 with HTTP; Sun, 17 Apr 2011 12:09:18 -0700 (PDT)
In-Reply-To: <BANLkTim4=eKQ2wq73Lf5zrjOND-r1n0XCw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171729>

Hi Dmitry,

On Sun, Apr 17, 2011 at 9:38 AM, Dmitry Potapov <dpotapov@gmail.com> wr=
ote:
> The repository is not borked, it's just your working tree is in an
> inconsistent state, but it is easy to fix:
>
> git reset --hard HEAD

Ah, sounds like my intuition that simply freeing up space and then
re-pulling should have fixed the problem was wrong.  Your explanation
makes sense.

> BTW, did you mean "git pull" above? Because if you did "git push"
> then those bogus changes are at the server now.

No, I work with a centralized repository which requires push
operations.  I know this negates the benefit of distributed SCM.

> It always helps to run "gitk --all" to see what you are doing.
> [...]
> So, the general solution is only one:
>
> =C2=A0git reset --hard HEAD

Thank you for your patient responses to what turned out to be a very
basic question!  My typical git workflow is very simple and has worked
fine until I ran out of disk space.

Luke
