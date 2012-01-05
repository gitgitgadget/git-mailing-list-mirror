From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Do not fetch tags on new shallow clones
Date: Wed, 4 Jan 2012 19:05:07 -0800
Message-ID: <CAJo=hJvL2ebziPw=0q-e=G3WFEvEKtFR2xMFMiquSyrHJDradA@mail.gmail.com>
References: <1325676922-6995-1-git-send-email-pclouds@gmail.com> <7vwr97nho7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 04:05:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ride1-0002BB-G7
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 04:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757652Ab2AEDF3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jan 2012 22:05:29 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36981 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757519Ab2AEDF2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jan 2012 22:05:28 -0500
Received: by pbdu13 with SMTP id u13so67814pbd.19
        for <git@vger.kernel.org>; Wed, 04 Jan 2012 19:05:28 -0800 (PST)
Received: by 10.68.74.167 with SMTP id u7mr770835pbv.103.1325732728186; Wed,
 04 Jan 2012 19:05:28 -0800 (PST)
Received: by 10.68.26.37 with HTTP; Wed, 4 Jan 2012 19:05:07 -0800 (PST)
In-Reply-To: <7vwr97nho7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187964>

2012/1/4 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>> =C2=A0We should also fetch tags that reference to downloaded objects=
=2E
>
> I do not think this has much merit.

I disagree. Its useful because cloning a branch immediately after it
has been tagged for a release should have `git describe` provide back
the name of the release from the tag (assuming of course no new
commits were made since the tag).

> The usual tag-following rules AFAIK
> assumes that if you have the commit C then you ought to have all the
> ancestors of C, which does not apply at all for the shallow hack to b=
egin
> with, and if you make the rule apply for the shallow hack, you would =
end
> up slurping the objects that are needed only for ancient versions, wh=
ich
> would defeat the objective of this patch, no?

We aren't talking about fetching the ancient history tags. We are
talking about fetching a tag that *directly* points at one of the
commits we did download the complete tree of.

> It also is my understanding that the shallow hack is almost always us=
ed
> with a depth of one, not a range, like "git archive | tar xf -", so i=
f
> anything, I would say a single-branch cloning has much higher priorit=
y
> than following tags.

I think I agree with you on priority of work effort. But I lack time
to make good on that by writing the code myself.  :-)
