From: Drew Northup <drew.northup@maine.edu>
Subject: Re: git over https and http 1.1
Date: Thu, 19 May 2011 16:31:49 -0400
Message-ID: <1305837109.25259.11.camel@drew-northup.unet.maine.edu>
References: <OF134A8B76.F0B9B9C0-ON85257894.00462851-85257894.00462862@greenhouse.lotus.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nir.Friedman@greenhouse.lotus.com
X-From: git-owner@vger.kernel.org Thu May 19 22:32:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN9tZ-0001ZM-3g
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 22:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934626Ab1ESUc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 16:32:27 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:42916 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933813Ab1ESUc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 16:32:27 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p4JKVtAx031573
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 19 May 2011 16:31:56 -0400
In-Reply-To: <OF134A8B76.F0B9B9C0-ON85257894.00462851-85257894.00462862@greenhouse.lotus.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p4JKVtAx031573
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1306441918.69323@5k2zor/f8JDowT68CEoVRg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174000>


On Wed, 2011-05-18 at 08:46 -0400, Nir.Friedman@greenhouse.lotus.com
wrote:
> I am using git with https as the transport protocol. 
> Response times were around 30 seconds before apache started processing the backend command. 
> I added the flags -  BrowserMatch "git"      downgrade-1.0 force-response-1.0
>  to the apache conf file, and response times were fast. 
> This seems to mean that the libcurl library is not dealing correctly with HTTP 1/1 over SSL. Is this the best fix? 
> If so, maybe appropriate documentation should be added to the git setup docs.--

Sounds a little drastic to me... Perhaps to find out what's going on you
might set up a test repo behind an STunnel instance and have a look at
the TCP/HTTP stream between them? 

Perhaps Git+libcurl isn't using keep-alive? I'd have to check the code.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
