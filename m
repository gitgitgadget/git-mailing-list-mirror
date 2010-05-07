From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 15:58:12 -0400
Message-ID: <g2s32541b131005071258s92e058bakc8f3a4df1e1dc634@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org> 
	<n2k32541b131005071211sb2411334v4f0919abfeb4cbb7@mail.gmail.com> 
	<alpine.LFD.2.00.1005071213550.901@i5.linux-foundation.org> 
	<i2i32541b131005071235z64c9de56w29a2d555cf801c9a@mail.gmail.com> 
	<alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 07 21:58:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATh1-0002q9-ER
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182Ab0EGT6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 15:58:34 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37687 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756954Ab0EGT6d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 15:58:33 -0400
Received: by gwj19 with SMTP id 19so863948gwj.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=mEtgeFIR3zBcjPv4E44PgNNSulq+Ufc0QCJeA7FRsMA=;
        b=RtgPufZBAXb18vR5AERoCojSsO8Tk3wYsQ4uxgh6XH00KAvuWSwfck8eGVjWCwdcyF
         5q6UxSZIcWI5HYG4J8GYREaxQ4QG86UmmagqCo07j76fGlBCcKFPAZ5rjJmpOlSqtjvW
         birWH9jhE8EU0vPrWPZAqr8EownelzZIy5cQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cPTJjL1P4WXY7b9rqnkOYVYbHDLMLNtXnWOYd8SiI0UEI79H/asb4604CRxx9Tpsqj
         0Ya54xvVhbi6JpmxRFv4D8XK810qMwmSaMUXgroTANmCro7G0MMAiYVD6jYTdiFqk6TQ
         iRzeaXfULMqo3SHVT0+7asfb/P3kXjb/N5inc=
Received: by 10.150.47.4 with SMTP id u4mr4013060ybu.179.1273262312368; Fri, 
	07 May 2010 12:58:32 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 12:58:12 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146576>

On Fri, May 7, 2010 at 3:45 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, 7 May 2010, Avery Pennarun wrote:
>> 1) Whether a project has files that should be EOL-converted
>> automatically (we seem to all agree that this is set in
>> .gitattributes, whichever attribute is used).
>>
>> 2) Whether a particular person wants those particular files to be
>> EOL-converted, and what to convert them to.
>
> So? If we were to have a .gitconfig file, then both of those things would
> just work.

No!  The whole point is that each user *does* still want to be able to
decide how to convert the files tagged by the crlf gitattribute (or a
new attribute, I don't care).  Setting this in a .gitconfig file
inside the project is pointless; I need it in my *personal* config.
msysgit users want to set it globally to CRLF by default, Linux or
cygwin users probably want to set it to LF by default.

So #1 is useful to have in the repo, #2 is not.

I am a real live example of this.  For our Delphi projects at work, I
want to check it out with LF on my Linux machine (so I can
patch/diff/merge/grep/edit/etc easily), and CRLF on my Windows machine
(so that the Delphi IDE doesn't get confused).  Other projects I want
to have pure LF on both Linux and Windows, so setting
core.autocrlf=true globally will break things.

Eyvind's proposal (or a similar proposal where his new attribute is
just the crlf attribute) will get me and all my co-workers the
wonderful correct behaviour *by default*; the current behaviour, or an
in-repo .gitconfig, will not.  The key feature is the new
core.eolStyle option, not whether or not we add a new attribute.

> That said, I don't think the extra .gitconfig is even worth it, the same
> way I do _not_ think Eyvind's extra .gitattributes things are worth it.

Do you even use any CRLF projects?  If not, then presumably none of
the options will seem worth it. :)

But the current behaviour really doesn't work for people who need CRLF
conversion, and an in-repo .gitconfig file won't help them.
core.eolStyle + a change to crlf attribute semantics will.

Have fun,

Avery
