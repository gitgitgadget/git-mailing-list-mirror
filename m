From: Chris B <chris.blaszczynski@gmail.com>
Subject: Re: [msysGit] Re: Git for Windows and line endings
Date: Fri, 19 Oct 2012 10:39:27 -0400
Message-ID: <CADKp0pxuFsSEeZoeemyaqhSJEcsjj1arEOsF4Ub8=76y7tkwHg@mail.gmail.com>
References: <CADKp0pyy=Nnv29LyhzAOX4B5wJNYnZ0h5d7zxNRyZxV2OGUSjg@mail.gmail.com>
 <CABPQNSZE7TP0G-uW1b1nbsNgpxYCEiD5KefS62GB5gZbWyZXDQ@mail.gmail.com> <alpine.DEB.1.00.1210190801490.2695@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:40:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPDk1-00066m-JG
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 16:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758243Ab2JSOju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 10:39:50 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:41408 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757769Ab2JSOjt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 10:39:49 -0400
Received: by mail-wg0-f42.google.com with SMTP id fm10so184431wgb.1
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Y6Z5DhsSUICWdktuN258fRJsX5EHBxt/wEYvkPMSilw=;
        b=CS/AXE7h5ut5y5Tlgl/byNRu6pnZA62FTCiQ4Dedlch29uvCOCfsykIUIQvAZggADf
         V1UrQb5FBHQJcjnh7bhRWQoDWQTrTT6cFu9HirivnNeuX0xaHlIJ50hGjFji4GHX7lxw
         ZAnlrmXuiBBMrzKuZBfCHg8FmQZv9xOS0MF25gzesX3fqgoZiSLx0xjKVCoekaVe01Ej
         wI0d9jHghnBqvCvly4858hHRxyJE2RyjwlAU2VH6A3H9pe+qz4Z5NH7sMRC3+mSnCYwi
         DhIxAPyu2rkk31WYwdpC+OYhPqH3MJavikaRYmhYpU75pqM8zW53Q7ajVLh9T0lLt1id
         AgYw==
Received: by 10.216.131.218 with SMTP id m68mr896822wei.195.1350657588091;
 Fri, 19 Oct 2012 07:39:48 -0700 (PDT)
Received: by 10.194.16.169 with HTTP; Fri, 19 Oct 2012 07:39:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1210190801490.2695@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208049>

Hi.  I'm sorry about the tone of the email; I was writing it after
spending a lot of energy fixing things up and I should have taken some
time to breathe. I recognize this is likely not going to change and
even if I could jump in to contribute it wouldn't matter. I also
recognize that changing it now might cause more problems. I am hopeful
though.

I would like to point out:
- Git on Linux does not mess around with line endings. I can create
and edit a file in either line ending on Linux and commit and still
have it untouched.
- Git on Windows via Cygwin also does not mess around.
- If those flavors of Git don't mess around, why should msysgit do it?

- Windows has been able to cope with UNIX line endings a long time; no
developer is using a default Notepad to open files with high
expectations. Any Windows development tool and editor worth anything
I've used is able to handle both just fine.
- VIM also handles Windows line endings just fine as well. I just
tested it on a Linux machine. Maybe old version? (pure VI is not even
on this machine but hard to press these days it can't handle it.)
- The files in .git folder are in UNIX format anyway, so why are those
not also included in line ending changes? Isn't is because there is a
Windows app (msysgit) running on Windows that expects the UNIX line
ending? So in the same manor, someone might have a Windows system
using some Cygwin components perhaps, or a Windows C program possibly
poorly written or just old, that demand some text files to be left
alone in the format we saved it.

- If there was SO MUCH thought into this, then it was too much; it was
the wrong thought. There should not have been much at all, and just
allow Git to do what it does: store things *exactly* as you put it in.
Allow the clients to worry about things like line endings should they
have the need to worry about it. I'm not seeing how the revision
system has any business making alterations to things one commits into
it.

- Our builds were not breaking, it was production due to deployment
model utilizing Git. What if there was a process to extract from Git
and then distribute? Sounds like it's simple and should work and there
are good advantages to this process to overcome speed of deployment
issues. That process is free to be either Linux or Windows, and to
distribute to either a Linux or Windows server. This process you may
consider a mistake, but the point is that Git is just storing things,
not worried about the process in which it is used.

- While there might be options to make the other flavors of Git mess
around with line endings, the default is to not touch it which is
critical. Because as you bring on developers you never know what they
selected during the installation, and you have to go back and have
them change it if they did something different.

- Developers are not expecting revision control system to make changes
to files they commit.
