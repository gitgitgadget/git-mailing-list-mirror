From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Tue, 3 May 2011 14:52:12 +0700
Message-ID: <BANLkTimfT87-vV0GCvsVmRJ6nBZt7jSkkw@mail.gmail.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com> <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org> <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org> <20110408223206.GA7343@sigill.intra.peff.net>
 <7vei5c1iat.fsf@alter.siamese.dyndns.org> <7vaag01gdl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 09:52:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHAPZ-0003MR-CL
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 09:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299Ab1ECHwo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 03:52:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48690 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab1ECHwn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 03:52:43 -0400
Received: by bwz15 with SMTP id 15so5295614bwz.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 00:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=sdk8TgoNnZRdPJBSuqsNc7SezCWjAXuKSfyzCj6nCFw=;
        b=SJ2EkvlvfbOKkkdblYZnGrtNwg3tlBsg2LXCHVY9ItrSWolOkCaz0cd3UpwPWMn/++
         qPskxB/2Q2XitczZxvZRrcAHNWKDWxlAAhtZ1/XcmTMUSTxOirzQe8ei0BJnjasJzUFw
         0zHMrRc2c9/UXHy+0aD9/UuwkNAyFijWNQBGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rQc/Aer2eZT36aFkOe4Dk/v0X2+FvtMQUTXgYErP/n20YSUagDkop/rnizhGmvJHCP
         9tzAMZMqjwnXWBUDJJkRI+RITJQo7Ou3cwPfow0Co7B5RnRfsAOrjU8C8ddIZTW/Y1nU
         qCOArmBxBbBXb3Rjoyd71HUFV4qH30TOt8Enc=
Received: by 10.204.32.9 with SMTP id a9mr4274974bkd.182.1304409162169; Tue,
 03 May 2011 00:52:42 -0700 (PDT)
Received: by 10.204.53.13 with HTTP; Tue, 3 May 2011 00:52:12 -0700 (PDT)
In-Reply-To: <7vaag01gdl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172650>

On Sat, Apr 9, 2011 at 6:18 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Subject: [PATCH] magic pathspec: futureproof shorthand form
>
> ...
>
> Also make ':' without anything else to mean "there is no pathspec". =C2=
=A0This
> would allow differences between "git log" and "git log ." run from th=
e top
> level of the working tree (the latter simplifies no-op commits away f=
rom
> the history) to be expressed from a subdirectory by saying "git log :=
".

I need someone to enlighten me again. Why do we need ":" for "no
pathspec" when we can simply specify no pathspec for the same effect?

"git log" and "git log ." at top worktree are not different because
any changes in the tree will make top tree object different, hence no
pruning (unless someone commits the same tree, which is really rare).
So

 - "git log" in subdirectory is exactly the same as "git log" at top.
 - "git log :/" in subdir can do whatever "git log ." at top can.
 - "git log ." in subdir will prune commits that does not change
subdir (current behavior)

I don't (or no longer) see the point of reserving ":" for "no pathspec"=
=2E
--=20
Duy
