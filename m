From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: when does git start caring about symlinks?
Date: Wed, 24 Nov 2010 21:55:49 +0700
Message-ID: <AANLkTi=O0pZ97kRt0jGfy20znfvfp3UTydTBn_aMBxE+@mail.gmail.com>
References: <ichk2q$bbu$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 15:56:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLGlo-00050x-68
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 15:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970Ab0KXO4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Nov 2010 09:56:22 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37419 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab0KXO4V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Nov 2010 09:56:21 -0500
Received: by wyb28 with SMTP id 28so9545680wyb.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 06:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Gx35sgDg7XLnsiHlC2we4rsalrQZ/NaTx9nsYDbW8Kk=;
        b=ERjm70sNcRTZKAdwNzrnJdwqeTHUdMItxEzXxQdOXMBvn1QO/3GNDM90EnJjkrkyW3
         mSOIkm9AQMEiB2ZYzK2rXMZNL4N1txcFNi9Cld3KjFPHxm1M44xWgnJZoGdTLwilXiHP
         4RP+ctX309gAJ8pTJGrp2UTOVu7PalokSIXCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nUZVoEzTUemAi5EBbrwgh0miHdfMhuH/Dg/vG8K0qroFZ3cK+u3L6Ky4p0EQXGo7iG
         BErTloh77mhxmYQf82wwQC4Lgiy/wNoM//TflcxIQtnyUhzFzxSnFBJOna1pUoIlv5K7
         zuYByJedYRbuxebK+GAxqzbKUIdtkcWPAmiPY=
Received: by 10.216.47.19 with SMTP id s19mr2602355web.56.1290610579254; Wed,
 24 Nov 2010 06:56:19 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Wed, 24 Nov 2010 06:55:49 -0800 (PST)
In-Reply-To: <ichk2q$bbu$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162065>

On Wed, Nov 24, 2010 at 6:50 AM, Neal Kreitzinger <neal@rsss.com> wrote=
:
> I have a question on how symlinks work and at what point git starts c=
aring
> about them. =C2=A0If dirA/repoA/.git has no symlinks and I copy it to
> dirB/repoB/.git (ie. cp -rp /dirA/repoA/.git /dirB/repoB/.git), but /=
dirB is
> a symlink to /x/dirB does that mean that repoB contains symlinks (I s=
uspect
> that repoB may be made up of all symlinks at this point)? =C2=A0In ot=
her words,
> if I parallel test repoA and repoB am I running a true parallel test =
or are
> the repos different because repoA has no symlinks and repoB has symli=
nks?

There should be no difference between repoA and repoB until you make
changes. Symlinks outside worktree do not matter. Symlinks inside .git
dir may cause problems when you start updating repos. But I don't
think recent git creates symlinks. There are other forms of symlinks
in .git dir though: .git as a file that points to real .git dir, or
=2Egit/info/alternates comes to mind.
--=20
Duy
