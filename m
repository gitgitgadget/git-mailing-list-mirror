From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/2] sh-setup: Write a new require_clean_work_tree
 function
Date: Fri, 1 Oct 2010 02:40:39 -0500
Message-ID: <20101001074039.GC6184@burratino>
References: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
 <1285877017-8060-2-git-send-email-artagnon@gmail.com>
 <7v4od7hsqt.fsf@alter.siamese.dyndns.org>
 <20101001045713.GE20098@kytes>
 <20101001053721.GB6184@burratino>
 <20101001072149.GA24171@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 09:43:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1aHX-0003gu-UA
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 09:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102Ab0JAHnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 03:43:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36653 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab0JAHnp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 03:43:45 -0400
Received: by iwn5 with SMTP id 5so3490562iwn.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 00:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=l54ZR7XstN2fHWa19QFgfCPhi3jVwnyBaPGmjWBmSVs=;
        b=M5oom4p/s0P++KM/0hjQXbQmMdyggDeSsykfBP6R+V2eY4DnhFwV0Q+Brjm/drKbYO
         pyzWpcIx/UFdJ7TJkuvEB9L0Wu5wxfN9QO3+PNEm3S+fogpmRxoFhhbahy03dKAodsT6
         2M1wRPnwcUtZWzdgipTV8HCUT36583ySQWViI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=e985KgBWP6Ou90OFIZDkSegM9jj8cCsZrBXuIRmqIIRxg0jOVjMS/4czVSjHEsYFys
         j0/pbZN9bCQQJ+OpWD4fTjC1Rxa25uETbQLroqjeZsyCwlsQ3egg3jc43oRBGU5qnl+9
         Bfh96LJiwkCIWe7ID3QMASSzuhKkEE/iHVEBw=
Received: by 10.231.33.203 with SMTP id i11mr4803667ibd.8.1285919024951;
        Fri, 01 Oct 2010 00:43:44 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u3sm906756ibu.0.2010.10.01.00.43.43
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 00:43:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101001072149.GA24171@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157737>

Ramkumar Ramachandra wrote:

> Are all these tags useful?

Probably not. :)

> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -264,12 +264,25 @@ the change to its true author (see (2) above).
>  Also notice that a real name is used in the Signed-off-by: line. Please
>  don't hide your real name.
>  
> -Some people also put extra tags at the end.
> -
> -"Acked-by:" says that the patch was reviewed by the person who
> -is more familiar with the issues and the area the patch attempts
> -to modify.  "Tested-by:" says the patch was tested by the person
> -and found to have the desired effect.
> +Some extra tags you can use in the end along with their meanings are:

I like the old "Some people" phrasing; maybe we can get the same effect
(i.e., making it clear that you don't really have to use these) by saying

 If you'd like, you can put extra tags at end:

> +1. "Reported-by:" is used to to credit someone who found the bug that
> +   the patch attempts to fix.

Sensible.

> +2. "Acked-by:" says that the patch was acknowledged by the person who
> +   is more familiar with the issues and the area the patch attempts to
> +   modify.

Maybe liked or approved instead of acknowledged.

> +3. "Reviewed-by:", unlike the other tags, can only be offered by the
> +   reviewer and means that she is completely satisfied that the patch
> +   is ready for application.  It is usually offered only after a
> +   detailed review.

Yeah.  Linux's Documentation/SubmittingPatches includes a nice
"reviewer's statement of oversight" by Jonathan Corbet, explaining
what exactly a reviewed-by is and is not supposed to signify.

> +4. "Tested-by:" is used to indicate that the person applied the patch
> +   and found it to have the desired effect.
> +5. "Thanks-to:" is a more broad term used to credit someone who helped
> +   with the patch in some way. The person perhaps gave an idea or
> +   reviewed some part of the patch without awarding a "Reviewed-by".
> +6. "Based-on-patch-by:" is used to credit the person whose patch yours
> +   is based on. The original patch was probably not considered for
> +   inclusion due to several reasons.

These seem intuitive without explanation.  I suppose Tested-by is
common enough and worth encouraging, though.  In the end, a person can
put what they want.  (e.g. the mysterious Whatevered-by:
http://lwn.net/Articles/399052/.)

Anyway, thanks for clearing this up.
