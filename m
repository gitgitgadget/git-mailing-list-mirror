From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH 01/23] Introduce git-test.sh and git-test-lib.sh
Date: Wed, 27 Apr 2011 15:11:11 -0400
Message-ID: <1303931471.25134.54.camel@drew-northup.unet.maine.edu>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
	 <1303543372-77843-2-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 21:12:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFA9X-0004ib-Rx
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 21:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589Ab1D0TLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 15:11:55 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:58144 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773Ab1D0TLy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 15:11:54 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p3RJBHQU027451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Apr 2011 15:11:22 -0400
In-Reply-To: <1303543372-77843-2-git-send-email-jon.seymour@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p3RJBHQU027451
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1304536285.77742@iMUev2bPxxKvsGPp5tJTtw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172260>

On Sat, 2011-04-23 at 17:22 +1000, Jon Seymour wrote:
> This command is intended provide a uniform command line interface
> to a suite of assertions that can be made about the state of
> the working tree, index and repository.
> 
> This commit introduces the core assert infrastructure. Subsequent
> commits will introduce check functions that extend the infrastructure
> in a modular way with additional tests.
.....
> +'test_condition' [--<condition> [ arg ... ]] ...
> +'require_condition_libs'
> +
> +
> +DESCRIPTION
> +-----------
> +`git test` provides a uniform, extensible API for evaluating various conditions that
> +pertain to the state of a git working tree, index and repository.
> +
> +Specified conditions are evaluated from left to right. If any condition evaluates to false, 
> +the command conditionally prints a diagnostic message to stderr and sets a 
> +non-zero status code. Otherwise, sets a status code of zero. 
> +
> +The message used to report a assertion failure may be overidden by specifying the --message option.
> +
> +Diagnostic output resulting from an assertion failure may be suppressed with the -q option. 
> +Note that the -q option does not suppress diagnostic output that results from the failure to 
> +successfully parse the arguments that configure the test API.
.....
Is this supposed to be a porcelain or plumbing? 

The name could probably be better to avoid confusion with the "unit
testing" code in t/.

Additionally, I'd like to know why this shouldn't be implemented as some
sort of 
'git status --assert="XXXX"' 
call...

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
