From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 3/3] git-add --intent-to-add (-N)
Date: Thu, 21 Aug 2008 16:23:52 +0200
Message-ID: <48AD7A78.2020907@gnu.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7viqtukbec.fsf@gitster.siamese.dyndns.org> <7v3akykb96.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 16:25:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWB5y-0003d6-Fp
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 16:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbYHUOXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 10:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbYHUOXz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 10:23:55 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:22107 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbYHUOXy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 10:23:54 -0400
Received: by ey-out-2122.google.com with SMTP id 6so695eyi.37
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=+Jeah3ePddOrlzXtYa3bz/9dOy7xTEQ1REdaZ0xOGbA=;
        b=O3Tntv7Cxy+hVgxUxm8Ek/0Q+csxUIQwi/aIoXGoGWfo7vlhq5UVWNFec1RXGslCiS
         HexYTGjz6IbQNX8mHrcKvY2A4fJdA/nBwHp+2TJkcy0JtqyZz7rhWFeugraPwsfL59nf
         40uqQtDcMMEk+fx8bYbFEUO7pSZ7mDQCBS65c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=seIbbfni8//HLt63VBxZEjmYw8o+RoHO8mFX8PxkFGJxtq98JleQuDMEA7AtZFvPbo
         0H7dd87xfHR063gWmaN6siwErHxKKzuafpv00sOfM5MvaJY6QpEOb72rwS606VBQQsvc
         hsv+VsyH/NkWYJjbYTzt19/vvr5OJCTSzgkLU=
Received: by 10.181.21.2 with SMTP id y2mr989027bki.44.1219328632229;
        Thu, 21 Aug 2008 07:23:52 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id k9sm8215236nfh.23.2008.08.21.07.23.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Aug 2008 07:23:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <7v3akykb96.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93155>

Junio C Hamano wrote:
> This adds "--intent-to-add" option to "git add".  This is to let the
> system know that you will tell it the final contents to be staged later,
> iow, just be aware of the presense of the path with the type of the blob
> for now.

While I like intent_* in the variables, what about "git add --path FILE" 
for the user interface?  Also, I wonder if it would be good to restrict 
"git add --path" to paths not already in the index, and give an error 
otherwise.

As I said elsewhere in the thread, I wouldn't use this feature (I keep a 
"git citool" window open to review my own changes, when I have to deal 
with new files), but I applaud its introduction.

> Then you can do:
> 
>     $ git commit -a ;# commit everything
> 
> or
> 
>     $ git commit oldfile ;# only oldfile, newfile not yet added

Did you mean "git commit" for the second use case?

Paolo
