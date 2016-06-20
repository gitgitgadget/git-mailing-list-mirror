Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA2D20179
	for <e@80x24.org>; Mon, 20 Jun 2016 06:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbcFTGxe (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 02:53:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:50646 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbcFTGxc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 02:53:32 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M0y47-1bWhnA0kTH-00v4P1; Mon, 20 Jun 2016 08:45:31
 +0200
Date:	Mon, 20 Jun 2016 08:45:29 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Lars Schneider <larsxschneider@gmail.com>
cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perf: accommodate for MacOSX
In-Reply-To: <9A11C3D1-3DAC-489F-BDF9-F4D409E8D3F7@gmail.com>
Message-ID: <alpine.DEB.2.20.1606200840350.22630@virtualbox>
References: <ae429d2481111f7ad1927ef22e3a691d4c99ebd7.1466254995.git.johannes.schindelin@gmx.de> <9A11C3D1-3DAC-489F-BDF9-F4D409E8D3F7@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YHSsa7kp1JDXDXm98Ry/Dlo9tDdERMfQnLRp5L9ydmXm5W8Z5gY
 rI1QfJ6kEnMlA5JLbwmlJxjOFFzMDnk0pafRbKqsVWdYalwz+3+Nt2M8QeoI4+caz0PQ5IY
 lO0HlinhRqjzqhsGN45s7AHsizCbWwGzJIrefzoPo8b1RD+UjXTT3UchamUYVBtva86hzd8
 15DZPV2Dbv5tZaoTZ1h2Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:CTfJMSSx4wk=:vN4YuW0fPuOQzXzightOzd
 TrKxWvbmcsLy4g5+Z6wh8PZ8Te7/miX7tkfk1yT39yWFdGaJr21tmQnlglpxfWOugLnWd1Lc9
 75UxNCTqwrcTFuggBiUFk3kTrzhy2KhObtHz794bKD4Ayzop+QDKpAQtBuBCjLTPWATxjum1a
 3DHmnrbiJ7mKdY3iMkkLWyYz13dtExd7k8Tt1iesE/M6zBf4D5beu/9/37SZb8JiWhqhS+HrV
 JI2LpZRjMrk6nNc3Sjhq/se87gsgo05tOB7xtBhbBYyzUkx9QT0vyZhlJ2Ctxse+3YRYfizDs
 qfm9d+iUREV1B5jq/BD0NNL5kmh05o2QoHT77tBwjy96zhPeu6vCwovoGylfc5HCLqEThGIcc
 ywf6jEgX6iEU3bCvyyfhggTSc6CtlCFGGuWklyAauthQS4QXmviD2enYBPXGrje8JZ5EEB1ZX
 obDmRGcHbJ+IyiMEKHJP/GIy0jpcP59r9xEOwo1iIwvDOw+QL2P5Fox/Mw9D6jhTv9P8qT/PF
 f9LZBWTtSA24PgzMbXDggyEJdIiglnmUv8JFsZo8iUYuINXfKCoQTa/3zo/kMIGEps7Xcrb+W
 9eOiTiFp21Kk0cquHM/XtxQmXI+Wf2q+hZ6aQZbWPtKBldazT6PdG0X39UnMKqYph0clAZ/QC
 N/IGueSaevZyqjaKb8SHUby+msXVCtRgoX8Yn7assmy93QKg4H2oOYCXiAUbCcctJplX9tJ/w
 fFaTnNOgL58sP/IyCmtM9GowBYhS+ZBuu3RDLX8GkLQ6SMWn2P/enuBwBc3SmFYRAy+hMTBzE
 dsWJhFz
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Lars,

On Sun, 19 Jun 2016, Lars Schneider wrote:

> > On 18 Jun 2016, at 15:03, Johannes Schindelin
> > <johannes.schindelin@gmx.de> wrote:
> > 
> > As this developer has no access to MacOSX developer setups anymore,
> > Travis becomes the best bet to run performance tests on that OS.
>
> We don't run the performance tests on Travis CI right now.
> Maybe we should? With your patch below it should work, right?

It *should* work, but I'd be reluctant to run them as part of the CI: we
have no real chance to catch perf regressions as of now. So all it would
do would be to add load to Travis.

> I only saw one error on my local OS X machine here:
> https://github.com/git/git/blob/05219a1276341e72d8082d76b7f5ed394b7437a4/t/perf/p0000-perf-lib-sanity.sh#L26

Yeah, well, I should have been clearer in my commit message: this patch
allows the perf tests to *run*, not to *pass*... ;-)

> Does the export of foo not work properly on OS X? "$foo" is empty...

Sorry, as I said: I no longer have access to a dev setup running MacOSX.

Ciao,
Dscho

P.S.: Please save me time by deleting the remainder of the quoted mail
when it is irrelevant to your reply. Thanks!
