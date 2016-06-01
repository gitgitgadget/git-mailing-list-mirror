From: Stefan Beller <sbeller@google.com>
Subject: Re: [BUG] git-submodule has bash-ism?
Date: Wed, 1 Jun 2016 13:59:06 -0700
Message-ID: <CAGZ79kaUHm==ZjRwD3MTnCXKAWUHszb4PPF=S4Y-TD2e4eBsTw@mail.gmail.com>
References: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com> <xmqqoa7kzy3u.fsf@gitster.mtv.corp.google.com>
 <xmqqk2i8zxtx.fsf@gitster.mtv.corp.google.com> <20160601163747.GA10721@sigill.intra.peff.net>
 <20160601183100.GN1355@john.keeping.me.uk> <20160601190759.GB12496@sigill.intra.peff.net>
 <20160601191621.GO1355@john.keeping.me.uk> <xmqqinxsy9q0.fsf@gitster.mtv.corp.google.com>
 <20160601202852.GP1355@john.keeping.me.uk> <xmqq8tyoy6se.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 22:59:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8DEQ-0006Zb-90
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 22:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbcFAU7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 16:59:09 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35494 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbcFAU7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 16:59:08 -0400
Received: by mail-qk0-f178.google.com with SMTP id c140so21768604qke.2
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PNMZuFsq4dhbjwFvG0Xb+nxYSDjMgYzjyEGU/+50w9c=;
        b=KYusWeODzFlJD5SNgIiCeH3/+r+mhf7E2s31KmVuxpwRB95krLM6jsHg1gq7F3BH0e
         FELQR44DlJmT017O5o9EPvq3MRTH87VdYjm6KKjZ8CTqYiqmsvVHjpraSf+9nqqsPzCN
         Djoxoyiw5Qd9+m7Q8RnaLuXfWcyqTmif6mw1Oa1m9IqA9mC05C5lS/nQdG2PddMZmvxX
         pyl4zC35yaDzK02gYuABoRMYiKw3EVSwuTZkkBbxpNE2dzkaiZJfH0Hhii4oLmeBR3sT
         vbXWJr+7vXXP6vqkt/y4Kr7nmD1psLLM77YPPoDcU/HsPFdAvnVz5wq7qd81D4X3Ze1f
         EUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PNMZuFsq4dhbjwFvG0Xb+nxYSDjMgYzjyEGU/+50w9c=;
        b=Yo3bB9FyzmpS2OuEAtFjCN7WHayv1ghHy4cfabbHBEler1wRpcCYRULxiQQnSzOAn0
         XoHN7aSBQuSNZlFr60DKDN9UVBX162gnXmLtEiNXK0jxuUoHN2e1QlFGOQ3lnfrFy5X5
         wMtD/n2lCKr75CvUNFGLQgArkiNMvIsB9anCoDGBsj7CzEu+QIWHN38k3lzNf/qEROpb
         oC2qpRmvgUElx/UemDJFD1dMSkNKNX1ClN1JlgmdJfb2E/pC/31YaWfYomjW4Hdh3qv6
         FF5LKBmSC/fbfXnCJvRZLxwtsCIzCCL84ASUuHBDpzpjFXXKAvy096GFWi8cOBrNnvBC
         cDGg==
X-Gm-Message-State: ALyK8tLL+74I5qwluFGgkJSVh/Cb7SYreJ/4Zk7oai+1v/912WlXBZHbLD9gm216pvB6968Z+5QJVU40JKqjl95B
X-Received: by 10.237.53.100 with SMTP id b33mr5807592qte.59.1464814747504;
 Wed, 01 Jun 2016 13:59:07 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Wed, 1 Jun 2016 13:59:06 -0700 (PDT)
In-Reply-To: <xmqq8tyoy6se.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296162>

On Wed, Jun 1, 2016 at 1:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Keeping <john@keeping.me.uk> writes:
>
>> Absolutely, my original point should have been prefixed with: I wonder
>> if the reason we haven't had any problems reported is because ...
>>
>> And we've got lucky because the clobbering of global variables happens
>> not to matter in these particular cases.
>
> Ah, I did misunderstand why you were making that statement, and now
> I fully agree with your conclusion (which is what Jeff spelled out
> in the latest message) that the fact that we saw no breakage report
> is not a datapoint that everybody's shell supports "local" at all.
>
> Thanks for clarification.

I think both the use of submodules and the use of shells not supporting 'local'
is a minority in our current user base, so I am not surprised that nobody
complained about that, as the overlap between submodule users and
non-local shell users may even be zero.

The patch just sent, looks good to me for the minimal fix in the tests.

Thanks,
Stefan


> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
