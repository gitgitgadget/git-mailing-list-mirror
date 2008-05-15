From: David Reiss <dreiss@facebook.com>
Subject: Re: [PATCH v2] Add support for GIT_CEILING_DIRS
Date: Thu, 15 May 2008 00:11:52 -0700
Message-ID: <482BE238.5020309@facebook.com>
References: <482B935D.20105@facebook.com> <482BE0EB.6040306@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 15 09:12:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwXe4-0001wg-E1
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 09:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbYEOHL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 03:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbYEOHL4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 03:11:56 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:27869 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbYEOHLz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 03:11:55 -0400
Received: from sf2pmxf02.TheFacebook.com (sf2pmxf02.thefacebook.com [192.168.16.13])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m4F7BsYa030868;
	Thu, 15 May 2008 00:11:54 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by sf2pmxf02.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 May 2008 00:09:04 -0700
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <482BE0EB.6040306@viscovery.net>
X-OriginalArrivalTime: 15 May 2008 07:09:04.0022 (UTC) FILETIME=[8EDD0360:01C8B65A]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-05-15_02:2008-05-14,2008-05-15,2008-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0805090000 definitions=main-0805140248
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82185>

> If you make it so that the default value of ceil_offset is 0 (i.e. in the
> absence of any GIT_CEILING_DIRS),
This is what the new version of the patch does.

> and at this place you did
> 
>                 } while (offset > ceil_offset && cwd[--offset] != '/');
> 
> you wouldn't have to bend backwards with this off-by-one magic, would you?
It seems like that would cause it to continue on with the outer loop, rather
than aborting (which is what the current version does) when you hit the ceiling.
Or maybe I'm misunderstanding something.

--David
