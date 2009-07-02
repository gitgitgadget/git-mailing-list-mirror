From: Jeff King <peff@peff.net>
Subject: Re: Bug report: .gitattributes: -diff Unset causes files to be
	reported as binaries
Date: Thu, 2 Jul 2009 13:05:08 -0400
Message-ID: <20090702170508.GB15802@sigio.peff.net>
References: <200907011208.35397.fenglich@fastmail.fm> <20090702053534.GA13255@sigio.peff.net> <200907021014.06540.fenglich@fastmail.fm> <4A4C961C.6090503@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frans Englich <fenglich@fastmail.fm>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 02 19:03:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMPh5-0002Ij-6g
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 19:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbZGBRDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 13:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbZGBRDN
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 13:03:13 -0400
Received: from peff.net ([208.65.91.99]:45158 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735AbZGBRDM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 13:03:12 -0400
Received: (qmail 15821 invoked by uid 1000); 2 Jul 2009 17:05:08 -0000
Content-Disposition: inline
In-Reply-To: <4A4C961C.6090503@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122655>

On Thu, Jul 02, 2009 at 01:12:28PM +0200, Paolo Bonzini wrote:

> >To exclude it in diffs, such as from `git show`. Take the case where you have
> >a grammar file for a parser and generate a source file from it(or any similar
> >scenario); the diff for the generated source file is not of interest and is
> >just noisy when read as part of a patch. This applies to all kinds of
> >generated files. However, this doesn't mean that the file should be treated
> >as a binary, and what practicalities that implies.
> 
> I am not sure it is a good idea, but you can do this with
> 
> FILE diff=/bin/true

This is a good idea Paolo (and I stole it when responding elsewhere in
the thread ;) ), but it should actually be:

  FILE diff=invisible

and then putting

   [diff "invisible"]
     command = /bin/true

in your config.

-Peff
