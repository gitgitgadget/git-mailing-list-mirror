From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 0/3] attributes
Date: Fri, 13 Apr 2007 17:02:17 +0200
Message-ID: <81b0412b0704130802n185bd009l8c72a1dd6c00eb16@mail.gmail.com>
References: <7vslb4d4wv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 17:02:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcNI6-0008Iq-98
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 17:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbXDMPCT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 11:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754030AbXDMPCT
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 11:02:19 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:37689 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbXDMPCS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 11:02:18 -0400
Received: by an-out-0708.google.com with SMTP id b33so939861ana
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 08:02:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dd4b61VH3Hca/d4H+TeOsbFIhtH58bLFzlxyy7Ppjka6qWd5B0uUqEfCOZvxA3cGidE4fkkXs2pcPScewL6srGV3RlTAcEcX5l8lB5JeBUEXpTl06GjlM0BayuHTI1yAA5YOr/RkDkJqKkIyfmUdKdwlViYZfp/HW4goKxBoIi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R6QJSBqdeBOzqDnBf54pnRSIyT/HkUMnbaw4WaNdA6Y6qEtimwM9og0QKGbjPnuR/7jkoQP2wcgbHXDa3QoSNtqaIQ3V1zl44FLYlIbhRNxhte+8rDIo11xjeaAeEhZXyd6sqZ02J28Xr7hn8gSAblDOE5hpqm6zMp/EBtbXFNU=
Received: by 10.100.154.13 with SMTP id b13mr2559932ane.1176476537620;
        Fri, 13 Apr 2007 08:02:17 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Fri, 13 Apr 2007 08:02:17 -0700 (PDT)
In-Reply-To: <7vslb4d4wv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44409>

On 4/13/07, Junio C Hamano <junkio@cox.net> wrote:
> So, you can express:
>
>         *       crlf !nodiff
>         *.[oa]  !crlf nodiff
>         *.ps    nodiff
>         t/*.ps  !nodiff
>
> to mean:
>
>         In general, I want all files to undergo autocrlf
>         conversion, and I do not want to disable textual diff
>         output for them, but files whose name match *.o or *.a
>         are binaries so do not touch them with autocrlf and do
>         not show textual diff for them.  Also, I do not want to
>         see diffs for *.ps files because I cannot read
>         PostScript, but I do want to see diffs of PostScript
>         files in t/ directory.  In either case, PostScript files
>         undergo autocrlf conversion.
>

I'd suggest to extend git-ls-files with a switch listing the
files with attributes (and their attributes, of course).
Will help to diagnose problems with attribute assignment.
