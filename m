From: Frank Li <lznuaa@gmail.com>
Subject: Re: git-mailsplit and TortoiseGit bugs
Date: Tue, 23 Jun 2009 09:26:51 +0800
Message-ID: <1976ea660906221826lfc074c2x6231dcae16535a9c@mail.gmail.com>
References: <5b31733c0906221053k4b2659bev1da861b8e997eb5f@mail.gmail.com>
	 <20090622202939.GA11912@sigill.intra.peff.net>
	 <5b31733c0906221446m1a82b39fkd5d25ea413697138@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, tortoisegit-dev@googlegroups.com
To: Filip Navara <filip.navara@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 03:34:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIuto-0003aL-2Z
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 03:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbZFWBeB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2009 21:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbZFWBeA
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 21:34:00 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:38057 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbZFWBd7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2009 21:33:59 -0400
Received: by wa-out-1112.google.com with SMTP id j5so536818wah.21
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 18:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9941SHEn3kFGX1sljDjFymMFVOSwbYlbN2pG9pcv7v0=;
        b=c1DjByYfQKWAue7qe3aJ+aPQX4WAKUFrWBKnT4eSSn+DUF+BdXRA0uDWB6vYOeK1R4
         H0WaaAGVmCBdsUfd06NJZDmiT7UKnHY/ZT+Rj71U15dzE2tJHR0KRveoHkUIaDVsy+Uz
         wUM9PyxNMMmNitMpEI/U7BF1jfJCrQhf+UPaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wSAuKAAgicXjCFe8Gl/qAp4hLrWe3/Rp1kpsbeAHvl+wIlfZ0WwB97tdARw1kSwDd8
         0XOIkl3tXJcfPlbX1zbmRn9W8MhRvjiPxiusLEH3LdYmznjg0Ld9NYrmqiLytxsN7cr7
         1VTgg6KSCIo97e8E1vXZ1c+r8waDtFhQzdZ8Y=
Received: by 10.114.58.17 with SMTP id g17mr3569241waa.167.1245720411055; Mon, 
	22 Jun 2009 18:26:51 -0700 (PDT)
In-Reply-To: <5b31733c0906221446m1a82b39fkd5d25ea413697138@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122070>

Do you means I should remove "boundary=3DWC_MAIL_PaRt_BoUnDaRy_05151998=
"
when send patch without attachment?

Tortoisegit bug report:
http://code.google.com/p/tortoisegit/issues/list

best regards
=46rank Li

2009/6/23 Filip Navara <filip.navara@gmail.com>:
> On Mon, Jun 22, 2009 at 10:29 PM, Jeff King<peff@peff.net> wrote:
>> On Mon, Jun 22, 2009 at 07:53:51PM +0200, Filip Navara wrote:
>>
>>> I'd like to report a bug. There's an incompatibility between the wa=
y
>>> TortoiseGit sends patches by e-mail and their handling by
>>> git-mailsplit. The mail sent by TortoiseGit specifies the Content-T=
ype
>>> header as "Content-Type: text/plain;
>>> boundary=3DWC_MAIL_PaRt_BoUnDaRy_05151998". git-mailsplit then
>>> misinterprets it and treats it as empty patch. While TortoiseGit
>>> should not be sending the boundary parameter, it is perfectly valid
>>> e-mail according to RFC 5322 and MIME RFCs. The "boundary" paramete=
r
>>> should be ignored for anything but "multipart" Content-Types.
>>
>> That seems like a bug in TortoiseGit, and I don't know if it is wort=
h
>> git trying to work around problems in something that is not even clo=
se
>> to a 1.0 version.
>>
>> Still, it is good to be liberal in what we accept. So maybe the patc=
h
>> below is worth applying (I assume from your description it will fix =
the
>> problem you are having, but I didn't actually test it with TortoiseG=
it;
>> please confirm that it helps).
>
> Yes, this patch helps. While TortoiseGit shouldn't send the parameter
> in the first place it's still prefectly valid e-mail that should be
> accepted. Of course I will report it in the TortoiseGit issue tracker
> for fixing.
>
> Thanks,
> Filip Navara
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
