From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: grep --no-index and pathspec
Date: Sat, 12 Feb 2011 15:39:31 +0700
Message-ID: <AANLkTikZuRyyZ4tErYuo1itmEs1X_gT5aogpTM3s4gON@mail.gmail.com>
References: <20110211095938.360726y1zinab9gk@webmail.df.eu>
 <4D55500B.1070603@drmicha.warpmail.net> <7v8vxm1l6q.fsf@alter.siamese.dyndns.org>
 <7vwrl6z20p.fsf@alter.siamese.dyndns.org> <AANLkTikG1C=7NRGoi+HWz8rE9RN8-pF6o0=S29GZA3eK@mail.gmail.com>
 <7vvd0py7xy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Lars Noschinski <lars@public.noschinski.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 09:40:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoB1V-0000VK-N0
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 09:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab1BLIkF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Feb 2011 03:40:05 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37379 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab1BLIkD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Feb 2011 03:40:03 -0500
Received: by wwa36 with SMTP id 36so3366153wwa.1
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 00:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=lk2p/W5Tg4KFJgS8ExsY0a5s0Qf3BRarXH8rihjm1rM=;
        b=gfzvZaQ/zMP4IJIeOw8cjlRDR8oWi5EM65a0pP3aFtsoqU7Y6W7Di7ZgoSRCf1zoeL
         1IJSkZYI7W/GEfm24alxTGKjHuBpXokGWZ6ihCHIu7FCB3WBKpZXRHq4tt6z+HUQ79hW
         OQ2+bnL1DGhzICsiIbTLdE2pcvA5/Sv2C38BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Vo/mTBtFwIvLKptHurqaFeHx1R+S+K7DUQ27hrzrR2AbPmhahSQDjoxPULR2VXd3/B
         t45qCJpG3QF6UxMz9ucSS4cih5kQGfUKQGN9+1s8I2DE65B5HTw7b2h1qNDPph6f1czY
         IN+wPmf0mafAxLZLSSs/kwdrY7mHAtTXHF6Gw=
Received: by 10.216.89.71 with SMTP id b49mr1469285wef.28.1297500001753; Sat,
 12 Feb 2011 00:40:01 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Sat, 12 Feb 2011 00:39:31 -0800 (PST)
In-Reply-To: <7vvd0py7xy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166604>

On Sat, Feb 12, 2011 at 3:26 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>> =C2=A0 =C2=A0 NOTE! This does *not* obviate the need for the caller =
to do the *exact*
>> =C2=A0 =C2=A0 pathspec match later. It's a first-level filter on "re=
ad_directory()", but
>> =C2=A0 =C2=A0 it does not do the full pathspec thing. Maybe it shoul=
d. But in the
>> =C2=A0 =C2=A0 meantime,...
>
> I was around back then, so I know how the code came about ;-)
>
> The pieces used in the pathspec limiting logic have been restructured=
 well
> enough that I suspect it may now be feasible for us to revisit the "M=
aybe
> it should" part in the above quote. =C2=A0Thanks to nd/struct-pathspe=
c topic, I
> think we are already half-way there.

I was around too, just oblivious about things. I can look into that.
Need to think a bit how to save what pathspecs are "seen", so that
prune_directory() in builtin/add.c can be dropped.
--=20
Duy
