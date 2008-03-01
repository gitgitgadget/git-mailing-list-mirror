From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 3/3] git-submodule: New subcommand 'summary' (3) - limit summary size
Date: Sat, 1 Mar 2008 20:42:46 +0800
Message-ID: <46dff0320803010442y12c1326dk45f53ce17453b53c@mail.gmail.com>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
	 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
	 <d6e82710452985611fb75c9d32a1b772bf0cb529.1204306070.git.pkufranky@gmail.com>
	 <18af168b52a735c33612c9c9e4778d8b8bef1cbc.1204306070.git.pkufranky@gmail.com>
	 <7v1w6u7vhf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 13:43:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVR3p-0006Sz-6N
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 13:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbYCAMmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 07:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755128AbYCAMmu
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 07:42:50 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:65199 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922AbYCAMmt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 07:42:49 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4907533wxd.4
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 04:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=55xGMnr4M93tMneK+jVlqhwL6vniwDqionoBvEcY7Vk=;
        b=nM5oOEk5hFYfaTiNFvmR1yyMtK1wApBoO4xpL8wDOks6rZgle+IbT8ryEfcJJe3L4j8s7bhw7dK4vlLVstM1XQ8GjViDH2/bmervLateNvw+5TLZloQ5Wiq65qiTi/ec09j/16AlHLlQULKRT/d5zvr3DluahgLoz51R9KdP1zI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q3EYh/w3AjT7sekg1KVtnrku1tuhSucoL7PQXm+wc8U0dCxA6jqZw2v6UHErEz41YAn+SRZFB70iMAjN4XjG5nKK0/n/6zf9zPTfV2sDKL2UdFhxnjfeRzTumCX30z6iTOnsXbupfUBTWP9UBu5mHDfb4Z9mW8oueeNXKOWGTtE=
Received: by 10.100.126.19 with SMTP id y19mr22663772anc.78.1204375366260;
        Sat, 01 Mar 2008 04:42:46 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sat, 1 Mar 2008 04:42:46 -0800 (PST)
In-Reply-To: <7v1w6u7vhf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75661>

On Sat, Mar 1, 2008 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:

>
>  > +             -n|--summary-limit)
>  > +                     if test -z "$2" || echo "$2" | grep --quiet -v '^-\?[0-9]\+$'
>
>  \?\+?????
>
>         summary_limit=$(expr "$2" : '[0-9][0-9]*$')
>
expr is portable?

>  or even
>
>         if summary_limit=$(( $2 + 0 )) 2>/dev/null ||
>            test "$2" != "$summary_limit"
>         then
>                 usage
>         fi
>

summary_limit=$(( $2 + 0 )) will always has return status 0
So i use
            summary_limit=$(($2 + 0))
            if test $summary_limit = 0 -a "$2" != 0
            then
                usage
            fi




-- 
Ping Yin
