From: Jeremy O'Brien <obrien654j@gmail.com>
Subject: Re: git grep -I bug
Date: Tue, 3 Feb 2009 14:42:58 -0500
Message-ID: <20090203194258.GA1354@Ambelina.snd-wireless.uc.edu>
References: <20090202174257.GA8259@Ambelina.erc-wireless.uc.edu> <7vwsc8hgh4.fsf@gitster.siamese.dyndns.org> <20090202182601.GA173@Ambelina.local> <7v1vugf8gc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 20:44:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LURCC-0007ng-GO
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 20:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbZBCTnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 14:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbZBCTnF
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 14:43:05 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:62501 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbZBCTnE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 14:43:04 -0500
Received: by gxk14 with SMTP id 14so1770966gxk.13
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 11:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=UQDTX8DaINi6F2wSif0Z9+ooWEDTCTdYGrbZdmXQDZM=;
        b=iX8tAVGObwKVd7ZKjTgHZ1QvMmhwMgQO7ObEDTIL3n4FHEtT4vIJ1GnxsAhGmm+h5H
         M2ISa7UFeyMLvbbzCM2/rM/g7ehrE2VaedFrjnK8ufcEtgbWrV1hjwp9FNMUDI/t8km1
         H9prGvAL37a+TQFRJ/CyCYu53bVvz9704b8tU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=H4sWa8XU3JwV8MVXG95UI4XZOGux/H0ppvwuu/bvE7BZj+kXaC9a2qkeJk2+/Kcrcd
         PnQetl6EEHrkxGBRB4CZy3bWZ77oGwm6Jlb6f04+w/p23YtYe11To/GpVI5kbFrKo5f9
         B5DuetkekkGrcXjdOf58RktGYOOc+xyGn7LRc=
Received: by 10.65.197.16 with SMTP id z16mr3473616qbp.25.1233690181109;
        Tue, 03 Feb 2009 11:43:01 -0800 (PST)
Received: from Ambelina.snd-wireless.uc.edu (dynamic-164-198.natpool.uc.edu [129.137.164.198])
        by mx.google.com with ESMTPS id p30sm362170qbp.22.2009.02.03.11.43.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 11:43:00 -0800 (PST)
Mail-Followup-To: Jeremy O'Brien <obrien654j@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v1vugf8gc.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108245>

On Mon, Feb 02, 2009 at 08:30:43PM -0800, Junio C Hamano wrote:
> Jeremy O'Brien <obrien654j@gmail.com> writes:
> 
> > On Mon, Feb 02, 2009 at 09:54:31AM -0800, Junio C Hamano wrote:
> >> Jeremy O'Brien <obrien654j@gmail.com> writes:
> >> 
> >> > I am running git version 1.6.1.2.309.g2ea3.
> >> >
> >> > When I use
> >> >
> >> > git grep -I "string_to_match"
> >> >
> >> > to ignore binary files in my grep, binary files are returned anyway.
> >> 
> >> One sanity check.  What does 'git grep --cached -I "string_to_match"' do
> >> in that case?
> >> 
> >
> > It works as expected. It is interesting that while my Linux install was
> > affected by this bug, my Mac OS X install did not seem to be affected by
> > it, while running the same version of git.
> 
> Perhaps your Mac OSX binary was built without external grep support.
> 
> Did the patch fix the issue, by the way?

I'm assuming that was the problem. And yes, the patch fixed it just
fine, thank you.
