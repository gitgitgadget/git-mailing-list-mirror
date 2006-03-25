From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 13:56:59 +0100
Message-ID: <81b0412b0603250456o7f5925e6kbbfc0054aec564a1@mail.gmail.com>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Davide Libenzi" <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 13:57:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN8KL-00021v-0e
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 13:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWCYM5E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 07:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWCYM5D
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 07:57:03 -0500
Received: from wproxy.gmail.com ([64.233.184.237]:43812 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751386AbWCYM5B convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 07:57:01 -0500
Received: by wproxy.gmail.com with SMTP id i5so1138060wra
        for <git@vger.kernel.org>; Sat, 25 Mar 2006 04:57:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YL1/xmIQg2EOgXcixvx8t66QqzcottaSPQLK3VGHLFtKYjBvYYpHbP/D3xS14nD2Ze2Rh2YseKpcfeJHgr9IuNOTXTHmx7FXnBK64vuvR+Mo6/gltDrDjHXtuYhLYV93A4Yl/4YKv9LsuA4aVnuru1Jl9AuvVRLPe9ZRlxHbYGY=
Received: by 10.35.37.18 with SMTP id p18mr948215pyj;
        Sat, 25 Mar 2006 04:56:59 -0800 (PST)
Received: by 10.35.46.19 with HTTP; Sat, 25 Mar 2006 04:56:59 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17983>

On 3/25/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> This uses a simplified libxdiff setup to generate unified diffs _without_
> doing  fork/execve of GNU "diff".
>
> This has several huge advantages, for example:
>

Even more impressive on Cygwin (>50x!):

.../git-win$ time git --exec-path=$(pwd) diff initial.. > /dev/null
real    0m1.485s
user    0m0.567s
sys     0m0.840s

../git-win$ time git diff initial.. >/dev/null
real    1m20.781s
user    0m31.806s
sys     0m20.717s
