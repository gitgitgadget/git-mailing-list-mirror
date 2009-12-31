From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [updated patch v3 2/2] Improve transport helper exec failure
 reporting
Date: Thu, 31 Dec 2009 20:05:46 +0100
Message-ID: <4B3CF60A.4050100@kdbg.org>
References: <1262284003-1417-1-git-send-email-ilari.liusvaara@elisanet.fi> <1262284003-1417-3-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Dec 31 20:05:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQQLG-0001vm-5e
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 20:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbZLaTFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 14:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753112AbZLaTFq
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 14:05:46 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:51724 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753103AbZLaTFq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 14:05:46 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 39052CDF86;
	Thu, 31 Dec 2009 20:05:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1262284003-1417-3-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135966>

Ilari Liusvaara schrieb:
> +	helper->silent_exec_failure = 1;
> +	if (start_command(helper)) {
> +		if (errno == ENOENT)
> +			die("Unable to find remote helper for \"%s\"",
> +				data->name);
> +		else
> +			die_errno("Unable to run helper %s", helper->argv[0]);

When you fix your implementation of start_command() to follow 
Documentation/technical/api-run-command.txt, the error message in the else 
branch is not needed anymore (and then you can ask yourself whether you 
really want to issue your own error message in the case of ENOENT).

-- Hannes
