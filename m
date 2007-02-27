From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC/PATCH] commit-tree: bump MAX_PARENTS to 128
Date: Tue, 27 Feb 2007 11:31:52 +0000
Message-ID: <200702271131.57856.andyparkins@gmail.com>
References: <20070226121557.GA18114@coredump.intra.peff.net> <7virdnhpbt.fsf@assigned-by-dhcp.cox.net> <20070227105212.GA21757@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 12:33:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM0Zq-0006bc-Kb
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 12:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933013AbXB0LcS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 06:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933051AbXB0LcS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 06:32:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:64801 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933013AbXB0LcD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 06:32:03 -0500
Received: by nf-out-0910.google.com with SMTP id o25so149015nfa
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 03:32:03 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rCfw/H+Zbx3vCEOQTRI0XoBjNADWCvoTmOTqitl//ILGDYt4FKr1TZxbIVVnGfZghE/WexOZp0cMr2TKYC3FOaM62XAzzQ2DTOEuzhBHvJ/cEbboFtgR2OLc9a43hCMQHmezQOAnwHbZbObUhsYFdBgzsCRhQLaN1OmZdiolkNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tdVOEajIQQ7tWr4v1yovUGBFbus3mCv1rjK9c0dgzCoIFVEsO86bRq77PngkKiAZLKTfVoDAeeGl3b/AYrOhM/DX4+sIqmuMzDDIBLJEXQt5tyuyAeZKvB+0kWN8yB+FQtUfaGMh36+doFUG37GL4lFjAeeo4rgFeqhhOOgwFSs=
Received: by 10.49.19.18 with SMTP id w18mr929842nfi.1172575922975;
        Tue, 27 Feb 2007 03:32:02 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id q28sm1548517nfc.2007.02.27.03.32.00;
        Tue, 27 Feb 2007 03:32:00 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <20070227105212.GA21757@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40711>

On Tuesday 2007 February 27 10:52, Jeff King wrote:

> A year or so ago, I started using git, and imported all of my CVS repos
> to git. I did each class directory separately, reasoning that each
> represented a separate history. This can end up being unwieldy, because
> there are dozens of repositories; I would now like to group them in the
> same repo for ease of clone/fetch.

It doesn't have fetch or clone support, but perhaps my poorman's submodule 
code will help you a bit, until real submodule support appears in git.

http://marc2.theaimsgroup.com/?l=git&m=116662031219222&w=2

I've found it useful for myself, and with a little bit of massaging I don't 
think it would be hard to put fetch support in.  I think it just needs a way 
of telling the remote end to switch GIT_DIR to a different directory.

"Merges" are handled by simply sorting out any conflicts in the module file 
(basically you pick one of the submodule commits) just as you would with any 
other file.

As I say - not fabulous, but gets me by.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
