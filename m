From: "David Aguilar" <davvid@gmail.com>
Subject: Re: git-branch --print-current
Date: Thu, 1 Jan 2009 20:26:29 -0800
Message-ID: <402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git mailing list" <git@vger.kernel.org>
To: "Karl Chen" <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Fri Jan 02 05:28:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIbdg-0000Yn-Er
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 05:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541AbZABE0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 23:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754658AbZABE0c
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 23:26:32 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:38049 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbZABE0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 23:26:31 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5784475rvb.1
        for <git@vger.kernel.org>; Thu, 01 Jan 2009 20:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6JJlRGgPg4QafMlpyhL8c52YN4p5ZKD/MsSA27NE2Ls=;
        b=yEptN1MbdRfq0tLNfrLrIzxqGZMDhXHK56X8yn/neN2QhQMuY4iCOnhd83/DBBpBQ/
         swuXIhS26cPkEuGcNmdNDepV3PadIJqWmqYG5H1eNX2PrV/dJ5uTDgSr/8P7pL+5U1la
         og+svS2RvmDwDr5/iMiiA1475ML9waTV0bmWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=p1NtTOMMGVeEzpbG9nm7bj9ZNjIxdqnlYXBcXUh3crAObHNyw6rouQG9QAbRmzG7nt
         Nql60SIAm1d8s1No2qh5ZCwWdBzaZdcKW98HuN3UWodokqgSk+I0bRq5O+/4JLYVhBQs
         81s4qNV/TQOmNsh7ZV47W6+hhXzH8ELQBmHQk=
Received: by 10.142.125.9 with SMTP id x9mr7181134wfc.85.1230870389459;
        Thu, 01 Jan 2009 20:26:29 -0800 (PST)
Received: by 10.142.241.20 with HTTP; Thu, 1 Jan 2009 20:26:29 -0800 (PST)
In-Reply-To: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104358>

On Thu, Jan 1, 2009 at 7:28 PM, Karl Chen <quarl@cs.berkeley.edu> wrote:
>
> How about an option to git-branch that just prints the name of
> the current branch for scripts' sake?  To replace:
>
>    git branch --no-color 2>/dev/null | perl -ne '/^[*] (.*)/ && print $1'


The justification I've heard before is that 'git branch' is a
porcelain and thus we shouldn't rely on its output for scripting
purposes.

You might want to use 'git symbolic-ref' instead.

$ git symbolic-ref HEAD
refs/heads/master

$ git symbolic-ref HEAD | sed -e 's,refs/heads/,,'
master


-- 
    David
