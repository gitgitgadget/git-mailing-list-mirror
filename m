From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: libgit2 status
Date: Mon, 27 Aug 2012 23:40:27 +0200
Message-ID: <20120827214027.GA511@vidovic>
References: <87a9xkqtfg.fsf@waller.obbligato.org>
 <5038A148.4020003@op5.se>
 <7vharpv77n.fsf@alter.siamese.dyndns.org>
 <nnglih0jotj.fsf@transit.us.cray.com>
 <7vfw78s1kd.fsf@alter.siamese.dyndns.org>
 <nngsjb8i30w.fsf@transit.us.cray.com>
 <7v6284qfw8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dag@cray.com, Andreas Ericsson <ae@op5.se>, greened@obbligato.org,
	git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 23:40:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6732-0008IT-8x
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 23:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583Ab2H0Vke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 17:40:34 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60011 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab2H0Vkd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 17:40:33 -0400
Received: by wicr5 with SMTP id r5so4142061wic.1
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nvBy/ulEH/+HRTRNgNWqlw/fnMBGBkDwYP5dl/gKCek=;
        b=mLjQZuIC+fChLRGca/UrA/Fdv/MWW80xmwuE4WEffUCP9eht6hIqmvD6aDgo1U15pP
         HxkkXwfY8Z9BbS6sJtySbjtZGEX7HLhXnLRBBJJKd1olIQW7vcCPyle9t+Xh+y3Ic/O1
         c1jSahzyPsDIsCZZVE6HXqB2gOcNCuMlLs6Zt+ebeAD1t9pN9w0tYUG0IUhWcGB5Zo8F
         7z6RNyinoLqMdLiwCyNj5BqV2dmvaeNy7vbEDmzs2ulk47uXHGQDsXAVfQhR8gneRzSk
         OKQDZQdP+6OHbJh+5Q7aeDLMJMv/LYnqpsMzViXKzfH1NPxGrd4ry2ZF60vMYfZ/MnLj
         O77g==
Received: by 10.216.44.3 with SMTP id m3mr7936726web.129.1346103631831;
        Mon, 27 Aug 2012 14:40:31 -0700 (PDT)
Received: from vidovic (146.132.84.79.rev.sfr.net. [79.84.132.146])
        by mx.google.com with ESMTPS id t7sm1995013wix.6.2012.08.27.14.40.29
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2012 14:40:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v6284qfw8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204374>

The 27/08/12, Junio C Hamano wrote:
> <dag@cray.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >>> I would be happy to be a guinea pig for libgit2 in order to improve it,
> >>> but I don't want to significantly impact git-subtree's move to core.
> >>> I'll have to figure out the right balance there given feedback.
> >>
> >> I expect it will take some time for libgit2 to allow our Makefile to
> >> start saying "LDFLAGS += -libgit2"; it will need to become as stable
> >> and widespread as other libraries we depend on, e.g. -lz and -lcurl.
> >
> > Well that's a chicken-and-egg problem, isn't it.  How will a library
> > become widespread unless something uses it?
> 
> That something will not be the git core itself.  Otherwise we will
> lose a stable reference implementation to catch its bugs.

This is exactly what I'm most afraid about. I tend to think it's a
chicken-and-egg problem, too.

Do you expect one big merge of a very stable libgit2 at some point?
Because, asking others to implement widely used tools on top of libgit2
in order to have it as stable/tested as curl is not going to happen, IMHO.

Otherwise, what about going with this optionnal "LDFLAGS += -libgit2"
ASAP with good disclaimer that it's only intended for development and
testing purpose? Then, git-core could slowly rely on functions of
libgit2, one after the other.


-- 
Nicolas Sebrecht
