From: Arun Raghavan <ford_prefect@gentoo.org>
Subject: Re: Removal of post-upload-hook
Date: Fri, 15 Jan 2010 01:22:18 +0530
Message-ID: <6f8b45101001141152x35c206b4q1591254c35002193@mail.gmail.com>
References: <6f8b45101001141001q40d8b746v8385bc6ae37a6af4@mail.gmail.com> 
	<20100114193607.GB25863@coredump.intra.peff.net> <20100114194107.GA20033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 20:52:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVVkI-0006kV-HK
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 20:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757499Ab0ANTwl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 14:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757483Ab0ANTwk
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 14:52:40 -0500
Received: from mail-qy0-f194.google.com ([209.85.221.194]:44530 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397Ab0ANTwj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2010 14:52:39 -0500
Received: by qyk32 with SMTP id 32so4281418qyk.4
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 11:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=xQ/WaVfeDcAm8s5oahCy3UuW23eavczDve/qM+VaGao=;
        b=DBMpC3J3hCupTmJC0AzL2RBCK7584teROsu57lfCcYopdDkmEMFqu4qjT6d/vDHKbE
         kbpQR5evuxK8pmsUvwUDA+zNqogvMoUWZRXxKMHA/apB3KzXUVV6/GepTLOgHVqj2gi2
         1yEou6Up/CxPneZlWYXNht3Y9ohclAMe1ivPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=ugS7hd5c0HLeyttVM7FERPIUCTm5cP9g/XaS1WtvCzvYmGVjom0+YK/wGjLJ5fAtCb
         8Vx5LxgzoEjKuzRVfa5dn9nYoJzjFAkIujW5unxU1aXvmQuDGX32/cn7lmGPRHudnoUv
         nj22JWQhixq52rbM/Ls4fRU4cEw5jt70AuLuA=
Received: by 10.229.102.165 with SMTP id g37mr1192022qco.65.1263498758383; 
	Thu, 14 Jan 2010 11:52:38 -0800 (PST)
In-Reply-To: <20100114194107.GA20033@spearce.org>
X-Google-Sender-Auth: f7798815242b650b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137018>

2010/1/15 Shawn O. Pearce <spearce@spearce.org>:
> Jeff King <peff@peff.net> wrote:
>> On Thu, Jan 14, 2010 at 11:31:57PM +0530, Arun Raghavan wrote:
>> > [I'm not on the list, so please CC me on replies]
>> >
>> > Hello,
>> > I noticed that the post-upload hook had been removed in commit
>> > 1456b043fc0f0a395c35d6b5e55b0dad1b6e7acc. The commit message state=
s:
>> >
>> > =A0 =A0 This hook runs after "git fetch" in the repository the obj=
ects are
>> > =A0 =A0 fetched from as the user who fetched, and has security imp=
lications.
>> >
>> > I was wondering if someone could shed some light (or links) on wha=
t
>> > security implications this hook has?
>>
>> Because receive-pack runs as the user who is pushing, not as the
>> repository owner. So by convincing you to push to my repository in a
>> multi-user environment, I convince you to run some arbitrary code of
>> mine.
>
> Uhhh, this was in fetch/upload-pack Peff, not push/receive-pack.
>
> Same issue though.

Ah, got it - thank you!
--=20
Arun Raghavan
http://arunraghavan.net/
(Ford_Prefect | Gentoo) & (arunsr | GNOME)
