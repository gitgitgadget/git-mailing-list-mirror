From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 16:52:40 +0100
Message-ID: <81b0412b0701180752x1664f661o17ce78a7024590f3@mail.gmail.com>
References: <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
	 <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
	 <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>
	 <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com>
	 <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com>
	 <45AF7FE8.5060003@op5.se>
	 <81b0412b0701180641v55987657t331d6a1868dabee0@mail.gmail.com>
	 <20070118152620.GB15428@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>, "Josh Boyer" <jwboyer@gmail.com>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 16:52:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7ZZI-0000VK-CR
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 16:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbXARPwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 10:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbXARPwo
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 10:52:44 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:19713 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbXARPwm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 10:52:42 -0500
Received: by wr-out-0506.google.com with SMTP id i22so195761wra
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 07:52:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kf6MTHkOt6Y7Luke57YH6mp0SB4rLTHUOC8nxH1gLJolv1BNBJTAMmoTBaDG2mMNx/OtWU00Z9EpQ8wTrHU0KRQHAOIYUKF75d9rVPuOt4riOX8iw92i/xSelOeE4/aHlW/CkypWAtAA5qkHzVdoD3V1a0JQ0XrqP3LehcqoyhU=
Received: by 10.78.164.13 with SMTP id m13mr982830hue.1169135560457;
        Thu, 18 Jan 2007 07:52:40 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 18 Jan 2007 07:52:40 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070118152620.GB15428@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37115>

On 1/18/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > don't think so. I _would_ cry seeing how fork(2) gets ported to Windows,
> > and you will, probably... after seeing how it is done in cygwin.
>
> AFAIK there's not a strong reason to keep fork() in Git.
>
> Currently anytime we fork a process its to perform a small amount
> of file descriptor redirection and then immediately exec some other
> executable, or a hook script.  In other words we probably could
> convert all current uses of fork to something like in run-command.c,
> which a Windows port could then easily replace using CreateProcess().

I count 17 instances (excluding run_command). At least fetch-pack
is not trivial (the sideband code. Could be done in a  thread, which
is not portable just as well).

> But removing fork isn't worth doing until someone is seriously
> trying to port Git onto Windows without Cygwin.  The current code
> works on sane OSes and isn't broken, so why fix it?

Right.
