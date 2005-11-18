From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 0/5] HTTP refactoring/cleanup
Date: Fri, 18 Nov 2005 11:02:52 -0800
Message-ID: <20051118190251.GE3968@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 19 00:04:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdBVk-0006ao-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 20:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVKRTC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 14:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVKRTC5
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 14:02:57 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:48987 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750758AbVKRTC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 14:02:56 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAIJ2q4b026703
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 11:02:52 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAIJ2qIM026701
	for git@vger.kernel.org; Fri, 18 Nov 2005 11:02:52 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12280>

The following set of patches cleans up http-fetch and http-push.

- Common HTTP code has been moved to http.c/http.h.  While
  curl-specific code still exists in both http-fetch and http-push,
  it is a step in the direction of allowing use of a different HTTP
  request library if someone is so inclined.

- Object request functions and data have been renamed to keep clear
  what types of requests are being processed, which will make it
  easier to process additional types of requests in parallel (eg.
  starting pack downloads immediately when an object 404s)

- The reliability and performance of http-fetch has been improved when
  built in an environment without curl multi support.

- XML parsing in http-push has been improved, which will make it
  easier to add functionality to update remote server info.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
