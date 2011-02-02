From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Features from GitSurvey 2010
Date: Tue, 1 Feb 2011 16:26:16 -0800
Message-ID: <AANLkTikaztSn+xQ3xT7d-3-Yghk69qXXN1DRg9h+kEHx@mail.gmail.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com>
 <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com>
 <AANLkTi=_DPSp2P3MuFOPgua2nH7U+RUt4AfAHSyPVv-G@mail.gmail.com>
 <AANLkTi=KUpYJBRMp9ti0h+g6a0iTw4D113rTgfTpR8C4@mail.gmail.com> <alpine.LFD.2.00.1102011647000.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Feb 02 01:27:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkQYl-0007fo-RZ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 01:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084Ab1BBA0k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 19:26:40 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34436 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1BBA0i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 19:26:38 -0500
Received: by fxm20 with SMTP id 20so7445581fxm.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 16:26:36 -0800 (PST)
Received: by 10.103.226.11 with SMTP id d11mr3826756mur.113.1296606396585;
 Tue, 01 Feb 2011 16:26:36 -0800 (PST)
Received: by 10.103.1.2 with HTTP; Tue, 1 Feb 2011 16:26:16 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1102011647000.8580@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165882>

On Tue, Feb 1, 2011 at 13:51, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 1 Feb 2011, Shawn Pearce wrote:
>
>> On Tue, Feb 1, 2011 at 09:11, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
>> > Narrow/Subtree clone is still just an idea, but can pack cache sup=
port
>> > be made to resumable initial narrow clone too?
>>
>> This would be very hard to do. =A0We could do cached packs for a pop=
ular
>> set of path specifications (e.g. Documentation/ if documentation onl=
y
>> editing is common), but once we start getting random requests for pa=
th
>> specifications that we cannot predict in advance and pre-pack we'd
>> have to fall back to the normal enumerate code path.
>
> Also... people interested in Narrow clones are likely to be shallow
> clone users too, right?

I think that depends.  Some users might want the full history of the
files they are working on.  Others wouldn't care and just want the tip
revision so they can make changes.  Obviously a shallow clone of depth
1 is very cheap to implement on the server; there really isn't any
caching required.

Probably 50% want full history, 50% want shallow clone.  So I doubt we
can assume that narrow implies shallow and thus is cheap.  :-(

--=20
Shawn.
