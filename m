From: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: [PATCH] Require JDK1.5
Date: Mon, 14 May 2007 03:07:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0705140303380.17507@alpha.polcom.net>
References: <11790995571082-git-send-email-robin.rosenberg@dewire.com>
 <1179100134893-git-send-email-robin.rosenberg@dewire.com>
 <11791001343234-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: spearce@spearce.org, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon May 14 03:07:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnP2Q-0005qG-Od
	for gcvg-git@gmane.org; Mon, 14 May 2007 03:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758358AbXENBHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 21:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758351AbXENBHl
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 21:07:41 -0400
Received: from alpha.lp.pl ([194.1.144.4]:43090 "EHLO alpha.polcom.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757875AbXENBHk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 21:07:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by alpha.polcom.net (Postfix) with ESMTP id 7A9E538CB32;
	Mon, 14 May 2007 03:07:30 +0200 (CEST)
In-Reply-To: <11791001343234-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47211>

On Mon, 14 May 2007, Robin Rosenberg wrote:
> This changes project settings to requre Java 5 and
> also tightens some compiler settings.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
> .../.settings/org.eclipse.jdt.core.prefs           |   22 ++++++++++---------
> .../.settings/org.eclipse.jdt.ui.prefs             |    5 +--
> .../.settings/org.eclipse.jdt.core.prefs           |   22 ++++++++++---------
> .../.settings/org.eclipse.jdt.ui.prefs             |    5 +--
> .../.settings/org.eclipse.jdt.core.prefs           |   22 ++++++++++---------
> .../.settings/org.eclipse.jdt.ui.prefs             |    5 +--
> .../.settings/org.eclipse.jdt.core.prefs           |   22 ++++++++++---------
> .../.settings/org.eclipse.jdt.ui.prefs             |    3 +-
> .../src/org/spearce/jgit/lib/ObjectIdMap.java      |    4 +-
> 9 files changed, 57 insertions(+), 53 deletions(-)
[snip]
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
> index c397a0d..63796fd 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
> @@ -50,9 +50,9 @@ public class ObjectIdMap implements Map {
>
> 	public ObjectIdMap(Map sample) {
> 		try {
> -			Method m=sample.getClass().getMethod("clone", null);
> +			Method m=sample.getClass().getMethod("clone", (Class[])null);
> 			for (int i=0; i<256; ++i) {
> -				level0[i] = (Map)m.invoke(sample, null);
> +				level0[i] = (Map)m.invoke(sample, (Object[])null);
> 			}
> 		} catch (IllegalAccessException e) {
> 			throw new IllegalArgumentException(e);

I wonder why one would need changes like this?

These casts are not needed for anything as far as I can see and your IDE 
should easily tell you what type that parameter is. No?


Thanks,

Grzegorz Kulewski
