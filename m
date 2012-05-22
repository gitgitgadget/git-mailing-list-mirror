From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: diffstat witdth with one changed file
Date: Tue, 22 May 2012 07:59:39 +0200
Message-ID: <4FBB2B4B.6030402@in.waw.pl>
References: <CACsJy8BrqaLbtVp5uF3q2Jo63DPwtFACYw3_rPy8eyNK7VSWMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 08:00:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWi8g-0004mW-IW
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 08:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469Ab2EVGAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 02:00:04 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:37157 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755248Ab2EVGAD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 02:00:03 -0400
Received: from 69-mo7-2.acn.waw.pl ([85.222.93.69] helo=[192.168.0.150])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SWi8X-0003E3-7M; Tue, 22 May 2012 08:00:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <CACsJy8BrqaLbtVp5uF3q2Jo63DPwtFACYw3_rPy8eyNK7VSWMw@mail.gmail.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198181>

On 05/21/2012 05:52 PM, Nguyen Thai Ngoc Duy wrote:
> Hi,
> 
> With recent git, "git log --stat 90e6ef5", the first commit's diffstat
> uses full terminal width while the next one uses less than 80 chars.
> Both changes one file. Is it intentional? I tend to think it's a bug
> because with one-file changes, diffstat width is not important as we
> have no other files to compare with.
Hi,
90e6ef5 makes 502 additions/deletions, so it scales the +- part to the
whole available terminal width. 90e6ef5^ does only 41 additions, so it
can display the +- part unscaled without even filling the terminal width.

Since we don't coordinate the diffstat width between different commits
in the same git-log invocation, there's no way to make the diffstats use
the same scale. Anyway, diffstat is only supposed to give a rough
overview, and it does that here.

What output would you expect?

Zbyszek
