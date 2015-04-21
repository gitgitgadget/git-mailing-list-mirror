From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH/RFC v3 0/4] Improving performance of git clean
Date: Tue, 21 Apr 2015 20:21:37 +0200
Message-ID: <CAMpP7NaUv10Ox0gNsE8cg4hUnNNiFi8NZSLw6F6SW+SLrt0VwQ@mail.gmail.com>
References: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
	<20150420221414.GA13813@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 20:21:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykcnn-0005z1-Jc
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 20:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbbDUSVi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2015 14:21:38 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36624 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbbDUSVi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2015 14:21:38 -0400
Received: by obbeb7 with SMTP id eb7so151683542obb.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=wLX9go95f/FhiZDDY9H48Z5mlb90CS/kbvWbPJq6vlw=;
        b=nTm1s4tqTIESBXUWKFZVxdjxCHSPrO6q4D7IWMo4uKCL84TUL23EbeMgkJxlCUu8yZ
         jbLMRi61NgYOruj9BAJ4limCHRlgvVV4buRGcZYvu5gzCqKL0N0LmFOQYjm7FGWC/NxE
         stT2LyN1F4R08rCkzbuDhvVY5tO3W3+oi20ikSJUWL+EOhX10lBjxaVq+uSnNz8K1m5j
         x2MsIJhWNjggq348wfCNC00YmwpxDmroCEupPcLkoKm9lNq3bq+Hnmbrbw2x5s61s1lZ
         l5M459pvIVuU6qj3kDtl0LtRmXaBcOYAUnWP70ZLyTbZYCz6Of/jaih3t9XHlfX9mxJD
         FflQ==
X-Received: by 10.202.185.87 with SMTP id j84mr19198241oif.47.1429640497747;
 Tue, 21 Apr 2015 11:21:37 -0700 (PDT)
Received: by 10.182.154.72 with HTTP; Tue, 21 Apr 2015 11:21:37 -0700 (PDT)
In-Reply-To: <20150420221414.GA13813@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267545>

Ok, thanks for looking into this.

I have no well founded opinions on the implementation but I do
think the performance tests would be more meaningful if the
setup/cleanup code could be removed from the timed section.
If the community agrees on an implementation I would be happy
to convert the new tests, either directly in this series or as a follow
up if that is preferred.

/Erik

On Tue, Apr 21, 2015 at 12:14 AM, Thomas Gummerer <t.gummerer@gmail.com=
> wrote:
> On 04/18, Erik Elfstr=C3=B6m wrote:
>> * Still have issues in the performance tests, see comments
>>   from Thomas Gummerer on v2
>
> I've looked at the "modern" style tests again, and I don't the code
> churn is worth it just for using them for the performance tests.  If
> anyone wants to take a look at the code, it's at
> github.com/tgummerer/git tg/perf-lib.
>
> I think adding the test_perf_setup_cleanup command would make more
> sense in this case.  If you want I can send a patch for that.
