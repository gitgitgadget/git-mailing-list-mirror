From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [msysGit] [PATCH 1/2] MSVC: Do not close stdout to prevent a
 crash
Date: Tue, 22 Nov 2011 07:45:21 +0100
Message-ID: <4ECB4501.1060100@lyx.org>
References: <1321710345-2299-1-git-send-email-vfr@lyx.org> <4EC80D84.2010202@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, gitster@pobox.com,
	kusmabite@gmail.com, Johannes.Schindelin@gmx.de
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Nov 22 07:45:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSk6k-0000nL-O7
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 07:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272Ab1KVGp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 01:45:26 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62753 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496Ab1KVGp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 01:45:26 -0500
Received: by eye27 with SMTP id 27so6178913eye.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 22:45:25 -0800 (PST)
Received: by 10.213.4.146 with SMTP id 18mr459491ebr.33.1321944324795;
        Mon, 21 Nov 2011 22:45:24 -0800 (PST)
Received: from [145.94.168.114] (wlan-145-94-168-114.wlan.tudelft.nl. [145.94.168.114])
        by mx.google.com with ESMTPS id s44sm5928420eef.11.2011.11.21.22.45.23
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 22:45:23 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EC80D84.2010202@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185776>



>> To prevent the crash and to prevent git from writing cruft into the patch
>> file, we do not close stdout, but redirect it to "nul" instead.
> A more robust solution is to add invalidcontinue.obj to the linker
> command line. This installs an invalid argument handler that does not
> abort, and restores a sane behavior.

This seems to work only for release builds or did I miss something ?

Is there any argument to not redirect stdout to "/dev/null" on all 
platforms ?

Vincent
