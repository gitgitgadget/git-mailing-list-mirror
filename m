From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Per file configurable eol-style transformations with Git?
Date: Sat, 21 Nov 2009 13:18:16 -0800 (PST)
Message-ID: <m3tywnbmpj.fsf@localhost.localdomain>
References: <9ED0EB52C33C41209726C6F4DB7FC194@helium>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Alexander Veit" <alexander.veit@gmx.net>
X-From: git-owner@vger.kernel.org Sat Nov 21 22:19:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBxLd-0000rG-1o
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 22:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbZKUVSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 16:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753955AbZKUVSN
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 16:18:13 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:45739 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbZKUVSM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 16:18:12 -0500
Received: by bwz27 with SMTP id 27so4188167bwz.21
        for <git@vger.kernel.org>; Sat, 21 Nov 2009 13:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=yi/QIWofQTPmdnwNMnyBGBWUiFBu+V7jTwDK2052j4w=;
        b=V4eRtulb82yhQm6nIPWp3YTHWU9I6/yBjtsONBuZa665AImT2WB/RMlMHwnn8kG63T
         0XdL7gonxBB+cPWZCfay0L7+fGgx7Go9Vld2B7FwweO9f/abN5jEFS1qn1CKE843zSMZ
         IFEId3QCdEi9DM3+tO1qYbGR5zAVHJQkUJOvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=dVRe4G+oQUMvZMp4iNmzTvROrSWGg+ShRxFH1nrb/CEdOXqTtOnreS13QXACpmaek8
         rqLrXNx2S0tL+XJGZ0WsiY+PMp2HHMRGwyDXbyAyWy2LL49GxCjNuPchUsYplTK0/ewp
         bv7sZkmiJtJK1YnIY5tboChY9ErA/0gOT+CXc=
Received: by 10.204.15.16 with SMTP id i16mr2918265bka.72.1258838296944;
        Sat, 21 Nov 2009 13:18:16 -0800 (PST)
Received: from localhost.localdomain (abvz69.neoplus.adsl.tpnet.pl [83.8.223.69])
        by mx.google.com with ESMTPS id 13sm732847bwz.10.2009.11.21.13.18.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Nov 2009 13:18:16 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nALLJ59R015273;
	Sat, 21 Nov 2009 22:19:06 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nALLJ4nd015270;
	Sat, 21 Nov 2009 22:19:05 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <9ED0EB52C33C41209726C6F4DB7FC194@helium>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133413>

"Alexander Veit" <alexander.veit@gmx.net> writes:

> we have projects that contain text files that need to
> have different end-of-line sequences, depending on the
> type of file, and depending on the operating system where
> they are checked out.
> 
> There are files that have
> 
>  - LF line breaks on each platform,
>  - CR LF line breaks on each platform, or
>  - either LF or CR LF line breaks, depending on the
>    platform's native end-of-line style.
> 
> With Subversion, the correct behaviour in checkouts, commits,
> diffs, or merges can easily be achieved by setting the appropriate
> svn:eol-style [*].
> 
> As I understand the Git documentation there's no such concept as a
> repository end-of-line style, or as an end-of-line transformation
> between repository and working copy.
> 
> So I wonder if it is possible to mimic Subversion's end-of-line handling
> with Git, especially for the svn:eol-style=native.

See `crlf` attribute, which can be set, unset, unspecified, set to
"input", and used together with core.autocrlf ("true", "false", "input")
and core.safecrlf.  Attributes can be set per path (using globbing
patterns) in .gitattributes file in tree, or in .git/info/attributes
(per repository).

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
