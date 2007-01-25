From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: git merge FETCH_HEAD produced bad commit message
Date: Thu, 25 Jan 2007 16:52:29 +0200
Message-ID: <20070125145229.GE25265@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 15:52:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA5xS-0002sE-QP
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 15:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbXAYOwF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 09:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbXAYOwF
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 09:52:05 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:38285 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965059AbXAYOwE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 09:52:04 -0500
Received: from mellanox.co.il ([194.90.237.34])
	by dev.mellanox.co.il (8.13.1/8.13.1) with SMTP id l0PEq3er027141
	for <git@vger.kernel.org>; Thu, 25 Jan 2007 16:52:04 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu, 25 Jan 2007 16:52:29 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37727>

Hi!
I like to do
	$git fetch <URL>

	$git log FETCH_HEAD
	
	$git merge FETCH_HEAD

I would expect this to be equivalent to

	git pull <URL>
	
However, the message that git merge produces in this case
is less than informative:

commit 3c11f564846227d80aa76b579c974913c3602862
Merge: 9871244... f5e6d63...
Author: Michael S. Tsirkin <mst@mellanox.co.il>
Date:   Thu Jan 25 16:46:51 2007 +0200

    Merge commit 'FETCH_HEAD' into ofed_1_2

I note that FETCH_HEAD actually has the information on where
the commit came from:
$cat .git/FETCH_HEAD
f5e6d63839970f4785c36b6be3835f037e74195c ssh://<hidden>/usr/src/ofed_1_2

So can not git merge be enhanced to put this data in commit log?

-- 
MST
