From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: t5505-remote fails on Windows
Date: Thu, 19 Mar 2009 11:00:50 -0400
Message-ID: <76718490903190800o4d82a037mb6fc5bf901c418d8@mail.gmail.com>
References: <49C0DE23.8020809@viscovery.net>
	 <20090319041837.GA32642@coredump.intra.peff.net>
	 <20090319044313.GA341@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0903191135530.10279@pacific.mpi-cbg.de>
	 <7vhc1pai84.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 16:03:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkJlr-0003ai-CK
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 16:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbZCSPAz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 11:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753937AbZCSPAz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 11:00:55 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:23196 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbZCSPAy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 11:00:54 -0400
Received: by rv-out-0506.google.com with SMTP id f9so603829rvb.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 08:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bcWKHDeASUlrn9b/7R3RZ+iA2zRZbKf1TM4lU+twp8s=;
        b=vTINU3KkQzd0kbOyfr2N1p4q68X/iiF3WxZbbQQRHcDNYQkgTTHXqBPXOFj5a61Jez
         kvHKatah0PHCLOqmUnqwKg6V4SDQoVzjChpYFe/lPpVL02CYTqSet+AUtZG7+thVtlkM
         HqOmZv1Et8O81CKowNzPe4zt29IlPQwKCXJeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JsT9EQqNICKexJxzKYQz2+WkAOWnBY3qch5MY0Y0KNEmZR3AmuDMMoIFRe9Ki4/kK1
         OvWaAOEQFVg5OXoZZOe6frOKbYknDHYNfIWB4aOQ8caiWFiMet1Vm84bxkAbLZFK3BER
         BzbefstIfF9+8vxEptAizY2rs9uuj7AJVYooM=
Received: by 10.140.187.14 with SMTP id k14mr829896rvf.270.1237474850588; Thu, 
	19 Mar 2009 08:00:50 -0700 (PDT)
In-Reply-To: <7vhc1pai84.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113775>

On Thu, Mar 19, 2009 at 7:02 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Do we really want an API for that? =C2=A0Calling qsort() directly sh=
ould be
>> obvious enough, no?
>
> I think so. =C2=A0If it were done like this (notice the lack of doubl=
e
> indirection in the cmp_fn signature):
>
> =C2=A0 =C2=A0typedef int string_list_item_cmp_fn(const struct string_=
list_item *, const struct string_list_item *);
>
> =C2=A0 =C2=A0void sort_string_list_with_fn(struct string_list *list, =
string_list_item_cmp_fn *);
>
> it would have made more sense, though.

Oh, wow, sorry, I didn't even realize Jeff had just added that
function. Somehow I missed that part of his patch.

j.
