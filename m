From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: What's cooking extra
Date: Sun, 23 May 2010 13:51:27 +0200
Message-ID: <20100523115127.GA20443@localhost>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
 <20100519170656.GA30161@pvv.org>
 <20100522130916.GA28452@localhost>
 <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com>
 <20100522222746.GA2694@localhost>
 <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 23 13:51:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG9iY-0002JA-6B
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 13:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660Ab0EWLvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 07:51:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53354 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469Ab0EWLvf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 07:51:35 -0400
Received: by fxm5 with SMTP id 5so1819280fxm.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=5++MBu9Nfvl9Uz+BQPcEtVJeASR2ktbEGxQVXuqN6lg=;
        b=KKkogfpd9Rt7ciiAtaCAMOTJuIhsiaDD3O5mXznOQvmdEOvxNyV0puHhkktJ/+2R6E
         /wL8P3MnOeCDfrK+7O6fZMumw161zkZ6f3Jyz5MHboneajcjjpAKcdtQhiZZOJXNrTtv
         98rn6EQJY5oWNtbvRowGDBBkQMTiU8NhdaOwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=LCcFt9EsBcCZqMLjO9XsnKvU5lsSuCerqlej0OhYfUuOkJTHVK5jBHm3KLQHALtItt
         xcaSo4JG3MLKCiZbRzGknjGkKzK2Oo+4FY093jJ1Hj+v58vCGgchxMu5GxyNBpRZh8m3
         k1o4cZI1EKTOsFUNdMFcPdxOOT362BJU1wwE8=
Received: by 10.223.47.130 with SMTP id n2mr3599826faf.55.1274615493148;
        Sun, 23 May 2010 04:51:33 -0700 (PDT)
Received: from darc.lan (p549A5187.dip.t-dialin.net [84.154.81.135])
        by mx.google.com with ESMTPS id 2sm14219017fav.13.2010.05.23.04.51.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 04:51:32 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OG9iK-0005PE-1F; Sun, 23 May 2010 13:51:28 +0200
Content-Disposition: inline
In-Reply-To: <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147574>

On Sun, May 23, 2010 at 12:36:51PM +0200, Eyvind Bernhardsen wrote:

> On 23. mai 2010, at 00.27, Clemens Buchacher wrote:
> 
> >> The "eol" attribute is used for files that need a specific line
> >> ending.  Setting it also sets "text".
> > 
> > If a file needs specific line endings, why enable conversion for
> > this file at all? Just make sure the repository contains the
> > correct version and unset the crlf attribute.
> 
> Yeah, that's what I initially thought too, but it makes sense to
> be able to use normalization to prevent line ending breakages in
> your repository.  If a file needs CRLFs for some tool to work,
> you don't want anyone to inadvertently convert it to LF, and
> "eol=crlf" makes git enforce that.

Unsetting crlf/text already disables converting it to LF. The user
would have to change the line endings in his work tree and commit
the file with wrong line endings. I do not see how this can happen
inadvertently.

> > I do see the value of a global core.eol option, however, since it
> > allows me to convert to LF instead of CRLF, which AFAIK is not
> > currently possible.
> 
> Actually, since git normalizes to LF, "eol=lf" simply means
> "convert on input but not on output", which is what
> "core.autocrlf=input" currently does.  The fact that you didn't
> know this reflects the poor usability of core.autocrlf, which is
> one of the things this series is trying to rectify :)

No, I am aware of autocrlf=input, but apparently I did not
understand the meaning of eol=lf correctly. So if a file has CRLF
endings in the repository, and eol=lf, it will _not_ be converted
to LF in the work tree? Conversely, if it has LF endings in the
repository, and eol=crlf, it _will_ be converted to CRLF in the
work tree?

I was expecting eol=lf and eol=crlf to be symmetric, which is also
the reason for my reply to Finn's safe crlf patch.
