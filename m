From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [RFC] Add posibility to preload stat information.
Date: Wed, 20 Mar 2013 19:36:41 +0100
Message-ID: <20130320183641.GB32426@paksenarrion.iveqy.com>
References: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
 <CALkWK0=b80U5dxGMpwKwL+jFURisEuSapWuuNRFcP+5R2f3+GA@mail.gmail.com>
 <20130320174120.GA32426@paksenarrion.iveqy.com>
 <CALkWK0nCY3o_KW8ykq9TkzfHeVj6NKDkOFuym9UmSWLH0ZFxBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, spearce@spearce.org,
	git@vger.kernel.org, pclouds@gmail.com, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:35:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINrd-0006EH-Ib
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab3CTSf0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 14:35:26 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:39991 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab3CTSfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:35:25 -0400
Received: by mail-la0-f48.google.com with SMTP id fq13so3581989lab.35
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=m1GqKZ0AK1JEu5wbeMnuz0hZBh0je2v0FGQWFTxunYQ=;
        b=A/G8W5O+7H3gBgNVZ6zAidegWc+ZpbPjCC2RlHBffmvNfMwsIk/WTVYJw4DXyuAepO
         UBhCro23tJSGRehz+XUcnNXjXdsqJcEKpUKr3vyr98gHiEz18w5DyIjEYWJ/eJm1OZGq
         or5hWtl7CGfsawlD6PXjL29MWrg3rnMXN26BahCbGTBbPws6WeFkO9KrdroZSAXTf6sl
         i/h6NGUneMKIxQNstH9PbNOawVEGhAfx1FA9vXhgRZ38Hym1dspcTFc1a3DrWaWcL/AJ
         TfjOLsn4IjJs6DFL7YqF0f0HYSLsUzZ0d7pV+xKDwm/GZ0cTNVBW+Cnrjdrp2HlSeUV7
         Y1Tg==
X-Received: by 10.112.5.6 with SMTP id o6mr9933948lbo.57.1363804524101;
        Wed, 20 Mar 2013 11:35:24 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPS id fz16sm1315947lab.5.2013.03.20.11.35.22
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 11:35:23 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UINsP-0001Vk-9d; Wed, 20 Mar 2013 19:36:41 +0100
Content-Disposition: inline
In-Reply-To: <CALkWK0nCY3o_KW8ykq9TkzfHeVj6NKDkOFuym9UmSWLH0ZFxBw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218644>

On Wed, Mar 20, 2013 at 11:19:38PM +0530, Ramkumar Ramachandra wrote:
> I think it should be a separate script in contrib/ that people can
> just `eval` in their shell configs; zsh has a chpwd() function for
> example, which seems like the right place to put such a thing.

I was trying to spare the number of calls to "git rev-parse
--is-inside-work-tree". But maybe that is to fast to care about.

> No, I meant in the commit message.

Okay, thanks.

> >> That said, this feature is extremely gross; it thrashes my filesys=
tem
> >> and hard drive.  Modern software is written to minimize IO, not
> >> maximize it!  I'm completely against the inclusion of this patch.
> >
> > It's extremly gross. I don't like this, _but_ it does speed up my w=
ork.
> > I'm unsure if it should be included in git though (hence the RFC-ta=
g).
>=20
> Yes, I would certainly like my git startup time to be improved.  But =
I
> don't want to trade my hard drive's life for it.

Does this really increase disk-reads? The fs-cache would make sure that
the disk reads is almost the same, we only do them before we usually do
them.

> What I meant by "first time" is "chpwd() into the git repository, not
> further chpwd()s when already inside the git repository".

That's a good point. I'm not sure how to solve that though. Because it'=
s
not a fact that you always go to the root git-dir first.

The only way I see this is with a lock-file that's kept and we only run
git status every 5 minutes when doing something inside a work dir. That
would add a lot of meta-data (the lock files), to store. (I hope I
successfully explained that).

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
