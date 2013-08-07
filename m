From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Wed, 7 Aug 2013 11:01:57 -0700
Message-ID: <4EE8B37B-F6A1-4BC4-9151-8546868E60A5@gmail.com>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 20:02:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V783j-0001GJ-MS
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 20:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932878Ab3HGSCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 14:02:03 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:43792 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756723Ab3HGSCB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 14:02:01 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so2433422pab.34
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=T2+JyApLV/dmVl/grP/a01Bq7eehc9VRMEwuHP8giCA=;
        b=o9nGSCdx5yiOJKS0UWrGE/fdTYNDISqQLjU0uhYTXPNlbMpNG+DYlP/oXkIlavvb47
         JSpBFXuT4HWxP9JBWv8AgGrfn1992zFKRqPb9IniSzb78Yc9EU2h7z5StvrQXUV59gEb
         9cPrqIKLSMO+3zRGglRNFjMn+7r3+/+G1FOedg/jm+qZ9AwdpJSRCIVg8f61wUYh15Ui
         bqTs6nPN+1bPet1fZ+CqzC30pvIM6vCxQ2Feur4NYWRRQjYw5FwrIg8GH+AjJIrK7uHU
         RlUtCAsdDsIpiprbrIgmt3e58mSk+XR753aYX7QTtmvgPY//XDPEIoYNsou9qkdQVpyz
         SQhw==
X-Received: by 10.68.170.37 with SMTP id aj5mr1934953pbc.79.1375898521090;
        Wed, 07 Aug 2013 11:02:01 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id pq1sm9484645pbb.26.2013.08.07.11.01.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 11:02:00 -0700 (PDT)
In-Reply-To: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231840>

On Aug 7, 2013, at 09:00, Ramkumar Ramachandra wrote:
> Hi,
>
> This is the difference between whatchanged and log:
>
> diff --git a/whatchanged b/log
> index fa1b223..004d9aa 100644
> --- a/tmp/whatchanged
> +++ b/tmp/log
> @@ -1,4 +1,4 @@
> -int cmd_whatchanged(int argc, const char **argv, const char *prefix)
> +int cmd_log(int argc, const char **argv, const char *prefix)
> {
>        struct rev_info rev;
>        struct setup_revision_opt opt;
> @@ -7,13 +7,10 @@ int cmd_whatchanged(int argc, const char **argv,
> const char *prefix)
>        git_config(git_log_config, NULL);
>
>        init_revisions(&rev, prefix);
> -       rev.diff = 1;
> -       rev.simplify_history = 0;
> +       rev.always_show_header = 1;
>        memset(&opt, 0, sizeof(opt));
>        opt.def = "HEAD";
>        opt.revarg_opt = REVARG_COMMITTISH;
>        cmd_log_init(argc, argv, prefix, &rev, &opt);
> -       if (!rev.diffopt.output_format)
> -               rev.diffopt.output_format = DIFF_FORMAT_RAW;
>        return cmd_log_walk(&rev);
> }
>
> Should we remove it?

I use it all the time.  Is there some log option to get exactly the  
same output?  It doesn't appear that there is.  The closest looks like  
"log --name-status" but it omits the modes and hash values.
