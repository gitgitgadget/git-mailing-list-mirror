From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v5 13/15] compat: die when unable to set core.precomposeunicode
Date: Wed, 17 Feb 2016 10:14:57 +0100
Message-ID: <435511DD-0B0F-437F-974C-65C7265188A8@gmail.com>
References: <1455627402-752-1-git-send-email-ps@pks.im> <1455627402-752-14-git-send-email-ps@pks.im>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Wed Feb 17 10:15:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVyCW-00029k-Vz
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 10:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbcBQJPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 04:15:07 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35679 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030229AbcBQJPA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2016 04:15:00 -0500
Received: by mail-wm0-f48.google.com with SMTP id c200so202435777wme.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 01:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W8qrX+6UxiSCGYHe99SvLRVjgekf2x7AAPvSeJvYyiY=;
        b=PxyQcjRI9jyKGkE7W3tsNYWHiAN2uGzrzPcCmxViQN9NQezoobF5YyctOvdPwxnO+7
         GK3ni6B98zD+59BkrR077NWl0BMaUCfv+ouBp8L1+W+PqQ6BiTswIAMBhg+VzYJkztb/
         gxCJ0xfsTiCNZixDNVsRUJ6RMAJ/bQ1kecBqsRfVtyxrRdL3LmmYLmRMSYHXAMPAJEiA
         xUPp01UpJv4/IaEc6kekdPYd8+jnwqvHTrVrnBxCc2Bwk6i3c32h+rGbOYcQEUopVfnq
         m7MMUMc4xn6UK7y1cv/kT3YQdKHm2IpCX5+5vzGCbzJxURHFr9Czk8tbWvam5qUUomQk
         G6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=W8qrX+6UxiSCGYHe99SvLRVjgekf2x7AAPvSeJvYyiY=;
        b=X8k+yRk/kDF9DdA2kpPBw48VgPKd3GiOi17lzadIUwQz7Sdgxrk5EIgMhTWeg4sZof
         VN9ZgWdPhOV+NkM2jJlB4x+2JDaOHQehmFdFZqc/DQQBfEM6nVqq1xsPjcD+rA/ygLzU
         KIVPIkzwzfpeaBUolUmGnRXaI0LwddvA7bl96PWgovgqLCEF6Kcbp6YCDnl8FQm3GgbH
         GHMeYbA1waBs1Lis2RfiQeF8XvIFjSBT6QyHhxmtk6vPDcc+j19R5Zr9NKKlthkf7jdF
         fPgXo6dnGzx/DiI8neoTcseJ0sAxXdBb7/f/HhCw4i47yw9GHD9GtSUw1jzHKDWeuXgS
         rA6w==
X-Gm-Message-State: AG10YOT+8WMixL6zBYGLy+Wi6f8B+nt2XkY5n6HT20e2HJFgoWANiQinPmlgtY4oz6lY0w==
X-Received: by 10.28.173.208 with SMTP id w199mr2166583wme.45.1455700499946;
        Wed, 17 Feb 2016 01:14:59 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB412D.dip0.t-ipconnect.de. [93.219.65.45])
        by smtp.gmail.com with ESMTPSA id v66sm2054022wmb.18.2016.02.17.01.14.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 01:14:59 -0800 (PST)
In-Reply-To: <1455627402-752-14-git-send-email-ps@pks.im>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286489>


On 16 Feb 2016, at 13:56, Patrick Steinhardt <ps@pks.im> wrote:

> When calling `git_config_set` to set 'core.precomposeunicode' we
> ignore the return value of the function, which may indicate that
> we were unable to write the value back to disk. As the function
> is only called by init-db we can and should die when an error
> occurs.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> compat/precompose_utf8.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
> index 079070f..9ff1ebe 100644
> --- a/compat/precompose_utf8.c
> +++ b/compat/precompose_utf8.c
> @@ -50,7 +50,8 @@ void probe_utf8_pathname_composition(void)
> 		close(output_fd);
> 		git_path_buf(&path, "%s", auml_nfd);
> 		precomposed_unicode = access(path.buf, R_OK) ? 0 : 1;
> -		git_config_set("core.precomposeunicode", precomposed_unicode ? "true" : "false");
> +		git_config_set_or_die("core.precomposeunicode",
> +				      precomposed_unicode ? "true" : "false");

I haven't been actively following this topic, so I don't know much about
it. However, I just noticed that the topic might brake the OS X build?

https://travis-ci.org/git/git/jobs/109752716 

Cheers,
Lars

> 		git_path_buf(&path, "%s", auml_nfc);
> 		if (unlink(path.buf))
> 			die_errno(_("failed to unlink '%s'"), path.buf);
> -- 
> 2.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
