From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Mon, 18 Aug 2008 16:28:00 -0700
Message-ID: <20080818232800.GD9572@spearce.org>
References: <20080810112038.GB30892@cuci.nl> <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080809210733.GA6637@oh.minilop.net> <20080810110925.GB3955@efreet.light.src> <20080816062130.GA4554@oh.minilop.net> <20080818061236.GF7376@spearce.org> <20080818230646.GA11044@cisco.com> <48AA0487.8050009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Derek Fawcus <dfawcus@cisco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marcus Griep <neoeinstein@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:29:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVE9p-0007wn-VA
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbYHRX2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752898AbYHRX2B
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:28:01 -0400
Received: from george.spearce.org ([209.20.77.23]:39531 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbYHRX2A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:28:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2FF2238376; Mon, 18 Aug 2008 23:28:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48AA0487.8050009@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92761>

Marcus Griep <neoeinstein@gmail.com> wrote:
> I was under the impression that tags were references to commit objects,
> and they to tree objects:
> 
> tag -> commit -> tree

No.  A tag can reference any object.  See for example the
junio-gpg-pub tag in git.git, it references a blob, not a commit.
The linux-2.6.git tree has a tag which references a tree.

Tags may also reference other tags.
 
> Also, wouldn't this require large numbers tags, or the ability to multi-
> target tags?

Tag objects don't have to have names in the repository's ref space,
but it helps that they do when you are doing git-lost-found.
Having a tag in the database which shouldn't have a ref name in
refs/tags is more than a bit funny.

-- 
Shawn.
