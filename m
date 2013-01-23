From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: GIT get corrupted on lustre
Date: Wed, 23 Jan 2013 16:44:24 +0100
Message-ID: <871udbc3af.fsf@pctrast.inf.ethz.ch>
References: <50D861EE.6020105@giref.ulaval.ca>
	<50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca>
	<50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca>
	<CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com>
	<50F8273E.5050803@giref.ulaval.ca>
	<871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil>
	<50F829A9.7090606@calculquebec.ca>
	<871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil>
	<50F98B53.9080109@giref.ulaval.ca>
	<CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
	<87a9s2o6ri.fsf@pctrast.inf.ethz.ch> <kdk2ss$498$1@ger.gmane.org>
	<87r4lejpx8.fsf@pctrast.inf.ethz.ch>
	<50FF051D.5090804@giref.ulaval.ca>
	<878v7keuh3.fsf@pctrast.inf.ethz.ch>
	<CABPQNSad1EKbmt3Gjs+uB9fud4YBqmk++5GMqF2s047Lcc8GwQ@mail.gmail.com>
	<87d2wvc3v0.fsf@pctrast.inf.ethz.ch>
	<CABPQNSb89h28O_a3uVoVrNisZqPcHHVFm8nP7GdFGCb=PVdcsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <trast@student.ethz.ch>,
	Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>,
	"Brian J. Murrell" <brian@interlinx.bc.ca>, <git@vger.kernel.org>,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?utf-8?Q?S=C3=A9bastien?= Boisvert 
	<sebastien.boisvert@calculquebec.ca>
To: <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 16:44:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty2VN-0001bq-Dv
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 16:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab3AWPo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 10:44:28 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:54356 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233Ab3AWPo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 10:44:27 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 23 Jan
 2013 16:44:23 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 23 Jan 2013 16:44:24 +0100
In-Reply-To: <CABPQNSb89h28O_a3uVoVrNisZqPcHHVFm8nP7GdFGCb=PVdcsQ@mail.gmail.com>
	(Erik Faye-Lund's message of "Wed, 23 Jan 2013 16:32:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214330>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Wed, Jan 23, 2013 at 4:32 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>>> POSIX allows error codes
>>> to be generated other than those defined. From
>>> http://pubs.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_03.html:
>>>
>>> "Implementations may support additional errors not included in this
>>> list, *may generate errors included in this list under circumstances
>>> other than those described here*, or may contain extensions or
>>> limitations that prevent some errors from occurring."
>>
>> That same page says, however:
>>
>>   For functions under the Threads option for which [EINTR] is not listed
>>   as a possible error condition in this volume of IEEE Std 1003.1-2001,
>>   an implementation shall not return an error code of [EINTR].
>
> Yes, but surely that's for pthreads functions, no? utime is not one of
> those functions...

Ah, my bad.  In fact in

  http://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xsh_chap02.html

there is a paragraph "Signal Effects on Other Functions", which says

  The most common behavior of an interrupted function after a
  signal-catching function returns is for the interrupted function to
  give an [EINTR] error unless the SA_RESTART flag is in effect for the
  signal. However, there are a number of specific exceptions, including
  sleep() and certain situations with read() and write().

  The historical implementations of many functions defined by IEEE Std
  1003.1-2001 are not interruptible[...]

  Functions not mentioned explicitly as interruptible may be so on some
  implementations, possibly as an extension where the function gives an
  [EINTR] error. There are several functions (for example, getpid(),
  getuid()) that are specified as never returning an error, which can
  thus never be extended in this way.

  If a signal-catching function returns while the SA_RESTART flag is in
  effect, an interrupted function is restarted at the point it was
  interrupted. Conforming applications cannot make assumptions about the
  internal behavior of interrupted functions, even if the functions are
  async-signal-safe. For example, suppose the read() function is
  interrupted with SA_RESTART in effect, the signal-catching function
  closes the file descriptor being read from and returns, and the read()
  function is then restarted; in this case the application cannot assume
  that the read() function will give an [EBADF] error, since read()
  might have checked the file descriptor for validity before being
  interrupted.

Taken together this should mean that the bug is in fact simply that the
calls do not *restart*.  They are (like you say) allowed to return EINTR
despite not being specified to, *but* SA_RESTART should restart it.

Now, does that make it a lustre bug or a glibc bug? :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
