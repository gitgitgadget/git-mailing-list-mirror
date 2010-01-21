From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: problem cloning via http since v1.6.6-rc0
Date: Thu, 21 Jan 2010 14:47:37 +0800
Message-ID: <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com>
References: <20100121004756.GA18213@onerussian.com>
	 <20100121050850.GA18896@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Yaroslav Halchenko <debian@onerussian.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Jan 21 07:48:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXqpz-0007zv-MK
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 07:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab0AUGri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 01:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752529Ab0AUGri
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 01:47:38 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:60911 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab0AUGri (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 01:47:38 -0500
Received: by iwn34 with SMTP id 34so4394121iwn.21
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 22:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=5NlBInV6NvanogrcwV6Jc6QIRIop8WLPHCgBXaL6G5k=;
        b=r4ckWc3idfOJGxiUDUfo3ZNDuLCH5TMlMFlBq1Vp3UB5CcKQvcBUXilrGVrYY3O9b6
         e/9jNhdJHxFSWgi7G8LuaJ4tAwvqvTk1YtgxIdtHfQ0fwVf24oWrYhqZ64OFkUsb87dj
         RMPdImlBBG6p2YKJKnnDlMP754BbD54A2b8qM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mbWua8nyg2txFSAk7wRu0UdLBvu+mScOEVH+OqJfQiF1wBQodFQt9iGs2B0VA/A/Wp
         h1iO+dpLt4UqnOyrd0X1Cl9+nLXPfHqxumwOLeMeAFz62lMXusa7MkUTp0FMcauOgkPJ
         a3XVDBUcP65Lwj5s0AsSx4AHhecGPEq5OGMB4=
Received: by 10.231.147.21 with SMTP id j21mr1625722ibv.80.1264056457211; Wed, 
	20 Jan 2010 22:47:37 -0800 (PST)
In-Reply-To: <20100121050850.GA18896@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137632>

Hi,

On Thu, Jan 21, 2010 at 1:08 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> Looks like remote-curl (which handles http) issues request for:
>
> '.../info/refs?service=git-upload-pack'
>
> And expects that if there is no smart HTTP server there for the request to be
> interpretted as:
>
> '.../info/refs'
>
> (i.e. webserver would ignore the query). This isn't true for git.debian.org.
> Requesting the latter works (and the data formatting looks sane), but the
> former is 404. This causes the fetch to fail.

afaik, putting a "?var1=val1&var2=...." still makes it a normal GET
request, even if the url requested is just a plain file and not some
cgi handler that uses those variables/values.

--
Cheers,
Ray Chuan
