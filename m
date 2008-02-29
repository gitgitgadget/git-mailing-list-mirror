From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 20/40] Windows: A rudimentary poll() emulation.
Date: Fri, 29 Feb 2008 23:16:16 +0100
Message-ID: <200802292316.16935.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <200802292216.25014.johannes.sixt@telecom.at> <5d46db230802291347u5f286dadw6b532abf82c0cff7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Govind Salinas" <blix@sophiasuchtig.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 23:17:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVDXF-0002Vv-UX
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 23:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbYB2WQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 17:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbYB2WQT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 17:16:19 -0500
Received: from smtp1.srv.eunet.at ([193.154.160.119]:57226 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbYB2WQS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 17:16:18 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 59AEF33DD4;
	Fri, 29 Feb 2008 23:16:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2833F6096F;
	Fri, 29 Feb 2008 23:16:17 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <5d46db230802291347u5f286dadw6b532abf82c0cff7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75578>

On Friday 29 February 2008 22:47, Govind Salinas wrote:
> On 2/29/08, Johannes Sixt <johannes.sixt@telecom.at> wrote:
> > On Friday 29 February 2008 05:19, Govind Salinas wrote:
> >  > On Thu, Feb 28, 2008 at 2:49 PM, Johannes Sixt
> >  > <johannes.sixt@telecom.at>
> >
> >  wrote:
> >  > > On Thursday 28 February 2008 10:36, Paolo Bonzini wrote:
> > > >  > For the future, would it be better to first use
> > > >  >
> >  > >  > WaitForMultipleObjects, and then use PeekNamedPipe to find which
> >  > >  > handles have data on it? That's how the mingw port of GNU
> >  > >  > Smalltalk does it.
> >  > >
> >  > >  I tried but I failed. If you can show me code where
> >
> >      ^^^^^^^^^^^^^^^^^^^^^
> >
> >  > > WaitForMultipleObjects works on handles that MSVCRT.DLL's open()
> >  > > created, I'll gladly accept it!
> >  >
> >  > I haven't tried it myself, but you can look at _get_osfhandle
> >  >
> >  > http://msdn2.microsoft.com/en-us/library/ks2530z6(VS.71).aspx
> >  >
> >  > of course you would need to keep a mapping from the handle to the fd.
> >  > Or _open_osfhandle might work the other way, I don't know if it will
> >  > necessarily return the same descriptor.
> >  >
> >  > http://msdn2.microsoft.com/en-us/library/bdts1c9x(VS.71).aspx
> >
> > Fscking basics, this. How do you go from here to WaitForMultipleObjects?
>
> Well, I could have sworn that named pipe handles were in the waitable
> list, but after looking again, they are not.
>
> However, I did find
>
> http://msdn2.microsoft.com/en-us/library/aa365603(VS.85).aspx
>
> which suggests you can pass these handles to ReadFile and if you include an
> OVERLAPPED struct in the call, it will return an event handle to wait on
> which you can then use to wait.

I've read the documentation. Try it. Come back when you succeed.

-- Hannes
