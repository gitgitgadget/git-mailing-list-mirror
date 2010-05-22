From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: What's cooking extra
Date: Sun, 23 May 2010 00:27:46 +0200
Message-ID: <20100522222746.GA2694@localhost>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
 <20100519170656.GA30161@pvv.org>
 <20100522130916.GA28452@localhost>
 <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 23 00:31:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFxEH-0000h6-Mk
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 00:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759035Ab0EVW1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 18:27:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45201 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759016Ab0EVW1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 18:27:55 -0400
Received: by fxm5 with SMTP id 5so1669273fxm.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Uv2o6YXe/J42qF7YtwTVt3drXsMFHx/k5ATZR/Jdv0w=;
        b=CcYBogJxxXOC/Yls8JktNRh++gF0rzneLIKvn7xnMiZzR/JEqi/+ryB44Npelw0PJX
         mvPNzfQm3oL3YKtepRZJdGaJiC5/vE7MPAyP/r452NaA/TkYjGSmppbvRsDjSQpueVEp
         UD8yrm/O3bIvO5OzPiejGybHgc+PKZdenwUsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=g/vdbDixBa2ANtDKg9B2+fPXds4rSSnyKctCFR9NPsufnE8JjZzaaCYhFJXzfaEY5L
         OLvdL/ZVTE36kL2b9TjN/D83jJ1GrMxiKiOVTAO0b0/InteW0fdrqto3ou8RXCQu12p5
         F5aaQqxxuNfgPi8aGPRL3x/fjES99Y/YoTyJU=
Received: by 10.223.98.24 with SMTP id o24mr3048899fan.29.1274567272439;
        Sat, 22 May 2010 15:27:52 -0700 (PDT)
Received: from darc.lan (p549A5187.dip.t-dialin.net [84.154.81.135])
        by mx.google.com with ESMTPS id 2sm11462827fav.13.2010.05.22.15.27.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 15:27:51 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OFxAY-00010y-2n; Sun, 23 May 2010 00:27:46 +0200
Content-Disposition: inline
In-Reply-To: <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147551>

Hi Eyvind,

Thanks for the extended summary. I still have several doubts, as
detailed below. But I understand that this has been heavily
discussed and if the discussion has indeed come to a conclusion,
then I will not complain about it now.

On Sat, May 22, 2010 at 09:42:14PM +0200, Eyvind Bernhardsen wrote:
> On 22. mai 2010, at 15.09, Clemens Buchacher wrote:
> 
> > As soon as the existing crlf attribute is given priority over
> > core.autocrlf, all the problems discussed originally go away.
> > So what exactly are the new attributes supposed to do?

For all my comments below I am assuming that the behavior of
autocrlf will be changed to respect the crlf/text attribute by
default.

> There is one new attribute, "eol", that is used for files which
> need a specific line ending.  Being able to "force" LF or CRLF
> line endings has been requested several times on the list, and is
> already sort of provided for by "crlf=input".

[...]
> Any file with the "text" attribute set will have its line endings
> normalized to LF in the repository.  If "text" is set to the
> special value "auto", git will only convert the file if it looks
> like a text file.
> 
> The "eol" attribute is used for files that need a specific line
> ending.  Setting it also sets "text".

If a file needs specific line endings, why enable conversion for
this file at all? Just make sure the repository contains the
correct version and unset the crlf attribute.

> core.eol controls which line endings to use for normalized files
> that don't have the "eol" attribute set, and defaults to the
> platform native line ending.

That makes sense to me, except for the part where I need a per-file
attribute.

> When core.autocrlf is set, the default value of the "text"
> attribute is set to "auto" but with an extra safety feature: if a
> file contains CRs in the index, it won't be normalized.  The
> extra feature comes from Finn Arne's "safe autocrlf" patch.
> 
> There is a backwards compatibility wrinkle in that core.autocrlf
> will override core.eol if the latter isn't explicitly set, so
> that "core.autocrlf=true" still results in CRLFs in the working
> directory on Linux.

This also makes sense. I just fear that making this frequently
misunderstood feature even more complex will only confuse users
further.

I do see the value of a global core.eol option, however, since it
allows me to convert to LF instead of CRLF, which AFAIK is not
currently possible.

On the other hand, this will cause users to stop caring whether or
not a file in the repository has LF or CRLF line endings. I am not
sure if that is a good thing, but I suppose it is better than what
we have now.

> > And, renaming the crlf attribute to text? Where did Linus suggest that? If
> > we do that, we don't even have to talk about backwards compatibility any
> > more.
> 
> In <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>:
> > So if you rename these things, keep them separate.  Make the "am I a
> > text-file" boolean be a boolean (plus "auto"), and just call it "text". 
> > And make the "what end of line to use" be just "eol" then.

I see. Well, if we rename the "crlf" attribute then we will have a
macro attribute "binary" and an attribute "text", which are not the
opposite of each other. That is a bit strange.

> The "crlf" attribute will be used if it is present so backwards
> compatibility is preserved to a degree.

Ah, ok. That is fine then.

> Scripts that test for
> the "crlf" attribute explicitly (such as git-cvsserver, which I
> fixed) will break.  I don't know how big a problem that is going
> to be in practice, but nobody raised it as an issue during the
> discussion.

I agree that should not be a big issue.

Regards,
Clemens
