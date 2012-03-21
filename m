From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Wed, 21 Mar 2012 18:59:26 +0100
Message-ID: <201203211859.26923.jnareb@gmail.com>
References: <loom.20120318T083216-96@post.gmane.org> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Ivan Todoroski <grnch_lists@gmx.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 18:59:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAPou-0002iC-NR
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 18:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759056Ab2CUR7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 13:59:31 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:55427 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756451Ab2CUR73 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 13:59:29 -0400
Received: by wibhj6 with SMTP id hj6so6847174wib.1
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=jwzNY0cF86iga5P4WyjNKcl0QWumcIeix4RRgJi+ls4=;
        b=liwYvh6sGfqmJQVqFw+SSc7inIio3aJVqJR6DUk7I1myc52EFbPSZwTtp9+MWZ7vUa
         jPMpYu374HfEMBEuVG6RSzl2gVE7I1E+7SMarorUuDswUUoGf9Uc4umTQUnFHAkbqUd1
         CoSQjt5ORRLiKCstECNPX3fU4Gsm4R9LjPhMRJkdbrVZITKtPhnBKnCf853c1qJ9FNyT
         DfyH1qnk1pnsxNKVdxocl63UvS8dMU6gI6pk3Bjc0tRCmQYu4umCmZYv6crHxSxnyvYx
         YO6ZHOGmn/lmXJF0JDHGv9DQb+4dzfzD8PFjC75hXSPX1uEvqPwP/pIXrbiI8CPdZkdp
         byTA==
Received: by 10.216.144.138 with SMTP id n10mr2827607wej.56.1332352768149;
        Wed, 21 Mar 2012 10:59:28 -0700 (PDT)
Received: from [192.168.1.13] (abvy85.neoplus.adsl.tpnet.pl. [83.8.222.85])
        by mx.google.com with ESMTPS id l5sm6196325wia.11.2012.03.21.10.59.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 10:59:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120321171423.GA13140@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193593>

Jeff King wrote:
> On Wed, Mar 21, 2012 at 07:28:24AM -0700, Shawn O. Pearce wrote:
> 
> > > Would it be OK for fetch-pack.c to use the packetized format (pkt-line.h)
> > > for reading the list of refs from stdin?
> > 
> > This is probably the easiest way to implement the sneak-into-stdin
> > patch. Use a pkt-line for each argument that should have been in the
> > argv array from the command line, and a flush pkt to terminate the
> > list.
> 
> Something in me feels slightly uncomfortable with that, just because
> simple newline-delimited formats make it easy for people to hack on the
> tool and feed input from unexpected sources.

Well, give people "pkt-line" command line tool which would transform
ordinary textual output on input into pkt-line (which is almost pure
text anyway) output and vice versa.

> But stateless-rpc is already a pretty deep internal interface anyway,
> and the format is already weird (the second half is already packetized
> input from a remote anyway). So it's probably not worth caring about
> hackability here.

Right.

-- 
Jakub Narebski
Poland
