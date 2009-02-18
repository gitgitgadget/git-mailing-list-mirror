From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH] 1/2 : (reworked) Externalizable/Serializable Items
Date: Thu, 19 Feb 2009 00:21:33 +0100
Message-ID: <200902190021.33382.robin.rosenberg.lists@dewire.com>
References: <320075ff0902161212s1980cd70r8cdc4c21550333ee@mail.gmail.com> <200902182159.51027.robin.rosenberg.lists@dewire.com> <20090218214859.GN22848@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nigel Magnay <nigel.magnay@gmail.com>, Git ML <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 00:23:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZvkv-00089G-UY
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 00:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbZBRXVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 18:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbZBRXVh
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 18:21:37 -0500
Received: from mail.dewire.com ([83.140.172.130]:23399 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742AbZBRXVg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 18:21:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1C1C8147E9BD;
	Thu, 19 Feb 2009 00:21:35 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3k-WNcCrN+gQ; Thu, 19 Feb 2009 00:21:34 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 88269147E9AD;
	Thu, 19 Feb 2009 00:21:34 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-11-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <20090218214859.GN22848@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110594>

onsdag 18 februari 2009 22:48:59 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > Shawn wrote:
> > > > +            os.writeUTF(KEY_FETCH);
> > > > +            os.writeUTF(refspec.toString());
> > > > +        }
> > > > +
> > > > +        for (RefSpec refspec : push) {
> > > > +        	os.writeUTF(KEY_PUSH);
> > > > +            os.writeUTF(refspec.toString());
> > > > +        }
> > > 
> > > Should we maybe allow RefSpec to serialize itself with
> > > os.writeObject() rather than using writeUTF() directly?
> > 
> > Doesn't the style above make it easy to define and document
> > a format that is easy for non-java programs to write and read,
> > while writeObject introduces java-centric stuff (depending on
> > the full class name etc).
> 
> Non-Java reading a Java serialization stream?  Seriously?

No, that was my objection to using writeObject, as that make
it a Java-only stream, but then it might not be worth doing
it via the serialization mechanism.

-- robin
