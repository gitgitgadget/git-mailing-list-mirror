From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/2] Fix spurious conflicts with pull --rebase
Date: Sun, 8 Aug 2010 13:27:19 -0600
Message-ID: <AANLkTimmys53DbyvdJFnbb0_iiaAjwczC6GafZO=DRWf@mail.gmail.com>
References: <1281103503-27515-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 21:27:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiBWq-0004oe-1x
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 21:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746Ab0HHT1X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 15:27:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52292 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622Ab0HHT1W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Aug 2010 15:27:22 -0400
Received: by fxm14 with SMTP id 14so4643423fxm.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=OvYaYII0N8z9pSKUXvSMMPPDKYs3Uy+QDJDe8it3fB0=;
        b=mqO0+dQK7f3aNgsIovh2Lou55kFCnYVWqp9ffiFSwIfOzwhvD8vqDIdaRC+vhFHTK2
         TKO4xbPxH2TUyamEK3F6R8TaEg9vs0bTX1jaGwHWST6FUib4lXwMTszuhWMCvDXr5F4J
         6Lj/lgzHdRgxK0gMleFIituY6SmkyMf5Gc6jE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=nYgaR1FMBiJb3sQ7uQidB9yGy5sziMnjHWxa4V2N3kJt3BZpRZK7/+zTYzCBcB7k/m
         Coen7QdZ0OdHTzstzyRKcC6/eDZeVtGGdLqUAixwXXUb9vSkwOTBkTCMon1sMVRXdr9G
         43bNTzCGTfkAavYgH5fkycrM7PU72MwJQvVBE=
Received: by 10.223.103.194 with SMTP id l2mr15766819fao.6.1281295639642; Sun, 
	08 Aug 2010 12:27:19 -0700 (PDT)
Received: by 10.223.149.82 with HTTP; Sun, 8 Aug 2010 12:27:19 -0700 (PDT)
In-Reply-To: <1281103503-27515-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152921>

On Fri, Aug 6, 2010 at 8:05 AM, Elijah Newren <newren@gmail.com> wrote:
> This patch series fixes git pull --rebase failing to detect if "local=
"
> patches are already upstream in cases where the upstream repository i=
s
> not itself rebased. =C2=A0Also in the non-rebased upstream case, this
> series avoids checking/applying more patches than needed (i.e. avoids
> having rebase work on commits which are already reachable from
> upstream).
>
> It would be nice to make 'git pull --rebase' able to detect if patche=
s
> being applied are already part of upstream in cases where the upstrea=
m
> repository has been rebased. =C2=A0As far as I can tell, that would r=
equire
> changes to format-patch to allow it to be told what 'upstream' is, an=
d
> some changes to git-pull.sh/git-rebase.sh to pass it this information=
=2E

I obviously hadn't slept enough when I wrote the above paragraphs;
they don't parse very well.  Sorry about that.  I just posted a new
series, with some wording improvements and minor portability fixes.

(For the benefit of those not following this list, to whom I gave a
direct link to this thread, the updated series is here:
http://thread.gmane.org/gmane.comp.version-control.git/152918)


Elijah
