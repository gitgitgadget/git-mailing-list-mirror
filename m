From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v11 12/13] tag.c: implement '--format' option
Date: Mon, 17 Aug 2015 14:38:33 -0700
Message-ID: <CA+P7+xr5C2DfAKtb-BDKUGW=4LB4ZRfO6wg=N-8APVNaCEgR5Q@mail.gmail.com>
References: <1439661643-16094-13-git-send-email-Karthik.188@gmail.com>
 <xmqqwpwtd9d0.fsf@gitster.dls.corp.google.com> <CAOLa=ZSvJ7WO9XADUtZkm=QK6S3n1KRcG4nLpPLKnZUxQ+BrJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 23:38:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRS7N-0006sp-Vm
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 23:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbbHQViy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 17:38:54 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34221 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbbHQVix (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 17:38:53 -0400
Received: by iodb91 with SMTP id b91so166935061iod.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 14:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TT/QKcmpZH40AmTyvcD3LGvccI461HCdDNTK8oym9/w=;
        b=NN0mtgKKQso18QoCfTfbGBUwSijRPElW4N2I/aAdnt5OoUkRCOvoB5b7oZf4Fh834N
         LZf8C7Tot2xCN7Adr3G+aEC3jFxXU4DQ7d4mdwqGKPLGm4T2Ey3ke+1VwnRY6D7E1jDZ
         hzQVAShowPno2eJt58gr4a357ozk+r/Kroo/pIQmIMDQ6TBs467w2TXn6gJq2FOFcE5o
         edCCOJ/AK+FzX7trOj+eJrfHGnj1P6C5aZIaoT5J/OmVnCLy+l3JZScMjivs1xWIeIdP
         BtMY3q8QOKiF947Ih4BbQ7kbJSoLTw8/qgL9MWUziFjnvd+MnEfmpggQJqJx8vD0chwo
         +kgw==
X-Received: by 10.107.133.137 with SMTP id p9mr3495598ioi.146.1439847532705;
 Mon, 17 Aug 2015 14:38:52 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Mon, 17 Aug 2015 14:38:33 -0700 (PDT)
In-Reply-To: <CAOLa=ZSvJ7WO9XADUtZkm=QK6S3n1KRcG4nLpPLKnZUxQ+BrJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276099>

On Mon, Aug 17, 2015 at 12:14 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Tue, Aug 18, 2015 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> From: Karthik Nayak <karthik.188@gmail.com>
>>>
>>> Implement the '--format' option provided by 'ref-filter'.
>>> This lets the user list tags as per desired format similar
>>> to the implementation in 'git for-each-ref'.
>>>
>>> Add tests and documentation for the same.
>>
>> Hmm, do we want "--format" added to "tag -l" and "branch -l" in the
>> first place?  Scriptors should be using "for-each-ref" plumbing in
>> the first place, and the point of unifying these three is to share
>> filtering features among them, which would make "for-each-ref" able
>> to express what the other two can do.  I'd hesitate to add too much
>> flexibility to "branch -l" and "tag -l" Porcelains to entice people
>> to script around them.
>>
>
> I'll leave that decision to you, but I see it as a good feature, when perhaps
> I just want to list tags with authors. Agreed `for-each-ref` can handle this too
> but I don't see why `tag -l` shouldn't.
>
> --
> Regards,
> Karthik Nayak

I agree with Karthik,it doesn't really hurt to add it to tag, and will
allow users who aren't familiar with for-each-ref to be able to get
the --format for some use cases. I think it would increase visibility
and use of the format option if it's available on tag and branch.

Regards,
Jake
