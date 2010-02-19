From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] ? - git log :/text results are strange
Date: Fri, 19 Feb 2010 18:41:32 -0500
Message-ID: <76c5b8581002191541x95c3378je6f0528c11aaba4f@mail.gmail.com>
References: <76c5b8581002191350h61d6d8c2jd0245c0963fcc85f@mail.gmail.com>
	 <201002192334.52495.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 20 00:41:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NicTb-0002sf-SU
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 00:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332Ab0BSXle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 18:41:34 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:42487 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab0BSXld convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 18:41:33 -0500
Received: by ywh35 with SMTP id 35so610091ywh.4
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 15:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=lTpSV2uqyNKPDQBjcV4EumXIDPdpWCAYBwjisKhe/R4=;
        b=HH1j3/uYDTDMJXt/39MZ1t2IHImn9v4cZXkwqBCNXWKyrogfAAHy1eI6wPPNw70FW5
         hTqrBvMjnFTmPq5ofsDbt1qLskC8YhmJ7UvPErhygOmKOLeU1no6GoM3A7vUhaOciemB
         2FIXHYIdNoVmsp1Q5STt5Zi6v097xDEVjoQFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=d67f53AHHW7a3+v8n2ZMVASsb7UsgtvJCpT+WMqYYqycl3I5BhQi0D9SIcuhUbAt7M
         rLvq/uA6h0Ogf9tu888Mw1dwP6e9xjwUZmoQqBOVXahi6mx0JKKmG10QUfCurOWtVL7n
         0H/Rky1h1IuOwm/LDHJ+JT/foMVg8F+PCzBUs=
Received: by 10.231.154.213 with SMTP id p21mr2002854ibw.42.1266622892809; 
	Fri, 19 Feb 2010 15:41:32 -0800 (PST)
In-Reply-To: <201002192334.52495.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140504>

oh. I see, thanks!

I had to do

$git log --pretty=3Doneline | grep fix

to get what i wanted...

On Fri, Feb 19, 2010 at 5:34 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> On Friday 19 February 2010 22:50:39 Eugene Sajine wrote:
>> When I=E2=80=99m executing
>> $ git log :/fix
>>
>> I expect to see commits with messages starting from word =E2=80=9Cfi=
x=E2=80=9D only
>
> You're not putting the puzzle together in the right way. =C2=A0The ch=
ain
> goes roughly like this:
>
> * git-log wants to know what its arguments resolve to
>
> =C2=A0* (the internal equivalent of) git-rev-parse works out that :/f=
ix is
> =C2=A0 =C2=A0a525d2a, as it (apparently) is the youngest commit with =
a message
> =C2=A0 =C2=A0starting with 'fix' (see man git-rev-parse)
>
> * git-log feeds a525d2a to the revision walker
>
> =C2=A0* the revision walker starts outputting commits backwards throu=
gh
> =C2=A0 =C2=A0history, starting from a525d2a
>
> and unsurprisingly, the log you pasted is just 'git log a525d2a'.
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
>
