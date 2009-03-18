From: pi song <pi.songs@gmail.com>
Subject: Re: [PATCH1/2] Libify blame
Date: Wed, 18 Mar 2009 18:01:43 +1100
Message-ID: <1b29507a0903180001yd510e49ld6d41a171f94e211@mail.gmail.com>
References: <49BE5343.60900@gmail.com>
	 <7vocvzmlqf.fsf@gitster.siamese.dyndns.org>
	 <1b29507a0903172259t348cb4d5n70f5b3003b1eeb00@mail.gmail.com>
	 <7v3adbmjwy.fsf@gitster.siamese.dyndns.org>
	 <1b29507a0903172352x7864911fm1104e22eddde54f1@mail.gmail.com>
Reply-To: pi.songs@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 08:04:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjppI-0008FK-N4
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 08:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbZCRHBr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2009 03:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbZCRHBr
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 03:01:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:41317 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbZCRHBq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 03:01:46 -0400
Received: by yw-out-2324.google.com with SMTP id 3so405853ywj.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 00:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=ir/dT1MEp1kAwQgsmRHFLqCyKeFgwjtC13wePNGNtmI=;
        b=I1W9P5qTnzJDnfh31HaAlubY6u/M5ZROKwp5yLQ/2zdjnY2fY+GJ0dA6ljKeUjU7No
         /vxbPYWNOQiIuNbajpamyHwmiNs7OtlfXMjiRAX2lw3xgN4iqhUVgTFvpMi7C3Kx99gz
         9c2UOC+0rKmKlRsZ4DiYtUrqmFNQD3R+0StJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        b=RDUA0H7dDKxPaAd2EqcXY/XyhHkW+mol4J2ymFFt/W9Qt1GBaTyeZ07Xt8mqz5PfCK
         xptCzOq/PSwjVDk9wKD5oQEYj2bDAMAnEFtzYXWvIl2233YrPVFx11RLEtI9jaipREzw
         Z8X2aocBmAGTTFCsA0wWqCTqwJ+qxdNvx/W/I=
Received: by 10.143.3.16 with SMTP id f16mr368396wfi.344.1237359703735; Wed, 
	18 Mar 2009 00:01:43 -0700 (PDT)
In-Reply-To: <1b29507a0903172352x7864911fm1104e22eddde54f1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113590>

BTW, following patches are not available yet : P

On Wed, Mar 18, 2009 at 5:52 PM, pi song <pi.songs@gmail.com> wrote:
> Wait. If you look at the builtin-blame.c, out of question it is very
> messy. Things like print_usage() or -L parameter parsing for example
> is not done upfront but hiding somewhere. Some functions are not very
> clear if they are frontend or backend. I would say nobody would be
> able to split it right in the first place. What you could do is to
> split it to something "roughly right" and then work from that.
>
> My latest two patches really do nothing but just splitting files. I
> haven't changed any logics or renamed any thing only to make this big
> beast more *manageable* rather than tackling the problem directly.
> Yes, some bits are =C2=A0still wrong but I believe 70% of the functio=
ns
> should already stay in the right place. The following patches will
> make the structure more right *gradually*.
>
> Pi Song
>
>
> On Wed, Mar 18, 2009 at 5:20 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> pi song <pi.songs@gmail.com> writes:
>>
>>> Don't you think we should rather split up into smaller files before
>>> start reorganizing things?
>>
>> Yes, but splitting it wrong is, eh, wrong ;-)
>>
>
