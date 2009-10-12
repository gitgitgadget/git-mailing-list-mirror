From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git refuses to work with gvim
Date: Mon, 12 Oct 2009 17:36:50 +0300
Message-ID: <94a0d4530910120736p4cc310c0id08765ab5f10d0a3@mail.gmail.com>
References: <20091012134312.236d250e@gzip.coli.uni-saarland.de>
	 <vpq8wfgg4u1.fsf@bauges.imag.fr> <20091012141334.GE9261@spearce.org>
	 <94a0d4530910120720pccaa920n7ab407494473ac7b@mail.gmail.com>
	 <20091012142523.GH9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	sebastian@coli.uni-sb.de, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 16:40:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxM4T-0002uT-Jw
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 16:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbZJLOh3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 10:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756828AbZJLOh3
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:37:29 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:39223 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756827AbZJLOh1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 10:37:27 -0400
Received: by fxm27 with SMTP id 27so9256735fxm.17
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0HARGZ/jxoO3sY5PkLYWPRzY4EQ/cwcw/AcfJ/Vs7DM=;
        b=sSbpGG6Hqf8+TWaWvOj3HajI2b72xOIao6mEVFflv4sLJr3XMtyaSx9cdxyd/KbxHw
         cjUitX+L3yTZeNAAeuShqsrr8lDcKrRJAMgdMteLbbX5boJOTnolY0jqpoW9rDS4CmvB
         OUpuPbZGLWpZScdSiB9uKXQ07MGsP8q3F8qvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GoZJxtXptvSfusgqxFsZx3XroWZHmmSaXjY+ymXf8R4Y7cLxPx/ZkdVjDfUbCn1jTc
         RXAu3bD2fBQgVAwdTDjcS8erzG2ppwd2FVFMG5GCWWPVR0WTA+oKD9B10e2HUCdw/Yb8
         1h6UXY27gtS2Y73mm3utjyHcmDv7D5v26UrC0=
Received: by 10.86.174.2 with SMTP id w2mr5358564fge.0.1255358210907; Mon, 12 
	Oct 2009 07:36:50 -0700 (PDT)
In-Reply-To: <20091012142523.GH9261@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130023>

On Mon, Oct 12, 2009 at 5:25 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> On Mon, Oct 12, 2009 at 5:13 PM, Shawn O. Pearce <spearce@spearce.or=
g> wrote:
>> >
>> > Someone needs to whack gvim upside the head and fix that program
>> > to behave correctly.
>>
>> Huh? What is wrong about 'gvim --nofork'?
>
> The fact that its a command line option that isn't the default.
> gvim's UI here is as bad as pre 0.99 git.
>
> People do:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0export EDITOR=3Dgvim
>
> and things work OK for a while, as they always open a new editor,
> work with the file, and then close it, killing the only running gvim
> session. =C2=A0Since gvim waits if its the only gvim process running,
> things seem fine. =C2=A0But days later when you leave a file open,
> suddenly the command calling $EDITOR starts failing.

I've never seen it happening. For me either it aways fails (fork) or
always work (nofork).

> I've seen it happen to a lot of people. =C2=A0They just start complai=
ning
> about how one day "git commit" is fine, and the next day its
> not working. =C2=A0But its been weeks since they selected gvim as the=
ir
> $EDITOR and they can't connect the open editor window as the problem
> with that Goddamn Idiotic Truckload of s**t they are forced to use.

Yeah, it happened to me too, but eventually I realized what was
happening. I like gvim's default behavior tough.

I personally don't see any problem... how about other SCMs?

--=20
=46elipe Contreras
