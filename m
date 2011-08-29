From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/2] am: preliminary support for hg patches
Date: Mon, 29 Aug 2011 19:51:35 +0200
Message-ID: <CAOxFTcyqGCB3TcS2CmFuVXqrCP2H-1aBDv3JJVKrNp-Q8Zahmg@mail.gmail.com>
References: <1314636247-26125-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1314636247-26125-2-git-send-email-giuseppe.bilotta@gmail.com> <7v62lg6tr3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 19:51:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy607-0004Ch-6c
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 19:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638Ab1H2Rv4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Aug 2011 13:51:56 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59606 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495Ab1H2Rv4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2011 13:51:56 -0400
Received: by ywf7 with SMTP id 7so4932911ywf.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=p8khenH4kS2m4MBcZzwbojxporzGUuMe17wftMMRtfw=;
        b=icXE1ttvZkp8y5l8LJtFsbhjXOLqSnyqQMgOqYaagaeQuIpisX0U0kEqCkPahwDz8/
         1vO5cPMstYTcutv4TOjP/Bx/0cNYqAwy5b+p+8YqTIAx9MiQctE4KvHjFBJv8oGARAo/
         agOCXUWuxEPPx+nM4xAKS3vRsj0eZduuOtWz4=
Received: by 10.42.139.137 with SMTP id g9mr4768729icu.75.1314640315171; Mon,
 29 Aug 2011 10:51:55 -0700 (PDT)
Received: by 10.231.14.131 with HTTP; Mon, 29 Aug 2011 10:51:35 -0700 (PDT)
In-Reply-To: <7v62lg6tr3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180327>

On Mon, Aug 29, 2011 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>
> I'll leave nitpicking of this patch and helping to improve it to peop=
le
> who actually have to deal with Hg generated patches for now.

[snip]

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # hg stores changeset meta=
data in #-commented lines preceding
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # the commit message and d=
iff(s). The only metadata we care about
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # are the User and Date (N=
ode ID and Parent are hashes which are
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # only relevant to the hg =
repository and thus not useful to us)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # Since we cannot guarante=
e that the commit message is in git-friendly
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # format, we put no Subjec=
t: line and just consume all of the message
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # as the body
>
> Personally I am a bit worried about the phoney "diff --git" output Hg
> seems to (be able to) produce. Do they have "index ..." line that exp=
ress
> the blob object names in git terms (implausible), for example? We _mi=
ght_
> want to strip s/diff --git /diff / so that apply won't be confused if=
 that
> turns out to be a problem.

Nope, it doesn't have index .... lines. Still, the patches seems to
apply correctly. Well, the couple of patches I tested did, at least,
even though they were marked as diff --git and they were lacking the
index ... lines.

--=20
Giuseppe "Oblomov" Bilotta
