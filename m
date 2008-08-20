From: "Don Zickus" <dzickus@gmail.com>
Subject: Re: Stange diff in "mailinfo: re-fix MIME multipart boundary parsing"
Date: Wed, 20 Aug 2008 09:10:11 -0400
Message-ID: <68948ca0808200610v6d81228fiabf0317ee4ae6ec5@mail.gmail.com>
References: <e5bfff550808191038u645cf4baldca5c2c4bbd02162@mail.gmail.com>
	 <48AB0805.1020309@gmail.com> <48AB0983.2050706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"git mailing list" <git@vger.kernel.org>
To: "Marcus Griep" <neoeinstein@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 15:13:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVnTF-0006Ba-58
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 15:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbYHTNKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 09:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754384AbYHTNKN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 09:10:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:11979 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbYHTNKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 09:10:11 -0400
Received: by rv-out-0506.google.com with SMTP id k40so448620rvb.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 06:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ts5ANzIMPXFACJPB8rwE6KIDN0VMDItcn3SQXZKDQs8=;
        b=tpG6/A3X+ItNoxBTg3JymhsSZoBQIEvIXvXJOYdKCcjJ/oUDyQxeThwV3V8ejq7R4f
         LAvXSpC7XnWzcS05GHQq42h4PvMRGDHnjAfsELJtDZn873qm3cvY8iQkdDns3tKRbYZE
         PliomnFgSJVyO6Jv0+835xA16tOvBMum714k8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=j1F04+z6vAWkJzVBr3MFzHaABSTKcX+reZX8vYykAFkrra/jfQxbLTisMunjJCQGnD
         VArXK7OPBUqncg9XdMrk44eV+0siF8ciJ+T+qqYFMq6e4huUQysyFZZ0xcvKzYQd8WIp
         k56Jm7/DBikE022oLMFbRVdsbIAsyiPuAmpng=
Received: by 10.141.211.13 with SMTP id n13mr21365rvq.184.1219237811424;
        Wed, 20 Aug 2008 06:10:11 -0700 (PDT)
Received: by 10.140.162.10 with HTTP; Wed, 20 Aug 2008 06:10:11 -0700 (PDT)
In-Reply-To: <48AB0983.2050706@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92987>

On Tue, Aug 19, 2008 at 1:57 PM, Marcus Griep <neoeinstein@gmail.com> wrote:
> Marcus Griep wrote:
>> It looks like an empty line added to the end of the file.
>> Unsanitary, but ok since it comes after the last MIME
>> multipart boundary.  Junio could probably just ax the change
>> to sample.mbox from the patch before applying it.

No the change was intentional.  In fact, because that extra line was
not there, a bug was hidden.  Adding the extra line exposed the bug
and hopefully will catch any more bugs in the future with regards to
the boundary code.

>
> Or I could have misunderstood the intent of the change, and it
> is necessary to fully test the change, since it appears to
> operate line-by-line, an empty line at the end would be necessary
> to trigger the code path that stops mailinfo from looking for
> another boundary.

Yes, exactly.

Cheers,
Don
