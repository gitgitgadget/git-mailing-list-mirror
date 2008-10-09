From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/5] Fix UnpackedObjectLoader.getBytes to return a
	copy
Date: Thu, 9 Oct 2008 14:49:26 -0700
Message-ID: <20081009214926.GA8203@spearce.org>
References: <1222824690-7632-1-git-send-email-spearce@spearce.org> <1222824690-7632-2-git-send-email-spearce@spearce.org> <1222824690-7632-3-git-send-email-spearce@spearce.org> <2c6b72b30810091446y22cb2e00te7a25676ee21ddac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 23:50:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko3P3-0006qo-O2
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 23:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672AbYJIVt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 17:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755517AbYJIVt1
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 17:49:27 -0400
Received: from george.spearce.org ([209.20.77.23]:42828 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501AbYJIVt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 17:49:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6077A3835F; Thu,  9 Oct 2008 21:49:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2c6b72b30810091446y22cb2e00te7a25676ee21ddac@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97894>

Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> On Wed, Oct 1, 2008 at 03:31, Shawn O. Pearce <spearce@spearce.org> wrote:
> > diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
> > index 5282491..87e861f 100644
> > --- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
> > +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectLoader.java
> > @@ -105,7 +105,12 @@ protected void setId(final ObjectId id) {
> >         * @throws IOException
> >         *             the object cannot be read.
> >         */
> > -       public abstract byte[] getBytes() throws IOException;
> > +       public final byte[] getBytes() throws IOException {
> > +               final byte[] data = getCachedBytes();
> > +               final byte[] copy = new byte[data.length];
> > +               System.arraycopy(data, 0, copy, 0, data.length);
> > +               return data;
> > +       }
> 
> If I understand correctly, shouldn't this return the copy variable?

F&@!#*@#&@!#*@!@!&#@#@*@!

Yes.  :-)

I think its already committed to master too.  Can you send a patch
along to fix, and point out how stupid I am?

-- 
Shawn.
