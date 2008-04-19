From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Confused about "ident" filter
Date: Sat, 19 Apr 2008 01:27:30 -0700 (PDT)
Message-ID: <m3skxiqmfr.fsf@localhost.localdomain>
References: <Pine.LNX.4.64.0804170812230.7970@ds9.cixit.se>
	<48076059.4040503@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sat Apr 19 18:01:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jn8Qm-0004Om-UY
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 10:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbYDSI1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 04:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbYDSI1e
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 04:27:34 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:28070 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbYDSI1d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 04:27:33 -0400
Received: by fg-out-1718.google.com with SMTP id l27so861195fgb.17
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=kBgLzcq85JTlKgkkSCNoYFCOXDJHGjxT3ZYqAuSYBfc=;
        b=PMmiXt6LwcGvMFA/quDPXkDVFS2UB7VNJUBt9zb//zqP2KD3Z7IqUbyg1LK6NmeeK773f6yDM85WVlbVz8+O3tF+sMpyp8UhfwrjBTI//UebS3dXlgJOvye7GVQ+vgHGg9qjcBw8t9WZVZ2hWUEnBm7iuC50OMirCrprRI481wI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=eioe3ghxawy5wn8nQrWz6peiEEesizjN+WoTRsA4salVsGKKb1dSB6S0UMNdtjYIRINhhNvgX585NKRAPC6/j8j1WKKxBtc0UJ4fKQuBH9xYoH7BBjb8zMJcJwgrp3qWtaH6117tjWdYPe1rMQlsfsV4SBHxF1hGoVijhen0JVM=
Received: by 10.82.127.15 with SMTP id z15mr6345600buc.41.1208593651783;
        Sat, 19 Apr 2008 01:27:31 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.208.125])
        by mx.google.com with ESMTPS id d27sm1404692nfh.2.2008.04.19.01.27.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Apr 2008 01:27:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3J8ROiF011454;
	Sat, 19 Apr 2008 10:27:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3J8RKWs011451;
	Sat, 19 Apr 2008 10:27:20 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <48076059.4040503@gnu.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79900>

Paolo Bonzini <bonzini@gnu.org> writes:

> Peter Karlsson wrote:
> > I tried doing "git checkout test.perl", I tried "git clone" to get a new
> > copy of the repository, but still it showed only "$Id$".
> 
> In fact I'm a little confused too.  The only way I found to expand
> "$Id$" consistently was "rm test.perl; git checkout test.perl", or "rm
> test.perl; git reset --hard HEAD".

I think that "git checkout -f test.perl" should work, forcing git to
replace existing file.

As to clone problem: it might be chicken and egg problem, with `ident`
filter needing .gitattribites in working directory during checkout
phase (currently there is no way to use gitattributes from a tree in
repository), and checkout writing this file.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
