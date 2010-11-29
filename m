From: "Luke Diamand" <luked@broadcom.com>
Subject: git-p4: slow doing a commit due to weird perforce behaviour?
Date: Mon, 29 Nov 2010 14:39:26 +0000
Organization: Broadcom Europe Ltd
Message-ID: <1291041566.1990.48.camel@kipper>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 15:39:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN4tM-0002yY-2B
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 15:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336Ab0K2Oji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 09:39:38 -0500
Received: from mms1.broadcom.com ([216.31.210.17]:4223 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078Ab0K2Oji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 09:39:38 -0500
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Mon, 29 Nov 2010 06:39:49 -0800
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 29 Nov 2010 06:39:29 -0800
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.17.16.106]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 EA6D374D04 for <git@vger.kernel.org>; Mon, 29 Nov 2010 06:39:27 -0800 (
 PST)
Received: from [10.177.66.89] (unknown [10.177.66.89]) by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 6E90420501 for
 <git@vger.kernel.org>; Mon, 29 Nov 2010 06:39:27 -0800 (PST)
X-Mailer: Evolution 2.30.3
X-WSS-ID: 60ED64BF3P030363362-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162387>

Am I just imagining this? It's more of a perforce question than a git
question I'm afraid.

git-p4 seems to be quite slow sometimes at submitting changes. At least
for me, it seems to be down to the generation of the diff, which is done
with "p4 diff -du ...".

If I do "p4 diff ..." or "p4 diff -dc ..." then the response comes back
straight away, and seems to be based purely on the currently checked out
files.

If instead, though, I do "p4 diff -du" then it appears to do a diff of
every file, or something. It's able to spot files that I haven't
actually checked out, but is *much* slower.

Does anyone else get this or is it just me?

% time p4 diff -du ...

real	0m9.082s
user	0m6.560s
sys	0m0.952s

% time p4 diff -dc ...
... - file(s) not opened on this client.

real	0m0.021s
user	0m0.000s
sys	0m0.000s
