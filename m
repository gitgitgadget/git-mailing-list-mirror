From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 01/14] Detect path names which overflow the name length field in the index
Date: Tue, 19 Aug 2008 20:32:40 +0200
Message-ID: <200808192032.44078.robin.rosenberg.lists@dewire.com>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org> <1219103602-32222-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 20:36:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVW3O-0007BS-Qx
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 20:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784AbYHSSeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 14:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755630AbYHSSeN
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 14:34:13 -0400
Received: from av9-1-sn3.vrr.skanova.net ([81.228.9.185]:40671 "EHLO
	av9-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526AbYHSSeM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 14:34:12 -0400
Received: by av9-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 01F2338384; Tue, 19 Aug 2008 20:34:09 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av9-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id DF48238329; Tue, 19 Aug 2008 20:34:09 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 9686437E45;
	Tue, 19 Aug 2008 20:34:09 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1219103602-32222-2-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92895>

tisdagen den 19 augusti 2008 01.53.09 skrev Shawn O. Pearce:
> C Git allows a path name to be longer than 4095 bytes by storing 4095
> into the path name length field within flags and then searching for a
> null terminator at the end of the path name, instead of relying on the
> length indicatior.  We cannot do this (easily) from an InputStream so
> we are currently going to just abort with an exception if we find such
> an extremely long path name.

What's hard? read bytes until we get a 0 shouldn't be hard. It has no
special meaning to an InputStream.

-- robin
