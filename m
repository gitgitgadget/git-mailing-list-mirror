From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Stamp Git commit id into file during build process
Date: Sat, 16 Jan 2010 11:35:34 -0800 (PST)
Message-ID: <m3d419desd.fsf@localhost.localdomain>
References: <a1138db31001161050i73eade1bif968ca1256dcef2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Richards <paul.richards@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 20:35:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWEQy-00028h-Ib
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 20:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab0APTfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 14:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753277Ab0APTfk
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 14:35:40 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:51563 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab0APTfj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 14:35:39 -0500
Received: by fg-out-1718.google.com with SMTP id 22so71651fge.1
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 11:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=QgrAaHUBv6/9RiyM0QWi9GVdy5AaqJdOxgHcS2l0p+M=;
        b=w6nBsm6fGCqzIgu1dyL+YHOPb9MRhX//81uD9Hc+LcebNCtBR/CwB5pHlJoXhgsIJ0
         8hSsoE2fMvqL/bnpdLiRQv9E6AvmytuZ/F8kQKqIYvx7/ps9uiS+AdDiCatCpAVc2OSj
         BwMCT486aWWntp3cLGM7DgW7OUSiDRb/n1hS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=LTjs9MQKkT5mFSnBxLPy3tCHSxIbZ55jKxfdATq8kn76hL/mB9YLp73buEqndq4NKC
         S2WLhkc/hdd3msc1I2W7ONQGg4Ocu8fo1cU9IP2tnWuyUUmrik6HyPzS5WWuZsn5S7Dt
         j6gYlJcwTAxtncVbJshyy4Fme1LLNpUp5ROTw=
Received: by 10.87.66.11 with SMTP id t11mr4831548fgk.18.1263670535469;
        Sat, 16 Jan 2010 11:35:35 -0800 (PST)
Received: from localhost.localdomain (aehn53.neoplus.adsl.tpnet.pl [79.186.195.53])
        by mx.google.com with ESMTPS id l19sm5386051fgb.3.2010.01.16.11.35.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Jan 2010 11:35:34 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0GJZ8Hi014293;
	Sat, 16 Jan 2010 20:35:19 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0GJYwWh014287;
	Sat, 16 Jan 2010 20:34:58 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <a1138db31001161050i73eade1bif968ca1256dcef2c@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137256>

Paul Richards <paul.richards@gmail.com> writes:

> Hi,
> I am in the process of migrating from Subversion to Git.  One thing I
> am unsure of is how to stamp the 'version' or 'commit id' into a file
> as part of a build process.
> 
> With subversion I used the SubWCRev tool from TortoiseSVN
> (http://tortoisesvn.net/docs/release/TortoiseSVN_en/tsvn-subwcrev.html).
> 
> With Git I imagine that I'd like to put a copy of the current commit
> id (either the full hash or a truncated version of that) into a file
> which then gets included into the program source code in some way.
> 
> Is there a recommended way of doing this with git?  Perhaps with
> something similar to SubWCRev?
> 
> Currently I am thinking about using "git log", and grepping the output
> in some way so that I just get the hash.

Not "git log".

Take a look how for example git project and Linux kernel use "git describe"
in GIT-VERSION-GEN script, and how they use GIT-VERSION-GEN script in the
Makefile.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
