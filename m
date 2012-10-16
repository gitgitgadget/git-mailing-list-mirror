From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch v3 0/8] Create single PDF for all HTML files
Date: Tue, 16 Oct 2012 19:17:45 +0200 (CEST)
Message-ID: <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: philipoakley@iee.org, peff@peff.net, gitster@pobox.com,
	th.acker66@arcor.de, git@drmicha.warpmail.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 19:18:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOAmH-0004Pu-PF
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052Ab2JPRRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 13:17:50 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:42764 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754981Ab2JPRRt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 13:17:49 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id 2AF1B1084BF;
	Tue, 16 Oct 2012 19:17:46 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id DFBDF46E02D;
	Tue, 16 Oct 2012 19:17:45 +0200 (CEST)
Received: from webmail15.arcor-online.net (webmail15.arcor-online.net [151.189.8.68])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id D2557266E5;
	Tue, 16 Oct 2012 19:17:45 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-12.arcor-online.net D2557266E5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1350407865; bh=wdCjAw9v6HgEbMg8ui3ZDz530UKIBHUDZ7nOpgF3yRA=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=byWyeyj+oGzV6eNq33XfejyvfYaQIpjjmqRzbLPnmmhW0j5NGRNqFPUuN+xhPvKo4
	 IEafl8YRVSukCYSyzTamMveRgFpivijgfsOsnd0ZMWubDVh1zOw88CLVSeTuZhUIkg
	 LhR3l7F137svEknCw9t+Nc3w/5TfmSnm4dH6GRZ0=
Received: from [188.98.243.159] by webmail15.arcor-online.net (151.189.8.68) with HTTP (Arcor Webmail); Tue, 16 Oct 2012 19:17:45 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.243.159
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207849>

Hi,

this is v3 of my patch series for creating a single PDF for all
git documentation files.

There are only 2 changes since v2 (thanks to Junio for pointing me at these issues) :
- The over-long lines in git-bisect-lk2009.txt where shortened by abbreviating the SHA1s.
- Pretty-printing the shell script in update-hook-example.txt was fixed.

To sum up, this patch series provides the following new "features":
- Make target "html" now creates HTML for ALL files in ./Documentation/howto and ./Documentation/technical
- New make target "fullpdf" first creates HTML for all files in ./Documentation/RelNotes and then collates all HTML 
files in ./Documentation and its subdirs (except user-manual.html) in one single PDF file.

This approach is of course not an optimal one but by using wkhtmltopdf
it could be carried out easily. A more perfect approach would be to 
rework/redesign the whole doc tool chain and so perhaps arrive at additional
output formats like e.g. epub. But this is the topic of a patch series yet to come ...

A current version of git-doc.pdf is available in
https://github.com/tacker66/git-docpdf.git. 


---
Thomas
