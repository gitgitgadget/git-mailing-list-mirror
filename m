From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 2/2] post-receive-email: deprecate script in favor of
 git-multimail
Date: Sun, 14 Jul 2013 23:02:45 -0700
Message-ID: <20130715060245.GD2962@elie.Belkin>
References: <1373789343-3189-1-git-send-email-mhagger@alum.mit.edu>
 <1373789343-3189-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Hiestand <chrishiestand@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michiel Holtkamp <git@elfstone.nl>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 15 08:02:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uybs6-0003U3-FJ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 08:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab3GOGCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 02:02:50 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:53629 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736Ab3GOGCu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 02:02:50 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so10907133pab.10
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 23:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6CG3Cd/SQPUfbyUrEqVN0uKxQQXP11p8ep48vkGmg6M=;
        b=WO4MMtzy1zyd4I3Eq1nlDLsU77XM4CM2gzcXqQV/YXks45xTFvy6LGWKaqSeXvUkvh
         V6RM+9XPeQy+D9b0VA/XX5KKWGe3cIscV43L0xXkFfKbARlcG5LMnXTt5NpdnqZnLGGu
         O8pQRfbS/wcun+JkkSjAJhq6df8iQPUZ+WL4IfRt5SU3sbOlifUevGLMqnekh7l8bC5q
         rsO6eUpuObA7UoLMr1N8sjAqIROoNAYqixwbVQdlJJF/NUMVjka/bC8B/tZqEHTFBXqb
         gsUF9uKHUHSAK9c4fmcrWnwCPYWVsfx49us1VbIqqb6laTGnXRDeqvd/lSHJyL4Oiwj1
         7cjg==
X-Received: by 10.66.139.227 with SMTP id rb3mr54128854pab.121.1373868169362;
        Sun, 14 Jul 2013 23:02:49 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id p2sm62414862pag.22.2013.07.14.23.02.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 23:02:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373789343-3189-3-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230421>

Michael Haggerty wrote:

> Add a notice to the top of post-receive-email explaining that the
> script is no longer under active development and pointing the user to
> git-multimail.

I think the spirit of this patch is sane.  Some thoughts on wording:

[...]
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -2,10 +2,19 @@
>  #
>  # Copyright (c) 2007 Andy Parkins
>  #
> -# An example hook script to mail out commit update information.  This hook
> -# sends emails listing new revisions to the repository introduced by the
> -# change being reported.  The rule is that (for branch updates) each commit
> -# will appear on one email and one email only.
> +# An example hook script to mail out commit update information.
> +#
> +# ***NOTICE***: This script is no longer under active development.  It
> +# has been superseded by git-multimail, which is more capable and
> +# configurable and is largely backwards-compatible with this script;
> +# please see "contrib/hooks/multimail/".  For instructions on how to
> +# migrate from post-receive-email to git-multimail, please see
> +# "README.migrate-from-post-receive-email" in that directory.

I think I'd say something like

(1)
	# An example hook script to mail out commit update information.
	#
	# This script is kept for compatibility, but it is no longer actively
	# maintained.  Consider switching to git-multimail, which is more
	# configurable and largely compatible with this script.  See
	# contrib/hooks/multimail/README.migrate-from-post-receive.
	#
	# This hook sends emails listing new revisions ...

or, if I wanted to emphasize the warning,

(2)
	# An example hook ...
	#
	# Warning: this script is kept for compatibility, but it is no longer
	# actively maintained.  Consider switching to ...

or, if I wanted to avoid seeming to promise that the script will be
around in the future,

(3)
	# An example hook ...
	#
	# Warning: this script is no longer actively maintained.  Consider
	# switching to ...

I prefer (2), which makes it clear to the reader that it is dangerous
to keep using the script (since no one is actively chasing down bugs)
while also making it clear why a potentially buggy script with a good
natural successor is still in contrib for now.  What do you think?

Thanks,
Jonathan
