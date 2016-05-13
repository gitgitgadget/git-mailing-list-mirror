From: Eric Wong <e@80x24.org>
Subject: Re: [BUG] t9801 and t9803 broken on next
Date: Fri, 13 May 2016 10:36:21 +0000
Message-ID: <20160513103621.GA12329@dcvr.yhbt.net>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 12:36:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1ASI-0001Ik-Ho
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 12:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbcEMKgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 06:36:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40382 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033AbcEMKgV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 06:36:21 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25DF620D5C;
	Fri, 13 May 2016 10:36:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294522>

Lars Schneider <larsxschneider@gmail.com> wrote:
> Hi,
> 
> t9801 and t9803 seem to be broken on next. A quick bisect indicates that d9545c7 
> "fast-import: implement unpack limit" might be the reason. (@gmane/292562).
> 
> Did anyone look into that already?

Just took a look (no p4, so couldn't run tests) and I guess it's
because the default changed and it doesn't generate tiny packs.

The easiest change is probably to call:

	git config fastimport.unpackLimit 0

during setup like t9300 now does.
