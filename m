From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: suggestions for gitweb
Date: Sun, 13 May 2007 18:52:16 +0200
Message-ID: <8c5c35580705130952r7c0e353dr9cf20aed61bdd463@mail.gmail.com>
References: <20070512205529.GS14859@MichaelsNB>
	 <7v8xbtwtsy.fsf@assigned-by-dhcp.cox.net>
	 <1f3701c794eb$5ff781b0$0200a8c0@AMD2500> <f25mic$1b1$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Michael Niedermayer" <michaelni@gmx.at>,
	"Aaron Gray" <angray@beeb.net>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 13 18:52:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnHJ2-0000t3-Bk
	for gcvg-git@gmane.org; Sun, 13 May 2007 18:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759297AbXEMQwT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 12:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759301AbXEMQwS
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 12:52:18 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:62991 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759297AbXEMQwR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 12:52:17 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1569555nzf
        for <git@vger.kernel.org>; Sun, 13 May 2007 09:52:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lO5w5XS0fXP+1D5Eu6a5zOrgdmNVOtEh483USXFc+GrdbpkgQ/cP93hE67Mq5oFe298GUKsN5T35UX6Jg7j0ehEPKnOOywtx+fyCi9DIbX2SQgqAh952HhghYii3V5NTt1WmmR6ZH4ye7jYIhutxmJ7RtEIcCXVSwddfyOvVJHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rQ0Vquy7p5XrVIKn96Tys7EoFDPSySxBISK8jvCfvbzT8QwWi7WpjxahQ0V3mZF9pwH91zVs5FN5FfqzRIbTvL9CQupEB1JhvAj1ewfCjtW108DcU9K9lFeTXa0MPZHzk8eXRX8MJ42o1RvdhA8ItBxJVjVhXk9GZWpLUJDFn/4=
Received: by 10.114.178.1 with SMTP id a1mr645387waf.1179075136156;
        Sun, 13 May 2007 09:52:16 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sun, 13 May 2007 09:52:16 -0700 (PDT)
In-Reply-To: <f25mic$1b1$2@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47150>

On 5/13/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Aaron Gray wrote:
>
> >>> * the history/log pages could contain some statistics for the commits
> >>>   like the number of files changed and lines added/removed
> >>
> >> Probably.
> >>
> >> The three last items should be relatively easy, if somebody is
> >> interested.  Pasky, Jakub, what do you think?
> >
> > I would like to see lines of code and file sizes too.
>
> Diff statistics for difftree / whatchanged, or diff shortstat is a bit
> costly, as it needs to generate and examine diff, and not only compare
> trees. Besides --numstat doesn't support renames well now, but that
> might not be an obstacle.
>
> Lines of code and file sizes: file size needs additional invocation
> per each file for gitweb; it would be easier for cgit. Costly! Counting
> LOC is even more costly

I've implemented number of files/lines changed in cgit's log view and
pushed it to http://hjemli.net/git/

It does consume some cpu (especially on the linux-2.6 repo), but it's
not terribly bad (and the caching helps out). But I felt like changing
the number of commits per page to 50, so I added a knob for this in
the config file while at it.

I'll try to get a proper diffstat on the commit page + file history
via tree view next (filesize has always been part of cgits tree view
btw).

--
larsh
