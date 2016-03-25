From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016 | Proposal | Incremental Rewrite of git bisect
Date: Fri, 25 Mar 2016 10:15:05 +0100
Message-ID: <vpqbn62vrza.fsf@anie.imag.fr>
References: <CAFZEwPNXKo5YN9OPPCkO90bSPD3ittU+y8eDxh-JLxnihBznuw@mail.gmail.com>
	<CAP8UFD0muBUEp9XknmcTWqg==ChzWP3m-p-v6vXyC09OC88U7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:15:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajNqB-0000pe-Vs
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 10:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbcCYJPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 05:15:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46562 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752236AbcCYJPX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 05:15:23 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u2P9F4nn005980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 25 Mar 2016 10:15:04 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2P9F5Au024283;
	Fri, 25 Mar 2016 10:15:05 +0100
In-Reply-To: <CAP8UFD0muBUEp9XknmcTWqg==ChzWP3m-p-v6vXyC09OC88U7w@mail.gmail.com>
	(Christian Couder's message of "Fri, 25 Mar 2016 10:02:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Fri, 25 Mar 2016 10:15:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2P9F4nn005980
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1459502107.77767@Zf4qlsHJDPSkOkQRvy6lJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289864>

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Mar 24, 2016 at 12:27 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>
>> Unification of bisect.c and bisect--helper.c
>>
>> This will unify the algorithmic and non-algorithmic parts of bisect
>> bringing them under one heading to make the code clean.
>
> I am not sure this is needed and a good idea. Maybe you will rename
> "builtin/bisect--helper.c" to "builtin/bisect.c" and remove
> git-bisect.sh at the same time to complete the shell to C move. But
> the actual bisect.{c,h} might be useful as they are for other
> purposes.

Yes. My view on this is that builtin/*.c should be just user-interface,
and actual stuff should be outside builtin, ideally in a well-designed
and reusable library (typically re-usable by libgit2 or others to
provide another UI for the same feature). Not all commands work this
way, but I think this is a good direction to take.

> When you have sent one patch series, even a small one, then your main
> goal should be to have this patch series merged.

I'd add: to get a patch series merged, two things take time:

1) latency: let time to other people to read and comment on your code.

2) extra-work required by reviewers.

You want to send series early because of 1) (then you can work on the
next series while waiting for reviews on the current one), and you need
to prioritize 2) over working on the next series to minimize in-flight
topics.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
