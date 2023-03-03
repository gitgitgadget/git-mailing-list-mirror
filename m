Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6F7C678D4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 00:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCCAHg convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 2 Mar 2023 19:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCAHf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 19:07:35 -0500
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646A255501
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 16:07:32 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 32306oiJ2027824
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 00:06:51 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     "'Dinesh Dharmawardena'" <dinesh_dh@outlook.com>,
        <git@vger.kernel.org>
References: <SY6P282MB3782FD975E6F39951C5A43DA92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>        <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>        <ZAEgRDelTlNZRJ5J@tapette.crustytoothpaste.net> <xmqqfsamiul2.fsf@gitster.g>
In-Reply-To: <xmqqfsamiul2.fsf@gitster.g>
Subject: RE: Let us not call it git blame
Date:   Thu, 2 Mar 2023 19:07:12 -0500
Organization: Nexbridge Inc.
Message-ID: <003201d94d64$1e732030$5b596090$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHxy2OwVODVUvoV78MH5dMcQq9SkALY6QXNA0wimLACCGG1M651xEYw
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, March 2, 2023 6:48 PM, Junio C Hamano wrote:
>"brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> On 2023-03-02 at 22:00:59, Dinesh Dharmawardena wrote:
>>>
>>> I am writing to you to request that the term blame in git blame be
>>> replaced with something that does not sound so blameful. I’m an SRE
>>> and we actively try promote a blameless culture as such industry
>>> tooling should also follow suit imo. Progressively phasing this term
>>> out with a better alias would be great.
>
>I actually do not think "git blame" is incompatible with blameless culture at all,
>unless you blindly say "this word is bad, that word is not" without thinking.  Blameless
>culture is about not blaming the _person_ who made an earlier mistake, but "git
>blame" is not about finding a person who contributed the badness to the codebase.
>
>It is all about which _commit_ contributed badness to the current codebase (i.e.
>"these commits are to be blamed for the current breakage that made us lose $XM")
>and it is up to the users how to interpret the story behind these found commits.  It
>often would not be the "fault" of the author alone, and striving for blameless culture
>is to find out what led to the mistakes in these commits.
>
>> I believe there's already an alias for it, git annotate, if you'd
>> prefer to use that.  The name "blame" came in with CVS, with the
>> synonym "annotate", so it's well understood, but you can use whichever
>> alias you prefer.
>>
>> I do think there may some differences in the defaults between git
>> annotate and git blame, but if someone wanted to send in a patch for
>> an option to make annotate produce identical output to blame, then I
>> think it could be a full replacement.
>
>At that point we can retire "git blame" and make it a built-in alias to "git annotate --
>behave-like-git-blame".  Then we will come full circle ;-)

I think you have a good point here. Blame is associated with the commit which is not a specific person (might be a group though). In some (a few, but growing) companies I am dealing with, the core.user and core.email are associated with a nameless single sign on (SSO), or tokenized user, in order to be compliant from a regulatory standpoint. This includes GDPR in Europe and the Privacy Act in Canada. In these cases, there is no identifying information in the commit itself, but externally in the organization's HR and IT departments where identifying information is tightly controlled. Cause and effect will always exist, no matter how one might choose to semantically hide the usage. Words do matter, but identifying information may not for much longer. Perhaps that approach might help the OP's organization in their jurisdiction, to dissociate the commit from the person except during a specific audit context.

