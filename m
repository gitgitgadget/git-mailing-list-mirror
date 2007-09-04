From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Calculating tree nodes
Date: Tue, 4 Sep 2007 05:19:49 +0100
Message-ID: <e1dab3980709032119r381f7a91ia84ba09039c21be1@mail.gmail.com>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
	 <20070904025153.GS18160@spearce.org>
	 <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 06:20:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISPtM-0000Vl-Rg
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 06:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbXIDETv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 00:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbXIDETv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 00:19:51 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:19179 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbXIDETu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 00:19:50 -0400
Received: by nz-out-0506.google.com with SMTP id s18so939399nze
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 21:19:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rppiiBpru+VV3cojcMmKu6pGB+r8JYk3FFXvGNaNnyWJoWpa7MgbNJz9gJHswzDXJ5/9h4A2/kKdHSyM4/f1RBPalgJxXCSz4FwvQ2IIhDfN93tQ9dOJTRpeTW9ObT/OtJWz/PF3eX017S9s1XMrsfOi3/7whLp/NjC7M+YrRdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UzxkgdKDAGKxrg52/B8v1ko/wc9ks62QMvvAM07bOCRbac+Fx9nDdhZReODSc9y+YhHhQ0m+wyExKPVy182WZBQBUB7Je3xT7jpUlbEZrOIfTVgXJfZnDk93TgrPl/pWcZxaG58E00sWfCa7gsgAdpq1owmLFXAbUAvqBMxUWII=
Received: by 10.64.181.12 with SMTP id d12mr9541704qbf.1188879589986;
        Mon, 03 Sep 2007 21:19:49 -0700 (PDT)
Received: by 10.65.81.12 with HTTP; Mon, 3 Sep 2007 21:19:49 -0700 (PDT)
In-Reply-To: <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57518>

On 9/4/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> Git has picked up the hierarchical storage scheme since it was built
> on a hierarchical file system.

FWIW my memory is that initial git used path-to-blob lists (as you're
describing but without delta-ing) and tree nodes were added after a
couple of weeks, the motivation _at the time_ being they were a
natural way to dramatically reduce the size of repos.

One of the nice things about tree nodes is that for doing a diff
between versions you can, to overwhelming probability, decide
equality/inequality of two arbitrarily deep and complicated subtrees
by comparing 40 characters, regardless of how remote and convoluted
their common ancestry. With delta chains don't you end up having to
trace back to a common "entry" in the history? (Of course, I don't
know how packs affect this - presumably there's some delta chasing to
get to the bare objects as well.)

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
