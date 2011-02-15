From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Tue, 15 Feb 2011 12:38:16 -0600
Message-ID: <20110215183816.GB26405@elie>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie>
 <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
 <20110214231920.GA24814@elie>
 <AANLkTim3g15GRZUhrq4=Bs28JHr3M53U_QavtyUxsh7L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 19:38:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpPnC-0007dn-O0
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 19:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab1BOSiX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 13:38:23 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36038 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab1BOSiW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 13:38:22 -0500
Received: by iwn9 with SMTP id 9so455556iwn.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 10:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LGlkIXjyFWwy7J92hUTcaqY4w6JjmiU/LI3xnwn7p0A=;
        b=OFUmhl8ckQ8okOuD2BQrzZjSIwL2h3Myl+lSNp8qimd8ysx2mtcd+Oaq3DQpFu9LjD
         o/WURzH050exxiFst3Isn6k+vbanN3AjlFMuKk3Tj1mKw0ia9UVLiw4XRAc2wlSYQeOx
         3KG++SlRnV3NncsUPJBc2zny4jjADRiV9GAeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EfQ4lfXb+r9GhU8GKNzaRpLqe7Y4ok9N7WyF+KzVr+TJHSjMzPP5Q4jfw7EWS9Wugy
         t5WD1cdCOHQGNP8h9R42WVsHoJZWSVPS8rPImRAMDKJVFk6P5au17Nrbt2zxo+igBbNV
         OHBWGiOlkh1fwCRRfETCc+t/ixCM9xlVmTN+k=
Received: by 10.231.157.205 with SMTP id c13mr4232739ibx.103.1297795101624;
        Tue, 15 Feb 2011 10:38:21 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id z4sm3801761ibg.13.2011.02.15.10.38.19
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 10:38:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim3g15GRZUhrq4=Bs28JHr3M53U_QavtyUxsh7L@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166864>

Piotr Krukowiecki wrote:
>> Piotr Krukowiecki wrote:

>>> =C2=A0--refresh::
>>> =C2=A0 =C2=A0 =C2=A0 Don't add the file(s), but only refresh their =
stat()
>>> - =C2=A0 =C2=A0 information in the index.
>>> + =C2=A0 =C2=A0 information in the staging area.
[...]
> If there is no staging - no commit, then you're right. But then you d=
on't
> have to mention index at all:
>
>  =C2=A0--refresh::
>  =C2=A0 =C2=A0 =C2=A0 Don't add the file(s), but only refresh their s=
tat()
>    =C2=A0 =C2=A0 information.

Yes, that sounds like an improvement.  Though I'd suggest something
like:

  --refresh::
	Don't add the files' content and mode, but refresh their stat(2)
	information if it is out of date.  For example, you'd want to
	do this after restoring a repository from backup, to link up
	the stat index details with the proper files.

The exact wording could use tweaking, but hopefully the idea is clear
(to explain what the option is actually used for).

> index is just part of git. How or where the stat information is
> refreshed does not matter.

I agree with that.  That this is (1) specific to that index, so the
operation needs to be repeated if you use GIT_INDEX_FILE to work with
a second index and (2) has as its only purpose speeding up operations
that compare the index to the worktree are relevant, though.

Anyway, I don't want to argue.  Many of the places pointed out in
the manual could use help.  It could even involve inserting the
phrase "a staging area".

Hopefully I have made clear why excising the word "index" from git
vocabulary (like the word "current directory cache" was eventually
eliminated over time in the past) does not seem like a good idea when
we don't even have a good alternative for it.  As the original post
mentioned, using three terms in documentation for fundamentally the
same thing is going to get confusing after a while.  Why not just use
one ("the index")?

Sorry for the ramble.
Jonathan
