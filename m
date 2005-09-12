From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH 00/22] cache cursors: an introduction
Date: Mon, 12 Sep 2005 12:37:42 -0400
Organization: Network Appliance, Inc.
Message-ID: <4325AED6.8050401@citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu> <4325A0D9.2000806@gmail.com>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040300040001080403090009"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 18:39:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EErJS-0008EV-HL
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 18:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVILQho (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 12:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVILQho
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 12:37:44 -0400
Received: from citi.umich.edu ([141.211.133.111]:16726 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932079AbVILQhn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 12:37:43 -0400
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 1B94F1BBBF;
	Mon, 12 Sep 2005 12:37:43 -0400 (EDT)
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
To: gitzilla@gmail.com
In-Reply-To: <4325A0D9.2000806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8407>

This is a multi-part message in MIME format.
--------------040300040001080403090009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

A Large Angry SCM wrote:
> Since you are proposing an API, some basic documentation about how to 
> use the API would be nice. Comments in cache.h seems the best place, for 
> now.

actually it might be best to have a list discussion first.  if i can 
answer questions and provide a few explanations here, the list archive 
might be a reasonable resting place for documentation.

the API is fairly simple and is documented via the function names. 
there isn't a whole lot of function-level documentation in the git code 
base that i have seen, so i erred on the side of less is more.

the first patch "introduce-cache-cursors provides most of the interface, 
and the subsequent patches demonstrate how to use it by changing parts 
of the git C code base to use the interface instead.

the main pieces are:

+  struct cache_cursor

which describes a position in the cache.

+  init_cc

which sets the given cursor to the top of the cache.

+  cc_to_ce

which extracts the cache entry that a cursor refers to.

+  next_cc, prev_cc, cache_eof

which allow cursor movement.

+  next_name

which skips to the next unique name in the cache.

+  walk_cache

which calls a function for each entry in the cache, in order.  the given 
function is responsible for moving the cursor to the next position 
before returning.

+  cache_find_name

which returns a cache cursor pointing to the found entry or to the entry 
which can be used as an insertion point if nothing matches.

+  cache_find_entry

which is a wrapper around cache_find_name that returns an entry instead 
of a position.

> The sentence "This patch series is against the "proposed updates" 
> branch, as of a couple of days ago." should have also included a commit 
> ID. That way we would know where/when the patches would apply cleanly 
> for testing and dissection.

i'm a dork.

6ae3d6e6d0f87cfa75b4bf213a485ff687defce8

i will include the base ref in my future postings.

--------------040300040001080403090009
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------040300040001080403090009--
