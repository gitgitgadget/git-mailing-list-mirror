From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Not going beyond symbolic links
Date: Tue, 5 Aug 2008 16:54:22 +0400
Message-ID: <20080805125422.GX7008@dpotapov.dyndns.org>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org> <7v8wvc2seh.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808041839130.3299@nehalem.linux-foundation.org> <alpine.DEB.1.00.0808050356480.9611@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.1.10.0808041921530.3299@nehalem.linux-foundation.org> <7vej54xa80.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 14:55:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQM4a-00011n-Ik
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 14:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758877AbYHEMya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 08:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757005AbYHEMya
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 08:54:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:41108 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756541AbYHEMy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 08:54:29 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1853683wri.5
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 05:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5yuQFNuqxuutbNFB/iws+WzW6P3BnbCXBCP4i7joVok=;
        b=Sw/s1ZhE1jzBvQ/7s73UWMGV6UVF6Ez31it+73qvKnkB3J4D3FjFYR8PLcvmUU0RsV
         pt3VymPo4dnzOgkPrKtHh0qN8PFCpD+6yNXn9HH9+ENimJMfwvhEzwOZyQh64bB2cGy4
         /bdfdp4lXvklOGFL16Yx/EoJL2/FdNvDBOlJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EaK0rAUIdnTR1ZevRzqvN/eLXLB0AImHpY9osane8uAKn+AdYcczUe1UV1nqGLOyGa
         Htn5ezTq2yclggNIdpwbJovwnXhwBTh8wOmN8BhFbM3nvNnhfHwIC48OMu9/2q8AfaRB
         P+Rgi4Hh7ppPNdbrFrDK0LgxItPVaV4HaF0bE=
Received: by 10.90.117.20 with SMTP id p20mr1349741agc.91.1217940867843;
        Tue, 05 Aug 2008 05:54:27 -0700 (PDT)
Received: from localhost ( [85.141.239.227])
        by mx.google.com with ESMTPS id 7sm11825159agc.14.2008.08.05.05.54.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Aug 2008 05:54:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vej54xa80.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91439>

On Mon, Aug 04, 2008 at 11:11:11PM -0700, Junio C Hamano wrote:
> 
> The thing is, the "feature" is not very well supported, even without the
> fixes from last night.  If you have a symlink "sym" that points at "dir"
> that has "file" in it, and if neither "sym" nor "dir/file" are tracked,
> you can "git add sym/file" to add it (I called it a bug).

Well, I actually used this feature less than a year ago and did not have
any problem with that. Not that it is very important for me now, but I had
makefiles in a separate build directory, and I used a symlink to move
building to a tmpfs partion, which sped up building slightly.

Obviously, if a symlink points to a directory inside of the repository
and then you use "git add sym/file", it is definitely a mistake. OTOH,
let's consider the following situation:

git init
mkdir newdir
touch newdir/foo
git add newdir/foo
git commit -m 'add foo'
mv newdir /tmp/
ln -s /tmp/newdir
touch newdir/bar
git add newdir/bar
git commit -m 'add bar'
git ls-files

And you can see:
newdir/bar
newdir/foo

Git does exactly what I want here!

Anyway, I more concern with performance impact of your patch. If it
is noticeable, then it would be nice to have an option to turn this
check off.

Dmitry
