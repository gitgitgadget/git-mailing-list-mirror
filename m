From: Nir.Friedman@greenhouse.lotus.com
Subject: git over https and http 1.1
Date: Wed, 18 May 2011 08:46:18 -0400
Message-ID: <OF134A8B76.F0B9B9C0-ON85257894.00462851-85257894.00462862@greenhouse.lotus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 14:46:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMg93-0007QE-HZ
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 14:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933103Ab1ERMq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 08:46:29 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:43244 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933093Ab1ERMq2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 08:46:28 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4ICeir5008222
	for <git@vger.kernel.org>; Wed, 18 May 2011 06:40:44 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p4IClfwp042994
	for <git@vger.kernel.org>; Wed, 18 May 2011 06:47:41 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p4I6kMRD019375
	for <git@vger.kernel.org>; Wed, 18 May 2011 00:46:22 -0600
Received: from internet1.lotus.com (internet1.lotus.com [9.32.140.212])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id p4I6kMs3019296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 18 May 2011 00:46:22 -0600
Received: from ghmail1.lotus.com (ghmail1.lotus.com [9.32.153.15])
	by internet1.lotus.com (8.14.4/8.14.1) with ESMTP id p4ICkLxT1765442
	for <git@vger.kernel.org>; Wed, 18 May 2011 08:46:21 -0400
Received: from gh203.lotus.com ([9.32.7.20])
          by ghmail3.lotus.com (Lotus Domino Release 8.5.2)
          with ESMTP id 2011051808462021-24589 ;
          Wed, 18 May 2011 08:46:20 -0400 
Importance: Normal
X-Priority: 3 (Normal)
Sensitivity: 
In-Reply-To: 
References: 
X-Mailer: Lotus Domino Web Server Release 8.5.1FP4 July 25, 2010
X-MIMETrack: Serialize by Notes Server on DWA/lotus(Release 8.5.1FP4|July 25, 2010) at
 05/18/2011 08:46:18 AM,
	Serialize complete at 05/18/2011 08:46:18 AM,
	Serialize by Router on DWA/lotus(Release 8.5.1FP4|July 25, 2010) at 05/18/2011
 08:46:19 AM,
	Itemize by SMTP Server on ghmail3/greenhouse(Release 8.5.2|August 10, 2010) at
 05/18/2011 08:46:20 AM,
	Serialize by Router on ghmail1/greenhouse(Release 8.5.2|August 10, 2010) at
 05/18/2011 08:46:21 AM,
	Serialize complete at 05/18/2011 08:46:21 AM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173876>

I am using git with https as the transport protocol. 
Response times were around 30 seconds before apache started processing the backend command. 
I added the flags -  BrowserMatch "git"      downgrade-1.0 force-response-1.0
 to the apache conf file, and response times were fast. 
This seems to mean that the libcurl library is not dealing correctly with HTTP 1/1 over SSL. Is this the best fix? 
If so, maybe appropriate documentation should be added to the git setup docs.