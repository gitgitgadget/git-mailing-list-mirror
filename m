From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v11 12/13] tag.c: implement '--format' option
Date: Tue, 18 Aug 2015 00:44:08 +0530
Message-ID: <CAOLa=ZSvJ7WO9XADUtZkm=QK6S3n1KRcG4nLpPLKnZUxQ+BrJQ@mail.gmail.com>
References: <1439661643-16094-13-git-send-email-Karthik.188@gmail.com> <xmqqwpwtd9d0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:14:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRPs3-0007YO-6g
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 21:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbbHQTOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 15:14:45 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:32886 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbbHQTOi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 15:14:38 -0400
Received: by obbhe7 with SMTP id he7so121147125obb.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PUoGu4+GR6mF1L2IKL0ybU9JV6KJIEkRJ0rGuPhB9So=;
        b=sh4FreIrKgU6qbqhkhAZX1fNiNRzmCvDDMrHniaOQVscGypIHvf25KXc2ztMa62126
         6wav7/alQi8WeaCfFRNq3agqXOwQGdxZblVQK1uvS3w7ALdz4qSsh5pIYooCPJ/Y22OK
         6g+1d7wvkam/bzrD2O++QAk2xaUbpzUqFphp0yN3IoWbwufqz3Ze67kDDZlqOETStWJE
         Inoro4c15ZtixD2h2N+vO/tSTfIIELNpk3w7K1ejaBC13UfzL9OpMx+ZLlATC2VLkBsa
         zy0VsVaTUNVMGYp3iKUr5lk96aJ6wikTSbk1lvZyUV7jnGkQO0eOh7YT5Qz4HlkLc4eJ
         7L4Q==
X-Received: by 10.60.62.105 with SMTP id x9mr2477116oer.1.1439838877672; Mon,
 17 Aug 2015 12:14:37 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 17 Aug 2015 12:14:08 -0700 (PDT)
In-Reply-To: <xmqqwpwtd9d0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276078>

On Tue, Aug 18, 2015 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Implement the '--format' option provided by 'ref-filter'.
>> This lets the user list tags as per desired format similar
>> to the implementation in 'git for-each-ref'.
>>
>> Add tests and documentation for the same.
>
> Hmm, do we want "--format" added to "tag -l" and "branch -l" in the
> first place?  Scriptors should be using "for-each-ref" plumbing in
> the first place, and the point of unifying these three is to share
> filtering features among them, which would make "for-each-ref" able
> to express what the other two can do.  I'd hesitate to add too much
> flexibility to "branch -l" and "tag -l" Porcelains to entice people
> to script around them.
>

I'll leave that decision to you, but I see it as a good feature, when perhaps
I just want to list tags with authors. Agreed `for-each-ref` can handle this too
but I don't see why `tag -l` shouldn't.

-- 
Regards,
Karthik Nayak
