From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: poll() emulation in git
Date: Wed, 05 Sep 2012 14:05:21 +0200
Message-ID: <50474001.5030407@gnu.org>
References: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bug-gnulib@gnu.org, git@vger.kernel.org,
	'Junio C Hamano' <gitster@pobox.com>,
	'Erik Faye-Lund' <kusmabite@gmail.com>
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org Wed Sep 05 14:05:44 2012
Return-path: <bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org>
Envelope-to: gnu-bug-gnulib@m.gmane.org
Received: from lists.gnu.org ([208.118.235.17])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org>)
	id 1T9EMZ-0007L1-2v
	for gnu-bug-gnulib@m.gmane.org; Wed, 05 Sep 2012 14:05:43 +0200
Received: from localhost ([::1]:44438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org>)
	id 1T9EMW-0003uv-6J
	for gnu-bug-gnulib@m.gmane.org; Wed, 05 Sep 2012 08:05:40 -0400
Received: from eggs.gnu.org ([208.118.235.92]:43583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1T9EMS-0003uY-6S
	for bug-gnulib@gnu.org; Wed, 05 Sep 2012 08:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1T9EML-0006fM-Ji
	for bug-gnulib@gnu.org; Wed, 05 Sep 2012 08:05:36 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:33300)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1T9EML-0006dO-E7
	for bug-gnulib@gnu.org; Wed, 05 Sep 2012 08:05:29 -0400
Received: by pbbro12 with SMTP id ro12so920597pbb.0
	for <bug-gnulib@gnu.org>; Wed, 05 Sep 2012 05:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=EIjaFKCkmID++OWPzChlBvMsVgk9OQ8qXnWH5X4k03Y=;
	b=U30sHYmgt8Ixd/6IT2HEG+Oxrok3Oid2DSnGzLyLLbTvYJIlGoW/+Pj5mCjE+RLQth
	xHeaznIYHgv6+BBdElHpirXFv4tDJn7+imlBC5ClBx4TIhK1bXFHqJ01OGgCfj/Smn4+
	AsBqC43J2jASswa6KADfhDhwQxLOXW9q/jWb7vOtCmvbOv3vkoPVgi9GecUzi2692IpE
	8YozGwoagsZJhJsxiVQpWf4Bcw8Ik7NQj4S2Fw33CoP7t/qV1ono64GkHcopcD8vafpC
	yknHWCSOoy/RCcCbd80LX1CF83D1CclQpZkj7L/EV8MsMb0LtU8YifrI35UNdCstI8Dh
	iIag==
Received: by 10.66.74.3 with SMTP id p3mr48529296pav.49.1346846728016;
	Wed, 05 Sep 2012 05:05:28 -0700 (PDT)
Received: from yakj.usersys.redhat.com (93-34-169-1.ip50.fastwebnet.it.
	[93.34.169.1])
	by mx.google.com with ESMTPS id y11sm1284324pbv.66.2012.09.05.05.05.24
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 05 Sep 2012 05:05:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 209.85.160.41
X-BeenThere: bug-gnulib@gnu.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Gnulib discussion list <bug-gnulib.gnu.org>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/bug-gnulib>,
	<mailto:bug-gnulib-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/bug-gnulib>
List-Post: <mailto:bug-gnulib@gnu.org>
List-Help: <mailto:bug-gnulib-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/bug-gnulib>,
	<mailto:bug-gnulib-request@gnu.org?subject=subscribe>
Errors-To: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org
Sender: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204821>

Il 05/09/2012 13:24, Joachim Schmitz ha scritto:
> However: this poll implementation, while compiling OK, doesn't work properly.
> Because it uses recv(...,MSG_PEEK), it works on sockets only (returns ENOTSOCK on anything else), while the real poll() works on all
> kind if file descriptors, at least that is my understanding.

Actually recv(...,MSG_PEEK) on most Unix variants works on non-sockets
too.  The trick is taken from GNU Pth in turn.

> Here on HP NonStop, when being connected via an non-interactive SSH, we get a set of pipes (stdin, stdout, stderr) instead of a
> socket to talk to, so the poll() just hangs/loops.

Does your system have a working FIONREAD ioctl for pipes?

> As git's implementation is based on ('stolen' from?) gnulib's and still pretty similar, CC to the gnulib list and Paolo
> 
> Any idea how this could get solved? I.e. how to implement a poll() that works on non-sockets too?
> There is some code that pertains to a seemingly similar problem in Mac OS X, but my problem is not identical, as that fix doesn't
> help.

Paolo
