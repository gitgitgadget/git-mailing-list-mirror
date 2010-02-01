From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/2] upload-pack: pre- and post- hooks
Date: Mon, 1 Feb 2010 07:20:10 -0800
Message-ID: <20100201152010.GC8916@spearce.org>
References: <6f8b45101001150414r2661001ep10819b601953c05b@mail.gmail.com> <1265013127-12589-1-git-send-email-ford_prefect@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arun Raghavan <ford_prefect@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Feb 01 16:20:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nby4c-0003uR-EX
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 16:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088Ab0BAPUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 10:20:15 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:64197 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911Ab0BAPUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 10:20:14 -0500
Received: by gxk24 with SMTP id 24so6749416gxk.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 07:20:13 -0800 (PST)
Received: by 10.151.28.3 with SMTP id f3mr3809884ybj.273.1265037613584;
        Mon, 01 Feb 2010 07:20:13 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 5sm1793176ywd.42.2010.02.01.07.20.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 07:20:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1265013127-12589-1-git-send-email-ford_prefect@gentoo.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138613>

Arun Raghavan <ford_prefect@gentoo.org> wrote:
> This patch set reintroduces the post-upload-pack hook and adds a
> pre-upload-pack hook. These are now only built if 'ALLOW_INSECURE_HOOKS' is set
> at build time. The idea is that only system administrators who need this
> functionality and are sure the potential insecurity is not relevant to their
> system will enable it.

*sigh*

I guess this is better, having it off by default, but allowing an
administrator who needs this feature to build a custom package.

Unfortunately... I'm sure some distro out there is going to think
they know how to compile Git better than we do, and enable this by
default, exposing their users to a security hole.  Ask the OpenSSL
project about how well distros package code...  :-\

I'd like a bit more than just a compile time flag.
 
> At some point if the future, if needed, this could also be made a part of the
> negotiation between the client and server.

I'm not sure I follow.

Are you proposing the server advertises that it wants to run hooks,
and lets the client decide whether or not they should be executed?

-- 
Shawn.
