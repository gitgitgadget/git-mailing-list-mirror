From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH] merge: allow "-" as a short-hand for "previous branch"
Date: Fri, 8 Apr 2011 00:13:30 +0100
Message-ID: <BANLkTikA3dFQpZWC=TC3+zp2FS=uBBxf0Q@mail.gmail.com>
References: <7vmxk164wd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 01:13:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7yOe-0003Zz-JW
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 01:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab1DGXNq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Apr 2011 19:13:46 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50966 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757120Ab1DGXNq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 19:13:46 -0400
Received: by qyg14 with SMTP id 14so2133703qyg.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 16:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7Dhz3aV+5xFuR8cJ5/tBP/XN1qIpVXRlYwt7trhL8Ug=;
        b=HV3GEorCwS2JIKE5Y/EmocMZNSwjIOxDPmo4JzLtpaGQu0ISMVivB3eMGlazkvej17
         oq+gNh5pNDphtEgI3R/KikzceWUuKWB0/XFugGSVU/3xsJwfdrMz34ohyeZlu2gS9ZZM
         VTdD9GLOsTfkfPYOq8IQubn9rmM3BDHLI3vbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=sw1JXiMqMUXIfCWNcZ83LNar0T/Qgi2mY4XaFaUMdq+s/aQocExjjv1xQW7bXOI8Bz
         5FLqQE1rOBTcU6xU5+KXMZ9tTL7GmbowbBXCfRUey9wImE4SJOnEnoxKdyZh5iPijwiA
         MsxHLt19B8xbq5kCF6beOZfyxNNEeHcI47Sc8=
Received: by 10.224.9.2 with SMTP id j2mr1195488qaj.57.1302218025211; Thu, 07
 Apr 2011 16:13:45 -0700 (PDT)
Received: by 10.229.44.144 with HTTP; Thu, 7 Apr 2011 16:13:30 -0700 (PDT)
In-Reply-To: <7vmxk164wd.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: G_2o0tN115vivdASptVBVK650fI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171092>

Hi,

On 8 April 2011 00:03, Junio C Hamano <gitster@pobox.com> wrote:
> Just like "git checkout -" is a short-hand for "git checkout @{-1}" t=
o
> conveniently switch back to the previous branch, "git merge -" is a
> short-hand for "git merge @{-1}" to conveniently merge the previous b=
ranch.
>
> It will allow me to say:
>
> =C2=A0 =C2=A0$ git checkout -b au/topic
> =C2=A0 =C2=A0$ git am -s ./+au-topic.mbox
> =C2=A0 =C2=A0$ git checkout pu
> =C2=A0 =C2=A0$ git merge -

I agree this is is useful, but is there a danger of this being a
common typo, and people merging in previous branches a lot more often
than they ever intended?  In the case of "git checkout -" that's not
as fatal, but if I ever mistype "git merge -" -- I'm now left with an
unraveling exercise to do.

Hopefully it won't be an issue, as it's no worse than mistyping branch
names -- I suppose it's the sheer length of "-" in this case which
leads to more potential for problems.

-- Thomas Adam
