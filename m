From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 11/23] Rewrite WindowCache to use a hash table
Date: Sat, 27 Dec 2008 14:30:05 +0100
Message-ID: <200812271430.06052.robin.rosenberg.lists@dewire.com>
References: <1230171079-17156-1-git-send-email-spearce@spearce.org> <1230171079-17156-11-git-send-email-spearce@spearce.org> <1230171079-17156-12-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 27 14:32:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGZGs-0005Kr-S4
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 14:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbYL0NaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 08:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbYL0NaM
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 08:30:12 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:48628 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753603AbYL0NaL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2008 08:30:11 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A9795005558AFE; Sat, 27 Dec 2008 14:30:07 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <1230171079-17156-12-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104004>

torsdag 25 december 2008 03:11:07 skrev Shawn O. Pearce:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
> index f617845..f478f04 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
> @@ -41,11 +41,7 @@
>  import java.io.IOException;
>  import java.lang.ref.ReferenceQueue;
>  
> -/**
> - * The WindowCache manages reusable <code>Windows</code> and inflaters used by
> - * the other windowed file access classes.
> - */
> -public class WindowCache {
> +class WindowCache {

This breaks the Eclipse plugin which want to call WindowCache.reconfigure. Package level
class can also have javadocs. Even though we do not require it, I still thinks it's a good idea. Not
sure how useful that one was.

-- robin
