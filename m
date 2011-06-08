From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4 2/4] Add infrastructure for ref namespaces
Date: Wed, 8 Jun 2011 11:41:25 +0200
Message-ID: <201106081141.26994.jnareb@gmail.com>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net> <m3sjrrwbyp.fsf@localhost.localdomain> <20110603210156.GA1806@leaf>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 11:41:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUFGi-0005or-EE
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 11:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab1FHJlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 05:41:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58095 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab1FHJlj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 05:41:39 -0400
Received: by bwz15 with SMTP id 15so261809bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 02:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=dth92bapH9ZOtTLFhdciLNcPlKbKTuoG/eoqb6/hOyE=;
        b=mKbs6284CerU8RBNuRToBWRUygpaBOwoFadxbsciB8zy2nErRw24MNCjpErTDLRU/U
         Cc2CWfQzgzug+D4esDNuTXSlPojI4A89cN5lP+7zgJY4WovkS+Itu2IrwttaOnlOWc5c
         3L53DdDPl3BKdlq95p15yYnEAu4nYdlHFLGhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BDSvf7T/a5OQkcTsADyTjagU7tB6MK7UwN7D6VmmmrFQRmHWDaxvhwA1fcp0VCiT++
         PFIAXvMfqQYs1h2/UJKqS6lgVwQLPNU+57XCUjEmSHNFk+OXCFGRXxtMa3Ut+6BXBUJb
         iPPrDN94lM45GFhhemZ+oJoS+MnMl9F52TtUA=
Received: by 10.204.153.20 with SMTP id i20mr585556bkw.208.1307526097499;
        Wed, 08 Jun 2011 02:41:37 -0700 (PDT)
Received: from [192.168.1.15] (abvu41.neoplus.adsl.tpnet.pl [83.8.218.41])
        by mx.google.com with ESMTPS id g2sm376067bkz.11.2011.06.08.02.41.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 02:41:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110603210156.GA1806@leaf>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175346>

On Fri, 3 June 2011, Josh Triplett wrote:
> On Fri, Jun 03, 2011 at 01:35:34AM -0700, Jakub Narebski wrote:
> > Jamey Sharp <jamey@minilop.net> writes:
> > 
> > > From: Josh Triplett <josh@joshtriplett.org>
> > > 
> > > Add support for dividing the refs of a single repository into multiple
> > > namespaces, each of which can have its own branches, tags, and HEAD.
> > > Git can expose each namespace as an independent repository to pull from
> > > and push to, while sharing the object store, and exposing all the refs
> > > to operations such as git-gc.
> > [...]
> > 
> > By the way, after this feature is merged in, would you like for gitweb
> > to understand ref namespaces and offer browsing of separate namespaces
> > (sub-repositories)?
> 
> Yes, definitely!  We'd love to see gitweb handling namespaces
> transparently, and presenting them identically to top-level
> repositories.  (Also, gitweb would need to present the appropriate
> repository URIs for cloning.)

Note that for gitweb support we would need some easy way to list all
namespaces that given repository provides.  But that is for the future.

BTW. what do you think about treating repository with own refs and with
namespaces similarly to how "forks" are handled in gitweb now?
-- 
Jakub Narebski
Poland
