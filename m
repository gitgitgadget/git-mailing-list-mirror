From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Sat, 31 Jul 2010 10:40:18 -0400
Message-ID: <20100731144008.GA10540@localhost.localdomain>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 16:40:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfDEk-00074w-BL
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 16:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038Ab0GaOkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 10:40:25 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61999 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935Ab0GaOkY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 10:40:24 -0400
Received: by qwh6 with SMTP id 6so649793qwh.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=U5JEqGrZDknn+OnOS2i88OXtbhRSwUXUU7RryZLh4SI=;
        b=oix4o/DFjI5kB0HqNOem4DyxJvFVeqQyXhFdlj2fduitysq5XCbGPQrZzb4uSuJSgR
         SiHwvi21O/6+dhmTI0PWZNWvr5oUkSLJbLX3kv74uzOvcsONAMic8FEWNMlIM5cewwwJ
         Xg6eYug/IqL1JAK09fz1Q/o9Br4GreSxVc5hs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mZHQ3GU8qJyotNdWtg1xiO1/Mqb6Qr1+5SQkf7yYBGCr1f2kMADKRMBdIN0MLyTHVL
         ylW4OTLMV0RWxEZisLLbZKfff798gl7jHV+BfYEzYUL99nDlSdyUbFvY258AJmRnRhyn
         tCwLkKHlEPGHVx7YzaWHdHGdEBLs4ngPPTz3I=
Received: by 10.224.28.134 with SMTP id m6mr813931qac.240.1280587223599;
        Sat, 31 Jul 2010 07:40:23 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id b8sm1405884vci.45.2010.07.31.07.40.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 07:40:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152328>

On Wed, Jul 28, 2010 at 03:29:44PM +0200, Matthieu Moy wrote:
> +		if ! eval "$rest"
> +		then
> +			warn "Command $rest failed"
> +			warn "You can fix the problem, and then run"
> +			warn
> +			warn "	git rebase --continue"
> +			warn
> +			exit 0
> +		fi

If the command, stored in $rest, is rather long, perhaps "Command
$rest failed" won't be friendly output. Perhaps:

    Command Failure: $rest
