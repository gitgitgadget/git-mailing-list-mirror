From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] commit: Add commit_list prefix to reduce_heads function.
Date: Sun, 5 Dec 2010 19:29:12 -0200
Message-ID: <AANLkTi=QK=N+_iGR9-47JKFs_SDKujJ8c4mtnnM0yo94@mail.gmail.com>
References: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
	<20101205021837.GA24614@burratino>
	<AANLkTinAT3kotKQTS6eS1SLigNzSp6grAU7WNRbHf3N=@mail.gmail.com>
	<20101205170919.GA7913@burratino>
	<AANLkTikL4BWtzNgx1+MBYxRRdfL=Gu71KPjaiKXprvnb@mail.gmail.com>
	<AANLkTinjJpGW2OiXM3edWYaNhS+w4qNLrvg-0aBwsL=x@mail.gmail.com>
	<7vk4joszcj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 22:30:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPMA4-0007ue-0j
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 22:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab0LEV3O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Dec 2010 16:29:14 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54630 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab0LEV3N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Dec 2010 16:29:13 -0500
Received: by bwz15 with SMTP id 15so10006843bwz.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 13:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Rftu9k4AtZ/B7l+g59Nui+01SdRGr8VzIeuzUwkS4/8=;
        b=xR3RiAInmtjsuSuw7ly+Qj03+y6HGQhPjSPxehpJ/d1QlcB6JABOQvlX0la+MGaroY
         LS+YHhbyMzXMMNjvKPvQa0chdCNqIvbZe2hRSciNLMYm+aAhtUpmGpq6qm2hqoc8o8Lg
         YcDUtTroOW74aDdaP7uJJPwSc/Iy+mn06lreM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rCPkr22AodtOHinoj/exrro3q0Vorku9vDoQVNAp5YCM5vp5ZBOM1PpGEIfIXbmQmj
         W5Ng92DFwIznzPIer3/55bNJehBOSWvHec+jNtwIWiijbBeCwwoflBGIdiZZOn5KRfcx
         nYVOLomI6ths9xQ21SR/aIr/z2ceTQ4R5v6cc=
Received: by 10.204.32.145 with SMTP id c17mr3475394bkd.40.1291584552279; Sun,
 05 Dec 2010 13:29:12 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Sun, 5 Dec 2010 13:29:12 -0800 (PST)
In-Reply-To: <7vk4joszcj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162964>

On Sun, Dec 5, 2010 at 7:07 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Thiago Farina <tfransosi@gmail.com> writes:
>
>> Also I thought that as Junio already picked up the other patch. It's
>> was a hint that the other functions that has "struct commit_list *l"
>> as its parameters could be renamed as well.
>
> You took a wrong hint and I think that is because you didn't think ab=
out
> what naming is for.
>
> "insert-by-date" does not say _why_ you want things to be inserted by=
 date
> (neither "sort-by-date"). =C2=A0They are pretty generic looking names=
 for any
> function that deal with a list of elements that record date. =C2=A0It=
 makes
> sense to anticipate there will be many other such functions that deal=
 with
> different kinds of lists that hold date-recording things, and naming =
one
> of them "this deals with list of COMMITS" by saying "commit_list_foo"
> makes quite a lot of sense, as "insert-by-date" does not give suffici=
ent
> information to the reader.
>
That makes sense to me. And clarified why the complain at all. And you
are right.

Would these be a candidates for adding commit_list_ prefix?

free_commit_list -> commit_list_free
contains
pop_most_recent_commit -> I'm not sure about this because of the
length of it, as Jonathan pointed in this thread.
pop_commit
