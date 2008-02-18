From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 18 Feb 2008 02:05:33 +0100
Message-ID: <200802180205.35009.jnareb@gmail.com>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org> <200802172301.30380.jnareb@gmail.com> <7vablzxfpm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 02:06:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQuSb-0003zQ-U9
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 02:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002AbYBRBFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 20:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755880AbYBRBFr
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 20:05:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:33074 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873AbYBRBFq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 20:05:46 -0500
Received: by ug-out-1314.google.com with SMTP id z38so251730ugc.16
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 17:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=CaJfMsMo9YFVE1Yl9bfUrpDHi53hRcvVOTwyZ/DyD5I=;
        b=Fgpz0LaY0Q+HE/I5mwRhS9iPJEj2BjmVKHz8XyWnz30Em7sLVn6IORc64It9puUXRSoMOvlYMDdU2Fg+//9mZ4lW/rScTsTj3QWO2MdBVLSzUOzrL/liasxnf2qWvEErHEPfhxCzyig7E9V8q5IGD4/fvVnTA+LNKTqAXL9TdnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=d88dGitQuAPijXLH7n33IEeHkI3QF6DaXfAXqfJp7UnHJAk7EOaaJarTvKY+xuUNfx33UFggxMOtVQNIrGZ2C7so+DzQ+m7sij5Vd6ldYeXgzv9erQZm73u/kRfPGi6Fn4k7qCvrxrJXSjG/W6lIVsTHZCOv5HG7A4V3HuJiVsU=
Received: by 10.66.217.20 with SMTP id p20mr2520619ugg.51.1203296742552;
        Sun, 17 Feb 2008 17:05:42 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.248.52])
        by mx.google.com with ESMTPS id b30sm11194442ika.11.2008.02.17.17.05.39
        (version=SSLv3 cipher=OTHER);
        Sun, 17 Feb 2008 17:05:40 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vablzxfpm.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74211>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > 1. Currently tests check _built_ version:
> >
> >    # Test the binaries we have just built.  The tests are kept in
> >    # t/ subdirectory and are run in trash subdirectory.
> >
> >    It would be nice if there were a switch which would allow to test
> >    _installed_ (somewhere) version of git, to check for errors like
> >    some script not finding some command etc.
> 
> If you are saying _in addition_ I would not stop you, but I am
> not interested in testing installed version at all.  Testing
> after installing is already too late.

Of course I'm saying "in addition": I wrote "if there were a switch",
meaning that current running test for built git would be default, and
after setting some environment variable for example it would test
installed (or rather pre-installed) version.

It would be testing halfway during installing: we should install to some 
DESTDIR (like rpm does when building from SRPM), 
e.g. /tmp/git-<version>-root/, or something like that.

-- 
Jakub Narebski
Poland
