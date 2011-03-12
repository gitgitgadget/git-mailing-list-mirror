From: Jonathan Nieder <jrnieder@gmail.com>
Subject: History surgery with fast-import (Re: Summer of Code project ideas
 due this Friday)
Date: Fri, 11 Mar 2011 18:20:17 -0600
Message-ID: <20110312002017.GA16081@elie>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110303185918.GA18503@sigill.intra.peff.net>
 <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>
 <20110303203323.GA21102@sigill.intra.peff.net>
 <20110309174956.GA22683@sigill.intra.peff.net>
 <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net>
 <20110310001017.GA24169@elie>
 <m339mu7u6n.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Elijah Newren <newren@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 01:20:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyCZO-0005IC-GW
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 01:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab1CLAU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 19:20:28 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50519 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab1CLAU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 19:20:28 -0500
Received: by qyg14 with SMTP id 14so2998215qyg.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 16:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4vxNf/DIa/gSAzI7JWWCTlBnc0KsIhro/spNPzRSe7Q=;
        b=unDVmASsSl67TKrqFXGzxP3DmK8Cymzd+RbtCqrAO/5kHoKZZ88eAkzE5DmYf84CIk
         46WJt5AR1KZoJ+EADKU6x5bID55e9nQfFdKuVhfUx40uM0Eouc5R2CvPSTlaPqMAWTq7
         5U/GA2LICPprRV3AQTNM0OULU7E5VRysVZbds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w3l8EpbWWD1vZ4RDpdrAmN7/7rUSSEp3bWOBM7l0PhnVd4GMVGmPWDMLrHyI9R5QVm
         K4a5xG8nWtWJTZX0wlUTpMAA2Fgwx5M2yGvgRxWqNonPXxTKVEYyeHJuNFOh3NIi1RFj
         V5Fqk6W5v7pdTU7e9YBm0muM6tcLJsZHbunqc=
Received: by 10.229.37.137 with SMTP id x9mr6729551qcd.151.1299889225180;
        Fri, 11 Mar 2011 16:20:25 -0800 (PST)
Received: from elie (adsl-69-209-58-73.dsl.chcgil.ameritech.net [69.209.58.73])
        by mx.google.com with ESMTPS id g26sm3266404qco.30.2011.03.11.16.20.22
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Mar 2011 16:20:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m339mu7u6n.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168935>

Jakub Narebski wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> 4. filter-branch killer: using fast-import's new features to implement
>>    common filter-branch operations (--subdirectory-filter,
>>    --prune-empty, obliterating certain files) faster.
>
> How it would be different from existing reposurgeon tool by ESR
> (cross-VC thanks to using fast-import format), or git_fast_filter by
> Elijah Newren (more of a library than a ready tool)?

Good question.

. reposurgeon loads the whole history into a convenient format,
  manipulates it, then dumps it as a separate step.  So it is even more
  flexible than filter-branch, but with a large history and especially
  on a small machine it can be slower.

. git_fast_filter is what Thomas mentioned --- a filter to go between
  fast-export and fast-import.

Both involve unpacking all trees.  Which is not a huge expense, mind
you, but there is room to go faster.

What I was suggesting is instead a tool that relies on fast-import to
do the heavy lifting.  So, for example, when you ask to delete
path/to/remove.txt from all commits, it would write:

 commit refs/heads/master
 mark :172
 author A U Thor <author@example.com> ...
 committer ...
 data ...
 from ...
 merge ...
 M 040000 [old tree name for that commit] ""
 D path/to/remove.txt

 commit refs/heads/mater
 mark :173
 ...

The idea is inspired by
http://thread.gmane.org/gmane.comp.version-control.git/158375
I am interested in it because I imagine something like this could be
useful for splitting out branches from a naive import of an svn repo
(and similar surgeries).
