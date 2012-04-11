From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] parse-options: Add support for dumping out long
 options
Date: Wed, 11 Apr 2012 07:59:21 -0500
Message-ID: <20120411125921.GC3161@burratino>
References: <1334140165-24958-1-git-send-email-bebarino@gmail.com>
 <1334140165-24958-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, szeder@ira.uka.de,
	felipe.contreras@gmail.com
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:59:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHx95-0001aj-Dv
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 14:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717Ab2DKM7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 08:59:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45971 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab2DKM73 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 08:59:29 -0400
Received: by iagz16 with SMTP id z16so1246962iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 05:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Z8md8yCRQ2uk1bPnyrLqFNqJMfK5/qTKxdJ9FzOCJDY=;
        b=beG5qMIIhwr7grSfeONXlfwisG3tNdda63IY/+f81oPLNgp9/LxGCidKv/N6XhZ8dL
         Jj37pwF/40E0TKUrjy58l1R0Hkmicn3OnkIN3UHHSQiCLtKOO4LcKdjSiRXC8iuvXmUW
         uOhjaXrVI2lkQSZ6qV0zKsXotge/mgyf2AYjXa6ZRqx1maTtQoUFjXgqKMZk6cKg20n7
         oqjEHwzVBTMAna+tBTlVXglFQgDC0GS0BHUrtm/pO0PYmU2MUpPC2LaNtbOkQotNRn9k
         9EvbBQCG8FzfRuhRGwV7oiWGA/1lxP2minlxaWaqclhBPmzaKfrnsnPHA294xODHP83S
         QVew==
Received: by 10.43.52.10 with SMTP id vk10mr9206788icb.25.1334149169158;
        Wed, 11 Apr 2012 05:59:29 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id us6sm25022549igc.9.2012.04.11.05.59.27
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 05:59:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334140165-24958-2-git-send-email-bebarino@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195178>

Stephen Boyd wrote:

> The bash completion script wants to know what the long options are for a
> certain command at runtime. Add a magical long option that nobody could
> possibly ever use (--dump-raw-long-options) to get this information.

Neat.  Probably should be documented:

diff --git i/Documentation/gitcli.txt w/Documentation/gitcli.txt
index f734f97b..0de074ec 100644
--- i/Documentation/gitcli.txt
+++ w/Documentation/gitcli.txt
@@ -96,6 +96,11 @@ usage: git describe [options] <committish>*
 	are deprecated, and such options are hidden from the default usage. This
 	option gives the full list of options.
 
+--dump-raw-long-options::
+	prints a space-separated list of supported options, including
+	negated `--no-<foo>` forms.  Long options taking an argument are
+	printed with a trailing equal sign, as in "`--depth=`".
+
 
 Negating options
 ~~~~~~~~~~~~~~~~
