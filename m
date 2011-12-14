From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/7] revert: do not remove state until sequence is finished
Date: Wed, 14 Dec 2011 21:32:32 +0530
Message-ID: <CALkWK0nn2mhaP5pwUob2_1ADzNkfP9_ZtUqWnhqWfn7pR9aj7Q@mail.gmail.com>
References: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net> <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net> <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net> <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net> <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net> <20111210130212.GF22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:03:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RarIK-0008IJ-DE
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757021Ab1LNQC6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 11:02:58 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63026 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756976Ab1LNQCz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 11:02:55 -0500
Received: by qcqz2 with SMTP id z2so591849qcq.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JpymzOsWdBN5yL1cqQ73oJLaV2eUW5lUhdWVdmZBOxU=;
        b=vsCqNBaSoF87wxGo6UvzORJ6zwnhirvm4nLHLITqFFxgWgKn+7hj64//YgzZfFsD0i
         TeCvoj6gbAMFucN8lxnTqa+uNmzmnVd5H3SRye76kn6Dnp/b4KwgmeQAdDWNtnYh2kw4
         u6QZDEl3Y0Vbc8rLqBIHxtc8ees612VoMLpfY=
Received: by 10.180.88.66 with SMTP id be2mr5795611wib.54.1323878573264; Wed,
 14 Dec 2011 08:02:53 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Wed, 14 Dec 2011 08:02:32 -0800 (PST)
In-Reply-To: <20111210130212.GF22035@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187136>

Hey,

Jonathan Nieder wrote:
> [...]
> After the recent patch "allow single-pick in the middle of cherry-pic=
k
> sequence" we don't need that hack any more. =C2=A0In the new regime, =
a
> traditional "git cherry-pick <commit>" command never looks at
> .git/sequencer, so we do not need to cripple "git cherry-pick
> <commit>..<commit>" for it any more.

So this is why you needed that "relatively esoteric feature" :P
This approach competes with the approach I presented in "New sequencer
workflow!" [1], where I use a special case to side-step various
sequencer state files: this approach wins on the grounds of
simplicity, and I can't see any potential long-term issues with my
limited foresight.  Do you have any other points of comparison?

[1]: https://github.com/artagnon/git sequencer #; 8a08d09b9

-- Ram
