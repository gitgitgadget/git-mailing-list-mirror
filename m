From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: xfuncname problems with C++
Date: Fri, 02 Jan 2015 21:25:26 +0100
Message-ID: <54A6FEB6.40305@kdbg.org>
References: <CAHd499Cn8C51i_+Dm4h_U4X_Jc-nhNMjoufiZRdn5LGxFqD_HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 21:25:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y78mu-0004Hy-SH
	for gcvg-git-2@plane.gmane.org; Fri, 02 Jan 2015 21:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbbABUZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2015 15:25:32 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:9453 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751779AbbABUZc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2015 15:25:32 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3kDd5h6wtVz5tlF;
	Fri,  2 Jan 2015 21:25:28 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 25CCD19F8BD;
	Fri,  2 Jan 2015 21:25:27 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <CAHd499Cn8C51i_+Dm4h_U4X_Jc-nhNMjoufiZRdn5LGxFqD_HA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261981>

Am 02.01.2015 um 17:49 schrieb Robert Dailey:
> I have a function like so:
> 
> void MyClass::SomeFunction(int someParameter)
> {
>     // Stuff changed in here
> }
> 
> When I do `git diff` on the file containing this function, I get a
> chunk showing some changed code in this function somewhere in the
> middle of the body. However, the chunk header shows my root namespace
> name in the file instead of the function header:
> 
> @@ -144,15 +149,22 @@ namespace Utils
> 
> What I expect to see:
> 
> @@ -144,15 +149,22 @@ void MyClass::SomeFunction(int someParameter)
> 
> I've tried various regular expressions that work in regex testers I
> use against this function signature, however they do not work when I
> apply them to my config:
> 
> [diff "cpp"]
>     xfuncname =
> "^\\s*[\\w_][\\w\\d_]*\\s*.*\\s*[\\w_][\\w\\d_]*\\s*\\(.*\\)\\s*$"
> 
> File name is "foo.cpp", I even added it to my git attributes file:
> 
> *.cpp diff=cpp
> 
> Using the regex above, my chunk headers come back blank. Why is it
> showing namespace? How do I make this match the nearest function
> header?
> 

Is the line that contains 'void MyClass::...' before line 149? Does the
word 'void' begin at the left-most column?

-- Hannes
