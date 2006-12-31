From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Strict ordering by date
Date: Sat, 30 Dec 2006 17:03:31 -0800
Message-ID: <45970C63.1020509@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Dec 31 02:36:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0pd9-0006XU-Lj
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 02:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWLaBgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 20:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWLaBgl
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 20:36:41 -0500
Received: from terminus.zytor.com ([192.83.249.54]:59141 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932575AbWLaBgk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 20:36:40 -0500
X-Greylist: delayed 1984 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Dec 2006 20:36:40 EST
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id kBV13WZi023167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 30 Dec 2006 17:03:33 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV 0.88.7/2396/Sat Dec 30 03:57:43 2006 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=1.1 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,RCVD_IN_SORBS_DUL,TW_PM autolearn=no 
	version=3.1.7
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35642>

Hi all,

I have added a --pretty=rpm option to git in order to automatically 
generate the changelog for an RPM specfile.  So far, so good. 
Unfortunately, rpmbuild is very picky and will simply refuse to run, at 
all, if any of the entries are out of reverse chronological order.  When 
dealing with merges or cherrypicking -- or, for that matter, a commit 
done with a broken time setting -- this doesn't work with either 
--date-order or --topo-order.

(And yes, this is an rpmbuild misfeature.)

I've tried to add a --strict-date-order option, but it's not clear at 
what point -- if any -- we actually have the full list of entries to 
display.  It doesn't seem to happen anywhere inside revision.c.

Any pointers appreciated.

	-hpa
