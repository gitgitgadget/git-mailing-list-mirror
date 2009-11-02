From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Mon, 2 Nov 2009 07:43:50 -0800
Message-ID: <20091102154350.GS10505@spearce.org>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 16:44:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4z4e-00010o-7s
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 16:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531AbZKBPnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 10:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755527AbZKBPnp
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 10:43:45 -0500
Received: from george.spearce.org ([209.20.77.23]:50331 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336AbZKBPno (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 10:43:44 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 31BB8381FE; Mon,  2 Nov 2009 15:43:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131916>

Scott Chacon <schacon@gmail.com> wrote:
> I've incorporated the comments from Shawn (except for the 'annotated
> tag' comment
> in the 'include-tag' section of the capabilities doc, which I didn't
> understand).
...
> +include-tag
> +-----------
> +
> +The 'include-tag' capability is about sending tags if we are sending
> +objects they point to.  If we pack an object to the client, and a tag
> +points exactly at that object, we pack the tag too.  In general this
> +allows a client to get all new tags when it fetches a branch, in a
> +single network connection.

There are two types of tags, annotated and lightweight, right?

To avoid confusion here we should make it clear we only send
annotated tag objects when this feature is enabled.  The protocol
doesn't have provisions to send SHA-1 to ref mapping inside of a
pack stream, so lightweight tags cannot be sent.

-- 
Shawn.
