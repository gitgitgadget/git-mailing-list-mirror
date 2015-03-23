From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Mon, 23 Mar 2015 10:07:39 +0100
Organization: gmx
Message-ID: <4f9cfb776b8a1418ba1b3bc07b10f577@www.dscho.org>
References: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
 <vpqwq2eyyzl.fsf@anie.imag.fr>
 <CACRoPnQp-3RGAPmoo1aM2KUA-phi138J2o82FwP9annM+xvOXA@mail.gmail.com>
 <4388b6e4005c2872aa7f5f83024f021d@www.dscho.org>
 <CACRoPnT04p-6o2u984a21RvHkk6CqpZWRyafg=T+WAPOD3hiTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 10:07:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZyKo-00044e-Ok
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 10:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbbCWJHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 05:07:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:58475 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089AbbCWJHl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 05:07:41 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LbM2k-1ZF7eD3HZ4-00kvxE; Mon, 23 Mar 2015 10:07:39
 +0100
In-Reply-To: <CACRoPnT04p-6o2u984a21RvHkk6CqpZWRyafg=T+WAPOD3hiTg@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:10gPd21f4Bn0AvhdzeJkEmuRbnQZYO7FTTneCwa1o34A2gY+Tia
 MFOxziI3V5fWC977k0yeYMNgdhxu091YSUoTT0T+0NUgtXoN8r/ctoDd4EaneRM9FWYUkNP
 ir9o1Dc4F3/6G+ugGMv/EHN9n687CFjE3jSIm2FmT/QNoOUnwd51T2nVKVBGkPyFLlzzyK3
 vejB46uvECkchgTs0+8HA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266128>

Hi Paul,

On 2015-03-22 18:39, Paul Tan wrote:

> The code coverage tools can help here as well. The kcov output clearly
> shows which options of git-pull are currently not being tested. But
> yes, I agree that the test suite shouldn't be relied too much on
> compared to code inspection and review.

Fully agree.

> On another important topic, though, along with git-pull.sh, I'm
> looking for another script to convert in parallel with git-pull.sh so
> that there will be no blocks due to patch review. Generally, I think
> rewriting scripts that are called frequently by users, or spawn a lot
> of processes due to loops, would be most desirable because the runtime
> gains would be much higher. A quick review of the scripts shows that
> git-am.sh, git-rebase--interactive.sh and git-quiltimport.sh have
> pretty heavy loops with lots of process spawning that grows with
> input.
> 
> I'm currently leaning with git-am because not only is it a frequently
> used command, git-rebase--am.sh (for non-interactive rebase) calls it
> as well. In fact, quick tests show that it takes up 98% of
> git-rebase's execution time on Windows, so if git-am's performance
> improves it would be a huge win on many fronts. git-am's code also
> seems to be manageable for a 3-month project.

Yeah, `git am` is definitely a good pick.

Thanks!
Johannes
