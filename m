X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-0.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	LIST_MIRROR_BCC,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Mon, 20 Nov 2006 12:33:02 +0100
Message-ID: <200611201233.02581.jnareb@gmail.com>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com> <200611201154.08732.jnareb@gmail.com> <7vu00u2wln.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 16:51:03 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:resent-from:resent-to:resent-date:resent-message-id:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Z+KO1i6waKJLXj92N289TMCOjtvZ/uBQmNuEb3unAvhAmZzz9k4rbUTqeDs3npMbZwoExgij9agXbU+E32ewRaTE81RkPkmVRmGUs9vSiqoDhcGDmFJrpO9jgH+aYKPV/K6FIw3ErO7iz59Qn7c+ZGBlb/AUinMIQ/PcA+H/pOs=
User-Agent: KMail/1.9.3
In-Reply-To: <7vu00u2wln.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31920>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmCLt-0003oT-8b for gcvg-git@gmane.org; Mon, 20 Nov
 2006 17:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966153AbWKTQu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 11:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966135AbWKTQu1
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 11:50:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:41713 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966153AbWKTQu0
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 11:50:26 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1237223ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 08:50:25 -0800 (PST)
Received: by 10.66.221.6 with SMTP id t6mr7669469ugg.1164041420997; Mon, 20
 Nov 2006 08:50:20 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id e23sm4851185ugd.2006.11.20.08.50.20; Mon, 20 Nov
 2006 08:50:20 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> ... I mean you trust (use) reference
>> info from packed-refs, but don't trust lack of dereference in
>> packed-refs.
> 
> That is exactly what the code does (at least that was the intent;
> there could be bugs since I am not Linus ;-).

The question is: is it more common case to have very large number
of heavyweight tags, or is it more common case to have very large
number of lightweight tags (refs to commit objects).

In the latter case the solution to not trust lack of dereference
means no gain in performance (although for the core checking type
of object is faster (much faster?) than depeeling tag, so the gain
wouldn't be large), although the solution is probably safer.

Still, the decision: do not trust the lack of dereference in
packed-refs, or mark packed-refs as having dereferences and trust
lack of dereferences, is fairly orthogonal to the format for depeel
in packed-refs.


P.S. I have just noticed that you have taken the discussion
off-list...
-- 
Jakub Narebski
