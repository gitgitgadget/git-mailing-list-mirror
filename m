From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/6] Another attempt to get the SVN exporter merged
Date: Sat, 12 Jun 2010 01:26:13 -0500
Message-ID: <20100612062613.GA2549@burratino>
References: <1276175389-6185-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 08:27:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONKC6-0004KN-8c
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 08:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab0FLG0X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 02:26:23 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65373 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab0FLG0W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 02:26:22 -0400
Received: by iwn9 with SMTP id 9so1201111iwn.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 23:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=iHPJ5Gt2Mgy3FPJPgNOFN5imDgjkrPD7PJc+4hcT5LI=;
        b=dAOfACE8OxdP22zY7svUMRIEV6WDd75aJ4XB38XT7+iLFAH7RgsvmhdvrMDyJ2moT6
         RP1dDmRzJ0HipKfXssQRbBKCRx8zKRn/ltq0eLtUKwURmfG9ToddCzFUPzjI5AGxDN/p
         zN98IHnYUMkXkHcZq4chA5SOnkgjABvLYIGac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TPgxZTTJo8Il54xqeosdjTc5LChsurtVb0mdrqsTkwiQGXZhu9/t8z6qvKPp89jy8R
         yvUm48wbdOWJzzEd0wiU4kCjL1kIZULawgU9cWjH6Oz2nZJ+cACSDSSz3qbL+iWirYUw
         mC2AtsnnHrxrV4OyJsn8TOoKjkM9W1QozE9pE=
Received: by 10.231.156.73 with SMTP id v9mr2939945ibw.117.1276323981654;
        Fri, 11 Jun 2010 23:26:21 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm8950618ibi.20.2010.06.11.23.26.20
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 23:26:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1276175389-6185-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148990>

Hi Ram,

Ramkumar Ramachandra wrote:

> It certainly looks like I'll never give up trying to get this series
> merged- this is my third attempt

=46irst of all, thanks for your work on this and sorry to take so long
to respond[1].

> I still haven't been able to get rid
> of the compiler warnings about unused functions

Will reply to the relevant patch.  Since it=E2=80=99s not so bad to fix=
, I don=E2=80=99t
think that should hold up queueing the series in pu.

> it looks like
> this series won't graduate to `master` before that happens- I'd
> appreciate pointers on how to do this.

Instead, I suspect the main missing ingredient is a caller.  The
series builds up some library infrastructure with no new feature to
exercise it, which makes it a good time to get feedback but not a good
time to merge.

Of course, we could easily add a feature to exercise it: David=E2=80=99=
s
svn-fe tool is IMO quite useful on its own (regardless of how the code
will be used later by remote-svn).

I don=E2=80=99t think that is so important for the remote-svn project. =
 In
other words, I hope some other reviewers show up, but if that doesn=E2=80=
=99t
happen, I would suggest submitting again for inclusion once the
remote-svn command with import capability is functional.

I planned to write a series adding svn-fe to contrib/ and then the
computer died.  If someone else doesn=E2=80=99t do it first, hopefully =
I can
try again this weekend.

> Major change since last time: Removed dependency on mmap for
> portability reasons.

Sad but perhaps necessary.  I guess this also opens the possibility of
later making the save operation atomic with the fsync() + rename()
trick.

Regards,
Jonathan

[1] My excuse: laptop died.  My new setup is finally in place and
working well but this Monday I will be on vacation in a land of poor
connectivity --- agh.
