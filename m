From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/2] allow mangling short options which take integer
	arguments
Date: Fri, 2 Oct 2009 10:26:33 +0200
Message-ID: <20091002082633.GA21168@localhost>
References: <20090925233226.GC14660@spearce.org> <20091001201648.GA12175@localhost> <20091001202301.GB12175@localhost> <alpine.DEB.1.00.0910012354080.4985@pacific.mpi-cbg.de> <20091002074317.GB9444@localhost> <20091002075012.GB27664@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 02 10:26:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtdTN-0008En-Gz
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 10:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516AbZJBI0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 04:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754416AbZJBI0c
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 04:26:32 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:38446 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290AbZJBI0a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 04:26:30 -0400
Received: by bwz6 with SMTP id 6so784340bwz.37
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=wDlRRbBokvdYQTrvfILWQsf/RZBKl+osNuLo2kqdh3U=;
        b=qe/gLAevzaqt0+wfwKlSLoBWQTW0QYkhnHUJW4+/7i0BujXRGqy4jYwiqPoOKB9yiI
         RVRM2eqFgyyPybEeCZ41v+W21gls87gUIHo6XS8WTvORRlECWZ8GnhWEL+G6cs55srwe
         OQpAc6rK7qtwTa9VBIcgzwPoh5KEZNYGw1mbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=ewbIEFpY6qr1KmuZbaKq7Z9rjU5WTa1sxtk0V5a77gRDycyttsiVaK4g6C9Xew0Wsz
         QxRJpEo1URpkg54FPGEo80neJKhCyedTcWGu+/uwgFAVXp2pUBxwAQTHlnWrlOyKAR9f
         nqx5f08k5PVldehX2TrGIe24aaci5YUqj7bYM=
Received: by 10.204.15.24 with SMTP id i24mr935096bka.2.1254471992282;
        Fri, 02 Oct 2009 01:26:32 -0700 (PDT)
Received: from darc.lan (p549A5168.dip.t-dialin.net [84.154.81.104])
        by mx.google.com with ESMTPS id 25sm1198586bwz.106.2009.10.02.01.26.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 01:26:31 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MtdTF-0005ca-S6; Fri, 02 Oct 2009 10:26:33 +0200
Content-Disposition: inline
In-Reply-To: <20091002075012.GB27664@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129431>

On Fri, Oct 02, 2009 at 03:50:12AM -0400, Jeff King wrote:
> On Fri, Oct 02, 2009 at 09:43:17AM +0200, Clemens Buchacher wrote:
> 
> > On Thu, Oct 01, 2009 at 11:55:03PM +0200, Johannes Schindelin wrote:
> > 
> > > And this patch looks even more straight-forward than 1/2, _but_... what 
> > > about cases where there are short options that are digits?
> > 
> > Could you point me to one of those? I did not find any during my
> > non-exhaustive search. We should be able to handle them easily by adding
> > PARSE_OPT_MANY.
> 
> The one that comes readily to mind is "git log -1", but that is actually
> parsed by the revision options parser, which doesn't use parseopt. But
> there are a few done by parseopt:

Oh, I mistakenly thought Dscho was asking about options with single-digit
arguments. Thanks for clearing this up.

Clemens
