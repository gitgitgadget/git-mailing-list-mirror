From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 80/83] run-command: make dup_devnull() non static
Date: Mon, 9 May 2016 17:05:08 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605091700060.4092@virtualbox>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org> <alpine.DEB.2.20.1604251704300.2896@virtualbox> <CAP8UFD2f1L3YKNBA4zP1bmGe8BQitxZp-aDsGP5UTDv06LbLBg@mail.gmail.com> <572BA80E.3000309@kdbg.org> <CAP8UFD35L8P2YJbbvg_-n9Nc61xMs+_2qBJwBxFzXeF-jA4WwQ@mail.gmail.com>
 <alpine.DEB.2.20.1605061733170.2963@virtualbox> <CAP8UFD0ht+ozCMguGwBc19dd9ViXG4tTE0mdaOQ+JVXhSOk02Q@mail.gmail.com> <alpine.DEB.2.20.1605071409490.2963@virtualbox> <CAP8UFD2wFZgOzmadm7X2988RyDGve92TsoMHPf2S5Ydyhc=Nyg@mail.gmail.com>
 <alpine.DEB.2.20.1605080811380.4092@virtualbox> <CACsJy8DUcLWQ6AwyLE+CF+TxZtqDLS=82peizSf4TrZ3q=qjJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Christian Couder <christian.couder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 17:05:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azmka-0007Tg-03
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 17:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbcEIPFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 11:05:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:54263 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbcEIPFb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 11:05:31 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MFctN-1anwEk1YqT-00Ebzy; Mon, 09 May 2016 17:05:11
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8DUcLWQ6AwyLE+CF+TxZtqDLS=82peizSf4TrZ3q=qjJg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:seSNokOqvGP9DYjQSOOuJFcb0LllHiec7Ohc0KnL6tlan4Cb4te
 FTI41sd+dQa99eb0OTMS+exMwEypUQfZ6EnWyGI97NvSS/lQt8/O1AH2+mji7Glatns+GKQ
 3lqyiB8A/Q3WmD9vOKvNrtXNFHLVkg7/nUtmX2eJfahaGfmZaBkFMSk1nSnyxlVp8ircM2U
 ijZvOqWp1uZLpG3ps9DKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E5sFflIOWco=:i2Sek29Br/DaFKRDge+a9M
 606jp6P9W9UeBTsNH6rl/4cDfSMG9Tc6WDagmJT1q5hmkoJL/iZpTj1OPnwD2TTJ2eRDx7eIJ
 9QbegwCSu4G9EQHe35sg60xab+UsXtSHcao4U7b2FYxczREZGPxGVHOZd+KYi0cW6A9MNZn0I
 W9pypVfydzF2FX7FRUksn03aI9g2SxVN5pK9b6hZ4eeXNIUERcA2bzRCwEfEQ+G4SG4Xf8X1L
 falncbiJOnIgCMtr2CGV0hUEZltEOIpig3tS33HQIauYcDddtoUX+cxFJr1H8kdAmpW4CffLK
 GdSQuP98oLHZOVbf2hcyGPW8RlDlVYiqkebfVFnXG4Z7Y/vWJtlk5l9pu7vzxW8nHkUQQxQQI
 d/hy+E/3YsBR5XwAEj8fCYeDqlf4TZ5NV/SRBYqAcx+6NnUrN3ou7+0UoFtp/bBSd5oYCbN0N
 LSRxNhPU0leyJ9gpnASJWboG75T6IMcIhLQaZ96l7N5Z9IdpbGMTuZTlPx0dohD8W617WoiiA
 IwVdKAH7Zp79zWPjbaO5O79loxBsi/siy9/mTBHWiW+SaSakzxi/05vLX3npg2roBkUBTeBeU
 TOl4uEs6yog4397s5ggbnljc8/u0/YMMKnp1FhX+kLRqqGlqIq9E4ZENuGhqHGiqKb4hMai/y
 DvzRWNLTMIn2XATkIZYWOS+iNHOEL8zA7GGrQVtr5WwU6dn5aJNZ6WfTc8M0HE0sdtabO0vfC
 NS4rext66hnFYErNzjhMny4V++TsyFE14fdFURn3Rs8IHEfK4rHC1r/i7R9tas5qiD3DEcJg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293999>

Hi Duy,

On Sun, 8 May 2016, Duy Nguyen wrote:

> On Sun, May 8, 2016 at 1:33 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > The claim is that this libifies the procedure. But it makes the code
> > really nasty for use as a library: if this is run in a thread (and you
> > know that we are going to have to do this in the near future, for
> > performance reasons), it will completely mess up all the other threads
> > because it messes with the global file descriptors.
> 
> I vote one step at a time, leave multi-thread support for future.

Oh, but I never said that we have to do that now!

All I said was that using this dup() dance instead of truly libifying the
functions would slam the door almost shut for future multi-threading.
Which is a strong hint in my book that we should *not* do that dup()
dance, but fix our code by introducing a silent mode.

> There's a lot more shared state than file descriptors anyway, at least
> there are object db and index access and probably a couple of hidden
> static variables somewhere.

Sure. And do we change those shared states temporarily in our functions?
No, we don't. The object db is not made temporarily inaccessible while a
certain function runs. The index access is not temporarily disabled while
a certain function runs.

And this is what that dup() dance does: it disables *all* output, not only
from the current thread.

> And I'm not sure if multi-thread really helps here. Are we really
> CPU-bound? If object inflation causes that (wild guess), can we just
> inflate ahead in some separate process and pass the result back?

Again. I did *not* suggest to introduce multi-threading. I was making a
case for *avoiding* that ugly dup() to /dev/null and then dup() it back to
the original state. That would just ask for unintended side effects.

Ciao,
Dscho
