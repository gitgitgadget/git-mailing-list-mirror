From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Sun, 10 Aug 2008 19:57:35 +0200
Message-ID: <20080810175735.GA14237@cuci.nl>
References: <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl> <alpine.DEB.1.10.0808100502530.32620@asgard.lang.hm> <20080810145019.GC3955@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Jamey Sharp <jamey@minilop.net>,
	Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Aug 10 19:58:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFBi-0000qL-2u
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 19:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbYHJR5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 13:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbYHJR5h
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 13:57:37 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:46433 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbYHJR5g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 13:57:36 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 4330B5465; Sun, 10 Aug 2008 19:57:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080810145019.GC3955@efreet.light.src>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91860>

Jan Hudec wrote:
>On Sun, Aug 10, 2008 at 05:16:47 -0700, david@lang.hm wrote:
>> On Sun, 10 Aug 2008, Stephen R. van den Berg wrote:
>>> However, pondering the idea a bit more, I could envision something
>>> similar to the following:

>.... provided the two entries under the same name wouldn't drive the internal
>logic completely mad, I quite like this. Note by the way, that you need to
>allow for two trees too, because you may want to store attributes for

Well, in theory yes, but currently git doesn't store directories.
How about extending git-core to allow for storage of directories by
virtue of the following object in a tree:

040000 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391  .

I.e. the hash belongs to the empty blob.
Normally you don't (have to) store these directory blobs, but if you
insist on having them, git will create the empty directory on checkout
(i.e. you wouldn't need the dummy file trick anymore to force the
directory to be present).
-- 
Sincerely,
           Stephen R. van den Berg.

Real programmers don't produce results, they return exit codes.
