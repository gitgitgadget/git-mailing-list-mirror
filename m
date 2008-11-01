From: "Elijah Newren" <newren@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Sat, 1 Nov 2008 13:57:54 -0600
Message-ID: <51419b2c0811011257v74a75053la59755e7dabe2f09@mail.gmail.com>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	 <20081030143918.GB14744@mit.edu> <4909CC85.1080803@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>, "Sam Vilain" <sam@vilain.net>,
	git@vger.kernel.org, "Sam Vilain" <samv@vilain.net>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 01 20:59:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwMcm-0006lK-Gw
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 20:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbYKAT5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 15:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbYKAT5z
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 15:57:55 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:63846 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbYKAT5y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 15:57:54 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1863117rvb.1
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 12:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3WPUPkFKBMSngsGnZDvXBVjisL9ItD60v7z3OHuG7QQ=;
        b=JVj3scSiChyhT6vtomhtUWPJsF8svqNZ+m6DHhYT6W9ieLYgPvV8va8sEukgEbXNq7
         Tp4W9BxbDyjf6pOjNYomOlYLK5wLvCGjzbyXEkkqMwi+VOcHILVhtSzBPJmRwuRdwfL3
         nuSDytWamQKYvrGMpGehPMyTz9DHcUbK0N5Mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iksPiYW5RjY9cjSw/P1ZwnEBR4FzeXRg2ZiOr6Ejup9lmub5EEyJPp/9PENp61vM3/
         kwA51ouNHV5oyUowRlkFsgANsT9UEsO5uj0T1Rfid31sVfpCAaZVrQsYVVJvYyIxSj0m
         ZkHMSiC/31WsNZ5soh1HCtWD3ql+X97SNFgD4=
Received: by 10.140.140.3 with SMTP id n3mr7659446rvd.299.1225569474155;
        Sat, 01 Nov 2008 12:57:54 -0700 (PDT)
Received: by 10.141.163.16 with HTTP; Sat, 1 Nov 2008 12:57:54 -0700 (PDT)
In-Reply-To: <4909CC85.1080803@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99767>

Hi,

On Thu, Oct 30, 2008 at 9:02 AM, Andreas Ericsson <ae@op5.se> wrote:
> I like it, although I guess one would have to add a "--staged" flag to
> git revert-file to be able to checkout files from index as well, or people
> will wonder why that can't be done.

Ew.  'git revert-file --staged foo'?  If you want to revert the
*unstaged* changes of a file, it should be 'git revert-file --unstaged
foo'.
I would expect 'git revert-file --staged foo' to revert the staged
changes in foo, i.e. it should do what 'git reset -- foo' does (except
that it should also work for the initial commit).  Thus, there'd be
little need for a --staged flag to revert-file, unless we allowed
reverting individual files back to some revision prior to HEAD (like
bzr and hg do)...
