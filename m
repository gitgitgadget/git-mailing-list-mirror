From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC/PATCH 0/3] fast-import: give importers access to the
 object store
Date: Thu, 16 Sep 2010 12:14:08 +1200
Message-ID: <1284596048.3298.3.camel@wilber>
References: <20100701031819.GA12524@burratino>
	 <20100701054849.GA14972@burratino> <20100817170216.GA14491@kytes>
	 <20100905031528.GA2344@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 02:09:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow22z-0003gT-RI
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 02:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448Ab0IPAJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 20:09:36 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:55515 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294Ab0IPAJg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 20:09:36 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id AA30E21C3AF; Thu, 16 Sep 2010 12:09:34 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 5442621C322;
	Thu, 16 Sep 2010 12:09:30 +1200 (NZST)
In-Reply-To: <20100905031528.GA2344@burratino>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156280>

On Sat, 2010-09-04 at 22:15 -0500, Jonathan Nieder wrote:
> It works like this:
> 
> frontend:
> 	feature report-fd=3
> 	commit refs/heads/master
> 	... revision 1 ...
> 
> importer:
> 	abc7856cba76bca87a65bca76bca8bca98bca78bca76

This is probably quite a late comment, but I don't think that
'report-fd=3' is a good idea in a protocol like this.  It should not
take an argument and just respond down the appropriate selected file
descriptor.  ie, default to standard output.  If standard input is a
socket, then use that bidirectionally.  If --report-fd is used on the
command line, use that.

Sam
