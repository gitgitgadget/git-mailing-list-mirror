From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Wed, 25 Jun 2008 21:30:34 -0400
Message-ID: <32541b130806251830t12b761bo9fa04a48cc53b2a9@mail.gmail.com>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
	 <m33an1josg.fsf@localhost.localdomain>
	 <32541b130806251253t3dcada10nbf94fee9e4aed9ec@mail.gmail.com>
	 <200806252335.05083.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 03:31:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBgKi-0004EM-Fe
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 03:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbYFZBah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 21:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbYFZBag
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 21:30:36 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:3467 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbYFZBag (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 21:30:36 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3466946fkq.5
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 18:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JtHL5xloXDrO4y2TOs3QmSTHUgjvF4e9byZfsLq10X4=;
        b=hoIjOs7KZnema7o5X6R+FBmVLA7hTp0C+/1tS+YnxS02S0o+PE4tmHzIvrEngb84AP
         LzTAl82F98E6JpHnx+oc+9Rtrc+jf2RE5PkCPr9WWJsVab6tanzLNHVTb6i09E5SZAw7
         vAjRCkkJgcbYVguO3SNIxCxFmMnBMMEXMb6pA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Y6oRph1KKLrEDOckOFamI5CwEBAWYOZE8UR9zz3lh7VBS1t1+PMu/usnxglME453DX
         orOjJfrfT0tGiG+9Ckt0KSYIUMhJlmhbO2fhl+2fGEGpc0iZeNqD8k1uPsNMjqEJmw3d
         PLI1Mbi5Q16+cjpcgSs52KbR+ygIHVSQ+mswM=
Received: by 10.82.163.13 with SMTP id l13mr682911bue.3.1214443834505;
        Wed, 25 Jun 2008 18:30:34 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Wed, 25 Jun 2008 18:30:34 -0700 (PDT)
In-Reply-To: <200806252335.05083.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86383>

On 6/25/08, Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 25 Jun 2008, Avery Pennarun wrote:
>  > Now the catch is, if I want to implement the daemon I was talking
>  > about earlier, I'd like to be able to notice untracked files (or
>  > directories with untracked files) individually.  Ideally, I guess the
>  > best way would be to just keep a separate list of all existing files
>  > that aren't in the index, and have git status look at that rather than
>  > at the actual filesystem.
>  >
>  > Are there any suggestions for how best to do this?
>
> You can try to take a look at how (third-party and Linux only) inotify
>  extension for Mercurial works.  AFAIK IIRC it uses some kind of daemon
>  which watches for inotify notices and updates Mercorial's equivalent
>  of index.

Sorry, I asked the wrong question.  I wasn't asking how to implement
the daemon, which I think I can do without much trouble.  I actually
need to know how to represent the information.

I was thinking of handling updated files by doing update-index
--no-assume-unchanged on files that change.  But where should I store
information about *untracked* files that have changed, so that
git-status can still report them but not have to scan them all?

Thanks,

Avery
