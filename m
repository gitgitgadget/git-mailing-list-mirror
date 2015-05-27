From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] git-new-workdir: add windows compatibility
Date: Wed, 27 May 2015 10:17:05 +0200
Organization: gmx
Message-ID: <4f5a995a4012f7f4bce10c8170b06527@www.dscho.org>
References: <CADBZQ5iAKsSrdvBnFcdPcm9psaJo5B-H1zqJj0aRc+xx6cCFMQ@mail.gmail.com>
 <xmqqfv6k7zp3.fsf@gitster.dls.corp.google.com> <5564A3F7.8030305@gmail.com>
 <CADBZQ5hR1L7FPM_Ht00-as5eXw+PMJk1T2P3_ZiHedf0bi-H1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Paul Smith <paul@mad-scientist.net>, Jeff King <peff@peff.net>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Richard Hartmann <richih@net.in.tum.de>
To: Daniel Smith <dansmith65@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 10:17:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxWWn-0008Dd-6c
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 10:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbbE0IRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 04:17:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:59285 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbbE0IRV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 04:17:21 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LiDrv-1ZSgQC0rOF-00nOMX; Wed, 27 May 2015 10:17:07
 +0200
In-Reply-To: <CADBZQ5hR1L7FPM_Ht00-as5eXw+PMJk1T2P3_ZiHedf0bi-H1w@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:ii1eGe6gfU8lcoFfH1hTl94dSjpZIhgBDBfb+GJdJfEYo71ZmP4
 xc5Ri3/o84M5L5z5O/OXA5/NdH/u69S6v0Vr/zDoMnh/t9zzdKkyI2YklAOoH/GxPjN9J0i
 F6RFcWSAhAoMhvhTuQzkXRWe8t2GEjslx8qcD5WFkBzPuvazfth6T254HUZM2kvFjchQ2EE
 xi85KVhuM5w5+yCksq4aA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270036>

Hi Daniel,

On 2015-05-26 19:16, Daniel Smith wrote:
> Thanks to everyone for reviewing my proposed patch an providing valuable
> feedback. This was my first patch submission to a large open source project
> like Git and the whole process was a little daunting.

Heh, yeah, it can be quite overwhelming (and this mailing list is very "male", too). Sorry!

I hope, though, that it was obvious we all only wanted to be helpful?

> On Tue, May 26, 2015 at 9:48 AM, Karsten Blees <karsten.blees@gmail.com>
> wrote:
> 
>> AFAICT, the MSys2 symlink() implementation is pretty smart to detect these
>> conditions and fall back to deep copy (aka 'cp -a') if symlinks are not
>> supported.
>>
>> IOW, using 'ln -s' will hopefully "just work" in the upcoming Git for
>> Windows 2, thus trying to fix it for MSys1 / Git for Windows 1.9x is
>> probably a lost cause.
>>
> 
> In that case, I'll abandon this patch and wait for Git for Windows 2 to
> come out.

Speaking of which: Could you try `git-new-workdir` with Git for Windows 2.x (developers' preview)? https://git-for-windows.github.io/#download

It *might* be necessary to define the `MSYS` environment variable to `winsymlinks:nativestrict` before starting the Git Bash, to enable symlinking. It would be really good to know if that is the case so that I can do something about this in the Git for Windows installer.

Ciao,
Johannes
