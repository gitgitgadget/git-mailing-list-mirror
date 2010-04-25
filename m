From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] git shortlog hangs in bare repo
Date: Sun, 25 Apr 2010 16:50:42 -0500
Message-ID: <20100425215042.GA25547@progeny.tock>
References: <u2i76c5b8581004221222ge8bb0b8cp55cb1f13d5f9692a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 23:50:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O69ie-00073n-Sy
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 23:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab0DYVt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 17:49:58 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59163 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab0DYVt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 17:49:57 -0400
Received: by gyg13 with SMTP id 13so6012217gyg.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Qxt4pVU/aYEdf7N4Q9PBaygtWnD4aDPdqJzBJhk1FzM=;
        b=U8bavVHLwYlemGx+BZzeZalArzf3j+xGkAHKL2KjeXu558Hfa5bcbGRz3NIFCmOnHK
         qXVjhsOqJl4uIJOjFTDNHcDU28wfayrh8oeFssoJNG9Q2zJUTbVGmQTWwRe+t+Kctu8H
         3zVyKm7t/4VJm7Qhe8eOB7fhbAmSjOD2nyOdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=APavc+ocdpr5em3vvFIKu+bqMRKIkF+fA3R+fzMcEcysIcoja8WbwKy5nqjHm9R1yL
         Qr63YaRQfe1kbiQYJHGcuZi8lHXRQSORyThKGstzXlV0CZFaKKFALLrycaeKvB07LHHm
         fd8+t6+aGLqxj0SytJkXkyIwGFV/NtfTrITk8=
Received: by 10.150.120.2 with SMTP id s2mr3346253ybc.278.1272232196761;
        Sun, 25 Apr 2010 14:49:56 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm2548137iwn.12.2010.04.25.14.49.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 14:49:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <u2i76c5b8581004221222ge8bb0b8cp55cb1f13d5f9692a@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145768>

Hi Eugene,

Eugene Sajine wrote:

> I have tried to run this command in order to get some stats from the
> mainline bare repo. The result is that "shortlog" hangs for long
> period of time and nothing happens. At the same time git log works OK=
=2E

I=E2=80=99m a big shortlog fan, too, but I should mention a certain per=
formance
characteristic: to sort its results by author, it has to build the whol=
e
log before it can print anything to standard output at all.  git log,
on the other hand, starts printing the most pertinent output right away=
=2E

Not sure that=E2=80=99s the problem, but thought I should mention it.

It would be nice to know what git version you are using, to be able to
check for relevant differences between your setup and mine.

Thanks for the report,
Jonathan

The most interesting recent change I could find is in v1.7.1-rc0~85^2
(shortlog: warn the user when there is no input, 2010-02-24).  That is
for the no-repository case rather than the bare-repository one.
