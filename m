From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Sun, 21 Jun 2015 14:01:16 +0200
Organization: gmx
Message-ID: <0fe9bc944a232d40fa94b659bbdf5c97@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
 <xmqq1th77829.fsf@gitster.dls.corp.google.com>
 <95e42f21de69ab5299c03ce6ad107037@www.dscho.org>
 <xmqqoakb5sk2.fsf@gitster.dls.corp.google.com>
 <558643CA.6000303@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	peff@peff.net
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jun 21 14:01:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6dwV-0004wf-9l
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 14:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbbFUMBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 08:01:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:52777 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbbFUMBg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 08:01:36 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MDm4o-1ZKNSS1TJu-00H7ut; Sun, 21 Jun 2015 14:01:18
 +0200
In-Reply-To: <558643CA.6000303@alum.mit.edu>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:YtXTk23BEEL05QUmN7WjTE95E65pa4R447cDxyGnCn02+jovqwo
 YWN7rgbe8Jihrs13xNWiFsrgj+gOaL1UeawGNY5Vyy7wjycYF9EALEBg64oH0gbFwjOIJVJ
 W3xy0SczP93VSvjtXeP0zKA2K2nEko/NFCbBYbOOs+acgt1Lr/tYaIcWT6NUiCOEd0oDrIM
 MBk/ao1Bey0zAO3QvBDgg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272254>

Hi Michael,

On 2015-06-21 06:55, Michael Haggerty wrote:
> On 06/19/2015 10:53 PM, Junio C Hamano wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>> Can you think of a name for the option that is as short as `--quick`
>>> but means the same as `--connectivity-only`?
>>
>> No I can't.  I think `--connectivity-only` is a very good name that
>> is unfortunately a mouthful, I agree that we need a name that is as
>> short as `--xxxxx` that means the same as `--connectivity-only`.  I
>> do not think `--quick` is that word; it does not mean such a thing.
> 
> `--connectivity-only` says that "of all the things that fsck can do,
> skip everything except for the connectivity check". But the switch
> really affects not the connectivity part of the checks (that part is
> done in either case), but the blob part.

Right, so `--skip-blobs` would be a better name, I guess, if you follow Junio's reasoning.

But...

> [...]
> As for thinking of a shorter name for the option: assuming the blob
> integrity checks can be turned on and off independently as described
> above, then I think it is reasonable to *also* add a `--quick` option
> defined as
> 
> --quick: Skip some expensive checks, dramatically reducing the
>     runtime of `git fsck`. Currently this is equivalent to
>     `--no-check-blob-integrity`.

This was my idea, without bothering to introduce the `--no-check-blob-integrity`. I was really thinking along the lines: If you just want to check quickly whether your repository is in good shape, without wanting to check too deeply, then `--quick` is your friend. I just *happened* to think of skipping blobs as a way to trade off accuracy for speed, but really, the reason why I introduced `--quick` was to have a way to check much faster if somewhat less thoroughly.

Ciao,
Dscho
