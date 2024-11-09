Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C61EEE0
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731142597; cv=none; b=NrWDZ3PdoIzhSz3AILk7rvtz9wGZPBpyljvaRJet7hx2z5tBk6PWv2tLaGJZ1tEN+ig6GjlJ3OBdVFAHLRie8RLskkJ3oR7rO6R+otrXfYegDzZbbSA9qvJfzVU+kKyR4bUgSVgLy2WWf9UlnozIoxJLq0rx2ou03jPpMPRB60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731142597; c=relaxed/simple;
	bh=nmzqbUR7QDAT4wnopoIDTKcIZXDg2CnZrYCdFzcD5+g=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=n3f2eizXk5it60SiJafCW77RgrSMeK9WsBB6r5d5x3OuZQFoxG03WRLXF191KUgK0n6TjSzSBarGsOOPQlRvW8NnamN2cRKMYAJcTaUUlPPCJ+4GjI2usx3wi36Ps1BNdcXrQsBzntNN34+cxo4Gz/fIfylDd1JBKGq7ROoE8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=VsxMEjD4; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="VsxMEjD4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=15jg9E1bH2tZGzvneqp3sr8oYH/gMdJe8yvbPagsw0s=;
 b=VsxMEjD4sC1VVMhLnNddfqu6Dd/YflQyuRoSAdi8QXcS2ohl/Ohhf4tnUOEhMhnSmmtGF3AuC7h+
   IzHhiOOYxM+qT1RvPsbU/VcMWsTy7KAkiEHPVpPayc57XNm366AE4MOL2jxaZ28ZLopFhyCRW8Cm
   9Y9gLFXkVURVlb00uwY4/ftaLQMJIvB982OBfmh68pcJEBB3zeTH6RKMoeY17YlYVDJIMGTc/aNP
   9gsHJ+KZcaMUCF0DV/DDJmFTzev0AIMlUsLd0+ueCMXwn4EWnjuUTSm9JI/tcfRGT0WtxtK3JPu9
   SueDGCCll4TebkvCPHpU1OQT3viQHT2+Ltbe2g==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SMO00BQ0DXQ7CC0@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 09 Nov 2024 08:51:26 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sat, 09 Nov 2024 09:51:03 +0100
Message-id: <D5HIPT1E30HA.8F3CRTZH9XIR@ferdinandy.com>
Subject: Re: What's cooking in git.git (Nov 2024, #02; Fri, 1)
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <xmqqr07rwsmd.fsf@gitster.g>
 <D5EJL736B135.2ZP7G9GHUY0YL@ferdinandy.com> <xmqqcyj9rz6a.fsf@gitster.g>
In-reply-to: <xmqqcyj9rz6a.fsf@gitster.g>
Reporting-Meta:
 AAHwAo4FCjJO3BxHQVytuMaE/uYnc+tWIMMMwn1q/wnJ2HJlmIZksEw5t3O8W32R
 lqXwQyC2TL9vw+Nfqs8I20cJC8E82Y7UOy4+aD3j8LnvTVeGwAieOUUMShPENBbQ
 wqTbDtODAEaQneC/PMsM/acTwPVLl9/nJY7Q5VD67b/j697xwUXE6SV1HhqC5PJB
 /pPhjLXxbNf1pnPNqgyI+uwHoAisJihBCeI9eog6DJcaXSliOXONu6NEk3hi2A8L
 OLj7TdN372gURrftN7qOnhflP+a0JVyNRxyw+yipQYLKDkinSl7VDKNR5q3TTOvB
 EAW/zj4mFvqYTmPjHFIEU9U3y3hUY+sGqj/DbivW8rXOAgZNPB4Zlwx5W+Px5hSg
 Rffccn50fBdX9+z4yKqFWhfz6csqIJ7mCvgH5gj7A6KgixVnCkKeMkiVjc/Ibo/D
 TFX+WV++GZEx6jU5ie+e91dtjl2elpZnx99tZdLUIyH9ef3mO8wsPPU=


On Wed Nov 06, 2024 at 01:19, Junio C Hamano <gitster@pobox.com> wrote:
> The "manual" to run the project on the maintainer side has this:
>
>    - If a topic that was picked up to 'seen' becomes and stays
>      inactive for 3 calendar weeks without having seen a clear
>      consensus that it is good enough to be moved to 'next', the
>      topic may be discarded from 'seen'.  Interested parties are
>      still free to revive the topic.  For the purpose of this
>      guideline, the definition of being "inactive" is that nobody
>      has discussed the topic, no new iteration of the topic was
>      posted, and no responses to the review comments were given.
>
> If the topic has been updated large-ish-ly since the previous
> rounds, it may deserve a fresh review, or the reviewers of the
> previous rounds may find it sufficient that they judge based on the
> change since the previous round (assuming that the earlier reviews
> did a good job of hunting problems in the previous rounds).  I do
> not offhand know who read the topic and how big a course-change the
> topic took during my absense, so hopefully somebody who is more
> familiar with the latest round can chime in before I dig the topic
> out from the bottom of my pile of backlog.

Thanks for the info, I'll wait then or maybe write a followup on the patch'=
s
thread sometime next week, where the previous reviewers are already CC-d.

Thanks,
Bence
