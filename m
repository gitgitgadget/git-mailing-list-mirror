From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] git: submodule honor -c credential.* from command
 line
Date: Thu, 25 Feb 2016 20:55:10 -0500
Message-ID: <20160226015510.GA5347@flurp.local>
References: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
 <1456426632-23257-2-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 02:55:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7co-0000w6-VR
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 02:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbcBZBzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 20:55:17 -0500
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36693 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbcBZBzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 20:55:16 -0500
Received: by mail-ig0-f195.google.com with SMTP id xg9so2561592igb.3
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 17:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uOJ00CYrYmb/Aq+ShEHi5+c7qSkG3Mcx/7kW13ATOfA=;
        b=trRRHII+RRS5T7hvpP+Wi4kQ+ZW/fuEPj/8De7iEkEDZaHEoi0joZktveii2Mo81OL
         B/uTdx4SR4r3w9SfRgEVIYhMIgJijGo4vfyd8JfRQ2lpwU/eyGv/x1KLEhtnLYpbyzJa
         c0Huf1JroQW8izEhYwL+sv7ENxhmdNecYKwcHo4PUqHhYXf+nL2IIRHmDwegh/4Q91TY
         AS5qoonu5WZKBbHxNiBCd3biH0J0h0r+cQHOmIsb4rHa4PLWbq3zKOKaxsm1DKQNZlwY
         d0Ho2xLQOetVYvIJ1ntt/bWI292ofXa/QHqwf8MoXoif6AkNglUBV4dMFNxpighjfcev
         Fpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uOJ00CYrYmb/Aq+ShEHi5+c7qSkG3Mcx/7kW13ATOfA=;
        b=czAh/rvKOV08j/7esSX0GiC5phNrqNb+n+Zoi7gd8ptG7ZhwYH0v9ikvHDOOosVEod
         dbnDLbdccSybvyIZyO6udZkCDjAu4UQ9slPxAbcJtHdyRtEv6vyUG6nfPEp98qa1pI3K
         LWhIrmNbKWEsmicaAuG54K93BfOlM7GCsR+m62+JjvCO2nWeD70/NVvJIrrCg3bHNDSm
         FqzkNJpctNRgnuxGssAdE0r3TwxxqSyDyy3kfV0WPjJGSiovV8VYTaTYkUBdli3Ssbzo
         Y5QWsr9hCiQT76mDq6FBH0rTOifsLqUcqgewmgE5Rx+a70t4Cq2l7TCtdPSZAqC7faJ2
         tyWg==
X-Gm-Message-State: AD7BkJLUziibxzaWX7PBuNgyz+TnSboyPnPbQEyGa7A7JRR6tUAGF/tpu1x9fEGlSFnxDA==
X-Received: by 10.50.132.74 with SMTP id os10mr400369igb.91.1456451715326;
        Thu, 25 Feb 2016 17:55:15 -0800 (PST)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id l11sm4440449iol.17.2016.02.25.17.55.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Feb 2016 17:55:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456426632-23257-2-git-send-email-jacob.e.keller@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287512>

On Thu, Feb 25, 2016 at 10:57:12AM -0800, Jacob Keller wrote:
> [...]
> Replace all the calls to clear_local_git_env with a wrapped function
> that filters GIT_CONFIG_PARAMETERS using the new helper and then
> restores it to the filtered subset after clearing the rest of the
> environment.
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
> @@ -0,0 +1,25 @@
> +test_expect_success 'sanitize-config keeps credential.helper' '
> +	git -c credential.helper="helper" submodule--helper sanitize-config >actual &&
> +	echo "'\''credential.helper=helper'\''" >expect &&

Not worth a re-roll, but these quote sequences are brain-melting.
Easier would have been to double-quote the second argument of
test_expect_success() and then do either:

    test_expect_success 'sanitize-config keeps credential.helper' "
        git -c [...] submodule--helper sanitize-config >actual &&
        echo \'credential.helper=helper\' >expect &&
        test_cmp expect actual
    "

or:

    test_expect_success 'sanitize-config keeps credential.helper' "
        git -c [...] submodule--helper sanitize-config >actual &&
        cat >expect <<-\EOF &&
        'credential.helper=helper'
        EOF
        test_cmp expect actual
    "

> +	test_cmp expect actual
> +'
> +
> +test_done
