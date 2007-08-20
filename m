From: David Kastrup <dak@gnu.org>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 23:03:36 +0200
Message-ID: <85k5rpor4n.fsf@lola.goethe.zz>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net>
	<20070820174142.GA7943@glandium.org>
	<867inqhyuk.fsf@lola.quinscape.zz>
	<20070820181357.GA8264@glandium.org>
	<86zm0mgicy.fsf@lola.quinscape.zz>
	<20070820184829.GA8617@glandium.org> <853ayeos82.fsf@lola.goethe.zz>
	<20070820205042.GB10173@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 23:03:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INEPf-0002FJ-4r
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 23:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbXHTVDk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 17:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbXHTVDj
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 17:03:39 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:57734 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751072AbXHTVDi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2007 17:03:38 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 86E6132E98F;
	Mon, 20 Aug 2007 23:03:37 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 7A2742D3B6A;
	Mon, 20 Aug 2007 23:03:37 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-046-034.pools.arcor-ip.net [84.61.46.34])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 4C0902C29E6;
	Mon, 20 Aug 2007 23:03:37 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id CCA491C36605; Mon, 20 Aug 2007 23:03:36 +0200 (CEST)
In-Reply-To: <20070820205042.GB10173@glandium.org> (Mike Hommey's message of "Mon\, 20 Aug 2007 22\:50\:42 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4014/Mon Aug 20 21:33:05 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56261>

Mike Hommey <mh@glandium.org> writes:

> On Mon, Aug 20, 2007 at 10:39:57PM +0200, David Kastrup <dak@gnu.org> wrote:
>> > And it has permissions associated with these hashes.
>> 
>> No, with the files.  Think again: the link between file system and
>> repository is the index, and the current index format has no
>> representation for trees or directories.
>> 
>> So git _can't_ store any information about a _directory_, since no
>> information about directories passes through the index.
>
> If, as Jan suggested in a previous message, you introduce
> directories in the index, I still don't see why you would need two
> entries in the tree object...

As I already said: you don't.  It may just be _convenient_ in the
_index_ for doing single pass merge collision detection (when a
directory is replaced by a file or vice versa).  But there would be no
additional information stored in the index, and it definitely would
not be worth to do double entries in the repository: the repository is
already capable of representing all the desired information and it
would be wasteful to introduce any complications there when the
current format already is fine.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
