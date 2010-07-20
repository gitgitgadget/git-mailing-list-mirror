From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH v3 05/13] parse the -L options
Date: Tue, 20 Jul 2010 23:46:04 +0800
Message-ID: <AANLkTinXDRV_Ikd-hoGoWPZmn1Tp0NYHoumaqthydsuw@mail.gmail.com>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
	<201007200048.18284.trast@student.ethz.ch>
	<7veiezni4m.fsf@alter.siamese.dyndns.org>
	<201007200951.56218.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 20 17:46:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObF1U-00086c-2p
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 17:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491Ab0GTPqQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 11:46:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51119 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354Ab0GTPqP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 11:46:15 -0400
Received: by pwi5 with SMTP id 5so2188727pwi.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Fb+N40Juc2Ot3uu7knTSjOSETBEpbXiBg6dwB6foDZA=;
        b=ue6zverZAjVjSRrqC+1ZQKzQxygAcy4gmDuvCMBUKezsqlFBKr8PG55ThI8/n1NetD
         GCwtU/fBtPr0TTmgrPQ2q1VWP1k9ayyVcJ6+KwiDh2m12gbKxzJIQhAjo1nCuNMsQZcM
         ynbreCK1ETMzZQ6k5aWxNYfiiziSuhwiAGEhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Lw2OK822Xa+U/EgUcD7Md/8EhW9JmhHSGG4WRRrOcFvhkQzuX/Z5myVUNoHtajechp
         6e2NNeR8i1jloom7846ZOlc9fRZYl+COeus8UAowG5N3OvendxuoNT91OIAmkDlZSDFE
         J7MldigJIHDfzeCHncaAYac6iuXGfyqRvJZMM=
Received: by 10.115.109.6 with SMTP id l6mr9709249wam.164.1279640764981; Tue, 
	20 Jul 2010 08:46:04 -0700 (PDT)
Received: by 10.229.217.149 with HTTP; Tue, 20 Jul 2010 08:46:04 -0700 (PDT)
In-Reply-To: <201007200951.56218.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151319>

On Tue, Jul 20, 2010 at 3:51 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Junio C Hamano wrote:
>> Thomas Rast <trast@student.ethz.ch> writes:
>> > I think that would just needlessly break the analogy to git-blame.=
[0]
>> > With the current code,
>> >
>> > =A0 git blame -L 2,3 <path>
>> > =A0 git log -L 2,3 <path>
>> >
>> > work the same.
>>
>> I like the general direction, but I am not sure how far we want to t=
ake
>> that analogue with blame, though.
>>
>> For example, Bo's "log -L" thing also works on more than one path, n=
o? =A0I
>> suspect it might be be reasonable to teach "blame" to annotate more =
than
>> one path (with ranges) the same way. =A0There is no technical limita=
tion in
>> the underlying scoreboard mechanism to prevent it from happening.
>>
>> Very similar to "blame" but quite differently from any normal "log"
>> operation, "log -L" allows only one positive commit (starting point)=
=2E
>
> AFAICT this is not a conceptual requirement, only one of the current
> implementation/option parsing. =A0[Bo, how hard would it be to remove
> this requirement?]
>
> 'git log --follow', if it were ever unbroken, would have much the sam=
e
> problem that while technically allowing more than one starting point,
> using that is only possible if the starting filename happens to agree
> on all of them.

I think Junio here did not ask for 'git log -L' to support multiple
starting commits. [1]
Considering the arguments you give below, I am in support of put it in
'git log -L' as what we do, now.

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
