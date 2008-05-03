From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: merge renamed files/directories? (was: Re: detecting rename->commit->modify->commit)
Date: Sat, 3 May 2008 14:11:45 -0400
Message-ID: <32541b130805031111r4cbea8e1l19c34ac05016a89b@mail.gmail.com>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com>
	 <32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com>
	 <20080501153457.GB11469@sigill.intra.peff.net>
	 <D0968007-2A38-44DB-B26F-3D273F20D428@midwinter.com>
	 <20080501231427.GD21731@sigill.intra.peff.net>
	 <481CA742.4080909@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ittay Dror" <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Sat May 03 20:12:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsMDw-000638-2t
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 20:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763507AbYECSLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 14:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761144AbYECSLv
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 14:11:51 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:45126 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757936AbYECSLu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 14:11:50 -0400
Received: by fk-out-0910.google.com with SMTP id 18so55920fkq.5
        for <git@vger.kernel.org>; Sat, 03 May 2008 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=w6H+J6Xfb/eo+vQOReKxDuy7IZWJ+DqAwMfftATiqfU=;
        b=rdW2Sghmd77sZ+LUgSR+KRhLDK6mR6QZDi051IfWBmkZpZMC1RAEHvwNXcqpoOT6GDp7rd1eJMcwyr96+Up19yuBSzih0dcjXCROrKI4PLPuUJjohPYjl271vP9z80mnoPv7Z1aQSEEmrU5cau7Te6rQoQ0xj3kfsWusZ8QrqPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UWzQMszBWESnhBmbNQyzdCEf7BTxUkzWImIpwvJYqbRFrp5F6Pb+df2pvGiH7cYRoKfx/bZD7s588MC/obsJgE/ijIxncJxrcvcH8tvxKB6pBs6vu8ohYWzADbXgZMthcchULMz6NACV40/ttL3YZz7Cc8wQ/Qd1s9PYwsGb8ao=
Received: by 10.82.186.5 with SMTP id j5mr427093buf.41.1209838305030;
        Sat, 03 May 2008 11:11:45 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Sat, 3 May 2008 11:11:45 -0700 (PDT)
In-Reply-To: <481CA742.4080909@tikalk.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81109>

On 5/3/08, Ittay Dror <ittayd@tikalk.com> wrote:
> Can someone comment whether supporting merges after renames will be on the
> Git roadmap?
>
>  As a Java developer, I can say that refactoring of class names and packages
> happens quite often. Having to remember I've made this change throughout the
> lifetime of a branch (or master, until pushed to a central repository), and
> needing to manually merge changes to files / packages (directories) I've
> refactored is something that I want my VCS to do.

Git already works fine for renames.  The only situation where
something funny happens is if you rename a whole directory and someone
else creates a file in the old directory.  (In that case, the new file
ends up in the old place instead of the new place.)  However, even in
that case, there is still no conflict and no manual merging necessary.

In fact, as someone else pointed out, renaming a java file requires
you to modify the file anyhow, so having git auto-move the file to
another directory *still* wouldn't make it work any better.

Have fun,

Avery
