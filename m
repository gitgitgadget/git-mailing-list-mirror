From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4: import utf16 file properly
Date: Wed, 14 Sep 2011 19:56:27 +0100
Message-ID: <4E70F8DB.8080008@diamand.org>
References: <CANeU7QndA0yv1OzU3vta5B8r8nCRdBSqTy0Rboc_bbpst+1pcw@mail.gmail.com>	<4E705DF8.1040508@diamand.org> <CANeU7QnW5kSni0W9M9q-FTWv4p_qc67LG3mA6BQj_U-wxNuZeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>
To: Chris Li <git@chrisli.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 20:56:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3udR-0001d3-Kl
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 20:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459Ab1INS4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 14:56:33 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63938 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269Ab1INS4c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 14:56:32 -0400
Received: by wyh22 with SMTP id 22so1970418wyh.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 11:56:31 -0700 (PDT)
Received: by 10.227.199.134 with SMTP id es6mr219219wbb.10.1316026591052;
        Wed, 14 Sep 2011 11:56:31 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id n39sm5080549wbp.7.2011.09.14.11.56.28
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 11:56:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.21) Gecko/20110831 Iceowl/1.0b2 Icedove/3.1.13
In-Reply-To: <CANeU7QnW5kSni0W9M9q-FTWv4p_qc67LG3mA6BQj_U-wxNuZeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181383>

On 14/09/11 19:29, Chris Li wrote:
> On Wed, Sep 14, 2011 at 12:55 AM, Luke Diamand<luke@diamand.org>  wrote:
>> On 13/09/11 22:33, Chris Li wrote:
>>> The fix is simple, just ask perforce to print the depot
>>> file into a real file. This way perforce will not performe
>>> the utf16 to utf8 conversion. Git can import the exact same
>>> file as perforce checkout.
>>
>> Does this change do the right thing with RCS keywords in UTF16 files?
>
> I don't know what is the rules about the RCS keyword in UTF16 files.
> I look at the current git-p4, it does not do any keyword replacement in
> utf16 files. So this patch did not change that. It should be a separate issue.
>
> The way I see it, this patch is a straight enhancement compare to the
> current git-p4 because the current git-p4 *corrupts* the utf16 files.
>
>>
>> If p4CmdList() fails, e.g. due to running out of diskspace, will this just
>> happily import a truncated/corrupt file?
>
> Good point. I add the error check and attach the new patch.
>
>> (And I could be wrong about this, but does you patch have newline damage? It
>> didn't seem to apply for me).

Looks good to me. I think you're right about the RCS keywords not being 
relevant here.



>
> Gmail dmage the white space. I should always use the attachment.
> Does the attached patch work for you?
>
> Thanks
>
> Chris
