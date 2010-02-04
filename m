From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] make --max-pack-size argument to 'git pack-object'
	count in bytes
Date: Thu, 4 Feb 2010 09:59:18 -0800
Message-ID: <20100204175918.GB18548@spearce.org>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net> <1265255308-20514-3-git-send-email-nico@fluxnic.net> <20100204040046.GR14799@spearce.org> <7v7hqtty38.fsf@alter.siamese.dyndns.org> <7vtytxexjl.fsf@alter.siamese.dyndns.org> <20100204172421.GA18548@spearce.org> <alpine.LFD.2.00.1002041249200.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 18:59:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd5zK-0005eA-QU
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 18:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506Ab0BDR7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 12:59:24 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:53181 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756421Ab0BDR7W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 12:59:22 -0500
Received: by iwn39 with SMTP id 39so3234637iwn.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 09:59:21 -0800 (PST)
Received: by 10.231.60.17 with SMTP id n17mr167672ibh.24.1265306361110;
        Thu, 04 Feb 2010 09:59:21 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm269023iwn.11.2010.02.04.09.59.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 09:59:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002041249200.1681@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138992>

Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 4 Feb 2010, Shawn O. Pearce wrote:
> 
> > How about for a transition period we do:
> > 
> >   if (v < 8192) {
> >   	warning("max-pack-size is now in bytes, assuming %dm", v);
> > 	v *= 1024 * 1024;
> >   }
> > 
> > So that existing users won't be completely broken if they are
> > relying on this flag, and have some time to adjust.
> 
> For 'git fast-import' which is not meant to be directly user operated 
> this makes sense.  I don't think this is a good idea for 'git repack' 
> though.  In the later case it is best if the user simply adjust right 
> away.
> 
> Also the warning text above could be less ambigous. Something like:
> 
> 	"max-pack-size is now in bytes, assuming --max-pack-size=%dm"

ACK on the fixed warning text.  I lacked enough coffee at the time
to write intelligent text.

-- 
Shawn.
