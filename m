From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: What is an efficient way to get all blobs / trees that have notes
 attached?
Date: Fri, 1 Apr 2016 12:51:52 +0200
Message-ID: <ndljs8$vj3$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 12:52:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alwgQ-0007D1-Jf
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 12:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbcDAKwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 06:52:01 -0400
Received: from plane.gmane.org ([80.91.229.3]:38254 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761AbcDAKwB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 06:52:01 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1alwgH-00079h-KP
	for git@vger.kernel.org; Fri, 01 Apr 2016 12:51:57 +0200
Received: from 131.228.216.133 ([131.228.216.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 12:51:57 +0200
Received: from sschuberth by 131.228.216.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 12:51:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 131.228.216.133
X-Mozilla-News-Host: news://news.gmane.org:119
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290522>

Hi,

I'm curious whether there's a more efficient way to get a list of blobs 
/ trees (and their names) that have notes attached than doing this:

1) Get all notes refs I'm interested in (git-for-each-ref).

2) For each notes ref, get the list of notes (git-notes list) and store 
them in a hash table that maps object hashes to notes.

3) Recursively list all blobs / trees (git-ls-tree) and look whether an 
object's hash is conatined in our table to get its notes.

In particular 3) could be expensive for repos with a lot of files as 
we're looking at all of them just to see whether they have notes attached.

Regards,
Sebastian
