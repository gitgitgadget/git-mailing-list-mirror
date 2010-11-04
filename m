From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH v8 1/5] Introduce bulk-move detection in diffcore.
Date: Thu, 4 Nov 2010 22:56:25 +0100
Message-ID: <20101104215625.GB3167@home.lan>
References: <1288303712-14662-1-git-send-email-ydirson@altern.org>
 <1288303712-14662-2-git-send-email-ydirson@altern.org>
 <20101029014540.GB28984@burratino>
 <20101029211852.GB5695@home.lan>
 <20101030002600.GC21410@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@free.fr>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 22:56:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE7nT-0004Xv-Ad
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 22:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab0KDV4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 17:56:35 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:39777 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340Ab0KDV4e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 17:56:34 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 28C9FD48072;
	Thu,  4 Nov 2010 22:56:26 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PE7nG-0002O9-02; Thu, 04 Nov 2010 22:56:26 +0100
Content-Disposition: inline
In-Reply-To: <20101030002600.GC21410@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160780>

On Fri, Oct 29, 2010 at 07:26:00PM -0500, Jonathan Nieder wrote:
> Yann Dirson wrote:
> 
> > Hm, I fear too much granularity would become meaningless :)
> [...]
> >                 If the code needs to be easier to understand, I'd
> > rather add some more doc, than added commits that are basically
> > "useless for bisect".
> 
> Yes, the example list was probably a little overboard.  Even so, the
> idea was to maintain bisectability by introducing a few tests at a
> time.  That way, the fallout of a subfeature can easily be found with
> "git bisect", among other benefits[1].

I like the idea when successive commits get new functionality, but we
have to avoid introducing known-broken functionality and fixing them
in later patches - and I fear the list as you described it was going
that latter way.

> >> Is the debugging output infrequent enough to just use a function
> >> unconditionally?
> >
> > You mean, keep funccalls even with DEBUG_BULKMOVE is not set ?  No,
> > there are too many traces for that.
> 
> Yep, that's what I meant.  Alas.

Well, thinking twice, calls to empty function would be optimized out,
so yes, we don't need cpp magic at all.

-- 
Yann
