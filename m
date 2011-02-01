From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Features from GitSurvey 2010
Date: Wed, 2 Feb 2011 00:11:56 +0700
Message-ID: <AANLkTi=_DPSp2P3MuFOPgua2nH7U+RUt4AfAHSyPVv-G@mail.gmail.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com> <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 01 18:12:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkJmN-0004zC-Mb
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 18:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451Ab1BARM3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 12:12:29 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37643 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab1BARM1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 12:12:27 -0500
Received: by ewy5 with SMTP id 5so3246961ewy.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 09:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=t95Deb7rASc5H252VLZsa/F5HxVCyPptr7XAiedF7Y8=;
        b=VmW+T5wGryeUHAeuHbR8pMr6RktLOYSDs1xaCfRL7EQx+jUMYVx1vu2PDknimiG7sz
         c0mjXG1sz3P1D99J4lXj2kaHuDlwVp8AIAFEr2SnDwiVBG1VrCCoxMwZxzMdwVAnxJWk
         ah3xSWShc+q6bZGZlqZuTA6v2g1ATvE6I2Ta8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QUyhIh89dLqOICibi2B+mb8/xkGYz7D7eC7e3ELvw5XiD3ESGfRuYoTfNhc0Tn1iJD
         uY6WOg4xI8i+VcxW7YYYaEELzsRkerjHZwA953nK5aYg3ex0+U+n+WRNYSoMmlyS7RlU
         aSPXGhhdFjh/vRQhY6Rl+WpMicMliEpt8nrjM=
Received: by 10.216.177.9 with SMTP id c9mr7618601wem.34.1296580346397; Tue,
 01 Feb 2011 09:12:26 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 1 Feb 2011 09:11:56 -0800 (PST)
In-Reply-To: <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165830>

On Tue, Feb 1, 2011 at 11:27 PM, Shawn Pearce <spearce@spearce.org> wro=
te:
> On Tue, Feb 1, 2011 at 05:51, Jakub Narebski <jnareb@gmail.com> wrote=
:
>>
>>> > resumable clone/fetch (and other remote operations)
>>>
>>> Jakub Narebski seems to be interested in this and Nicolas Pitre has
>>> given some good advice about it. =C2=A0You can get something usable=
 today
>>> by putting up a git bundle for download over HTTP or rsync, so it i=
s
>>> possible that this just involves some UI (porcelain) and documentat=
ion
>>> work to become standard practice.
>>
>> I wouldn't say that: it is Nicolas Pitre (IIRC) who was doing the wo=
rk;
>> I was only interested party posting comments, but no code.
>>
>> Again, this feature is not very easy to implement, and would require
>> knowledge of git internals including "smart" git transport ("Pro Git=
"
>> book can help there).
>
> I think Nico and I have mostly solved this with the pack caching idea=
=2E
> =C2=A0If we cache the pack file, we can resume anywhere in about 97% =
of the
> transfer. =C2=A0The first 3% cannot be resumed easily, its back to th=
e old
> "git cannot be resumed" issue. =C2=A0Fixing that last 3% is incredibl=
y

I thought the cached pack contained anything and for initial clone, we
simply send the pack. What is this 3%? Commit list? Initial commit?

> difficult... but resuming within the remaining 97% is a pretty simple
> extension of the protocol. =C2=A0The hard part is the client side
> infrastructure to remember where we left off and restart.

Narrow/Subtree clone is still just an idea, but can pack cache support
be made to resumable initial narrow clone too?
--=20
Duy
