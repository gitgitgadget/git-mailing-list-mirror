From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: git rebase --interactive squash/squish/fold/rollup
Date: Wed, 17 Jun 2009 18:48:35 +0200
Message-ID: <4A391E63.6000206@gmail.com>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com> <7vvdmurfao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:49:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGyJk-0000pN-0v
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 18:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355AbZFQQsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 12:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbZFQQsp
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 12:48:45 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:52536 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbZFQQsp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 12:48:45 -0400
Received: by ewy6 with SMTP id 6so672382ewy.37
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=b3s1O9zxtbhNwptfOwbWfy5GjS9Snc4zHKi1RIH86m0=;
        b=dFW5ghOGFKLpQ+rn2GFH/+QHxlsgH3oMEZL06NJKypCx2dGD7RRXyW8NSjudcYgD6u
         M9WDELmtSsCvK48i4uGG7rtsOLub6w1GM8AbF+bXX92Au7h5X2xsbDL4+3bUNRBBEZon
         UZwpjVhIstNiKq6Cr5wG87CzHU34Ag4SBcUo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=KHmtrjHP3uWHbCR5D8r40kWODV0lc8DUYrjTj5r4bLg9+p3vl8xUTliIN0R1y7aw4d
         qxioO7VamFAV4yM+mPdHKjgOQkjJiRBUt0PswwgnTNlbbAj2v4ImeIqX0JNPvBQsyLy+
         Ecfuq12q5T+q+2fH5PAEaL1GPOXDWfr1A/U34=
Received: by 10.210.56.2 with SMTP id e2mr3133381eba.42.1245257326719;
        Wed, 17 Jun 2009 09:48:46 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 10sm111702eyz.21.2009.06.17.09.48.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 09:48:46 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <7vvdmurfao.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121760>


> So I can see why a variant of "squash" that does not change (nor even ask
> for a replacement of) the commit log message from the one that is being
> amended could be useful.

One way could be to have arguments to squash in a way that was proposed 
for the sequencer GSOC project last year.  For example,

commit 123456
squash -C HEAD abcdef

would just proceed with the commit of HEAD, and since squash is 
basically apply-to-index + commit, the HEAD would still be 123456.

Paolo
