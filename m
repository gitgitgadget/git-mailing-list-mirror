From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 22:56:41 +0100
Message-ID: <CAMP44s0y3UPVT+ndELaKNsWXAPG3kv-Xq_Wf6ONDF3Z99A5zMQ@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
	<CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
	<CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
	<CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
	<CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
	<CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
	<CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
	<20121116204017.GX12052@goldbirke>
	<7vr4ntkzy4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Marc Khouzam <marc.khouzam@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 22:56:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZTuD-0007VB-Bn
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 22:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250Ab2KPV4n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2012 16:56:43 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:54812 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab2KPV4m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2012 16:56:42 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so3263315oag.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 13:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=j+ciuNzWc94Gqoqv0Kx9wkBIqRRBGsDhVD8J4m7e4GA=;
        b=HqC6QKchck+sMLXrC5vndVgxX1q+MZkZsOhL2F0EwaYjeF0aroxigNJxt64Rg7o+ag
         CoEh4iZxuERFoLsiSbGspJzp92Q6P1o1peqNu2ZvcD/mvpGJxZHdJigv1310KG8tWzzs
         6VhYnSTve2le8LPhzihWstcb9tbLGWeWCDWdwHclYz8RQ0gopwecxXAKo1MwmZ5HtjVH
         FyNaFGPclrmF4Mw25ssZDT1FNDlwmqPZvxqeFodCJkxZ9uZC49FlZBlQMYxv5qTE6ThY
         Gm2XNqaAnkYDU5HLzlP5geLQEH88Otzdk+EOGTl84FWaThTJhaJUpDsbzrbvhxNoQJ5m
         LpLg==
Received: by 10.60.12.233 with SMTP id b9mr5164448oec.95.1353103001952; Fri,
 16 Nov 2012 13:56:41 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Fri, 16 Nov 2012 13:56:41 -0800 (PST)
In-Reply-To: <7vr4ntkzy4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209917>

On Fri, Nov 16, 2012 at 10:20 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> For zsh, perhaps?
>
> Yeah, I was wondering about that.
>
> If we make zsh completion read output from a little stub in bash
> completion, just like Felipe steered this series for tcsh, we do not
> have to worry about "zsh does not split words unless emulating a
> shell and here is a way to tell zsh to do so" kind of stuff in bash
> completion.

Do we worry about that now? If we do, the only reason is because we
hadn't had a proper wrapper, like the one I'm proposing to merge. So,
we had to put things inside if [[ -n ${ZSH_VERSION-} ]]. Those things
would move to my wrapper.

The only exception where we had to change code outside of that chunk
that I'm aware of is '8d58c90 completion: Use parse-options raw output
for simple long options', which is probably fixed in later versions of
zsh, and if not, we could always replace those functions inside my
wrapper.

> The point is not about the quality of zsh's emulation
> of (k)sh when it is run under that mode, but is about not having to
> have that logic in bash-only part in the first place.

As I said, that logic can be moved away _if_ my wrapper is merged. But
then again, that would cause regressions to existing users.

Maybe we should warn them right now that they should be using my
wrapper, and that this method of zsh support would be obsoleted. But
my wrapper probably hasn't received enough testing, so do we really
want to do that right now?

Either way, I'm confident that whatever code we need can be
consolidated in git-completion.zsh, even without having to run bash.

Cheers.

--=20
=46elipe Contreras
