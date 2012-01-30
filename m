From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb showing slash r at the end of line
Date: Mon, 30 Jan 2012 01:23:05 -0800 (PST)
Message-ID: <m3obtlczmu.fsf@localhost.localdomain>
References: <1327673954458-7229895.post@n2.nabble.com>
	<m3aa58eskw.fsf@localhost.localdomain>
	<7vvcnwybxj.fsf@alter.siamese.dyndns.org>
	<201201281802.44339.jnareb@gmail.com>
	<1327910140526-7235866.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ondra Medek <xmedeko@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 10:23:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrnSI-0002aK-Do
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 10:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882Ab2A3JXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 04:23:09 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33955 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab2A3JXI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 04:23:08 -0500
Received: by eaal13 with SMTP id l13so1038456eaa.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 01:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=pad5sFGPg+zRqg/8H7ntYStFAn+Ch6QyvEMLsxZCLHc=;
        b=ME9M0tCaiz9yXR6fJOiKmZq2kB8ZcTz+Bu6Dj50Hb65TOuYTxE1BA1dclaT0auyNA1
         CFeX5cFRZLIx3EPiWBbTSWxE/JhZfoWy36lS+t9JR1jhpEL1PRzbThwj8f3Ly4m8Gj2c
         xjKy90+mC7haG6z4a7Atd7gKTu+5BIYIHqtlw=
Received: by 10.213.11.10 with SMTP id r10mr2679512ebr.144.1327915386839;
        Mon, 30 Jan 2012 01:23:06 -0800 (PST)
Received: from localhost.localdomain (abwg78.neoplus.adsl.tpnet.pl. [83.8.230.78])
        by mx.google.com with ESMTPS id b49sm70270133eec.9.2012.01.30.01.23.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 01:23:05 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q0U9Nda6014402;
	Mon, 30 Jan 2012 10:23:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q0U9NcJU014399;
	Mon, 30 Jan 2012 10:23:38 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1327910140526-7235866.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189333>

Ondra Medek <xmedeko@gmail.com> writes:

> I have read "SubmittingPatches". I have made a path by "git format-patch -M"
> and I have though it's enough. The problem maybe was, that I had not
> included "Subject: " from the result of "git format-patch -M". Next time I
> will try to do it better.

The problem is that in place of proper commit message, describing
change for posteriority as described in SubmittingPatches, you have an
email describing why you created this commit:

OM> Hi,
OM> we have gitweb running on Linux box. Some files have Windows line ending
OM> (CRLF) end we do not use core.autcrlf translation. gitweb show the last \r
OM> in the end of each line, which is annoying. I have creates a simple patch to
OM> avoid this. It adds just one line. I am not sure if the regexp should
OM> contain 'g' switch in the end. Also, not sure if there shoul be some config
OM> option to switch on/off this?
OM> 
OM> Cheers
OM> Ondra
 
Take a look how other commit messages are written in git.git, and
please remember to sign off your patches.

> I am a Git newbie, but my bare repos have "config" file and this file can
> contain the "core.autocrlf" setting. So the gitweb can read it. Or what
> about to have a special section [gitweb] in this config? For now, the gitweb
> config files are somewhat "scattered" = "descrition", "cloneurl",
> "project.list", ...

The [gitweb] section contains stuff that can be used instead of
individual files like 'description' ('gitweb.description' can be used
instead if that file is not present), and also to configure
overridable features on per-repository basis, like 'gitweb.snapshot'.
 
> Yeah, the autodetection of mixed mode line endings could be the best
> solution.
> 
> However, from my point of view a global gitweb setting would be enough for
> now.

I think that if not using autodetection this should be made into
proper gitweb %feature, e.g. named 'eol' - this automatically gives
ability to override it on per-repository basis via repo config.

-- 
Jakub Narebski
