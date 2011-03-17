From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [RFD] Expanded Pretty Format Placeholders Proposal
Date: Thu, 17 Mar 2011 20:57:34 +0000
Message-ID: <1300395454.2004.9.camel@walleee>
References: <1299804441.6220.1.camel@walleee>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 21:57:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0KGQ-0005yX-CZ
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 21:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab1CQU5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 16:57:41 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:43104 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab1CQU5k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 16:57:40 -0400
Received: by wwk4 with SMTP id 4so502142wwk.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=plui1gCvKKdA7c9HnO7R+3C67sbbz+b+FFKcTTnl6Iw=;
        b=pvNz/EBLkY7XnjHcxLAfe8Ufl7n9L7bi/Bgvyfdg0nSD5+jwp9zEJEPQM/SBblNFUB
         J+/hGc7AR8kP2pDLjBa2xSu8t7vVYGxkB14Tp6MLembL8tNFO1GbVse395pW8KSivp8n
         3Hvn5yG7JGPNZl7kKI0D9XuNEM1yzjJIRm+YI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:in-reply-to:references:content-type:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        b=ND9KCzArF6QnByqJUuacTRKQhEMNPt5Jyte5oRGvmropmKreLxpSFho3HMJ9SagdUe
         Rr4QM1HR1QJoQQB5OZp15eD5hBbY8873TQa2pUVqO2eKoIgOadd2o2HaaeauzfqC+uvs
         AqSEXT4dU5UezNGAhIpMnip4TkOB36GPCHXhw=
Received: by 10.216.144.205 with SMTP id n55mr1397351wej.5.1300395458573;
        Thu, 17 Mar 2011 13:57:38 -0700 (PDT)
Received: from [192.168.0.2] (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id r57sm1280827wes.25.2011.03.17.13.57.36
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 13:57:36 -0700 (PDT)
In-Reply-To: <1299804441.6220.1.camel@walleee>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169278>

On Fri, 2011-03-11 at 00:47 +0000, Will Palmer wrote:
..snip
> For my own purposes (conditional formats), I'd like to see the ability
> to embed an entire sub-format within a placeholder. Clearly this would
> complicate the parser quite a bit (we wouldn't be able to just look for
> a closing ")", for example), but I think the flexibility makes it work
> it. To achieve this in terms of a specification to shoot for, we can
> simply say that any embedded "%(" must be terminated by its own ")" to
> be valid. eg:
> 	%(foo-condition: %(format: %H, aka %h), %H )


of course, this conflicts with the need to embed a literal ")" within a
sub-format. The simplest option for this would be to either allow %) as
an escape, as with %%. Even simpler, of course, would be %x29, but this
seems needlessly obscure. The only objection I have to %) is "It's
ugly". To me, %(format: "this is a paren: )") is easier to read, but
that would just be moving the problem around, adding the necessity of
the just-as-ugly-or-moreso %", or alternatively C-style \" and \\.
So I think that %) will be the best option.


> 
> -- Will
> 
