From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Errors cloning over http -- git-clone and cg-clone fail to fetch a reachable object...
Date: Mon, 7 Nov 2005 09:14:47 -0800
Message-ID: <20051107171446.GA4070@reactrix.com>
References: <46a038f90511061354k5378a92ckc427841f90ec8b4@mail.gmail.com> <46a038f90511061852h5cdf9539o34f69b4deb9f041a@mail.gmail.com> <20051107043737.GI3001@reactrix.com> <46a038f90511062050geee7e73qddcd52e3a2ec86df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 18:17:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZAaC-0005P7-P5
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 18:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVKGRO4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 12:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVKGRO4
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 12:14:56 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:3983 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964876AbVKGROz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 12:14:55 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA7HEmb8005285;
	Mon, 7 Nov 2005 09:14:48 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA7HElhJ005282;
	Mon, 7 Nov 2005 09:14:47 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511062050geee7e73qddcd52e3a2ec86df@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11272>

On Mon, Nov 07, 2005 at 05:50:02PM +1300, Martin Langhoff wrote:

> > Does it always error out on the same pack file?
> 
> Yes.

You might try this to see exactly what request/response headers
curl thinks are passing back and forth.


diff --git a/http-fetch.c b/http-fetch.c
index ea8af1b..11d4dca 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -325,6 +325,7 @@ static struct active_request_slot *get_a
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_range_header);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
+	curl_easy_setopt(slot->curl, CURLOPT_VERBOSE, 1);
 
 	return slot;
 }

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
