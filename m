From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv3] tag: add --points-at list option
Date: Wed, 8 Feb 2012 10:58:23 -0800
Message-ID: <20120208185823.GG6264@tgrennan-laptop>
References: <20120208002554.GA6035@sigill.intra.peff.net>
 <1328682076-23380-2-git-send-email-tmgrennan@gmail.com>
 <20120208154442.GB8773@sigill.intra.peff.net>
 <20120208184332.GF6264@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 08 19:58:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvCiu-00041g-KN
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 19:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757318Ab2BHS62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 13:58:28 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:43700 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757202Ab2BHS62 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2012 13:58:28 -0500
Received: by obcva7 with SMTP id va7so1166135obc.19
        for <git@vger.kernel.org>; Wed, 08 Feb 2012 10:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wBJb3aq5+NtKfUP6KPgVgbThgNVjMGA/k0BUrPT+QNo=;
        b=HQLGL8viSOM2DQu0wIofVTK39gJDhJRripkfu/NWiTp9iag5UoILM+GiOAIP7E6ZDE
         bvXSJ33kMpKcKDw6Pi3QSton7haJSRT/f4fFjIwifhe992urB66bDj1lJ6HhL4gfOEYq
         vYcbQLm89+R/m0aON+A5Xot06MMkT1Bo1zjgg=
Received: by 10.182.11.41 with SMTP id n9mr27273398obb.24.1328727507594;
        Wed, 08 Feb 2012 10:58:27 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id on10sm479406obc.11.2012.02.08.10.58.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Feb 2012 10:58:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120208184332.GF6264@tgrennan-laptop>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190248>

On Wed, Feb 08, 2012 at 10:43:32AM -0800, Tom Grennan wrote:
>On Wed, Feb 08, 2012 at 10:44:42AM -0500, Jeff King wrote:
>>On Tue, Feb 07, 2012 at 10:21:16PM -0800, Tom Grennan wrote:
>>
>>Also, should we be producing an error if !obj? It would indicate a tag
>>that points to a bogus object.
>
>I think the test of (obj) is redundant as this should be caught
>by get_sha1() in parse_opt_points_at()

I'm wrong. That tests the sha of the point-at argument, not the
sha/objects of the refs/tags entry.  I'll add...

	if (!obj)
		die(_("invalid tag, 'refs/tags/%s'"), refname);

-- 
TomG
