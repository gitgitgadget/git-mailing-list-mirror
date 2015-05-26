From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] git-new-workdir: add windows compatibility
Date: Tue, 26 May 2015 11:53:09 +0200
Organization: gmx
Message-ID: <cbfbf842705637b52cde9c6b61f89a75@www.dscho.org>
References: <CADBZQ5iAKsSrdvBnFcdPcm9psaJo5B-H1zqJj0aRc+xx6cCFMQ@mail.gmail.com>
 <xmqqfv6k7zp3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Smith <dansmith65@gmail.com>, git@vger.kernel.org,
	Paul Smith <paul@mad-scientist.net>, Jeff King <peff@peff.net>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Richard Hartmann <richih@net.in.tum.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 16:37:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxFyu-00020t-6J
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 16:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbbEZOhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 10:37:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:58316 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210AbbEZOga (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 10:36:30 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MXZNq-1YacdL0s2Y-00WZRE; Tue, 26 May 2015 11:53:13
 +0200
In-Reply-To: <xmqqfv6k7zp3.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:DyJGNyduWzvajK/dJdCD5g228/KcuZCSKwEsHV2DAe1hRfC4fIi
 FzE8iUcAp5y1Yh/1U5OABeWDcs75xKqnKX3ydVx+jIucGQdh0wf8Ev23yexm0EguYtQL2fw
 AIdPUFh4EaiHnVJKtoGj+ARtximOh8Kx78qgXmT1Wa/xXkgott827u6PS4CxpnFkzqacr7A
 l8YCWCofVN1We+LEhlZPQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269942>

Hi,

On 2015-05-26 06:03, Junio C Hamano wrote:
> Daniel Smith <dansmith65@gmail.com> writes:
> 
>> When running on Windows in MinGW, creating symbolic links via ln always
>> failed.
>>
>> Using mklink instead of ln is the recommended method of creating links on
>> Windows:
>> http://stackoverflow.com/questions/18641864/git-bash-shell-fails-to-create-symbolic-links
>>
>> Script now branches on Windows to use mklink. This change should not affect
>> unix systems.
>>
>> Signed-off-by: Daniel Smith <dansmith65@gmail.com>
>>
>> Has been tested on Windows 8.1 and OS X Yosemite.
>> ---
> 
> Swap the "Has been tested..." and "Signed-off-by:" lines.
> 
> I'll defer to Windows folks if "mklink" is a sensible thing to use
> or not; I have no first-hand experience with Windows, but only heard
> that links are for admin user only or something like that, so I want
> to hear from people whose judgement on Windows matters I trust.

The biggest problem with `mklink` is that it is only supported on Windows Vista and later, while I really like to keep Windows XP support in Git for Windows.

That is why Karsten Blees' symlink support (emulated via NTFS reparse points) which I just merged into Git for Windows yesterday is so careful about everything.

But git-new-workdir is in `contrib/`, anyway, and not installed in Git for Windows by default, therefore it is less critical: interested parties will have to be a bit knowledgeable in any case.

So I am fine with it!

Ciao,
Dscho
