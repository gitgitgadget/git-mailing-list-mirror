From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Tue, 30 Oct 2012 07:58:59 +0100
Message-ID: <CA+EOSB=Rr8czjVJfA+F6DmHjDUBy0QQ-wd4t-3Uwb1Ksoadr0Q@mail.gmail.com>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 07:59:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT5n8-000515-U2
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 07:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993Ab2J3G7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 02:59:00 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:48113 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab2J3G67 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 02:58:59 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so7767675iea.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 23:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=pqRY8HBdpiF6ogp0+vbTWXU6BNjeg/82AX1Jh+05Iuw=;
        b=X9WFTxVxohSQUh3WfwaJ/QU5Xa+k7FtJhTo4HG5yKAwcfhVTbfLY653LlzpokKO5AD
         0V5oGmZNNhGwmuZYy4HIDdyxCEz1n7Z6CITRXbcVSBt5VsFqZg0Ga/WDq7zVKDaSmH/J
         t5cWgUXbfhj8vgnlyVPQvUiLAoq/wVhrj/HHQsjk/KC1CKi2k6Vq/rPKBUv3QfJWFHXA
         sXHZCumN7Kwz4qmmIwH3c2jWf9NCke7vwZR4kYUJH8+DhTsw9ojWaBAVw3AHhirf0p2i
         vxTaKOoPBGaNy4HOpeXt+gdMpd3PtisUySHSWWiVfqWP5xNzOZxqgEQX8LCQgK4ovSN9
         xtGg==
Received: by 10.50.236.39 with SMTP id ur7mr598281igc.26.1351580339270; Mon,
 29 Oct 2012 23:58:59 -0700 (PDT)
Received: by 10.64.176.237 with HTTP; Mon, 29 Oct 2012 23:58:59 -0700 (PDT)
In-Reply-To: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208681>

The shell word splitting done in base is a bashism, iow not portable.

Best

2012/10/30, Felipe Contreras <felipe.contreras@gmail.com>:
> No reason to use the full path in case this is used externally.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/test-lib.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 514282c..5a3d665 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -389,7 +389,8 @@ test_done () {
>  	then
>  		test_results_dir="$TEST_OUTPUT_DIRECTORY/test-results"
>  		mkdir -p "$test_results_dir"
> -		test_results_path="$test_results_dir/${0%.sh}-$$.counts"
> +		base=${0##*/}
> +		test_results_path="$test_results_dir/${base%.sh}-$$.counts"
>
>  		cat >>"$test_results_path" <<-EOF
>  		total $test_count
> --
> 1.8.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Inviato dal mio dispositivo mobile
