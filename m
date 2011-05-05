From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH for maint branch] git-completion: fix zsh support
Date: Thu, 5 May 2011 22:29:37 +0300
Message-ID: <BANLkTikFnSuyfq6NT3wrWdE3AdkVXLmskw@mail.gmail.com>
References: <1304605458-1483-1-git-send-email-felipe.contreras@gmail.com>
	<7vtyd9830w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:29:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4F7-0003Y6-Ua
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134Ab1EET3l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 15:29:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37259 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab1EET3k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 15:29:40 -0400
Received: by fxm17 with SMTP id 17so1751649fxm.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 12:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Bn7cw0Ov5VJPmPjYUp7VpK2j9iV1pL6y8slejLe4AJc=;
        b=eS/Wp3M++k8Ei5J0g5oSE/N81lmogAQVSTCcBUMrbksWPLZII3kCawYDVvaZY8YOWk
         v//7E7tmWVtnxiF4HNkd3OjoZkMPXu/cu9l+h0TEUjeRfTmBqyitRL4zSYibFzoVYyVz
         LTahsZVRudrEa5el9FrZDQyc3SilRrKr4jJpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LZ8b1Ab4VuTggfmbIZWzBxhaMaLC9N6W0sGYlNj+/4VnAwv869AUQ2WmUVyt68Iwp6
         nJTqcuWmr9v3/WsecY/1bf7PjNcDzTsTMNWMU8WMnDnJNFdFhXOjsanHWPN7DFfmfuhS
         s6lZI93PV6Iwy0LUx0zFAIIZEjLk74SW6n9nU=
Received: by 10.223.87.215 with SMTP id x23mr1959609fal.32.1304623777641; Thu,
 05 May 2011 12:29:37 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Thu, 5 May 2011 12:29:37 -0700 (PDT)
In-Reply-To: <7vtyd9830w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172888>

On Thu, May 5, 2011 at 8:34 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> It turns out 'words' is a special variable used by zsh completion.
>>
>> There's probably a bug in zsh's bashcompinit:
>> http://article.gmane.org/gmane.comp.shells.zsh.devel/22546
>>
>> But in the meantime we can workaround it this way.
>>
>> Currently zsh is completely broken after commit da48616 (bash: get
>> --pretty=3Dm<tab> completion to work with bash v4), which introduced
>> _get_comp_words_by_ref() that comes from debian's bash_completion
>> scripts, and relies on the 'words' variable to behave like any norma=
l
>> variable.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> =C2=A0contrib/completion/git-completion.bash | =C2=A0 =C2=A03 +++
>> =C2=A01 files changed, 3 insertions(+), 0 deletions(-)
>>
>> This patch is meant for the maintenance branch, so Szeder's patches =
are not
>> needed.
>
> Do you mean sg/completion-upadates that is in 'next' need to be rever=
ted
> and replaced with this one? =C2=A0If that is the case I would love to=
 have an
> Acked-by in this patch.

Are those patches going to be applied on the 'maint' branch? The first
two are general cleanups, the third one is actually fixing stuff, but
it depends on the previous ones. My approach doesn't require any other
patches so it can be applied directly into maint. It can also be
applied on top of the two cleanup patches from Szeder.

--=20
=46elipe Contreras
