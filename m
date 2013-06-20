From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] remote: make prune work for mixed mirror/non-mirror
 repos
Date: Fri, 21 Jun 2013 01:38:30 +0200
Message-ID: <1371771510.17896.61.camel@localhost>
References: <1371763424.17896.32.camel@localhost>
	 <1371766304-4601-1-git-send-email-dennis@kaarsemaker.net>
	 <7vppvgpfib.fsf@alter.siamese.dyndns.org>
	 <1371769636.17896.44.camel@localhost>
	 <7vhagspdfx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 01:38:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpoR3-0001TO-9I
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 01:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965611Ab3FTXid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 19:38:33 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:57798 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965269Ab3FTXic (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 19:38:32 -0400
Received: by mail-wg0-f42.google.com with SMTP id z11so121372wgg.3
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 16:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:x-mailer:mime-version:content-transfer-encoding
         :x-gm-message-state;
        bh=9Nv1yMtYN5GQVyCHN5rx6csqfHOdishEdoUaAfAjkcE=;
        b=l6fvLpc4ouDTSSH/QyJrdUFUlgraxWGC2FP6Fnu0qL/pD2I80rEqUbTfAC3DuJd9zY
         C0ZVydZO0uOfCz7I2j+cK63eISz47P0u5rgMbBBAxkfWzT/f9N4RwRPjGD0E5DR0mNxI
         SjJ5v1IvzOfccTag946RquN5AZWmxQwGK62vVOB5sOLG3Ut9DCneDufNBF7wy2W3QLEe
         KFqu51cT9saPV/fi6wWamHbtUmj5ZSBldyfybhK08dEDVz7O1xNzHk/kUEPY0baCT2XV
         LjGNsOGfKRPu9W37t2lo8pnKEVpHhEfWZ1PmbejSCqVbwbe5tCyMRiZJQHLMRpxM6Zxy
         NgqA==
X-Received: by 10.194.120.7 with SMTP id ky7mr7243171wjb.89.1371771511677;
        Thu, 20 Jun 2013 16:38:31 -0700 (PDT)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id fb9sm19412465wid.2.2013.06.20.16.38.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 16:38:31 -0700 (PDT)
In-Reply-To: <7vhagspdfx.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
X-Gm-Message-State: ALoCoQniR1HHhDkgbaQm28/k00Xs2WAd1TQHiQJtME1Hh9zR7Gz08tQsYPjrUU1Q/4smp0PlBleM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228561>

On do, 2013-06-20 at 16:30 -0700, Junio C Hamano wrote:

> Maybe there is a miscommunication.
> 
> 	$ git ls-remote git://github.com/git/git.git | grep remotes/
> 
> shows that that repository, your origin, has refs/remotes/github/html

Yes, I misunderstood you and see the problem now. Thanks for being
patient with me :)

> > Yeah, I'm starting to think this is not such a good idea. How about plan
> > B: issuing a warning when adding a remote with a refspec that also
> > matches another remote's refspec?
> 
> Surely that will make things safer.
> 
> > Or plan C: add a per-remote pruneIgnore setting that in this case I
> > could set to refs/tags/* refs/remotes/* as I know it's correct? Could
> > even be combined with plan B.
> 
> As I already said "I dunno", I am not sure if it is worth the effort
> to support overlapping RHSs of fetch refspecs, so between B and C, I
> would vote for B.

I'm halfway through cooking up a patch for B, as I agree that it will
make things safer.

I'd really like to have C as well though, would you accept a patch that
implements it?
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
