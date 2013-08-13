From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Tue, 13 Aug 2013 22:13:48 +0700
Message-ID: <CACsJy8B7PrOr8YX0d05dw75tfCVNWEJ-YPDe414yTzgQe2Ea=w@mail.gmail.com>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
 <7veh9z1gym.fsf@alter.siamese.dyndns.org> <CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
 <CACsJy8Dke6Pezqsdcjzejc_cWCgOGTGs8LifjM2h2TQJy7N4HA@mail.gmail.com> <CA+CP9O5Ak3YD60--Mj+eLv3qzbZuuwTN-AxY3xb=SciKD=uZoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Jeske <davidj@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 17:14:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9GIh-0006uA-Vs
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 17:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758203Ab3HMPOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 11:14:19 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:36459 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757573Ab3HMPOT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 11:14:19 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so11655572oag.3
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IxZ5MIhf80UKPHshecgc/a9/KPjcZarvaBt8n93mvRI=;
        b=KTjFun9o1PLLin8kkgX0YCdeOs3qsdZg4VsIOLGZlFpRBrDG5TPZkzjKvH4kiuHf6U
         fIsGnshtWwHuAwH88kweMpujJNIusAIVN5shQ3F/27N6jA71oiU6fb2qPR2xVrzGasaW
         ZY/ZoS30Mhm7ykwaBKYjofctvTuxxzT8F7VI189Q/dJUAzzgmdWLMQ9jHpZgZFOu/kJu
         2TVTFMR2UDuxwlTJmndP+LweVT00CmkeWyuto5WqApjQJNpNJWscEk/tSMEoM3UD+Zkh
         wcBcswok/dCGSF3D838vVEEdQE2quDiq+YwCnD3Cqnv4tbAEDtIStj8begScSlepVhqa
         BL4g==
X-Received: by 10.182.214.98 with SMTP id nz2mr4228465obc.37.1376406858239;
 Tue, 13 Aug 2013 08:14:18 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 13 Aug 2013 08:13:48 -0700 (PDT)
In-Reply-To: <CA+CP9O5Ak3YD60--Mj+eLv3qzbZuuwTN-AxY3xb=SciKD=uZoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232226>

On Tue, Aug 13, 2013 at 9:44 PM, David Jeske <davidj@gmail.com> wrote:
> On Aug 12, 2013 11:06 PM, "Duy Nguyen" <pclouds@gmail.com> wrote:
>>
>> On Mon, Aug 12, 2013 at 3:37 PM, David Jeske <davidj@gmail.com> wrote:
>> > Is there currently any way to say "hey, git, show me what commits are
>> > dangling that might be lost in the reflog?"
>>
>> How do you define dangling commits?
>
> Any commit which I did not explicitly do something with. (Merge, rebase,
> amend, branch name, discard)
>
> Today every one of those actions is explicit except discard.

So basically everything that is (1) produced by "git commit", (2) not
connected to any ref and (3) not an amend. I think (1) and (3) can be
achieved with "git log -g --grep-reflog commit: HEAD". We only need to
filter out ones that are connected to some ref. Not sure if that can
be done with script though. Maybe add "--dangling" to "git log -g" to
do such filtering?
-- 
Duy
