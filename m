From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Automatically autoload bashcompinit for ZSH, when needed
Date: Wed, 27 Apr 2011 04:11:26 +0300
Message-ID: <BANLkTindtTVcLetYs1wJ0K9BcQO7YNYpvw@mail.gmail.com>
References: <7vtydkddto.fsf@alter.siamese.dyndns.org>
	<1303849690-20894-1-git-send-email-mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 03:11:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEtHx-0002Zf-2L
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 03:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab1D0BL2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 21:11:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56759 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab1D0BL1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 21:11:27 -0400
Received: by fxm17 with SMTP id 17so818856fxm.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 18:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6kSXZuKUHqNFc5/NjxKDKLRFNDEwrO+weZccOEy6HWk=;
        b=LFrcwtobdwfh21h4kYJZgrFxG1YeAC30iqCheCsA8HrABtWK1mEdG7rHqB5ThzhHQE
         SUhQm8WBjPSY3mSzzfMJ7AB6yUXc3FymEv1qdJvk1ealGOEPMweqQJkfC97NEi+vyLza
         JfFDGkQMBQBwKLiznn38a6oylxk4idNrhiiRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VdvAhwzNiJ3lzAnOuPMlrQLz+QpjZYPVcH27zTrO0o2BNxGtv66CWtX/0HzX6MkXCZ
         SxFTssgU/fPlQR2A7YLq1o13M9F4CxVIdoOZMtbXYeF3kavEFTfdDIVa/332bC40bfjp
         NBRQP8O+FU5nEq1kbVXtBcjoa7VraMVHt7gTw=
Received: by 10.223.87.16 with SMTP id u16mr1601378fal.13.1303866686271; Tue,
 26 Apr 2011 18:11:26 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Tue, 26 Apr 2011 18:11:26 -0700 (PDT)
In-Reply-To: <1303849690-20894-1-git-send-email-mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172139>

On Tue, Apr 26, 2011 at 11:28 PM, Marius Storm-Olsen
<marius@storm-olsen.com> wrote:
> If bashcompinit has not already been autoloaded, do so
> automatically, as it is required to properly parse the
> git-completion file with ZSH.
>
> Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
> ---

> +if [[ -n ${ZSH_VERSION-} ]]; then
> + =C2=A0 =C2=A0 =C2=A0 if ! bashcompinit >/dev/null 2>&1; then
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 autoload -U bashco=
mpinit
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bashcompinit
> + =C2=A0 =C2=A0 =C2=A0 fi

How about this instead?
autoload -UX bashcompinit && bashcompinit

--=20
=46elipe Contreras
