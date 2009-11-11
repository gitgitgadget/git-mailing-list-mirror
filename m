From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: P4 Sync problem
Date: Wed, 11 Nov 2009 14:57:46 +0000 (UTC)
Message-ID: <loom.20091111T154425-182@post.gmane.org>
References: <loom.20091110T145046-137@post.gmane.org>  <1a6be5fa0911110043i63b5c032s7924f9f1cdfe32ee@mail.gmail.com>  <loom.20091111T100646-406@post.gmane.org>  <1a6be5fa0911110400l1fe931afmbb53ceba8704e029@mail.gmail.com>  <loom.20091111T131837-901@post.gmane.org> <1a6be5fa0911110554u7c3a04c8hf50100b784b63c7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 15:58:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8EeI-0005NP-DR
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 15:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723AbZKKO6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 09:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756616AbZKKO6G
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 09:58:06 -0500
Received: from lo.gmane.org ([80.91.229.12]:49289 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756544AbZKKO6F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 09:58:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N8Ee8-0005J3-Fg
	for git@vger.kernel.org; Wed, 11 Nov 2009 15:58:08 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 15:58:08 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 15:58:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132660>

Tor Arvid Lund <torarvid <at> gmail.com> writes:

> //depot/A/...
> -//depot/A/B/...
> //depot/A/B/C/...
> 
> ... git-p4 sorts these paths by length. For a given filename, it finds
> the longest path that matches that files directory, and if that path
> starts with a '-', the file is not synced (for a file
> "//depot/A/B/myfile.c" it gets a match on "-//depot/A/B/...", and
> myfile.c is not synced, but the file "//depot/A/B/C/myotherfile.c" it
> matches "//depot/A/B/C/...")
> 
> Do you have an example that shows how it might fail?

According to the P4 User's Guide 
(http://www.perforce.com/perforce/doc.091/manuals/p4guide/02_config.html#1066090) 
Perforce prefer later mapping if there is a conflict.

So, if you switch paths:
-//depot/A/B/...
//depot/A/...
perforce will sync all the the files. Of course, this is not a very 
useful case.  
I suppose the order is not important until mapping are implemented...
