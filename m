From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH v2 2/4] apply: Allow blank context lines to match beyond 
	EOF
Date: Thu, 25 Feb 2010 00:02:52 +0100
Message-ID: <6672d0161002241502h2f80b511j445465fdc2fd16ab@mail.gmail.com>
References: <4B857CE4.4000201@gmail.com>
	 <7vaauyfj3k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 00:03:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkQFv-0005X5-LY
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 00:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758150Ab0BXXCy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 18:02:54 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:38742 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab0BXXCx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 18:02:53 -0500
Received: by wwf26 with SMTP id 26so1580457wwf.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 15:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CLSPWqh649NlUnNYLbbE9gSmqSQli0YxJwUqmyRZRqw=;
        b=MqfRZYOoFk//5ACkiwGMVucnkPUnLkqaZSYkAF75ziilazmq5/Ve6KFest1lA//K1U
         ZwZNzlwYX3x1R52GxgeOU7G78Yws/vVZkopdSIR7odiG+Z25s2VoGexGPkaNOt70PUy5
         L9ykk6cTgZNZkzKZBPgztgjWi7iqj1nBPLLuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AipM9uxBszxndkb56zW2kXKStlef5KGDtwHtiEZESn+ILTHygUqX0Vr1lOT3Ene2Hb
         EzPs3aW4yP1s0rtXUo77umGSWczvcdEjnnpa1R+DonLFjQB7CFZPL9yC3LkD2T6dsNJm
         kZqkbVMiIy5MkH7NakcefDHwUl6i64CTDMhGo=
Received: by 10.216.90.142 with SMTP id e14mr259079wef.85.1267052572229; Wed, 
	24 Feb 2010 15:02:52 -0800 (PST)
In-Reply-To: <7vaauyfj3k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140998>

2010/2/24 Junio C Hamano <gitster@pobox.com>:
> Very nicely done.

Thanks! :)

> On the other hand "limit" does not have such a good definition, other=
 than
> as a work around to bypass line-number check when we are trying to ma=
tch
> at the end. =C2=A0It might be cleaner to read if we move the problema=
tic "line
> numbers must match" logic and eliminate this variable, like the attac=
hed
> patch does on top of this one.

Yes, your version is better. Having a "limit" variable no longer makes
sense (my original patch used "limit" in two places). Feel free to
squeeze it in.

> I couldn't figure out how this would interact with the ignore_ws_chan=
ge
> codepath, though. =C2=A0That one shows a clear sign of being bolted o=
n as an
> afterthought (once you fall into that "if()" statement you will not c=
ome
> back).

Yes, it does seem bolted on.

I haven't looked much at that if() statement, because I
sort of assumed that because of the return it couldn't do any
harm.

It is too late in my time zone for me to think clearly, but it does
seem that I was wrong and that I'll need to do some changes in
that "if()" statement, and also write some more tests for
the combination of --whitespace=3Dfix and --ignore-space-change.

I'll be back another day.

Thanks for the review.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
