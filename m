From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC] Secure central repositories by UNIX socket authentication
Date: Mon, 28 Jan 2008 11:14:27 +0300
Message-ID: <20080128081427.GP26664@dpotapov.dyndns.org>
References: <20080127103934.GA2735@spearce.org> <alpine.LSU.1.00.0801271402330.23907@racer.site> <20080127173212.GW24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 09:15:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJP8w-0004qe-ND
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 09:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbYA1IOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 03:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbYA1IOc
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 03:14:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:30160 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbYA1IOb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 03:14:31 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1621781fga.17
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 00:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=nTvw5pgcu+swtHcz2eGMJ+WOsRZJ+0kz+IEPS1tRVnk=;
        b=ZEYpkl4ypLN8LKERDBJ2Tw73E41wO7o+JVXYJTztweLHbl+OhTn9vGSOwG6JCEtU15PYtvtdt4h1r6kIMqJYFkhyb1CHXcK/h7Rk2EpuKOWc09/3fkWlG/9KHdLYKAKBqGiT1V3Zwv2d04SYCgp2aq70f5AcyBl9nETec3rIQgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Kk7DLqk3DJ2TS5CIirwUAzT7ooy6hj7I4SEA8Jd+n6M5xlX0mVqObMx/qLLRYfbvy0H6QbHhSZhjPLuxfAq1vwyJFi0lNmks1UYb8PAmpD9651xgNasIeZtcvYIuTHss16/IDL6qW75NhIENecXo3RRsVq87lU8keb0jyl8uqrY=
Received: by 10.86.62.3 with SMTP id k3mr4962776fga.24.1201508070782;
        Mon, 28 Jan 2008 00:14:30 -0800 (PST)
Received: from localhost ( [85.141.188.213])
        by mx.google.com with ESMTPS id e20sm7767134fga.1.2008.01.28.00.14.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Jan 2008 00:14:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080127173212.GW24004@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71862>

On Sun, Jan 27, 2008 at 12:32:13PM -0500, Shawn O. Pearce wrote:
> 
> So you come down to four options:

<snip>

How about gitosis? It requires only one extra user (usually called git),
which is the owner of all repos. This user has git-shell as its login
shell. All users are authorized by their ssh keys. The configuration and
kyes are stored in the special repo called gitosis-admin. You can define
what users to what repositories have read or write access. This is done
by adding a user to one or more groups defined in gitosis configuration.
You can have as much groups as you want. The default configuration looks
like this:

[group gitosis-admin]
writable = gitosis-admin
members = your-name

It defines the gitosis-admin group, member of which can write to the
gitosis-admin repo, and you are member of that group.

WRRNING: I have not used gitosis myself, but it looks worthy of a try.

Dmitry
