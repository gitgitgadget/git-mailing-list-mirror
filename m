From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Thu, 28 Jun 2007 18:31:50 -0700
Message-ID: <31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Sam Vilain" <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Jun 29 03:31:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I45L0-0005ds-7D
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 03:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764917AbXF2Bbw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 21:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764132AbXF2Bbw
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 21:31:52 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:60976 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764074AbXF2Bbv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 21:31:51 -0400
Received: by wx-out-0506.google.com with SMTP id h31so701540wxd
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 18:31:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jWQ2GIcMXVGwKN6xNTegGLC98MTvtTP+cdOxKpSgt1U7Exv1zptkNDA6Ug2ZFthqZt+1DuOF+niTnXorWWCA3BFBu1UF26eD07us4LPpIOFvhtwDUR5x1qor297KW0U6Rh36NALiHcVQMnMTJJmKDMncG+CkjZ9n6H1nOOTgzJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YRhlOsnhK+NGnxd15pgvXNP2edLwPO68+hTAEfIaY5KPNELlm7m2Emgmfnrffg1T/7Ciif0RvwylJ4R9T+qxFobZlRVGjmgIkIizsKF1Z+yjJtDUKNPNxK/YPdMvxhs/RUadJ9ismgHUCWpQIxGJ7LlY3VCU7yyQpWrMaMMlAXw=
Received: by 10.90.116.6 with SMTP id o6mr2677216agc.1183080710704;
        Thu, 28 Jun 2007 18:31:50 -0700 (PDT)
Received: by 10.90.54.18 with HTTP; Thu, 28 Jun 2007 18:31:50 -0700 (PDT)
In-Reply-To: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51143>

On 6/28/07, Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> There was emerge already but I much prefer this mode.
>

I beat ya to it: http://marc.info/?l=git&m=118301192520295&w=2

But it looks like maybe you did a better job (updated docs, for
example). Other than that, it's almost exactly the same.

Ack.

Jason

P.S.

doing this:
>      if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
>         merge_tool_candidates="$merge_tool_candidates emerge ediff"
>      fi

and then this

>     merge_tool_candidates="$merge_tool_candidates opendiff ediff emerge vimdiff"

makes this

>      echo "merge tool candidates: $merge_tool_candidates"

print out emerge and ediff twice, presumably because we're adding it
in for both "visual" emacs and "regular" (i.e. -nw) emacs. I suck at
shell scripts, so I'm probably missing something but what why do we
have all of that testing for emacs + vim if we just add their tools
anyway right afterwards?
