From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] hooks: Add ability to specify where the hook directory is
Date: Mon, 25 Apr 2016 16:19:20 +0200
Message-ID: <CACBZZX6T-vmgbMTyrbU+228mQoRFzgCjkV13uiQyedmc8SfyAg@mail.gmail.com>
References: <CACBZZX7jTHqSq0ADJxO0cP+1MZMWAowLMMj4J0NHkFTYOYsJiw@mail.gmail.com>
 <1461532702-4045-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 16:20:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auhMm-00022U-1R
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 16:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbcDYOTn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 10:19:43 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:33464 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbcDYOTk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 10:19:40 -0400
Received: by mail-qg0-f46.google.com with SMTP id f92so30478599qgf.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ysD44d04qsC1lnTlrTU0iJyVGs3bdwsiGfzkpxK7X7E=;
        b=JXRODhnts8UXIbVq5VeBg9gyApUmC5vgSbsWKcoBl7oBsEVPhW47GsdalXUJRT4n2Q
         GN4CjtbtUVJPNSU45HVQlYviHXUX3/baH5RWfy1x+nE+3iyBTSf89TFwzEk+NfmhsBxQ
         FB1ANv5iwy7sMhFT/Y+uSjCM4wHv+5LbRkmfBG+xX3Y2BG/sJwJtyc5JfX0Ry/cZJUWm
         rnXrOk5Qxs1Vt27xDQvjGE0zOvPEIzb3zsQNjSRHXE4XT/a8toceuIStwXDhUzrnhCfZ
         XkfnCKDH1wyyEMyVYkveYmMTmF78IfITFwpA5lw5eM9GG2TsYar37saARi+2XMk6e5zP
         853A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ysD44d04qsC1lnTlrTU0iJyVGs3bdwsiGfzkpxK7X7E=;
        b=NOalN8zo9ScUbCBhcZsBr31W2HVtVHhDow8BsUgDiJUYL3e+BsqRZ6GVdzHVknm3AG
         iGXplNlXGOEb5bpETwCSe2gDhu7CuSz580Cm2pBPmxWhqR5XePWc+2WQ5o0N2BOyUY6o
         eV2fCe9anfeqUkIrQh4wgDHsFG7fB2p+widf5yjBv5GqZDV1D4+uoEhOGVKHGH+mVece
         aiUB4ecV1cWe7SlTH8TbkDTJSw6hg7+Ll1EkhlqKXO72C24/zoGAfResGBqUXPno2xDz
         zp2SMTRc2M9mDGbxC6eA+0nhJ0+eRq5miIiYubcvkAnBpiWPd158WrEcV795atj2d2ps
         wpZg==
X-Gm-Message-State: AOPr4FWGQvKawtHBfz0jLmG0J6KdNcPnmK/aMyuMSZ8UKvQQscgMHmACt9dWD1VDRuNI7kDPGQl5VfYm3OO2Zw==
X-Received: by 10.140.89.19 with SMTP id u19mr34902761qgd.90.1461593979492;
 Mon, 25 Apr 2016 07:19:39 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Mon, 25 Apr 2016 07:19:20 -0700 (PDT)
In-Reply-To: <1461532702-4045-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292485>

On Sun, Apr 24, 2016 at 11:18 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
<avarab@gmail.com> wrote:
> Change the hardcoded lookup for .git/hooks/* to optionally lookup in
> $(git config core.hooksPath)/* instead.
>
> This is essentially a more intrusive version of the git-init ability =
to
> specify hooks on init time via init templates.
>
> The difference between that facility and this feature is that this ca=
n
> be set up after the fact via e.g. ~/.gitconfig or /etc/gitconfig to
> apply for all your personal repositories, or all repositories on the
> system.
>
> I plan on using this on a centralized Git server where users can crea=
te
> arbitrary repositories under /gitroot, but I'd like to manage all the
> hooks that should be run centrally via a unified dispatch mechanism.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>
> This is based off the githooks.txt series I just sent, I thought it
> made the most sense to address the questions the previous version
> raised about how we treat the working directory with unrelated
> githooks.txt doc improvements.
>
> This version also address all the other issues SZEDER G=C3=A1bor note=
d.

This still applies cleanly on top of the v3 githooks.txt series I just =
sent.

I forgot to note one thing, when I re-rolled this I changed the
configuration variable from core.hooksDirectory to core.hooksPath,
everything else in config.txt that dealt with paths was *Path
something, so I thought that made more sense for consistency.
