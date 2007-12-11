From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: backups with git and inotify
Date: Tue, 11 Dec 2007 13:24:16 +0000
Message-ID: <e1dab3980712110524k59437f15pd38f74f55d692a69@mail.gmail.com>
References: <20071210202911.GA14738@bit.office.eurotux.com>
	 <20071210215746.GA3022@atjola.homenet>
	 <20071211102546.GA5811@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: "Luciano Rocha" <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 14:25:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J256G-0004Zy-5O
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 14:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbXLKNYS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 08:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbXLKNYS
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 08:24:18 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:8760 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbXLKNYR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 08:24:17 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1683767wra
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 05:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Y+IM+A7HbLxlUgjCri/x2Z4/x8AiElnTflaqNggK9D4=;
        b=Cz4XAe+eW9ctgZZwqkUl9k3YJby9XqYCmGDIrZlOLLQARGzIcfEqDRz7+SRsAgxmFox91WXjRh4e4km3obPTnWg3NODR6KRarMXES9fVhmfArkvjnesbKjDOZ70aukMixPYV8tldkPlyZr8KDBVj4pz5YYkArqXmYCJDdpy9Uak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NPXsXZBf8LrmPfa2YjVq87F6vwEsgJ35h9FsZjj7V0GB1H8pSoX1MoW+kl4DAM+gmR1LLxKIYHLZsY1tk+g0/Up5H8CMWvAcM6ALOtIqWuLRHxoZlJT8e6N+tgiAqq0mapsSr6r4FareMRyS8YY5hYEokLbL0FkHoX5qgbZciss=
Received: by 10.150.123.16 with SMTP id v16mr2685200ybc.1197379456417;
        Tue, 11 Dec 2007 05:24:16 -0800 (PST)
Received: by 10.150.53.15 with HTTP; Tue, 11 Dec 2007 05:24:16 -0800 (PST)
In-Reply-To: <20071211102546.GA5811@bit.office.eurotux.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67851>

On Dec 11, 2007 10:25 AM, Luciano Rocha <luciano@eurotux.com> wrote:
> On Mon, Dec 10, 2007 at 10:57:46PM +0100, Bj=F6rn Steinbrink wrote:
> > On 2007.12.10 20:29:11 +0000, Luciano Rocha wrote:
> FWIW, I also think that trying to keep a coherent stat with automatic
> commits isn't possible. As for the temporary, unneeded files, a
> exclusion pattern will suffice, and using .git directly, instead of a
> (FUSE) filesystem, will allow permanent storage of those temporary
> files, until explicitly removed.

As a data point, I find it easier for my work to have rules that
specify the files you DO want to keep. (I actually have a set of
common suffixes to ignore that's checked first but purely for
efficiency: it's quicker to throw out the usual suspects like *~, *.o,
*.pyc, etc, immediately rather than fail to match all the more
complicated "keep this" rules every single time.) One advantage of
this is that if I do something stupid like drop a 2G video file into
the tracked tree it's doesn't get sucked in to the git repo.

--=20
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
