From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 3/8] gettextize: git-pull eval_gettext + die message
Date: Mon, 13 Sep 2010 21:57:45 +0000
Message-ID: <AANLkTikn8wB+DhoDJfKOiiNOVSAh0wd49ogpP_WDQ_DA@mail.gmail.com>
References: <1284406558-23684-1-git-send-email-avarab@gmail.com>
	<1284406558-23684-4-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 23:57:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvH29-0002zb-Ky
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 23:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073Ab0IMV5r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 17:57:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62008 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab0IMV5q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 17:57:46 -0400
Received: by iwn5 with SMTP id 5so5466082iwn.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BMqJ6rVDGApIEsMK2m44F2bdB01HUPxUFOyUXF8u/9U=;
        b=bnTyD6DRDICkX+5VX5dnmgq+2XhcE5SAWesqPjG0lgS9xChk2CI3htzINZMzO3LsX2
         1Uh/dQz8GNR9xkDwx08zfWKBBXQL5N+a0MT7OSuOOHTAdsn80+L1CG+xg9ROeW0nGSJ2
         pKtzXsB0Ah+39zC19m9ZXArVxlVmDHkUDFQEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JZh+AoH0sUrJC6IH4R8PwP3gLh6oOtrojlJ1gT6RTDe5pYjXxuIitO98/nn/jld/OS
         Aso2ktV9cHKUK7TprWxz4nLsSSkrkgmHfvSw9aWwZopBFB5f19KgZ+wTAPcGvHodsJnZ
         h36CXK5YfAmR4lypMxl2fd7L8Hq/dyDv0kaqQ=
Received: by 10.231.145.16 with SMTP id b16mr6721827ibv.198.1284415065710;
 Mon, 13 Sep 2010 14:57:45 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 13 Sep 2010 14:57:45 -0700 (PDT)
In-Reply-To: <1284406558-23684-4-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156130>

On Mon, Sep 13, 2010 at 19:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:

> -$ git diff '$orig_head'
> +\$ git diff \$orig_head
> =C2=A0output, run
> -$ git reset --hard
> -to recover.'
> +\$ git reset --hard
> +to recover.")"

"make pot" rightly whines about this:

    git-pull.sh:265: warning: Although being used in a format string
    position, the msgid is not a valid Shell format string. Reason:
    The string refers to a shell variable whose value may be different
    inside shell functions.

Just using "$" instead of "\$" for "$ git ...." works,
i.e. eval_gettext "foo $ bar" instead of eval_gettext "foo \$ bar".

Is that portable? Is " $ " always the same as ' $ ' in POSIX shells?
