From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Wed, 19 Jun 2013 11:26:45 +0530
Message-ID: <CALkWK0=-PT=QD5enFQhrDZN03xCAttZKtjtT8rE7n4QynT+Ndg@mail.gmail.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
 <1371607780-2966-3-git-send-email-rhansen@bbn.com> <CALkWK0mo2SG+Eh1Qmy58Xo-taG_EGEj9RSx65EYhvs2CLK9dUA@mail.gmail.com>
 <51C135BE.4030506@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 07:57:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpBOc-0007DT-Ah
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 07:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755739Ab3FSF50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 01:57:26 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:50297 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab3FSF5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 01:57:25 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so11750028iea.25
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 22:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Riy7MzY13vsmzECauq5Gv3HM/RXZWMRs6spNcS8NhMk=;
        b=bQP2+JcHFmWT3tw2fZXYbk2Bq3puItv3xRHphkUASfh6Eh7HxYdWB3WlpmieBbMSt7
         CrSgDXqoeTLhSLfUFpIbPKxdLjlwHUPU2s46wTD6j55wlmK6ZJTVF1V1qKMabNp9qAO5
         stDHRZ+wuVSnX/vBkJlX7yRa+z6i7RlEaYF6Ayi+VYlcDCG0h8JAOJYQvRVdOK5HqT9S
         8APlwoP+4Ks1AzOCVoBAKYBc4hUDFgNgXj+A123MFK+3b++1mDFdZnwXxno+rvrhlEr7
         zM5FT7H7aWg6dgulaQNbKgRuibI39Przn0t0AxLRmBvzFgjDEtlZMT/s5etLsB3pKAhJ
         Ki+Q==
X-Received: by 10.50.3.37 with SMTP id 5mr621202igz.0.1371621445278; Tue, 18
 Jun 2013 22:57:25 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 22:56:45 -0700 (PDT)
In-Reply-To: <51C135BE.4030506@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228347>

Richard Hansen wrote:
> On 2013-06-19 00:19, Ramkumar Ramachandra wrote:
>> Is master~3 a committish?  What about :/foomery?
>
> Yes; as documented, both of those are refs that point to a commit.

>From gitglossary(7):

ref
    A 40-byte hex representation of a SHA-1 or a name that denotes a
    particular object. They may be stored in a file under $GIT_DIR/refs/
    directory, or in the $GIT_DIR/packed-refs file.

Do master~3 and :/foomery qualify as refs?

>> Look at the other forms in gitrevisions(7); master:quuxery,
>> master^{tree} are notable exceptions.
>
> gitrevisions(7) says that master:quuxery is a ref pointing to a blob or
> tree, so it is not a committish.  However, if quuxery is a submodule, I
> would expect master:quuxery to point to a commit object and thus be a
> committish.  So perhaps the <rev>:<path> description in gitrevisions(7)
> should be updated to accommodate submodules.

When quuxery is a submodule, master:quuxery refers to a commit object
that does not exist in the parent repository.  I don't know what we
gain by documenting a comittish you can't even `show`.
