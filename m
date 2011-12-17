From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 02/11] git-p4: test debug macro
Date: Sat, 17 Dec 2011 22:43:18 +0000
Message-ID: <4EED1B06.80007@diamand.org>
References: <1324147942-21558-1-git-send-email-pw@padd.com> <1324147942-21558-3-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 23:43:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rc2yS-0001dY-EC
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 23:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335Ab1LQWnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 17:43:20 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44298 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab1LQWnT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 17:43:19 -0500
Received: by wgbdr13 with SMTP id dr13so8472391wgb.1
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 14:43:18 -0800 (PST)
Received: by 10.227.208.133 with SMTP id gc5mr8638083wbb.25.1324161798522;
        Sat, 17 Dec 2011 14:43:18 -0800 (PST)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id o3sm19051536wiy.14.2011.12.17.14.43.16
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 14:43:17 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <1324147942-21558-3-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187407>

On 17/12/11 18:52, Pete Wyckoff wrote:
> Call this from a test to have it pause and wait for you to
> investigate.  It prints out its current directory and the
> P4 environment variables.  It waits for ctrl-c before continuing
> the test.
>

Very useful, thanks!


> +# Go investigate when it pauses, then hit ctrl-c to continue the
> +# test.  The other tests will run, and p4d will be cleaned up nicely.
> +#
> +# Note that the directory is deleted and created for every test run,
> +# so you have to do the "cd" again.
> +#
> +debug() {
> +        echo "*** Debug me, hit ctrl-c when done.  Useful shell commands:"
> +        echo cd \"$(pwd)\"
> +        echo export P4PORT=$P4PORT P4CLIENT=$P4CLIENT
> +        trap echo SIGINT

Does that work with non-bash shells like ash? It didn't for me.

> +        sleep $((3600 * 24 * 30))
> +        trap - SIGINT
> +}
> +
