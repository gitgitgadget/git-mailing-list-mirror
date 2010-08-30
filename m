From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] builtin/merge_recursive.c: Add an usage string and
 make use of it.
Date: Sun, 29 Aug 2010 21:42:59 -0500
Message-ID: <20100830024259.GC4010@burratino>
References: <20100829214648.GE1890@burratino>
 <9e0261a0eebe275e2ed1fa651e5ab80c35f6048c.1283120150.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 04:44:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpuMb-0000js-BX
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 04:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463Ab0H3Coo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 22:44:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36292 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299Ab0H3Coo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 22:44:44 -0400
Received: by ywh1 with SMTP id 1so1496506ywh.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 19:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/+BLbOznhtxSlvVbE3kChlDDIndkcwpsrYwmenPjPQM=;
        b=xQRq9mw4hEXnBWreKN06mWJCyWIjgiyx3YZYkegfLlvkT/4qDuzhnFlB7nfn+94a5+
         g9bliW3icfSWmmk9M71mqddtvHdQYCTHsqPD0PFEMA3DiqY4z5WuKTENtV3vIf+y6Ivv
         UOb/Kwmm+tsHo7SBS2lwoUa2fz+2ybcqLCJ4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WsBgFVE0mCJ3ZgWnUQ+XUR8dx8JZhZDipJxMCfWn0yiPU9ric6x4UAL40LVZbPMQyE
         wrQspn60+CF+w/UzXxgJUFLkBl/ulNBgDRE356jNac5fpbSEfrHJvv14SNGH2sqv6PIV
         yWh0m17kKbdRY9AVzqzSQo6WDpvrFlPG2D3PI=
Received: by 10.150.215.17 with SMTP id n17mr4847467ybg.44.1283136283210;
        Sun, 29 Aug 2010 19:44:43 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id d5sm3016340ybi.21.2010.08.29.19.44.42
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 19:44:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9e0261a0eebe275e2ed1fa651e5ab80c35f6048c.1283120150.git.tfransosi@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154755>

Thiago Farina wrote:

> The previous output for git merger-recursive was:
> usage: merge-recursive <base>... -- <head> <remote> ...
> 
> Now the output is:
> usage: git merge-recursive <base>... -- <head> <remote> ...
[...]

> --- a/builtin/merge-recursive.c
> +++ b/builtin/merge-recursive.c
> @@ -3,6 +3,9 @@
>  #include "tag.h"
>  #include "merge-recursive.h"
>  
> +static const char builtin_merge_recursive_usage[] =
> +	"git %s <base>... -- <head> <remote> ...";

Now that you've researched it, wouldn't it make sense to include an
explanation for this %s in the log message?

Still, ack on this part.

> @@ -37,19 +40,19 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
>  		if (!prefixcmp(arg, "--")) {
>  			if (!arg[2])
>  				break;
> -			if (!strcmp(arg+2, "ours"))
> +			if (!strcmp(arg + 2, "ours"))

My comment on the rest still applies: it is best if patches do not
contain unrelated changes to unrelated parts of the files they touch.
