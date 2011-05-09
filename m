From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 (for maint)] git-completion: fix zsh support
Date: Tue, 10 May 2011 02:58:32 +0300
Message-ID: <BANLkTikUe_Kwdi+F3vK-7kC9WNU-x_8LDw@mail.gmail.com>
References: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
	<1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
	<20110509225307.GG22908@elie>
	<BANLkTim1Di2ABtrv8ncVPT6+vCvq5pD_kw@mail.gmail.com>
	<20110509232804.GB23781@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 01:58:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJaLX-0007rG-QU
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 01:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899Ab1EIX6f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 19:58:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40819 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab1EIX6f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 19:58:35 -0400
Received: by fxm17 with SMTP id 17so3956377fxm.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9Rb0O5rVtAlp9wcC6NUWAPmDGJBr/6Jnqxt9tf7mnrU=;
        b=BF3Zzy+wareaF04hv42KpecsN5ohlac1dLdVqdVxSXuu/NcZo/8EC2nwCVyo2BIiTN
         KuS/kM51x4fcGshrzrZC4XC1xNkZJPDThcMA8vG7ceryHTyD9UyxAk+EmH5kvKb0XIrE
         NgyLQynJ3e8CfivGEOFpAfldkwHZg18HMp6yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mmZlxhEM0dLD/3nCf5BkQjom5vJkGmqWeXsPm5nG79TIDl5FKek/8S5Q3oUprGQ/Vs
         sd3ZKiW16rzJTzJ2HqKic2d/Kbxvzb26GtQMwufPMHkkhLweUnKtTvGz3gWFqfMdsNPQ
         JsEL0yfM2+In+ERY5/hv95OQagEO7d3AL1okc=
Received: by 10.223.77.4 with SMTP id e4mr3000593fak.51.1304985512838; Mon, 09
 May 2011 16:58:32 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Mon, 9 May 2011 16:58:32 -0700 (PDT)
In-Reply-To: <20110509232804.GB23781@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173295>

On Tue, May 10, 2011 at 2:28 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>> On Tue, May 10, 2011 at 1:53 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>
>>> =C2=A0- the fix in sg/completion-updates is less likely to be broke=
n by
>>> =C2=A0 future changes in the bashcompinit library.
>>
>> How exactly?
>
> Because there remains the possibility that functions from bashcompini=
t
> will make use of the $words variable. =C2=A0I have said this about th=
ree
> times. =C2=A0It is not very likely, assuming the zsh developers want =
to keep
> supporting that fix (and I think they should), but the chance is ther=
e.

And I even wrote a test to show you that's not the case:
http://article.gmane.org/gmane.comp.version-control.git/172963

Now, can you modify my test to explain how *exactly* zsh folks can
screw my patch up?

>>> =C2=A0- this fix is conceptually simpler. =C2=A0In a way, the fix i=
n
>>> =C2=A0 sg/completion-updates only works by accident.
>>
>> You are missing other advantages:
>
> Sorry, I should have prefaced the above with "in my opinion". =C2=A0A=
nd to
> be clear, I am not saying this fix should not be applied; I am just
> explaining the trade-offs as I understand them.
>
> The reason I asked for another opinion is that I find it hard to be
> objective in this case, because of another consideration I didn't
> mention: each moment I have been spending on this is an exercise in
> frustration.

Well, don't :) Just ask yourself this question: is the patch good
enough? If not, send your own version.

Personally I think the latest version of the patch clearly explains
what it is doing, and why. It even has comments on the code, which the
other alternative doesn't.

--=20
=46elipe Contreras
