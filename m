From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 1/3] git-svn: Support retrieving passwords with GIT_ASKPASS
Date: Fri, 26 Feb 2010 18:41:02 +0100
Message-ID: <4B8807AE.2090502@kdbg.org>
References: <3.SQo> <1267142845-3040-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davvid@gmail.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 18:41:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl4Bj-0003wS-CW
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 18:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965515Ab0BZRlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 12:41:12 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:29101 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965499Ab0BZRlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 12:41:09 -0500
Received: from [192.168.0.202] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 718A9A7F03;
	Fri, 26 Feb 2010 18:41:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1267142845-3040-1-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141137>

Frank Li schrieb:
> +if (! exists $ENV{GIT_ASKPASS}) {
> +	if (exists $ENV{SSH_ASKPASS}) {
> +		$ENV{GIT_ASKPASS} = $ENV{SSH_ASKPASS};
> +		if ($^O eq 'msys') {
> +                        $ENV{GIT_ASKPASS} =~ s/\\/\\\\/g;
> +                        $ENV{GIT_ASKPASS} =~ s/(.*)/"$1"/;

Don't quote GIT_ASKPASS here.

> +	if (exists $ENV{GIT_ASKPASS}) {
> +		open(PH, "$ENV{GIT_ASKPASS} \"$prompt\" |");

		open(PH, "-|", $ENV{GIT_ASKPASS}, $prompt);

and you don't have to do any quoting at all, no?

-- Hannes
