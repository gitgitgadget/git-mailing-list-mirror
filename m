From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2009, #02; Sat, 05)
Date: Tue, 8 Dec 2009 13:58:22 +0800
Message-ID: <be6fef0d0912072158g1334aaf0s46299d833f694f1d@mail.gmail.com>
References: <7vpr6siki5.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.2.00.0912061738580.5582@cone.home.martin.st>
	 <20091207153736.GC17173@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Martin Storsj?" <martin@martin.st>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 06:58:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHt68-0001h2-0F
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 06:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbZLHF6T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 00:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933068AbZLHF6S
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 00:58:18 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:40697 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933005AbZLHF6Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 00:58:16 -0500
Received: by iwn35 with SMTP id 35so3653885iwn.4
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 21:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AveLjRHcMnHClNS5qE983BM1hcTenBpk0d8TGI6d4zk=;
        b=cCopDf4dQeuElbx6A2ui3qtt+ZPAdWZcZcEMx6RYPvni5CwHyBAc3mcZ7113B+e8UZ
         vf4oDkW34+Vrtn81V+MeYs07cpBy3x0ox05b9YwYClcrYUKv19ZbQbaqeBRGPhmQBeMK
         lVpuAhdxxBmXm68Njahlq4bvOL6ZbpDm0KFfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BgFEnfcwXVHb/qUfIGFTHHWhe5jA1ifSmiYZMFlujLyJI4Zr6mUOPVVi7MEO7MwdAN
         zkyjd6Bpe9fqfNKHHHmN1kb3flWT9EyxHo5zUKySNQcKukBQCcInHB66bVIX0IEs+W16
         Q76AKzGSJJSED/tWstWQ0ieasmtA1F4b7MIBo=
Received: by 10.231.120.90 with SMTP id c26mr131911ibr.1.1260251902396; Mon, 
	07 Dec 2009 21:58:22 -0800 (PST)
In-Reply-To: <20091207153736.GC17173@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134817>

Hi,

On Mon, Dec 7, 2009 at 11:37 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Martin Storsj? <martin@martin.st> wrote:
>> On Sun, 6 Dec 2009, Junio C Hamano wrote:
>> >
>> > * tr/http-updates (2009-12-01) 3 commits
>> > =A0- Allow curl to rewind the RPC read buffer
>> > =A0- Add an option for using any HTTP authentication scheme, not o=
nly basic
>> > =A0- http: maintain curl sessions
>> >
>> > There was a discussion on a better structure not to require rewind=
ing in
>> > the first place? =A0I didn't follow it closely...
>>
>> I think the conclusion is: Rewinding support isn't strictly necessar=
y,
>> there's a number of mechanisms in both git and curl that should make=
 sure
>> that those cases shouldn't surface. A few of them in curl have an
>> unfortunate conincidence of bugs up until the latest version, though=
,
>> leaving much fewer mechanisms in place to avoid this.
>>
>> Since that patch is quite non-intrusive I think it's a good safeguar=
d,
>> though. What do you think, Tay, keep it or leave it?
>
> I think the conclusion of the thread was that what you have queued
> in tr/http-updates is OK as-is. =A0The patch to grow the postbuffer
> to store the entire request wasn't a good idea and got dropped.

Martin, sorry the late reply. I agree with Shawn. Perhaps we could
relook at rewinding-to-any-position when restarting the rpc client
(eg. git-send-pack) has been implemented.

--=20
Cheers,
Ray Chuan
