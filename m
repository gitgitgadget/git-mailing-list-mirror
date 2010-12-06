From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git diff --summary only seems to work when combined with --stat
Date: Mon, 6 Dec 2010 15:03:04 -0600
Message-ID: <20101206210304.GA9735@burratino>
References: <AANLkTimCAy8kcQaKNaxz4UJp2ZB=_HeRMmeaQ5ZHNV4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 22:03:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPiDP-0005Bt-RB
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 22:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab0LFVDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 16:03:15 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45208 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab0LFVDO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 16:03:14 -0500
Received: by wyb28 with SMTP id 28so12465438wyb.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 13:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fH5C/sFxVFJvi7z+mwQ9cVYm9BypC7olXlPH6BL9xUk=;
        b=aLewnVtKUa4eOUHqFg37QpYOaBwHHma9XhNrb9WkVJKiSbb7XHZmFIghLFIUfK43LK
         DQBuGNvD0p0Vt4Y9X8e1bFkeGoPT8phO3afgpskAecxkHwCmjYvyO+Xmj1PH8PPBS3DF
         nCwDhzLk/vdLm+qzQJhqo9+3iws6DMM5+MvIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bhgbi4F/pRWiI+/DGqWSRraQDcyOKnOziRVBu0t7RTO7XBwSPBtAblpY/JTKVK5b3t
         BuVo68BS3fXbtKIW8xiSO1QN62CE+58HmpPO2dvkhKDzIByyFLRBES1AvZDpguAmkMSQ
         yc+2Uxw3Y4TRhYKhsMXmGHpx42Epbtw4IQGss=
Received: by 10.216.30.65 with SMTP id j43mr5577701wea.20.1291669392833;
        Mon, 06 Dec 2010 13:03:12 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id e12sm2578527wer.36.2010.12.06.13.03.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 13:03:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimCAy8kcQaKNaxz4UJp2ZB=_HeRMmeaQ5ZHNV4g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163022>

Hi Yves,

demerphq wrote:

> It seems like the --summary option only works in combination --stat.
> 
> It doesn't seem to work if I use it by itself, nor in combination with
> --name-status or --num-stat. And depending on the order, it either
> does nothing, or causes a usage note.

It is tricky, but as you noticed --summary is not actually about the
diffstat.  --summary affects the output summarizing new files and
renamed files.

Example:

	$ git diff --summary v1.7.2..v1.7.3
	delete mode 100644 Documentation/RelNotes-1.5.0.1.txt
	delete mode 100644 Documentation/RelNotes-1.5.0.2.txt
	[...]

> $ git diff --name-status --sumary HEAD^
> usage: git diff <options> <rev>{0,2} -- <path>*

There is an 'm' missing here. :)

Hope that helps,
Jonathan
