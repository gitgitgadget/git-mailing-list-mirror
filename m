From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 2/3] parse-options: add PARSE_OPT_CUSTOM_ARGH for complicated
 argh's
Date: Mon, 18 May 2009 00:08:27 -0700
Message-ID: <4A11096B.8020208@gmail.com>
References: <1242557224-8411-1-git-send-email-bebarino@gmail.com>	<1242557224-8411-2-git-send-email-bebarino@gmail.com> <7vd4a7ey4h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 18 09:08:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5wxj-0000uR-8m
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 09:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199AbZERHIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 03:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbZERHI3
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 03:08:29 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:6277 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbZERHI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 03:08:29 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1050361wah.21
        for <git@vger.kernel.org>; Mon, 18 May 2009 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PKeY7noFYv4NZMoObcKU1RN18wpYoI2QOYFLBMPsGGM=;
        b=eM3azAR5e+K+Ot6+WPW0s/s7jJaof4x2dRf/9siWPMjQMR9wQS20SFXThXdOax8Hsg
         KeDtvmITMotPcG4T6g+ZFl19kKLVy7hRIaRCi0ob+1NB0nzNNwLPUmUyA58GVLzbbrGQ
         uRfOeMQU9DTwzqw/hOXBGIGikhWQXQKqLHohM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=lGejYcZ8C44uB3UAPTSjEexF9YtTaCDlIw/ySdoBWh8kr9JO0CkMl93FzOL3DvJGvS
         CX7UjVNMGAjlr8F9DnZCDzJ/OiUhUK294LCUuXqw957xo6D3jvx7ONBtJw6NmcegQsVV
         KsZUyj601jdHwT+nkvENRLfmZFZCYzBsa3oH4=
Received: by 10.115.47.1 with SMTP id z1mr10616015waj.133.1242630510038;
        Mon, 18 May 2009 00:08:30 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id m28sm4584514waf.2.2009.05.18.00.08.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 May 2009 00:08:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <7vd4a7ey4h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119421>

Junio C Hamano wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
>> If argh is complicated, i.e. the option takes more than one argument,
>> don't add the brackets around argh in the usage message.
>
> I think later user wants a bit more descriptive explanation, like...
>
> 	Usually, argh element in struct option points at a placeholder
> 	value (e.g. "val"), and this is used to show
>
> 	    --option=<val>
>
> 	by enclosing the string inside of angle brackets.
>
> 	When the option takes something more complex (e.g. optional part
> 	separated by comma), you would want to produce a help that looks
> 	like
>
> 	    --option=<val1>[,<val2>]
>
> 	In such a case, the caller can pass a string to argh with
> 	placeholders already enclosed in necessary angle brackets
> 	(e.g. "<val1>[,<val2>]") and set this option.

This description sounds nice ;) Is PARSE_OPT_CUSTOM_ARGH a good name? I
was thinking maybe PARSE_OPT_MULTARGS is better?

> Please update Documentation/technical/api-parse-options.txt as well.

There's no documentation on the flags yet, but I suppose I could add that.
