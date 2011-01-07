From: Darxus@chaosreigns.com
Subject: git clone --update ?
Date: Fri, 7 Jan 2011 17:54:05 -0500
Message-ID: <20110107225405.GH20411@chaosreigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 08 00:04:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbLLr-0006RJ-EN
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 00:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912Ab1AGXEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 18:04:01 -0500
Received: from panic.chaosreigns.com ([64.71.152.40]:51776 "EHLO
	panic.chaosreigns.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136Ab1AGXEA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 18:04:00 -0500
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jan 2011 18:04:00 EST
Received: by panic.chaosreigns.com (Postfix, from userid 1000)
	id 02A88AC8D1; Fri,  7 Jan 2011 17:54:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=chaosreigns.com;
	s=mail; t=1294440846;
	bh=bd/nn8CB4fyqmFxWfBRSJF0CdhZ9MWXDQyQj8MCId7c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=wcFfB48WfZGIcnrJkAV9GteRHxJTMb7Qk7CntvmgUHBkhrzCLLs6Q5dbCuvamt/kc
	 dQ3fyzSGFhRauwcOSAFk4aLzExwgs1XPSWeCQ5DerOAN190HQNV/2pEwLkUXQFxW9L
	 gQyfM4QGb4MIU8yW7mt55vfBiwFDF6WKkInSg3KA=
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164784>

I'm working on a build script that pulls source from 12 git repos:
http://www.chaosreigns.com/wayland/wayland-build-ubuntu-all.sh

I would like to be able to do the equivalent of:

 rm -rf gtk+; git clone git://git.gnome.org/gtk+ --branch gdk-backend-wayland

Without re-downloading the entire thing.  Even if I made any kind of
modifications to the repo.

One suggestion I've gotten was;

  git checkout gdk-backend-wayland && git fetch git://git.gnome.org/gtk+ gdk-backend-wayland && git reset --hard FETCH_HEAD && git clean -fxd

Possibly replacing the branch name with HEAD if I want the default branch.

It would be nice if, instead, I could just run something like:

  git clone --update git://git.gnome.org/gtk+ --branch gdk-backend-wayland

Bonus points for working if I have not already cloned it.
