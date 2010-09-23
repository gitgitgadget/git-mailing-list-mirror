From: Arun Raghavan <ford_prefect@gentoo.org>
Subject: Re: Enforcing clone/fetch to use references.
Date: Thu, 23 Sep 2010 18:09:19 +0530
Message-ID: <AANLkTik-VRdUzFSBD2VADp=WMVtRh_kO6zjZxLxOZohW@mail.gmail.com>
References: <20100921204456.GA24357@huya.qualcomm.com> <20100921213135.GB1255@sigill.intra.peff.net>
 <20100921221229.GA29680@huya.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Sep 23 14:39:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyl5Z-0006pp-S2
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 14:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab0IWMjn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 08:39:43 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65054 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564Ab0IWMjm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 08:39:42 -0400
Received: by gxk9 with SMTP id 9so526844gxk.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=1o0jR7WKF2udcWN3Mbjt+6yUOCcrPJDWXn0oUrCxgRM=;
        b=sfQBsnpzhnJrpXPEp01+gtlxDCxqxBpOPqbNKRW2xhaSO37bIc8ZwYmzlH5qzJ514e
         yHXQqgltFDTYbqBbLwXJZudGtV2UR57s+LPPxYiXuBesRVz+SGgopABv2iKmtSTDGeY9
         hksN18GUR7F26nQh0V1j6i6X2H+1SL0FnL+1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=OEBfVY255iUGFFzwAvevkvO1nEJhJ56AWFbAHGmPtCAM2xoVhIxmvf1vuIRSvTkSQ9
         7qxvCUoOFXlMKl4iw6lS6hHpUlZ/uXbvIdR4zP/+7zBj/5f2/5014/9eCo84Rfg2Vex/
         /tJvkPkiSnTEll55Fx8wixA+gkmBsRo60zAxM=
Received: by 10.100.154.6 with SMTP id b6mr1950236ane.152.1285245581447; Thu,
 23 Sep 2010 05:39:41 -0700 (PDT)
Received: by 10.220.168.193 with HTTP; Thu, 23 Sep 2010 05:39:19 -0700 (PDT)
In-Reply-To: <20100921221229.GA29680@huya.qualcomm.com>
X-Google-Sender-Auth: YMaCMDoEIwNoW1imvk1HKjd_0sc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156866>

Hey David,

On 22 September 2010 03:42, David Brown <davidb@codeaurora.org> wrote:
> On Tue, Sep 21, 2010 at 05:31:35PM -0400, Jeff King wrote:
>> On Tue, Sep 21, 2010 at 01:44:56PM -0700, David Brown wrote:
>>
>> > Suppose I want to publish some changes to a tree. =A0I have a serv=
er
>> > available where I can run a git daemon, but for one reason or anot=
her
>> > I want to force people to use the another git repo as a reference.
>> > The reason could be one of bandwidth, or someone who isn't comfort=
able
>> > making all of the other source available. =A0Ideally, someone who
>> > already has the other git repo cloned, and just adds mine as a rem=
ote
>> > wouldn't notice the difference.
>>
>> I think the gentoo people were talking about doing something like th=
is.
>> They wanted you to use some faster and/or restartable protocol to cl=
one
>> initially, and so they wanted to reject initial clones. I'm not sure=
 if
>> they are doing that, and how (from the thread below, I suspect they =
run
>> a patched git).
>>
>> The simplest thing would be a pre-upload-pack hook. There was some
>> discussion of that in this thread:
>>
>> =A0 http://article.gmane.org/gmane.comp.version-control.git/137007
>
> Arun, did you ever get a chance to rework the upload-pack hooks to
> work only from git daemon? =A0If not, I'd like to take a look into
> implementing this.

I never did get a chance to finish work on this. The last IRC
discussion we had about this is at
http://dev.gentoo.org/~ford_prefect/git-hooks-discussion-log.txt

We still definitely do need this in Gentoo for when our git migration h=
appens.

Cheers,
--=20
Arun Raghavan
http://arunraghavan.net/
(Ford_Prefect | Gentoo) & (arunsr | GNOME)
