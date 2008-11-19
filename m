From: Matthias Kestenholz <mk@feinheit.ch>
Subject: Re: git and mtime
Date: Wed, 19 Nov 2008 13:22:34 +0100
Message-ID: <C33ABF98-2E52-4928-BF79-CB3B6A8460DB@feinheit.ch>
References: <20081119113752.GA13611@ravenclaw.codelibre.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 13:24:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2m6M-0007ha-TT
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 13:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbYKSMWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 07:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752497AbYKSMWz
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 07:22:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:21057 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbYKSMWy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 07:22:54 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2820621fgg.17
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 04:22:52 -0800 (PST)
Received: by 10.86.93.17 with SMTP id q17mr690897fgb.8.1227097372717;
        Wed, 19 Nov 2008 04:22:52 -0800 (PST)
Received: from saufpark.feinheit.local (77-56-178-27.dclient.hispeed.ch [77.56.178.27])
        by mx.google.com with ESMTPS id e11sm922856fga.9.2008.11.19.04.22.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Nov 2008 04:22:51 -0800 (PST)
In-Reply-To: <20081119113752.GA13611@ravenclaw.codelibre.net>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101330>

Hi,

On 19.11.2008, at 12:37, Roger Leigh wrote:

> Hi folks,
>
> I'm using git to store some generated files, as well as their sources.
> (This is in the context of Debian package development, where entire
> upstream release tarballs are injected into an upstream branch, with
> Debian releases merging the upstream branch, and adding the Debian
> packaging files.)
>
> The upstream release tarballs contains files such as
> - yacc/lex code, and the corresponding generated sources
> - Docbook/XML code, and corresponding HTML/PDF documentation
>
> These are provided by upstream so that end users don't need these  
> tools
> installed (particularly docbook, since the toolchain is so flaky on
> different systems).  However, the fact that git isn't storing the
> mtime of the files confuses make, so it then tries to regenerate these
> (already up-to-date) files, and fails in the process since the tools
> aren't available.
>
> Would it be possible for git to store the mtime of files in the tree?
>

This subject comes up from time to time, but the answer always
stays the same: No. The trees are purely defined by their content, and
that's by design.

If you do not want to regenerate files that are already up-to-date,
you need multiple checkouts of the same repository.



Thanks,
Matthias
