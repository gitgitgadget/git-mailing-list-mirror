From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [RFC PATCH v4 11/26] Move WebDAV HTTP push under remote-curl
Date: Fri, 30 Oct 2009 20:06:55 +0100
Message-ID: <20091030190655.GA7442@localhost>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-12-git-send-email-spearce@spearce.org> <be6fef0d0910300910me43c77fue6dcb6034dd0ea5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:07:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3wp3-000717-Rw
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 20:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757353AbZJ3TH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 15:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757351AbZJ3TH3
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 15:07:29 -0400
Received: from mail-ew0-f228.google.com ([209.85.219.228]:43148 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349AbZJ3TH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 15:07:28 -0400
Received: by ewy28 with SMTP id 28so3334828ewy.18
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=JMW51qZ+7m3x7tqjF+zbvoCZ20my1m1VHnitBfGpwUI=;
        b=b4ltzPW63/d316J1aIr28WabRPECEBWuGwbAnpYCWdTWKwPLDIUrDnTxEP9TMa5O+l
         jQEd20Uyt1xUr60e0oMxIXm752lvXbpCw/UmUgqqmJscsDkYHmSvlByd9NbLfWA8mNwT
         w+S8JQjpxwiHtj5d8IKRrQa89jX2xPEYkg6IY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=MAfa3WPNB8I7PxezGUl7uh8u/B37MhF88al//jNwx0BiEgnNQ+MBWvm9j0JFL7Usu5
         VEff6yHSj+MT1F5GB3BmuQeMg8p2SPnqfTzhkNrlVmpEyv5ODgrcRwMXsc/Ygq77V/+P
         qTSaFstrU8gXxu6oogckNcrx+lbTZfYlzw6BE=
Received: by 10.211.154.16 with SMTP id g16mr1287730ebo.19.1256929652388;
        Fri, 30 Oct 2009 12:07:32 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 7sm7964395ewy.6.2009.10.30.12.07.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 12:07:19 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N3woJ-0002MJ-SB; Fri, 30 Oct 2009 20:06:55 +0100
Content-Disposition: inline
In-Reply-To: <be6fef0d0910300910me43c77fue6dcb6034dd0ea5b@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131731>

On Sat, Oct 31, 2009 at 12:10:29AM +0800, Tay Ray Chuan wrote:

> Clemens, the following addresses your non-desire to remove the
> "unpacked refs" test in your earlier email
> <20091025161630.GB8532@localhost>.

> Now that the first push in "push to remote repository with packed
> refs" succeeds, the "unpacked refs" test is redundant.

How can the changed result of one test suddenly make another test redundant?
The two are testing different things.

> Since http-push
> in that first test already updated /refs/heads/master and /info/refs,
> 'git update-ref' incorrectly reverts the earlier push, and 'git
> update-server-info' is redundant.

No, 'git update-ref' correctly reverts the earlier push, so we can push again
and 'git update-server-info' is therefore necessary for the test to work
independently of its predecessors result.

Clemens
