From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC] (reverse) combined diff conflict style
Date: Fri, 19 Feb 2010 08:15:15 +0100
Message-ID: <36ca99e91002182315i25ad527dt553d79628734b02f@mail.gmail.com>
References: <1266521789-3617-1-git-send-email-bert.wesarg@googlemail.com>
	 <7v1vgi8eqw.fsf@alter.siamese.dyndns.org>
	 <36ca99e91002181243y371ce2f5i7136d8fbe6837b6b@mail.gmail.com>
	 <7vocjlx056.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 08:15:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiN5B-00060b-4e
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 08:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471Ab0BSHPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 02:15:19 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:12199 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370Ab0BSHPR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 02:15:17 -0500
Received: by fg-out-1718.google.com with SMTP id l26so182797fgb.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 23:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xYqfNd4NKczOtznyGVsqhQ09dVp7RBLxIivviKOgjKc=;
        b=tixPfnx4B3HshkzHJ+pSYpAgwdPrwLLqrMbJFCCgFlEqlrKOeothym3OxvrYLqs1Qt
         rFJsr32TkBn/D1t5UNPA6vczCXA7z+0VuEosaNxfPOYAabTAn3vnx9b2zt7iRa+Hn/rZ
         84SfrnOh4+We+bEWZ16lDrxmu5Kz8EqYa9Crs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rD8DyJ7a5r8/U452nnvufKbXhv9qlK73qDqRFAxa5UuJz+Q2LD9VMvPToBdDULSuBl
         Z/uH2SYk6O2v/Z0fNExhi2Ks/vqzuNov+AWKauO/88xT1UoIQ//+GUPrAImYiCD7dgSN
         j/mtMSXPK7nfkj9NIdZMFhXXjxLjxFCixA3K8=
Received: by 10.223.15.154 with SMTP id k26mr8646146faa.77.1266563715590; Thu, 
	18 Feb 2010 23:15:15 -0800 (PST)
In-Reply-To: <7vocjlx056.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140423>

[ Sorry, I removed the list by mistake. CC'ed again ]

On Fri, Feb 19, 2010 at 06:30, Junio C Hamano <gitster@pobox.com> wrote=
:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>> I use two programmed short-cuts in my editor for this. The first
>> 'applies' the diff, i.e. it keeps all lines prefixed with ' ' or '+'
>> and deletes lines with '-', and then removes the first column. The
>> second 'reverses' a diff, i.e. exchanges '+' with '-' and vice versa=
=2E
>> With these two operations I find it easier to resolve the conflict
>> than with the mege/diff3 presentation.
>>
>> I'm also convinced, that it is currently impossible to implement thi=
s
>> conflict style in the xdiff library. So it will probably be forever
>> some 'external solution'.
>
> Why not?
>
> IIUC, your approach is to postprocess output diff3 style merge.
>
> =C2=A0- First define your style as a new "conflict style" and store i=
t in
> =C2=A0 git_xmerge_style to pass it around. =C2=A0"checkout --conflict=
=3Dbert" would
> =C2=A0 learn this style automatically.
>
> =C2=A0- In ll_xdl_merge(), we usually call xdl_merge() and return dir=
ectly its
> =C2=A0 return value. =C2=A0When style is "bert", instead of doing tha=
t, you pass
> =C2=A0 "diff3 style" and drive xdl_merge(), _but_ you do not return. =
=C2=A0Instead,
> =C2=A0 you do your postprocessing right there and then return the res=
ult.
Thanks for this pointer. That looks really doable. Will report back lat=
er.

Bert
