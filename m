From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: sparse fetch, was Re: [PATCH 08/12] git-clone: support --path to do sparse clone
Date: Fri, 25 Jul 2008 10:14:16 +0200
Message-ID: <bd6139dc0807250114qc1c6cf5ufa7df0862507010d@mail.gmail.com>
References: <20080723145718.GA29134@laptop>
	 <20080724171952.GB21043@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807241837441.8986@racer>
	 <20080724185332.GQ32184@machine.or.cz>
	 <bd6139dc0807241201v50cd5ef2m58ee7efc05119e20@mail.gmail.com>
	 <alpine.DEB.1.00.0807250210090.4140@eeepc-johanness>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, "Jeff King" <peff@peff.net>,
	"=?ISO-8859-1?Q?Nguy=3Fn_Th=E1i_Ng=3Fc_Duy?=" <pclouds@gmail.com>,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 10:15:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMISP-0000WB-Sm
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 10:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbYGYIOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 04:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbYGYIOT
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 04:14:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:12673 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbYGYIOR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 04:14:17 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3957277wfd.4
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 01:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tcs3zZ2I/mJ3pLFdVIoZlgvcOTU/afiE9pZs1bryVXw=;
        b=C9YJ8wZVZ/yBRqdFUxJxFwcEPP6dyusu/8qwmcLLqO2IP/kglyV15TUjNdmlOH7Kgb
         60p5p1eBHOWLorz7IapP8UowZCeEKpxw/eQ2JkVSKGujb7fXwMbjSiJHOegUnGBL87H/
         n8IfD2Te3m/u423+QOdcPmaguKgBXqY8sOAvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=qGbnO2oj0k8GEvGr02X8Nx/8Us8ck7YM6gWewQuYHl0FPCDoez8XOVv73prncG1jn3
         IE1gR7pPlcm7FLJY8YtZg5lFaB7JubH1v1vvadH/kF4m4Ws92v4j8eOiUoUOi7Ad7H2Y
         00d0aAna1+2sodH9Q7L1e5LAOdEo+eJrvY7xs=
Received: by 10.142.229.5 with SMTP id b5mr446389wfh.280.1216973656749;
        Fri, 25 Jul 2008 01:14:16 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Fri, 25 Jul 2008 01:14:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807250210090.4140@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90010>

On Fri, Jul 25, 2008 at 02:12, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 24 Jul 2008, Sverre Rabbelier wrote:
>> Wouldn't that be as simple as passing a pathspec to git-rev-list? Not a
>> lot of overhead there I reckon.
>
> So the server would _not_ have to deflate the objects to inspect them?  I
> thought you knew more about Git's object database.

Nope, I did not know this. I thought that the server already had to do
all that to decide what to send, since not every request asks for the
same pack (someone might not have updated in 2 month, or someone might
might be up to date, or anything in between).

>> Just keep them?
>
> You'd still have to inspect the objects, which is way more work than the
> current code has to do.  Remember: in the optimal case, upload-pack does
> not more than just serve the existing deltas/base objects.

Ah, I can see how that would produce overhead then.

-- 
Cheers,

Sverre Rabbelier
