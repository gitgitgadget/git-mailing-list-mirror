From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/WIP v3 01/31] wrapper: implement xopen()
Date: Wed, 24 Jun 2015 20:39:33 +0200
Organization: gmx
Message-ID: <40fbc9dd1a066ba137647ff384aa6395@www.dscho.org>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
 <1434626743-8552-2-git-send-email-pyokagan@gmail.com>
 <ed4f6565ed610a337244e06cc15b41bb@www.dscho.org>
 <CAGZ79kYtF+rHozVQhNz8uguLZvArPiB2UdkPTFn=Vc+YCsA=UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 20:59:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7ptn-0005r3-58
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 20:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbbFXS7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 14:59:46 -0400
Received: from mout-xforward.gmx.net ([82.165.159.41]:52393 "EHLO
	mout-xforward.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbbFXS7o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 14:59:44 -0400
X-Greylist: delayed 1205 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jun 2015 14:59:44 EDT
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LoJDJ-1Yawc327VB-00gEZF; Wed, 24 Jun 2015 20:39:34
 +0200
In-Reply-To: <CAGZ79kYtF+rHozVQhNz8uguLZvArPiB2UdkPTFn=Vc+YCsA=UQ@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:SNTNEKAq52PKv7ip+l2xdr+UFXXBPMexns+G7uCBZ4iIfGVYosQ
 uoM/rHGHwT0yc6LBT2v2uJSxnH7IJLs9WfQzTSp/J61TTMj6jwq9jAnKSG1Svda7iQywzdM
 kw91A1tZioD8Y/exom7EJmc7VZ7B9XAXMMqWrHDAzRRfEuN/p06nLg+sN96lTv8XCZ0mVPB
 UgnsMcn9jbg0CWEih57sw==
X-UI-Out-Filterresults: junk:10;V01:K0:rLDhpW39Qh0=:HVtxuQIVeKNrgHDS1zaZ3FjG
 xpl71jN4ZO8c7dj6JTDWp0oJiAf+v3a5v8T+WORslXcU8YOge4+JkQh8W2KzoWbcJSz/A/+r6
 GqpkhCEsY+8luwbp/MOiymkXd/Tt9OGNS/S3bcJhrEM/NFXhXbDK59k4nDEMYrcimrsyu9YsR
 3bXrzLh9HZyPpnVxIS874DVzQw2mupNzmDr6BjMkU0g3c5TcSvTKs8khIko+n7CtcmMTzWK+p
 7CzqlGMRDxrGhf4Bn7rlT+h4R8rLi1fbLaZ1S+MDOAO6MsCHHoEiHRd28w9J+kaNQeD8YyalJ
 dWv/pUS195sIxSyIi8WEUS7XT+CyvBqvOkVPVINjTg+hx3q2wgw0weGlempocuB1d0zoq6tQ+
 IKAxG/N5uxyjDb2KPvXwx09lpxnTiVKL5k6T+x/wgimi7HpoHjC33ujDX3vOJ/WW9NgPfQI8H
 VCmTluEn9AkMNYvYIb5S0W0FmGo5z2NnvOsKquzNoJMthC9WokwD38G8TgWNQPI1+Y5LCAo8Q
 MUbT5LUsI8VcTO6/QUWjTJjNsNE0idB5odzjmR3t9PF/XqSj8hZTufm+XIt5Kj1nsSEz5CGqx
 NVjDmQidWIxVUoXQQVTm9Vi8W5G8I94rAfRpbrqdVC7Zvf/RlWNmdQ0FnQFByQodPxsMzqhZC
 1qrxNDWXms5j0SyG62kA027Zdyq7IVjwuLrAeqW3tU3CWg4+TTlrovCmw/hBhbZtB4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272577>

Hi Stefan,

On 2015-06-24 18:59, Stefan Beller wrote:
> On Wed, Jun 24, 2015 at 9:28 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>>
>> On 2015-06-18 13:25, Paul Tan wrote:
>>
>>> +             int fd = open(path, oflag, mode);
>>> +             if (fd >= 0)
>>> +                     return fd;
>>> +             if (errno == EINTR)
>>> +                     continue;
>>> +             die_errno(_("could not open '%s'"), path);
>>
>> It is often helpful to know whether a path was opened for reading or writing, so maybe we should have something like
>>
>> if (oflag & O_WRITE)
>>     die_errno(_("could not open '%s' for writing"), path);
>> else if (oflag & O_READ)
>>     die_errno(_("could not open '%s' for reading"), path);
>> else
>>     die_errno(_("could not open '%s'"), path);
>>
>> ? I know it is a bit of duplication, but I fear we cannot get around that without breaking i18n support.
> 
> This distinction was part of earlier series, but Torsten Boegershausen
> suggested to leave
> it out. [compare
> http://thread.gmane.org/gmane.comp.version-control.git/270048/focus=270049]

So sorry that I missed that (it is still somewhere in my ever-growing inbox). I would have politely disagreed with Torsten if I had not missed it, though.

IMO the varargs make the code more cumbersome to read (and even fragile, because you can easily call `xopen(path, O_WRITE | O_CREATE)` and would not even get so much as a compiler warning!) and the error message does carry value: it helps you resolve the issue (it is completely unnecessary to check write permissions of the directory when a file could not be opened for reading, for example, yet if the error message does not say that and you suspect that the file could not be opened for *writing* that is exactly what you would waste your time checking).

Ciao,
Dscho
