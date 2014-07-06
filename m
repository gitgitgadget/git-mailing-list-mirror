From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v5 00/28] Support multiple checkouts
Date: Sun, 6 Jul 2014 23:46:51 +0300
Message-ID: <20140706204651.GB21237@wheezy.local>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 22:47:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3tLB-00083G-JE
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 22:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbaGFUrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 16:47:09 -0400
Received: from p3plsmtpa12-04.prod.phx3.secureserver.net ([68.178.252.233]:50579
	"EHLO p3plsmtpa12-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750942AbaGFUrI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jul 2014 16:47:08 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa12-04.prod.phx3.secureserver.net with 
	id P8n31o00v3gsSd6018n6Xx; Sun, 06 Jul 2014 13:47:07 -0700
Content-Disposition: inline
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252943>

Hi.

What future does this have? Currently it is marked as
"Stalled", but still mergeable with some trivial conflicts
and seem to be working (except some bugs in interaction with
submodules, see below). It would be very nice if this
feature is officially supported.

I also have a comment about how it interacts with submodules.
Would it be more appropriate to mark "modules" as a
per-checkout directory? Because each of the working tree's
submodule is obviously a separated directory in filesystem,
and in most cases (at least in my practice) they are
checked-out to different revisions.

So, currently (before proper linking of submodules checkouts
implemented), if make submodules per-checkout (actually it
appears to somehow work even with current code, maybe
because some submodule code ignores the common_dir), one
could run "git submodule update" if necessary, and get fully
separated clones, which would work normally.

It still may break if submodules are removed, added or
renamed, but this seems to be inevitable until config is
separated to per-checkout and common parts, which I suppose
is a much bigger task.

-- 
Max
