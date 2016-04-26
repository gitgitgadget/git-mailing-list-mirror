From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 03/15] submodule add: label submodules if asked to
Date: Tue, 26 Apr 2016 15:50:59 -0700
Message-ID: <CA+P7+xrPYHEoLPNbGaSDSniHUCLeqj+d85ei3T_uwnBmz68G1g@mail.gmail.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com> <1461703833-10350-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 00:51:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avBpE-0000dY-LZ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 00:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbcDZWvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 18:51:21 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35761 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbcDZWvU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 18:51:20 -0400
Received: by mail-ob0-f169.google.com with SMTP id n10so12769717obb.2
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bCbeknZ8vqiWw1poFXP+xDLZ5aNAMphSVeTZtaY42aM=;
        b=mGGyeguVr4/q9ilYvo3nN7jiRqYS4cyu9gNNg37LkiZlNiNaTkY/qJx28lpJ06HtRp
         nvUwxliDtPn5R3NNCY0hlQ0WK425O3SscAvTbRQUTv8YeBHKI5p6BtxcvhbKWtP8XGrE
         /VFFnIkkEBdz5ZzyeRurv0Lyfhe3mMSw/76kGm2Len7Equ4O87U0q6n98G8eK8fnyysL
         998duCgvRjGRePa3ou1e4KDKEVGtwRmpt1QG55H27QKwGRQIoM6Z9TirbyP4D0GIrl1y
         xd7toTeqCbkkmyUHGh/lj4Gp/7drSgl5nsgphLyclaBGykSE9aErYB+qz9yzq668eccp
         w8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bCbeknZ8vqiWw1poFXP+xDLZ5aNAMphSVeTZtaY42aM=;
        b=ISH8ZBpc9WmoiSnB4Q0Nmkzge5oyYG2/5sedS7jSDZ+XuDi2vtGWNTPvRGjt4BUCSb
         WllXioDVsC3usxAkROeNhTnefvOjta/1060o7hEw7fD0GEV72cjMctJaGXPFDdu3Lm0D
         v7VFlesmiJdNGu5fT92gLLRf6RPG7dVcACfmpCOypKihY4mkOb2gXpvnaXl5Pu3XnS4R
         dtU7kUB3FWIlCSlu1MhCBe944ZNZ5g81OVNEmS/XiuLcFGQa5Q44u8PyJxmP8/QUrfYV
         pcEoQp3k8CH3I0cSYxzGxPgERYfJiQmqjsK5wY4BXWtLZJjB43HGSabMzvOssnq3LiW2
         RgfA==
X-Gm-Message-State: AOPr4FX4ng3czP3AFBmQZoMETZZfeExRcwh0R2K4OiiK6WaEWBA/yG3zjptOwyCbiJ2N/wDMH/kEboY8THUOwg==
X-Received: by 10.60.52.177 with SMTP id u17mr2258069oeo.61.1461711079371;
 Tue, 26 Apr 2016 15:51:19 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Tue, 26 Apr 2016 15:50:59 -0700 (PDT)
In-Reply-To: <1461703833-10350-4-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292694>

On Tue, Apr 26, 2016 at 1:50 PM, Stefan Beller <sbeller@google.com> wrote:
> When adding new submodules, you can specify the
> label(s) the submodule belongs to by giving one or more
> --label arguments. This will record each label in the
> .gitmodules file as a value of the key
> "submodule.$NAME.label".
>

Ok so labels will be in the .gitmodules file. This means that if we go
back in history using git bisect or something similar, we'll
potentially change what the default submodules are for example?

This is sort of why having some submodule data appear in the
.git/config file is useful since it helps keep things like the remote
url safe from being updated when doing this sort of thing.

I am not sure if labels will be that important in this case?

Thanks,
Jake
