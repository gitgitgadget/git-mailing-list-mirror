From: Frans Englich <fenglich@fastmail.fm>
Subject: Re: Bug report: .gitattributes: -diff Unset causes files to be reported as binaries
Date: Thu, 2 Jul 2009 13:29:04 +0200
Message-ID: <200907021329.04258.fenglich@fastmail.fm>
References: <200907011208.35397.fenglich@fastmail.fm> <200907021014.06540.fenglich@fastmail.fm> <4A4C961C.6090503@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 02 13:26:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMKQw-0004VT-Bl
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 13:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbZGBLZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 07:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbZGBLZq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 07:25:46 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:47094 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752234AbZGBLZq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 07:25:46 -0400
X-Greylist: delayed 11698 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jul 2009 07:25:46 EDT
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 5A056389A63;
	Thu,  2 Jul 2009 07:25:49 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 02 Jul 2009 07:25:50 -0400
X-Sasl-enc: X57O27vCE6l6XAu97YHoNyn/Ca6OmYQ0WY3MEjrz3t/K 1246533944
Received: from localhost (unknown [62.70.27.104])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9CC0D1E5E;
	Thu,  2 Jul 2009 07:25:44 -0400 (EDT)
User-Agent: KMail/1.9.10
In-Reply-To: <4A4C961C.6090503@gnu.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122634>

On Thursday 02 July 2009 13:12:28 Paolo Bonzini wrote:
> >> So as far as I can see, git is behaving exactly as it is supposed to.
> >> Maybe you can be more specific about what effect you were trying to
> >> achieve by setting gitattributes in the first place?
> >
> > To exclude it in diffs, such as from `git show`. Take the case where you
> > have a grammar file for a parser and generate a source file from it(or
> > any similar scenario); the diff for the generated source file is not of
> > interest and is just noisy when read as part of a patch. This applies to
> > all kinds of generated files. However, this doesn't mean that the file
> > should be treated as a binary, and what practicalities that implies.
>
> I am not sure it is a good idea, but you can do this with
>
> FILE diff=/bin/true
>
> > If -diff affects whether a file is treated as a binary, as opposed
> > whether it's diff'ed, it would imo make sense to call it -binary.
>
> No, diff affects how a file is diffed.  The particular setting "-diff"
> diffs the file as if it was binary.

Aha, then we're maybe at conclusion; if -diff doesn't cause the files to be 
treated as binaries, then the phrase "Binary files a/file.txt and b/file.txt 
differ" is wrong, it shouldn't read "Binary files", but maybe rather "The 
files".


Cheers,

		Frans
