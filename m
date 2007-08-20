From: Mike Hommey <mh@glandium.org>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 22:50:42 +0200
Organization: glandium.org
Message-ID: <20070820205042.GB10173@glandium.org>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <20070820174142.GA7943@glandium.org> <867inqhyuk.fsf@lola.quinscape.zz> <20070820181357.GA8264@glandium.org> <86zm0mgicy.fsf@lola.quinscape.zz> <20070820184829.GA8617@glandium.org> <853ayeos82.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 22:52:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INEEc-0006c8-Rc
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 22:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763511AbXHTUvo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 16:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763445AbXHTUvo
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 16:51:44 -0400
Received: from vawad.err.no ([85.19.200.177]:54923 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761881AbXHTUvm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 16:51:42 -0400
Received: from aputeaux-153-1-3-249.w82-124.abo.wanadoo.fr ([82.124.49.249] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1INEDl-0001Ib-Fn; Mon, 20 Aug 2007 22:51:38 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1INECw-0002eX-4r; Mon, 20 Aug 2007 22:50:42 +0200
Content-Disposition: inline
In-Reply-To: <853ayeos82.fsf@lola.goethe.zz>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56260>

On Mon, Aug 20, 2007 at 10:39:57PM +0200, David Kastrup <dak@gnu.org> wrote:
> > And it has permissions associated with these hashes.
> 
> No, with the files.  Think again: the link between file system and
> repository is the index, and the current index format has no
> representation for trees or directories.
> 
> So git _can't_ store any information about a _directory_, since no
> information about directories passes through the index.

If, as Jan suggested in a previous message, you introduce directories in
the index, I still don't see why you would need two entries in the tree
object...

> > (...)
> >> > I think i wasn't clear enough... I just wondered why the format for tree
> >> > entries is something like (if you'd write it in perl):
> >> > sprintf "%06o %s\0%s", $mode, $file, pack("H[40]", $sha1)
> >> 
> >> Now I am sure I don't get your point.
> >
> > See what a raw tree object looks like:
> > git-cat-file tree 708453d64796eb617cb8a1602959e00356693315
> 
> Well, a tree is a container for files (which in turn consist of their
> permissions, file names, and blobs).

The question here was why the permissions are encoded with "%06o" while
the hash is packed. Anyways, it's just a boring detail.

Mike
