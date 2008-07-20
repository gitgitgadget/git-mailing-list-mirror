From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH 2/2] git-add -a: add all files
Date: Sat, 19 Jul 2008 21:28:32 -0700
Message-ID: <905315640807192128q5e1a4533m3c3585d534772df3@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <20080717155538.GE11759@fieldses.org>
	 <alpine.DEB.1.00.0807171915420.8986@racer>
	 <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807171940160.8986@racer>
	 <48806897.1080404@fastmail.fm>
	 <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>
	 <7vsku5grpr.fsf@gitster.siamese.dyndns.org>
	 <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org>
	 <905315640807192120k45b8c0e3k5b341e77c466dde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>,
	"Jay Soffian" <jaysoffian@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 06:34:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKQd4-0007NP-7h
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 06:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbYGTE2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 00:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbYGTE2e
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 00:28:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:62497 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbYGTE2d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 00:28:33 -0400
Received: by nf-out-0910.google.com with SMTP id d3so308135nfc.21
        for <git@vger.kernel.org>; Sat, 19 Jul 2008 21:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=sNAJ36AiYmkVqQnX6NfEqwcDvDrRpV2XXHZjoqPfdAk=;
        b=KSsGNHMA/FTJz3hdmWY8RMnUrTOjY6fH/Kt+E/UQRW39KTe5Ax75NcUBVNki1sm/Js
         OwHxPOw3D+erNPntAhxlBDIefgIyqjhLOP8TliVX85b+8wqoOGjqv2r2DisK48CNYc0D
         fwMmJLYkPJxYr8V/oz9MTA5Zw2AW0aonUS6UQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=ryfF/+szgfSli6GDQw+IiECecKJPcEZcTwHY6huVkPjHJ93CAWHMU3B3NCocLySW+s
         lnczX76RrlKN05+sqmeRE3vGqQC/H7zhYkrddM1Y/W2GyHkfbMZlEGD5XlJg+CxOxhwk
         ZhQp47UPyon9T63bgcC0WWL/IuL5o8wj5nmYs=
Received: by 10.210.60.8 with SMTP id i8mr1870259eba.24.1216528112186;
        Sat, 19 Jul 2008 21:28:32 -0700 (PDT)
Received: by 10.210.28.18 with HTTP; Sat, 19 Jul 2008 21:28:32 -0700 (PDT)
In-Reply-To: <905315640807192120k45b8c0e3k5b341e77c466dde@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 42cf27cf8883070a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89158>

On Sat, Jul 19, 2008 at 9:20 PM, Tarmigan <tarmigan+git@gmail.com> wrote:
> On Sat, Jul 19, 2008 at 8:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> People sometimes find that "git add -u && git add ." are 13 keystrokes too
>> many.
>
> It's too bad that 'commit -a' and 'add -a' will have different
> meanings.  Are add and commit considered porcelain enough that their
> short options could be changed?  Probably not, but it would be nice to
> align 'commit -a' and 'add -a' or maybe 'commit -u' and 'add -u'.  I
> can just hear people whining about inconsistent flags between
> subcommands with this change.
>
>> The support of this has been very low priority for me personally, because
>> I almost never do "git add ." in an already populated directory, and if a
>> directory is not already populated, there is no point saying "git add -u"
>> at the same time.
>
> Your reasoning for not using it (which is probably the case for most
> people), combined with the inconsistent short options makes me dislike
> the short option a little bit, but I like the long --add option.

I meant --all instead of --add obviously.

>
> Thanks,
> Tarmigan
>
