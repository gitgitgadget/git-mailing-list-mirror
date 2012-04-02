From: "Holding, Lawrence" <Lawrence.Holding@cubic.com>
Subject: Question: how to have ls-files use the .gitignore in the index
Date: Tue, 3 Apr 2012 11:07:08 +1200
Message-ID: <A5E8E180685CEF45AB9E737A010799805DFACA@cdnz-ex1.corp.cubic.cub>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 01:07:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEqLO-0001G2-GX
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 01:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013Ab2DBXHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 19:07:17 -0400
Received: from exprod6og117.obsmtp.com ([64.18.1.39]:58439 "HELO
	exprod6og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753502Ab2DBXHN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 19:07:13 -0400
Received: from bb-corp-outmail1.corp.cubic.com ([149.63.70.140]) (using TLSv1) by exprod6ob117.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT3oxIHPelhB/sYR74m/J5Ep2hCLBcIZe@postini.com; Mon, 02 Apr 2012 16:07:12 PDT
Received: from bb-corp-ex4.corp.cubic.cub ([149.63.2.70])
	by bb-corp-outmail1.corp.cubic.com (8.13.1/8.13.1) with ESMTP id q32N7BG4010314
	for <git@vger.kernel.org>; Mon, 2 Apr 2012 16:07:12 -0700
Received: from cdnz-ex1.corp.cubic.cub ([172.19.33.136]) by bb-corp-ex4.corp.cubic.cub with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 2 Apr 2012 16:07:12 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question: how to have ls-files use the .gitignore in the index
Thread-Index: Ac0RJVRsaTOcMXe0RH+X+HzAjja1zw==
X-OriginalArrivalTime: 02 Apr 2012 23:07:12.0063 (UTC) FILETIME=[56296CF0:01CD1125]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194576>

I have a pre-commit hook that checks the index for files that match the
ignores / excludes in the repository. But sometimes this will run on a
repository where not all the folders are up-to-date with the tip, and
will then test against the working tree versions of these files and not
those in the index.

from pre-commit:

	if git ls-files -i --exclude-standard | grep .
	then
	    exit 1
	fi 

Is there an option to have ls-files use the excludes in the index
without checking out the whole file tree?

Thanks,
