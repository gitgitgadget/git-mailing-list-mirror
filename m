From: Mike Hommey <mh@glandium.org>
Subject: Re: [RFC] git rebase -s ours
Date: Mon, 3 Mar 2008 07:55:21 +0100
Organization: glandium.org
Message-ID: <20080303065521.GA18152@glandium.org>
References: <20080301111716.GA3263@glandium.org> <20080302010527.GB22843@coredump.intra.peff.net> <20080302124848.GB8696@glandium.org> <20080303054126.GB24210@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 07:52:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW4Wv-0004Il-7R
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 07:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbYCCGvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 01:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbYCCGvc
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 01:51:32 -0500
Received: from vuizook.err.no ([194.24.252.247]:47019 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231AbYCCGvc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 01:51:32 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JW4W9-0007Qm-Js; Mon, 03 Mar 2008 07:51:27 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JW4a1-0004oR-Fl; Mon, 03 Mar 2008 07:55:21 +0100
Content-Disposition: inline
In-Reply-To: <20080303054126.GB24210@coredump.intra.peff.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75890>

On Mon, Mar 03, 2008 at 12:41:26AM -0500, Jeff King wrote:
> On Sun, Mar 02, 2008 at 01:48:48PM +0100, Mike Hommey wrote:
> 
> > I don't have a workflow in mind, but I have expectations: considering
> > the documentation, I would expect git rebase -s ours to do what git
> > filter-branch can do with grafts.
> 
> I'm not sure I follow. Can you elaborate?

Starting with a history like this:

                      G---H 
                     /
        A---B---C---D---E---F

Where A, B, C, ... are *trees*, not commits, the expected result would
be

        A---B---C---D---E---F---G---H

This is what might happen with git-filter-branch if you graft G to F. (I
don't know if it actually works in cases where the grafted commit had a
parent, originally)

Mike
