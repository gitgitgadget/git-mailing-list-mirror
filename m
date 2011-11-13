From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: delete deprecated refs to release disk space
Date: Sun, 13 Nov 2011 18:01:18 +0100
Message-ID: <CACBZZX5kBqM1eye40_Vw0W=8qnNsUQBVCE0q9JrixYomGPuZbg@mail.gmail.com>
References: <20111113151033.GD16065@external.screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Sun Nov 13 18:01:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPdRC-0002Mx-Dj
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 18:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629Ab1KMRBl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Nov 2011 12:01:41 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52517 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab1KMRBk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2011 12:01:40 -0500
Received: by bke11 with SMTP id 11so5042117bke.19
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 09:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=q/sRgXo4/Ph0aoGhu1B+okrRWu3nmLJlr+ADDSrQvVM=;
        b=d3zs2XoEk5RzpdjA4otKKy8NAgwH1cvqpRYJdMWLOVFu71jo4TsdkJ0zhq/pj5jFRN
         cpGsBhjDBV2t7E/qrqJBErk1bwjweTQwOIrIMCVmk1t3ug87CSjpzkXXTByIUWXr5J4o
         F9K9ZjvrMyY9QlvGBMczgU1nJZN/1kkCcF5e8=
Received: by 10.204.154.89 with SMTP id n25mr6431444bkw.75.1321203699114; Sun,
 13 Nov 2011 09:01:39 -0800 (PST)
Received: by 10.204.69.71 with HTTP; Sun, 13 Nov 2011 09:01:18 -0800 (PST)
In-Reply-To: <20111113151033.GD16065@external.screwed.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185342>

2011/11/13 Peter Vereshagin <peter@vereshagin.org>:
> Hello.
>
> I use git for sql database backups:
>
> =C2=A0 =C2=A0http://gitweb.vereshagin.org/endvance/blob_plain/HEAD:/e=
ndvance/README
>
> Am wondering if there is a way to remove the expired revisions? Follo=
wing that
> scenario:
>
> =C2=A0 =C2=A0https://gist.github.com/1362183
>
> I think there should be the way to decrease the space that .git takes=
=2E Without
> compression, of course.
>
> No problem if this involves the overwriting of the history like =C2=A0=
filter-branch
> does. =C2=A0But filter-branch doesn't seem to be able to remove the o=
ld =C2=A0info =C2=A0from
> repository based on expiration time, does it?

What you're looking for is git-filter-branch + the graft facility. I
can't remember the exact invocation, but you echo the sha1 of the
commit you want to be the oldest commit to .git/info/grafts, then run
git-filter-branch.

You can use whatever you like to discover that sha1, e.g. keep N
revisions (which might be committed once per day) around, or have some
custom time limit etc.
