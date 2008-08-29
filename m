From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Re: [PATCH 0/2] Use %as and %cs as pretty format flags
Date: Thu, 28 Aug 2008 19:10:45 -0500
Message-ID: <d77df1110808281710r6d58739fl2acb93e1940c7433@mail.gmail.com>
References: <d77df1110808280409o9445f9fybcab2c8d1066a8d8@mail.gmail.com>
	 <20080828231547.GD29609@coredump.intra.peff.net>
	 <7viqtkd84s.fsf@gitster.siamese.dyndns.org>
	 <20080828235420.GB30195@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 02:11:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYrak-0005fj-6r
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 02:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbYH2AKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 20:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754426AbYH2AKu
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 20:10:50 -0400
Received: from qb-out-0506.google.com ([72.14.204.224]:40735 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbYH2AKt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 20:10:49 -0400
Received: by qb-out-0506.google.com with SMTP id f11so1210852qba.17
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 17:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WeHFlw6NBqul+BK+q71jUB+O3vekSCj+UWLu3XF2LJU=;
        b=DH18AGYnh5hZY0zpuO/WAS9bpA5ed1dLGg93bWvZmV+iZyfNVlvgKgX/G2/EhgGD5z
         7++p24Bk9BhLWAqadxoWO0bs52Xd3ljQXR2rNv/l0xhQJNUy0sk/INlv4N7lMqS36KIh
         eQJn25REpH42ZVG1d/1fkqMlBX8spMrePRcy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kNbOC2smWXP1la7SO8rMoGdbCYkWa4yTm8kfHzQMISXypQBmbMSRAO1f4eOIAB9I0m
         g1H1+x9RmVkGnR4yJZjsGCswywlyzNayh0eRCyFRNxG2oJpL0+N+EujH3RO3Sn5ZQeQj
         ReyogbcWrKKRNUxqCT972ckpRCBX0k0Ti5tUg=
Received: by 10.66.221.6 with SMTP id t6mr3974411ugg.55.1219968645927;
        Thu, 28 Aug 2008 17:10:45 -0700 (PDT)
Received: by 10.66.234.6 with HTTP; Thu, 28 Aug 2008 17:10:45 -0700 (PDT)
In-Reply-To: <20080828235420.GB30195@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94230>

On Thu, Aug 28, 2008 at 6:54 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Aug 28, 2008 at 04:36:51PM -0700, Junio C Hamano wrote:
>
>> I was actually thinking about rejecting this, asking for something that
>> allows to express all the other %[ai][dDri] format can express, and
>> perhaps more.  So I think "%ad(short)" is a good direction to go, except
>> that 'd' is already taken.  Perhaps %a(date), %a(shortdate,local),...?
>
> I was thinking we could accept %ad _or_ %ad(short), but of course
> introducing the latter can break existing "%ad(my other random text)"
> which is a bad idea.
>
> I really think some consideration should be given to introducing
> arbitrary "arguments" to formatting specifiers, of which this is one
> example. Another that has been mentioned is pulling an arbitrary element
> from a list.
>
> How do you feel about a brand new syntax (and supporting the old, of
> course) that is syntactically a little easier to extend. Like:
>
>  %(macro, key=val, key=val)
>
> e.g.
>
>  %(authordate, format=short, tz=local)

The genesis of this patch was the documentation says that %ad
represents 'author date' without any more specific information.  I
thought that I could do

git show --date=short --pretty=format:"%ad %h"

and get the date in short form---but alas, this did not work.  So I
wrote up the patch to get a short date format.  Your ideas are much
more powerful.  I like them.

Thanks for git.

Nathan Panike
