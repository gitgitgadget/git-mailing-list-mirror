From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 16:58:16 +0200
Message-ID: <e5bfff550707150758h7a9e893frb068d4a9508bc3b2@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550707141346q2eba4ab8ka1c85e8b5a2c1b1d@mail.gmail.com>
	 <20070715093529.GD2568@steel.home>
	 <e5bfff550707150306t3196f723ia3071ac301fb3f24@mail.gmail.com>
	 <20070715104858.GG2568@steel.home>
	 <e5bfff550707150432v780d8361yba2fc729504d5b73@mail.gmail.com>
	 <e5bfff550707150529l7e9bdd9fu253d38f99d4d2ed7@mail.gmail.com>
	 <20070715083529.6855a858.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Jul 15 16:58:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA5YM-0002RV-U1
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 16:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758028AbXGOO6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 10:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758116AbXGOO6S
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 10:58:18 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:34595 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757377AbXGOO6R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 10:58:17 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1283152wah
        for <git@vger.kernel.org>; Sun, 15 Jul 2007 07:58:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZKf5g24YeLYyC1WbPOxDzVjEtaln9YQG8F8mxMBCLEZFH9BLWi0HKVLpbTRdCIohZQGA5aqSynQs/rdh0U7tekQK21JmbKE/5HQXkBia0lKZ/n4nkZS6hHQBsN0oodlrJfo08OlqBqYC6XR8xfdMeWRF/I66kNIYUOBDEjQj8JE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pP/eh6WWOoHfAK5jqcmgfMQJG5+DSBMJ7fYEBE0suc+KforvlS9uMPhwOLv1efebip4acBjI3EqMnOsMLebMYqTtYZru5hD8TGcDlbxUMJXPGhA6Rb/FlwtLqxrHpHtb7qJVw3W+6UF6GvkqQL2b+MXgLaWFi0Hg1we1w884+9s=
Received: by 10.114.170.1 with SMTP id s1mr3346768wae.1184511496509;
        Sun, 15 Jul 2007 07:58:16 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 15 Jul 2007 07:58:16 -0700 (PDT)
In-Reply-To: <20070715083529.6855a858.seanlkml@sympatico.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52562>

On 7/15/07, Sean <seanlkml@sympatico.ca> wrote:
>
> If you only look for ^\0 (ie. first position only) the parsing should
> be okay.  Not that it helps with the performance issue you're trying
> to address.
>
revisions are streamed, there is only one first revision, all the
others are linked togheter in a big stream.

Actually I ended up looking for the character after the '\0' (if any)
to be 'c' that is the beginning of "commit <sha> ....." but it's a bit
hacky.


Marco
