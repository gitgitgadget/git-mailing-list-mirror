From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Sat, 22 Dec 2007 15:48:21 +0000
Message-ID: <57518fd10712220748v188d769eo204fcc572993395e@mail.gmail.com>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>
	 <20071219184457.GC3015@steel.home>
	 <57518fd10712191437s6f192feds50d006fdfc624444@mail.gmail.com>
	 <4769A7FB.1070904@lsrfire.ath.cx>
	 <57518fd10712200244o656c7f44j426cc71c89515de3@mail.gmail.com>
	 <476A5DFF.40803@lsrfire.ath.cx>
	 <57518fd10712200508x4b15f9acy10aed83a3cebeba@mail.gmail.com>
	 <57518fd10712210247s2fcbbf61ke67bbdc0f5ffe70b@mail.gmail.com>
	 <7vhcibyvh0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 16:48:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J66ap-0004Sp-T2
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 16:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbXLVPsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 10:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbXLVPsX
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 10:48:23 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:32880 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbXLVPsW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 10:48:22 -0500
Received: by rv-out-0910.google.com with SMTP id k20so820484rvb.1
        for <git@vger.kernel.org>; Sat, 22 Dec 2007 07:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=qIFgv533JedqshHoOGQj6rZpx7dUt/5b7V7cqpb08ow=;
        b=XgssiyJDkeKp5F93kSOccwgH84VJVXvyFE0LSwNqM8pdmJEN2UqBNndeVLdDoCuaeo/FklRthuUXHY367c0zJlsIvg6L3fMF2GwEQU2iF9B56QM+F4doT5Sn2zQsmGAgbDX19E1fR+cTBPqLJee8VpUToaMzO5jWfVeclSJLIWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=WgYqfqiPgwoqUtmq0PZ73QSoN9rnUpcuh73GS6slU1dE92nAwbyT76jLS6wxDww6vej2zFEFIQ2bDNZgVhw2u0VmlQIt12o6X6GsCHZVExuv/HovuRe/3hf83JyMYJtj9u33dy5Ml+6iNhVGuGmY8SbP97JeT8vYvNjvXKFUroo=
Received: by 10.141.180.5 with SMTP id h5mr1408604rvp.222.1198338501381;
        Sat, 22 Dec 2007 07:48:21 -0800 (PST)
Received: by 10.140.134.14 with HTTP; Sat, 22 Dec 2007 07:48:21 -0800 (PST)
In-Reply-To: <7vhcibyvh0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 58356b63de395cd2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69140>

On Dec 22, 2007 8:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>   On Dec 19, 2007 6:44 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
>   > Could you try
>   >
>   >     git cat-file 18d2480ab689b483ef1ebbdb3f7420904049ba0b
>   >
>   > (or any other problematic commit) and post its output here?
>
>   You mean git cat-file commit ... ?
>   I get the normal output, but the problematic commits don't show a
>   newline character at the end of the cat-file output.
>
> "I get the normal output" is not what Alex asked you to supply,
> nor would be sufficient information.  There may be some
> abnormality in the commit object that you probably did not spot,
> but Alex or other people may have been able to if you were
> actually posted its output here.
========
$ git cat-file commit 18d2480ab689b483ef1ebbdb3f7420904049ba0b
tree 2416c620c6f7c1864065a6e778588b71b3e0bd5d
parent 9fc80d0a05835c68885f253844ab586b38d09202
author Jonathan del Strother <jon.delStrother@bestbefore.tv> 1197907511 +0000
committer Jonathan del Strother <jon.delStrother@bestbefore.tv> 1197907511 +0000

Try to flush log files before terminating the app%
========
The '%' suffix is zsh showing that there's no newline there.  Under
bash I get no '%' and the next prompt starts immediately following
'app'.

> One thing I noticed funny in your original message was "-1-".
> Is it essential that the number is spelled incorrectly to
> reproduce this problem?

No, sorry - I don't know how that got there.  I get identical output
whether it's "rev-list -1"  or "rev-list -1-"



I've been trying to reproduce this on my home repo, and have only been
partially successful.  I haven't been able to make git rev-list -1
show a malformed message body.  I can only get the problem to occur
when printing multiple commits (eg git rev-list -20 ...) Bizarrely,
the first 2 commits shown in rev-list never show a problem.  After the
first 2, commits with the broken message bodies will always appear
broken, regardless of their position in the list.  However, the
content that appears instead of the body will change depending on the
commits that appear prior to that one.

I realise this doesn't appear to mesh with my observations the other
day, where I was seeing the broken bodies even when just using
rev-list -1 - I'm at a loss to describe it.  Both machines are intel
macs (one a MacPro, one a MacBook Pro), running OS X 10.5.1, with the
same git version (1.5.4.rc0.1162.g3bfea).  Unfortunately I've switched
my work machine off for christmas, or I'd ssh in and try to re-verify
things.


I do appreciate people's help in trying to reproduce & fix this - I
realise I've not given people much to go on.
