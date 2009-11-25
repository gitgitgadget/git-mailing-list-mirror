From: Mike Jarmy <mjarmy@gmail.com>
Subject: Re: Commiting changes onto more than one branch
Date: Wed, 25 Nov 2009 14:43:02 -0500
Message-ID: <6b4a562b0911251143s63f09f7bwe4b67d6871d8a1b2@mail.gmail.com>
References: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>
	 <76c5b8580911250838x361ae081n271fcee2d1234703@mail.gmail.com>
	 <6b4a562b0911250847x59116687iba1d1640ca6c3887@mail.gmail.com>
	 <7vaayazb2a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 20:43:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDNle-0007zv-9N
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 20:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbZKYTm6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 14:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753841AbZKYTm6
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 14:42:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:13989 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbZKYTm5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 14:42:57 -0500
Received: by fg-out-1718.google.com with SMTP id 19so162844fgg.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 11:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=POFBmfK/bM+LYVJk1mLILm78PBRdM7Nvz/6SQbESoSQ=;
        b=v/88vuF85pI20omXR5rCqyit6Y2qSUN2A+XrUf9X/Cww5rhxMpezPVgL8Q7RVuWNrT
         Xkaa8Yw3NSpz0Oi63BD2gw2qShmmDA7taavXHkonHkiqUCc/n/p4THC4PTDkWVlgdNT1
         74g+FAJpO+py6sKw9gzZg71F+lylSs2zC+HSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SSzYVP34MdQpitWBIdKFapVD9ks826tIu2IkpzYXvN1JPJD+C7l90JOiO/F7nKyNOr
         eI3eTDe97/oJEyBLa2o0WXiJKq+SXR4njVt1VA+Xrb734JTgz8toKk5sJW3Yhc+rYksP
         sZXuSd99ytZIE3EyIJWiI0zG2QlcfmCDBX+rg=
Received: by 10.103.122.22 with SMTP id z22mr3471238mum.123.1259178182752; 
	Wed, 25 Nov 2009 11:43:02 -0800 (PST)
In-Reply-To: <7vaayazb2a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133663>

Junio C Hamano wrote:
> I take it to mean that even though v[345] have diverged, the area tha=
t the
> particular change you have in mind has to touch haven't changed since=
 they
> forked.

Correct.  Sometimes, there might be unrelated changes to a given file
or files, in which case conflict resolution will be done manually.
But generally speaking, bugfixes will tend to go on quite cleanly.

> Instead, you can fork such a topic from the latest common.
>
> =A0 =A0 =A0 =A0o--o--o--o--o--o--o--o v4
> =A0 =A0 =A0 /
> =A0 =A0--o--x--x--x--x--x--x--x v3
> =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0Y---Y
> =A0 =A0 =A0 =A0 =A0 =A0your change(s)
>
> and merging this to v3 and v4 will have the desired effect.
>
> =A0 =A0 =A0 =A0o--o--o--o--o--o--o--o---------M v4
> =A0 =A0 =A0 / =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/
> =A0 =A0--o--x--x--x--x--x--x--x---M v3 =A0/
> =A0 =A0 =A0 \ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/ =A0 =A0 /
> =A0 =A0 =A0 =A0Y---Y----------------.-----.
> =A0 =A0 =A0 =A0 =A0 =A0your change(s)
>
> The merges will incorporate this particular change alone without drag=
ging
> anything else. =A0When you merge it to v4, none of the unrelated 'x' =
will be
> merged into it.

That sounds a whole lot like what I need.

Right now I'm thinking that the right approach is that once we have
released v3, and started working on v4 heavily, we will probably not
want to check any commits directly into v3.  Bugfixes will have their
own branch.   If there is a whole new project or whatever being done
on top of v3, it will have its own branch as well.

So once v3 is in beta or whatever and we declare a code freeze, we
could have a rule that all commits must be merge-commits coming from
dedicated branches with descriptive, intelligible names.  For each
dedicated branch, some thought will have to be given as to just where
off of v3 to branch it from (not just carelessly off the latest tip).
Meanwhile, new development will continue on v4, with lots of commits
going right into the branch (or into v4 sub-branches with occasional
merge-commits into v4).
