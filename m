From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv2 2/5] t5512 (ls-remote): modernize style
Date: Sat, 3 Mar 2012 09:33:50 -0800
Message-ID: <20120303173350.GL2572@tgrennan-laptop>
References: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
 <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
 <1330740942-25130-3-git-send-email-tmgrennan@gmail.com>
 <7vipim6rf2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 18:34:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3sqv-0003hd-DY
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 18:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873Ab2CCReI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 12:34:08 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:42994 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab2CCReG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 12:34:06 -0500
Received: by dadp12 with SMTP id p12so3170182dad.11
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 09:34:06 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.68.74.138 as permitted sender) client-ip=10.68.74.138;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.68.74.138 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.68.74.138])
        by 10.68.74.138 with SMTP id t10mr30545266pbv.126.1330796046451 (num_hops = 1);
        Sat, 03 Mar 2012 09:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0kfNs9QEF6mHX+G+fhyd+NTr0sUV6xqE2M1N309dHAE=;
        b=P0CwChn5tk+Dgd88z6LJbSNvvdlfN7QKiFahsnFOTXTD6+MjT/HK2l40F9OR7GhnXU
         hjBd1AZEvKiRo7M4cTIENxX9OQozlN2lQP1+qM6t+381S1DL7+RXHZAlt+efACi42gfr
         wDNL1HoHnIvr2fqMTp81543d+RDq2mCDLLITlYRMY2p7prbeQV5nfvrCO63xi7AtFpKD
         lfCio7h/i+OK4CFjUfeMSaSFv1/Ttk0UU/Lv6Nmo420JDkorE54NzgnSGyroc1BF3s+7
         aOEKMVxQL8ACNgYMkU0ToKjp4W7NosXn1yvmCg33cH/CGrzpnvZ0rrqdwR9ADsn2OTIo
         /RLA==
Received: by 10.68.74.138 with SMTP id t10mr25860560pbv.126.1330796046355;
        Sat, 03 Mar 2012 09:34:06 -0800 (PST)
Received: from localhost (c-69-181-129-72.hsd1.ca.comcast.net. [69.181.129.72])
        by mx.google.com with ESMTPS id f5sm1135236pbq.43.2012.03.03.09.33.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 09:34:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vipim6rf2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192118>

On Sat, Mar 03, 2012 at 12:05:05AM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>>  test_expect_success 'confuses pattern as remote when no remote specified' '
>> +	'"
>> +	cat >exp <<-EOF
>> +		fatal: 'refs*master' does not appear to be a git repository
>> +		fatal: The remote end hung up unexpectedly
>> +	EOF
>> +	"'
>
>Please make it a habit to make your test script a cascade of &&, i.e.
>
>	... remote specified' '
>	cat >exp <<-\EOF &&
>        fatal: '\''refs*master'\'' does not ...
>	...
>        EOF
>
>No need to resend; I'll fix it up locally.        
>

Oops, I missed the && on that one.

What about the quoting of t6300's,

cat >expected <<\EOF
'refs/heads/master' 'Mon Jul 3 17:18:43 2006 +0200' 'Mon Jul 3 17:18:44 2006 +0200'
'refs/tags/testtag' 'Mon Jul 3 17:18:45 2006 +0200'
EOF

Do you want it like this,
	cat >expected <<-EOF &&
		'\''refs/heads/master'\'' '\''Mon Jul 3 17:18:43 2006 +0200'\'' '\''Mon Jul 3 17:18:44 2006 +0200'\''
		'\''refs/tags/testtag'\'' '\''Mon Jul 3 17:18:45 2006 +0200'\''
	EOF

or,
	cat >expected <<-EOF &&
		'"'refs/heads/master' 'Mon Jul 3 17:18:43 2006 +0200' 'Mon Jul 3 17:18:44 2006 +0200'"'
		'"'refs/tags/testtag' 'Mon Jul 3 17:18:45 2006 +0200'"'
	EOF

or something else?

Thanks,
TomG
