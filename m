From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v7 6/9] submodule: fix detection of invalid submodule URL
Date: Tue, 29 May 2012 07:39:29 +1000
Message-ID: <CAH3Anrrg4Fc5GXB_VwOXRfwP=hx5Xn5bqimP56oDB0USn7c4Cg@mail.gmail.com>
References: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
	<1338132851-23497-7-git-send-email-jon.seymour@gmail.com>
	<4FC3CB7E.6000501@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com,
	phil.hord@gmail.com, ramsay@ramsay1.demon.co.uk
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon May 28 23:39:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ7f5-0006lQ-Pv
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 23:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab2E1Vjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 17:39:31 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51711 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab2E1Vjb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2012 17:39:31 -0400
Received: by wibhj8 with SMTP id hj8so2036732wib.1
        for <git@vger.kernel.org>; Mon, 28 May 2012 14:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fHpL8rsQy8h4wWesYhFxriWsg6akU+ps7VJjNiZyA5s=;
        b=y4FV4HWGIZAkFI+6bRQZ/4rS58rN8vMJW2OlU4wVLpvFvnYG2zD+Ci3SKLJtByzW4a
         ElDFh68SCBY5xat/foYrHCsPd44eJWoVkrLLU/1sH5WonLbKntWXm93r5DxJWsZPe9zc
         bxNRqHjhFauX5g+T/ypnRH53PSRYyuLEIWcp/nLr3lQD3bhXD1wCgrEDiB7vaXEuF06O
         7VAmp8r+etk/BovnQS1eauzxPAIHQDfwG95xKMVS+pcbU8cP+Xz2vplOktNCYivMuAeC
         6nuzsPsWjtKADwgEcGvIV7SWDuLsVtXU32UB/Y2/Qm+/JbowLh3QnGpUtW+5a+Ia+AUU
         tS2g==
Received: by 10.216.55.148 with SMTP id k20mr5385568wec.70.1338241170030; Mon,
 28 May 2012 14:39:30 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Mon, 28 May 2012 14:39:29 -0700 (PDT)
In-Reply-To: <4FC3CB7E.6000501@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198725>

On Tue, May 29, 2012 at 5:01 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 27.05.2012 17:34, schrieb Jon Seymour:
>
> Without understanding in detail what this series is about, I would gu=
ess
> that the previous two case arms are not very Windows friendly. Does t=
he
> right thing happen when $remoteurl is "c:/path/to/remote"? Would it h=
elp
> to use is_absolute_path?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if is_absolute_path "$remoteurl"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0variant=3D"${r=
emoteurl#*/}"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$remoteu=
rl" in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...other cases=
 go here...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> -- Hannes

Thanks, I will investigate this as an alternative.

jon.
