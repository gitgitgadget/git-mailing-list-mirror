From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rev-list: accept --format without argument
Date: Wed, 04 Aug 2010 09:39:23 +0200
Message-ID: <vpqocdiltck.fsf@bauges.imag.fr>
References: <1280310120-16852-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vlj8v7ftw.fsf@alter.siamese.dyndns.org>
	<vpqy6cvwovv.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 09:39:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgYZu-0008Lp-H6
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 09:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627Ab0HDHjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 03:39:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38379 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932602Ab0HDHjj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 03:39:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o747SrwA005992
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Aug 2010 09:28:53 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OgYZP-0001NP-No; Wed, 04 Aug 2010 09:39:23 +0200
In-Reply-To: <vpqy6cvwovv.fsf@bauges.imag.fr> (Matthieu Moy's message of "Wed\, 28 Jul 2010 18\:29\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 04 Aug 2010 09:28:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o747SrwA005992
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281511736.55666@B/cYviZxWVLmWeN1tlScnQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152564>

Any other thought on this? I don't care much either way, but we should
make the doc and the implementation consistant anyway...

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>> The documentation says the syntax is --format[='<format>'], match it in
>>> the implementation.
>>>
>>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>>> ---
>>> Not that it's terribly usefull, but better be consistant ...
>>
>> Hmm, I do not care too deeply either way as I do not expect anybody sane
>> to have used, nor learn from this patch and start using, --format without
>> any formatting specification, but it somehow feels that this patch takes
>> consistency the wrong way.
>
> The other way would be stg like:
>
> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
> index d78e121..9b6f389 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -1,5 +1,5 @@
>  --pretty[='<format>']::
> ---format[='<format>']::
> +--format='<format>'::
>  
>         Pretty-print the contents of the commit logs in a given format,
>         where '<format>' can be one of 'oneline', 'short', 'medium',
>
> But I'd say it's simpler to be able to say "--format is an alias for
> --pretty" than "--format is an alias for --pretty _except that ..._".
>
> And actually,
>
> git rev-list --format
>
> is not that stupid if you read it as "list revisions and do some
> formatting as you do it".
>
> (but I don't care much either ;-) )

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
