From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 7/8] t5523-push-upstream: test progress messages
Date: Sat, 16 Oct 2010 19:46:13 -0500
Message-ID: <20101017004613.GG20883@burratino>
References: <1287254223-4496-1-git-send-email-rctay89@gmail.com>
 <1287254223-4496-2-git-send-email-rctay89@gmail.com>
 <1287254223-4496-3-git-send-email-rctay89@gmail.com>
 <1287254223-4496-4-git-send-email-rctay89@gmail.com>
 <1287254223-4496-5-git-send-email-rctay89@gmail.com>
 <1287254223-4496-6-git-send-email-rctay89@gmail.com>
 <1287254223-4496-7-git-send-email-rctay89@gmail.com>
 <1287254223-4496-8-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 02:49:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7HRg-0006yG-Ea
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 02:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757068Ab0JQAtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 20:49:46 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36833 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757022Ab0JQAtq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 20:49:46 -0400
Received: by ywi6 with SMTP id 6so894157ywi.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 17:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xBqd9VVN+QQU8lEU0QczF3o7lb68jKiqMDVL7Zj3ihc=;
        b=CKIvetbcEwXjg3DOT9uzWxYCgTPPIXUU2pE9Bdv41ApL+eltDY2IlxIDfC6xbEG6RA
         pqgPDyorwNvU4SN4Zrdx9RnpNLnCzrcKz5HfSb3vE+GCsOjCa7PxTOHwybJPwTdwBS7B
         rgCJdccRT/4gaK6ygtCVAHW0ENCD38vrMlIZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bFpHYK7v8YBfuUtln9gGmeva8LajgDEYYGNAML/YTHlfRcUJSxPbJvWAfKmbC3tCKF
         TsG0AM/+KS8mL36B0tzmiNyKmX8pnoggB819SAfNguUCkfjxK62MKu9mDi3O/8ru6yXh
         xUQQpQUZaNR4P1DsNhJrKJH5c22jgwCS5gmjg=
Received: by 10.100.172.10 with SMTP id u10mr114631ane.121.1287276585647;
        Sat, 16 Oct 2010 17:49:45 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id g18sm18862209anh.38.2010.10.16.17.49.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 17:49:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287254223-4496-8-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159181>

Tay Ray Chuan wrote:

[...]
> --- a/t/t5523-push-upstream.sh
> +++ b/t/t5523-push-upstream.sh
> @@ -70,4 +71,41 @@ test_expect_success 'push -u HEAD' '
>  	check_config headbranch upstream refs/heads/headbranch
>  '
>  
> +test_expect_success TTY 'progress messages go to tty' '
> +	ensure_fresh_upstream &&
> +
> +	test_terminal git push -u upstream master >out 2>err &&
> +	grep "Writing objects" err
> +'

Thanks for testing the usual case.  It is easy to forget sometimes.

The tests using the TTY prerequisite would need to use TTYREDIR
unless we simplify the latter out of existence.
