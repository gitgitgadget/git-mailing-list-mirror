From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: SChannel support in Git for Windows
Date: Fri, 15 Jan 2016 19:47:46 +0300
Message-ID: <20160115194746.abcb4b7dab4653d222e0362c@domain007.com>
References: <CA+1xWaokgVthDv-up76RP+s+r4pSv5ntmePtDVND+rsKuo+-YA@mail.gmail.com>
	<20160115185923.1e9fe5220b623625fdbc8041@domain007.com>
	<CA+1xWarcXz4RdgXd8p-43sQ5UeRAwXmrsU_JVqwewmro7rz2Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>, git@vger.kernel.org
To: Robert Labrie <robert.labrie@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 17:47:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK7XW-0007he-IS
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 17:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbcAOQrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 11:47:51 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:49554 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbcAOQru (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 11:47:50 -0500
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id u0FGlk2F021061;
	Fri, 15 Jan 2016 19:47:47 +0300
In-Reply-To: <CA+1xWarcXz4RdgXd8p-43sQ5UeRAwXmrsU_JVqwewmro7rz2Gw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284179>

On Fri, 15 Jan 2016 11:11:58 -0500
Robert Labrie <robert.labrie@gmail.com> wrote:

> You are correct, SChannel in NT 5.x is limited, but all those versions
> are officially out of support.
> 
> When you're part of a Windows ecosystem, those root certs get pushed
> into the local store by a GPO (usually), and you don't have to think
> about it. That's the only reason I'm pushing.
> 
> Sounds like libcurl can't make it a run time consideration, and git
> (understandably) doesn't want to worry about SChannel limitations in
> very old versions of Windows.
> 
> Does git use libcurl for everything? I wonder if I could just drop my
> own libraries with WinHTTP support?

I'd say you could fork the Git for Windows's SDK [1], hack it to build
curl with the configuration you need and then create your own
installer.  You'll need to rebase your patch each time a new GfW
release will come out, but the patch should be small enough IMO.

1. https://github.com/git-for-windows/build-extra/releases/latest
