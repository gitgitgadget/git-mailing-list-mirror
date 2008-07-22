From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Error: "You have some suspicious patch lines"
Date: Tue, 22 Jul 2008 02:13:05 -0700 (PDT)
Message-ID: <m33am2wade.fsf@localhost.localdomain>
References: <4885895C.5050108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Aurel <ben.aurel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 11:14:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLDwh-0007di-93
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 11:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135AbYGVJNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 05:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbYGVJNL
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 05:13:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:8116 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649AbYGVJNI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 05:13:08 -0400
Received: by ug-out-1314.google.com with SMTP id h2so347535ugf.16
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 02:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ayK1anZjc4hUvijEQ+UR2WfKnV4raoWplGrd/z5l6Oc=;
        b=wNfbObmBe72yEYj0k4uu90N+eVEtdfGY+DvKUK8zBTVSL753RKjp+3y9pXSgHjBRAC
         GG1T3f+IQAx6UnBcJLTZC9Yt+EoPtL8HVF3H8UXq2NZFE9k0qwP+F2u8JwWPEw2XZOW6
         Sx74Cm8+PdpJ491ERr/mCEMFfVZ1FA0GqhCbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=AhcgYiuUu95Vz1LG0QuqlfB+baNfF+hlvzfeGnGTFPIM2CDUj6Ik0Hou9tnqdMQ8se
         Den7jN41lcoSsFFKDQxjtau8yar7pBbG5JqyjnM2bg098S+Iw+U3RUsCnugNZizTUPFQ
         aSVN1bnsQKgIYVPDVLMlMdDZy6J1nUF0d/sKc=
Received: by 10.103.193.13 with SMTP id v13mr3415984mup.7.1216717986451;
        Tue, 22 Jul 2008 02:13:06 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.247.139])
        by mx.google.com with ESMTPS id e10sm18469238muf.3.2008.07.22.02.13.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jul 2008 02:13:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6M9Ceiw020050;
	Tue, 22 Jul 2008 11:12:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6M9CU4u020037;
	Tue, 22 Jul 2008 11:12:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4885895C.5050108@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89474>

Ben Aurel <ben.aurel@gmail.com> writes:

> I working on mac os x 10.5.4 (intel) with git version 1.5.5.3 and I
> always get this message for most of my perl scripts and also for
> "Makefile.pre" files:
> 
> ----------- Message ---------------
> * You have some suspicious patch lines:
> *
> * In src/scripts/trunk/3rdparty/file_sanity.pl
> * trailing whitespace (line 52)
> ...
> ------------------------------------------

> The question now is: Is it really necessary to edit the git script
> everytime? Is there a urgent reason why git refuses to commit because
> of "suspicious" lines? Is it really necessary?

.git/hooks/pre-commit is example hook which helps to keep Coding Style,
and prevents from accidentally comitting nonresolved file-level merge
conflict (file with conflict markers).

If you want to skip running this hook once (or once upon a time), you
can use '-n'/'--no-verify' option to "git commit".  Or you can turn this
example hook off, either by removing execute permission from it, by
removing it alltogether (you can still find it in templates, usually at
/usr/share/git-core/templates/hooks/pre-commit), or rename it adding for
example '.sample' or '.nonactive' suffix.

This hook should not be turned on by default, but if your filesystem is
executing bit challenged it could be turned on at repository creation
time unintentionally.  Newer version of git use '.sample' suffix (for
example pre-commit.sample) instead of relying on not always reliable
execute bit being unset.

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
