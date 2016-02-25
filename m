From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Some strange behavior of git
Date: Thu, 25 Feb 2016 17:14:09 +0100
Message-ID: <20160225161409.GK1831@hank>
References: <56CE31F8.7090706@ip-5.ru>
 <20160225095755.GJ1831@hank>
 <56CED1F8.60601@ip-5.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Olga Pshenichnikova <olga@ip-5.ru>
X-From: git-owner@vger.kernel.org Thu Feb 25 17:13:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYyY4-0003kj-8c
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 17:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933105AbcBYQNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 11:13:48 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36318 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932938AbcBYQNs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 11:13:48 -0500
Received: by mail-wm0-f50.google.com with SMTP id g62so36036966wme.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 08:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rdoPuFXQVT2kgnJyHKLIJG1+RxWD5MsdmOV0ItEbibI=;
        b=lAO9n5c2uhr1Rq2tOLpavcAsahG9++H4xpr82UJs66kyi6UUWeP6Hu0DjrZU7IQGv1
         Z7ElLsngoO5RU/XDzSWZqYCEajpEX4I9PUUqNMHalGbkH4jClT7BTDNtn8IpVX23RZeU
         3+pUSOq6JpVEZku94d5mCwbPi6jUFuuifSvat2iCJAkJoBzVWrAXKG9xap0Tr5QDNmm+
         ZQV1ylTSC4RHv5hZupfhU62ClGppSjv4h84bfgtM8jms5do74FHP999i9A9++IbX7CHs
         pTdt89aRj0vUCVXMksOCA1VuTbtTKKvW9k+Tt3ZwXdxWpo8Tq5WMXaBmdRP8dihdJJ5g
         I/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rdoPuFXQVT2kgnJyHKLIJG1+RxWD5MsdmOV0ItEbibI=;
        b=M0wKll0Z0iSXrZGrv6j3aDLQWJmo+S+Tuzl8a1YPQKtcVJxUzKlfdQVv16oxPDnFKC
         JZljEvEVbPTXOZmqCarLIhVpCD2wSBgDcS2Rf6P7q8JxGbYlY22+GHWLKi2SyuKpI3up
         DOthjGyVmwfhubf0NNzTxlIrzsnjPjTc5K4QCb/CFzB/nTGfQaR1pHKP6tkCw1w7L4eS
         HIohBbr2CZJbdu7NYgLWMzozPvFZ2bT3YtlunZqRHmrS/QjPZPIVmReHD6vCPs8sY06Y
         cqvNzUG4RNbQl+ylo3HIhbt8rYcs8h73Dsfv4BE7970/RJI/sLOxTU3RIcupxnQV3nXZ
         vY2g==
X-Gm-Message-State: AG10YOTg2JTxCjiDXyl4EhKqmV7BwQVFbXOsUehVOh5gC+dCEebF8/Eu5X1gdtez/TnD2w==
X-Received: by 10.28.53.134 with SMTP id c128mr4650872wma.10.1456416826588;
        Thu, 25 Feb 2016 08:13:46 -0800 (PST)
Received: from localhost (host130-107-dynamic.40-79-r.retail.telecomitalia.it. [79.40.107.130])
        by smtp.gmail.com with ESMTPSA id n10sm7534631wjf.28.2016.02.25.08.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2016 08:13:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56CED1F8.60601@ip-5.ru>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287396>

[Please keep everyone cc'd in the conversation, especially the mailing
list.  I added it back for now.
Also please don't top post on the list]

On 02/25, Olga Pshenichnikova wrote:
> No, it isn't empty, but I found the problem.
> Problem was that I handled subdirectories structure in exclude file:
>
> design/dir1
> design/dir2
>
> But
>
> design/dir3 wasn't ignored and wasn't controlled.
>
> So, my problem take place when some sub directory both isn't ignored AND
> isn't controlled even if it isn't empty.

I think that's a bug, I think this directory should only be removed if
-x is given.  I haven't come up with a patch yet, but here's a test
demonstrating the failure.

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 86ceb38..0961007 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -653,4 +653,13 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
 	test_path_is_dir foobar
 '

+test_expect_failure 'git clean -d does not clean ignored files in subdir' '
+	mkdir -p sub/dir &&
+	>sub/dir/file &&
+	test_when_finished rm .gitignore &&
+	echo sub/dir/ >.gitignore &&
+	git clean -df sub &&
+	test_path_is_file sub/dir/file
+'
+
 test_done


> Thank you for response!
