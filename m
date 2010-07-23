From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: question (possibly) on git subtree/submodules
Date: Fri, 23 Jul 2010 12:18:59 -0500
Message-ID: <20100723171859.GG2507@burratino>
References: <xotjlj92i9gr.fsf@leonardo.pit.corp.google.com>
 <4C49C9C6.3080409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: maurizio.vitale@polymath-solutions.com,
	Maurizio Vitale <mav@leonardo.pit.corp.google.com>,
	git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 19:20:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcLut-0005a7-SC
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 19:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992Ab0GWRUB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 13:20:01 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50689 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192Ab0GWRUA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 13:20:00 -0400
Received: by qyk7 with SMTP id 7so294397qyk.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5aPXsj776lN2eySGrOJ2QtFPWZT7jKva3+A70M3yzP0=;
        b=N90cTZEAoZjSR3nDy1pQxo4ZgkLeygW7DTZRfvo8nyxZcbKO96T7qbeLrdwPJqa/i0
         h8KoTP6Qw7U754OiaKsn1uGY25ZjYh/uCzefQcN0I51bqKXzYFICZSQCCr3EcMrPsQ/S
         xecYhJBePBtcM70atG9iV8qChZ5BvIldX7590=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rcbo3EUM4KncJdEpn7582wtZYJeiHrkFa7vWnoLDQu//wgKJaq7jFeiFXxqtFfiYIE
         SbsVdhPmazhAXrLmK7UT2Ihk+x6pyJQqNztoRLpg+kPa122YGNZM26aFVZrWR6u81vSv
         tNumlTOjDJNY5z+UgaVXWc+HSUdgpEa6Vmlv0=
Received: by 10.224.87.227 with SMTP id x35mr2829145qal.123.1279905599337;
        Fri, 23 Jul 2010 10:19:59 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id fb41sm480923qcb.15.2010.07.23.10.19.57
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 10:19:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C49C9C6.3080409@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151555>

Chris Packham wrote:

> The short answer is no. Nothing git has currently will let you clone =
a
> subset of files. Shallow clones exist if you want all the code and th=
e
> last X changes. The reason for this is git, like other DVCSes, tracks
> _changes_ rather than _files_ this is something that took me a while =
to
> get my head around when I was learning git.

Not quite as cut-and-dried as it may sound, I think.  Internally git
compresses blobs (and other objects) by comparing them to other ones,
but I do not think that is what you are talking about, and I do not
see what that has to do with partial clones.  In fact, the main reason
I can see that partial clones (in the sense of getting all metadata
but not all blobs) are not implemented is that no one has written code
for it yet.

Here is a thread on related work[1].  Maybe someone else can find a
more pertinent link.

> The best advice I've seen is to actually take your repository and use
> git filter-branch to create several smaller repositories

Right, and this is what =E2=80=9Cgit subtree=E2=80=9D excels at.  It pr=
ovides an
alternative interface and implementation for =E2=80=9Cgit filter-branch
--subdirectory-filter=E2=80=9D.

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/73117/focus=3D=
73935
