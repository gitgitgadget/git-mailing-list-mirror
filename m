From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: What happens when the repository is bigger than gc.autopacklimit
 * pack.packSizeLimit?
Date: Fri, 29 Aug 2014 14:54:45 -0400
Message-ID: <201408291854.s7TIsjM3003040@hobgoblin.ariadne.com>
References: <201408271936.s7RJarOh011358@hobgoblin.ariadne.com>
 <20140827194746.GE7561@peff.net>
 <201408291538.s7TFc0DU001156@hobgoblin.ariadne.com> <20140829184716.GB29456@peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 20:54:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNRJy-0004yb-BB
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 20:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbaH2Syq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 14:54:46 -0400
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:32881
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752942AbaH2Syq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Aug 2014 14:54:46 -0400
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id khkP1o00627AodY55iulUH; Fri, 29 Aug 2014 18:54:45 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id kiuk1o00r1KKtkw3fiulZ0; Fri, 29 Aug 2014 18:54:45 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id s7TIsjUL003041;
	Fri, 29 Aug 2014 14:54:45 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id s7TIsjM3003040;
	Fri, 29 Aug 2014 14:54:45 -0400
In-reply-to: <20140829184716.GB29456@peff.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1409338485;
	bh=tVi2OoIlIQFG3Cj2f47o57ffp/VKALS8hvzB/JXwWNM=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=pImuW6U5iVzeDsPfWrFwnh1OiyWzvImDVWtIKa7csRXUzVDj/lcxVZOYiXmQ+5cRr
	 h7HaUOIaxfukrs3N5paeCr0ELVeLIRuNKLd0Teb46oucSRt/7p+G+3aS8gHTXXYg6I
	 Za8wOSNp4TnDdMoFSpMCuT6vZmrQN4KSOKR1bP70W/KVMwNrPosvIcqYcB0uobOpdr
	 qiaHLJd4YcQDRuanSnYdlE0yL7P3nz2MgRRF/Ky88TmRWZVzGampzShFw1FYhIPCaG
	 8W//YHzW/4uIIwEZs3cLM8PgQbWniIm81WBEgliKZx+oe2XhRfnVwOqzsDYh/VoGeA
	 UD12if18rpmWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256178>

> From: Jeff King <peff@peff.net>

> That makes sense, though I question whether packs are really helping you
> in the first place. I wonder if you would be better off keep your
> non-delta binaries as loose objects (this would require a new option to
> pack-objects and teaching "gc --auto" to ignore these when counting
> loose objects, but would be fairly straightforward).

Having 40,000 lose objects might be troublesome in its own way.

Dale
