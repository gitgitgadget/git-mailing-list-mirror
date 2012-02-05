From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 4/4] completion: simplify __gitcomp*
Date: Sun, 5 Feb 2012 23:14:03 +0200
Message-ID: <CAMP44s3ECM2e08wsjMzu9Y4xDRw+KVNbMdCeAmxiPn3jNtC59Q@mail.gmail.com>
References: <1328214625-3576-1-git-send-email-felipe.contreras@gmail.com>
	<1328214625-3576-5-git-send-email-felipe.contreras@gmail.com>
	<7vty37oedr.fsf@alter.siamese.dyndns.org>
	<20120204135404.GF16099@goldbirke>
	<7vmx8xggan.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 22:14:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru9PX-00027z-Mt
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 22:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839Ab2BEVOH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 16:14:07 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44633 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750843Ab2BEVOF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 16:14:05 -0500
Received: by lagu2 with SMTP id u2so2657037lag.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 13:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=16IVpQnPLliBV+jNVraMmn9/zHsfdgvd4KhMSaqRZh4=;
        b=VWrEBZ7JwkK9JBcOimn/UCEAxBhkavWx47lBNnJ/wCzqxbQwURiOiB1xzHJRjpypi/
         qs4Nf4UA2AZTyNphW95PWy8+AwMUbaob0nPR3H2FtxJfd3DkEsj2rWnObIX+hjki99SV
         CqIJN/LgOSqhh1psepnmMo5hWblFDzw9XfpJU=
Received: by 10.152.123.68 with SMTP id ly4mr2648641lab.13.1328476443569; Sun,
 05 Feb 2012 13:14:03 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Sun, 5 Feb 2012 13:14:03 -0800 (PST)
In-Reply-To: <7vmx8xggan.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189964>

2012/2/5 Junio C Hamano <gitster@pobox.com>:
> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> And it does make a difference, it breaks the completion of a single
>> word in multiple steps, e.g. git log --pretty=3D<TAB> master..<TAB>.=
 =C2=A0In
>> such cases we pass "${cur##--pretty=3D}" and "${cur_#*..}" as third
>> argument to __gitcomp() and __gitcomp_nl(), which can be empty strin=
gs
>> when the user hits TAB right after the '=3D' and '..'.
>
> After saying "this rewrite is wrong", I was actually wondering if I s=
hould
> have said "this rewrite is not faithful to the original". =C2=A0Based=
 on your
> analysis, the difference does break the callers, so the rewrite is in=
deed
> wrong.

That's why we need tests for the completion stuff as well. I was
thinking on doing that, but if I have to write a peer-reviewed essay
with an introduction for the people that are not familiar with the
code in each of the patches, I'd rather not.

--=20
=46elipe Contreras
