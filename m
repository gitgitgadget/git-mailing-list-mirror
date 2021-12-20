Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85669C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 21:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhLTVUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 16:20:11 -0500
Received: from mout.gmx.net ([212.227.15.15]:60383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231310AbhLTVTp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 16:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640035170;
        bh=32AZoFLWeVJz98aqC08VFeKAbhahfuO9dDdWTHr/yaU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZRqoMwYXBP9fPf5lUwNZOQeB0gENKErNVcytJKEuCL6KUjH3YsZ5Y6MCzewWyQ0Hi
         qLJEscDywQwEb3HvkbmzXb1Ir5s6Kpfvpy5DzuSuSLmYDO4tHl9EUqpbIz/7Jb81Y3
         mkUPtc6kwfFjFPnQOLya1J4gVU5okCpCwoFfhRrY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.215.174]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCtZ-1mS0iz0ylr-00bNjJ; Mon, 20
 Dec 2021 22:19:30 +0100
Date:   Mon, 20 Dec 2021 22:19:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Joel Holdsworth <jholdsworth@nvidia.com>
cc:     git@vger.kernel.org,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v2 0/2] git-p4: remove "debug" and "rollback" verbs
In-Reply-To: <20211217140547.2115095-1-jholdsworth@nvidia.com>
Message-ID: <nycvar.QRO.7.76.6.2112202217570.347@tvgsbejvaqbjf.bet>
References: <20211217140547.2115095-1-jholdsworth@nvidia.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nHAIgD9TmK22Bx0y7wCU1MCfUzKt8F9Mn8Vm9tjFwv6s8nsaPv8
 3ALL44QlYE/TIIOqeXttNaXvby3+ZoT8MKFBRMsM+uRd2u1BTm5DvEyMxu4aaGAa+JrGyMa
 qlgDNajKm+EYMwWCBWCKO/gHxxv5qSB6fh9sPvxoRZ0hKFXncPlHwDC/vJOz8ced4Jx/HcD
 HHmIkhTjU6sDkVd+eMUGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8HVk85MDrIA=:uYehMSz46rQ/sFIw2uyt15
 Fd+hM2LSTKkg7y1nhRm0HoiVzbnoaw01j92wyB/jIR7vO+GbrRvDEbPr+KBLQfcYyZa0K6gdo
 HEthazaz2wbwVIShBDcFk1oeSlYsjZnYozq5B221r49rFRHrNg6qDZWxC7/5RGSfk2lDyyi3N
 J99YGcs98swF6Df4Z0vj4qfkyYmskDZ7oRZkdjkJgQtdsh48LecisobJIVMbkwXMIV4hEa30O
 tdGiIUv3ffkml3oGKqhyIkALBcdVOJ+Bcm1kWOEzlPegUHW2+Hwg0BFM2ULZrEhyvCyaCafe6
 MqFqd0M0GMDuanTV/wCv4dG8WlNO1GykRRrXOamAwDHUQH+WOyEJHgKJ5h+GUi32b+CWGeOfR
 h1fRTUi510ZoW0pbdVt0c3nWvRxA4518eL81KP9iCbLnh2oJd3jkpOUHB9WGcuDxRToSziYnV
 fR/f+60bQKlMzN8RnZPXRsQefSC6h4hRy1orKxIesZiQhd0lqiBNw8/pClCYk1RqbqD71hrkr
 0JDIO07cOLBjPDESBhhYcRAFneVVQQbFitGk/DWWVC41UDBz4NkKer0P88alXs0//mN032ZIP
 42nqMNl6sXp0KVDDo8V2OtdOsNc6H2quhxL0EEthKswyP9MOeR81mCGU8PXcDQ1UZBOLRdtUP
 umpxaSX7h53QmmvNtiuMeutWjsoxSe0IIB/FWSNbek6KA7/p54RXtixKEYAQoFbIRTvknyMFa
 Wg+vpagcR+pIKwdQaq6a7eUa7b31iAZfJaPlzCGutvXZ1Yslf6jiYWWHVgYLDcc3xmSgi+X6D
 Ctvf+viv1fe/PicrVNGqeozZA9K726raEBBl33ZRgH/5MT3qVxosV5eV3TuL+d9rBiBWOwxzm
 DVUZJ3tv5jLoPO/vurJAxkSNDZGtsMXdKuPJYwrV5myxEjSnljg+lkQaLjf4IRwGyLu6lfnG1
 9QQxb39vpWHx+o+jDsiLJ/16G6AxbbtheFW4k7qq974C3GVYHuQlsV/VaVDnXQnSyl2YV0+bj
 FRio/il7evv62cJtEjq4P4O20e4JYPSjcPWZGzJ5lAiBsEkR/rFm/suUNewcSus6KWOp6UUkX
 U74qWBGd+K8Fco=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

On Fri, 17 Dec 2021, Joel Holdsworth wrote:

> git-p4 contains a selection of verbs for various functions of the
> script. The "debug" and "rollback" verbs appear to have been added early
> in the development life of git-p4. They were once used as debugging
> tools, but no longer serve any useful purpose either for developers or
> users. Removing these verbs simplifies the script by removing dead code,
> and increases usability by reducing complaexity.

Thank you for Cc:ing me, but I am not really familiar with Perforce. All
my modifications in the git-p4 area stem from trying to let the CI/PR
builds pass... So I don't feel that I am competent enough a reviewer for
this patch series.

Ciao,
Johannes
