From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Collective wisdom about repos on NFS accessed by concurrent clients (== corruption!?)
Date: Fri, 5 Apr 2013 15:42:04 +0200
Message-ID: <87li8xrt5f.fsf@linux-k42r.v.cablecom.net>
References: <515419D0.7030107@olwing.se> <515EC51C.9070206@olwing.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Kenneth =?utf-8?Q?=C3=96lwing?= <kenneth@olwing.se>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:09:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWI8-0002u6-DP
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161679Ab3DENmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Apr 2013 09:42:09 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:30268 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161611Ab3DENmI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Apr 2013 09:42:08 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 5 Apr
 2013 15:41:55 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (213.55.184.239) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 5 Apr 2013 15:42:04 +0200
In-Reply-To: <515EC51C.9070206@olwing.se> ("Kenneth \=\?utf-8\?Q\?\=C3\=96lwing\?\=
 \=\?utf-8\?Q\?\=22's\?\= message of "Fri,
	05 Apr 2013 14:35:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [213.55.184.239]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220191>

Kenneth =C3=96lwing <kenneth@olwing.se> writes:

> Basically, I'm at a place where I'm considering giving up getting thi=
s
> to work reliably. In general, my setup work really fine, except for
> the itty-bitty detail that when I put pressure on things I tend to ge=
t
> into various kinds of trouble with the central repo being corrupted.
>
> Can anyone authoritatively state anything either way?

My non-authoritative impression was that it's supposed to work
concurrently.  Obviously something breaks:

>> My experience so far is that I eventually get repo corruption when I
>> stress it with concurrent read/write access from multiple hosts
>> (beyond any sort of likely levels, but still). Maybe I'm doing
>> something wrong, missing a configuration setting somewhere, put an
>> unfair stress on the system, there's a bona fide bug - or, given the
>> inherent difficulty in achieving perfect coherency between machines
>> on what's visible on the mount, it's just impossible (?) to truly
>> get it working under all situations.

Can you run the same tests under strace or similar, and gather the
relevant outputs?  Otherwise it's probably very hard to say what is
going wrong.

In particular we've had some reports on lustre that boiled down to
"impossible" returns from libc functions, not git issues.  It's hard to
say without some evidence.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
