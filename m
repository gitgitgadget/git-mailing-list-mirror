From: "Ondrej Certik" <ondrej@certik.cz>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Wed, 26 Nov 2008 16:50:14 +0100
Message-ID: <85b5c3130811260750y2e24436ye2426ccfc2f66071@mail.gmail.com>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
	 <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>
	 <85b5c3130811260135g4646bf72iaf57f599fdd21a0c@mail.gmail.com>
	 <85b5c3130811260218s7529914eyb56a05ec1ca34b8f@mail.gmail.com>
	 <492D6CC3.2050408@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Fabian Seoane" <fabian@fseoane.net>
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 16:51:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Mfw-00062B-D8
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 16:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbYKZPuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 10:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbYKZPuS
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 10:50:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:25395 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbYKZPuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 10:50:16 -0500
Received: by nf-out-0910.google.com with SMTP id d3so290915nfc.21
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 07:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=aalLDLSfcDAec+XzvLstHykE5i6vFzWgGVTN65TlRp4=;
        b=BEy2XUVhQMfn9zWINjyTmC0LEA/FuwUSaj91KtS+DX7fhLLEctt6yEFY2vTFiTqu5b
         +zGaB2Wo8LFMb/Ld9VYuXignjzQX5C8or3WDvUZ542Lp+sDGJhWY15a58wBal9wZskae
         EwzJkv+dAdvZeT1DEUhP/FkyjMG3wABHVfxAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=t+Fvz7TrZrQOKm87qfcCPeXAqwPCaj5/0YoueySRfdrvhlwRUaX2PKoCwSc6xWbFSD
         TK2zT2NvsOSl8EA9grEXfejEh1WpSRvtQKm0Vh43ScVmrEP1oEAERJKOi0XnvJbK1Orx
         rFPv4jBNJZcH67WEosku+yVnxP6ylMTOImCzs=
Received: by 10.86.84.5 with SMTP id h5mr3878465fgb.12.1227714614660;
        Wed, 26 Nov 2008 07:50:14 -0800 (PST)
Received: by 10.86.33.8 with HTTP; Wed, 26 Nov 2008 07:50:14 -0800 (PST)
In-Reply-To: <492D6CC3.2050408@drmicha.warpmail.net>
Content-Disposition: inline
X-Google-Sender-Auth: 51b03fdadb488335
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101741>

On Wed, Nov 26, 2008 at 4:35 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Ondrej Certik venit, vidit, dixit 26.11.2008 11:18:
>> On Wed, Nov 26, 2008 at 10:35 AM, Ondrej Certik <ondrej@certik.cz> wrote:
>>> On Wed, Nov 26, 2008 at 1:14 AM, Johannes Schindelin
>>> <Johannes.Schindelin@gmx.de> wrote:
>>>> Hi,
>>>>
>>>> On Tue, 25 Nov 2008, Ondrej Certik wrote:
>>>>
>>>>> I would like to export our whole git repository to patches, and then
>>>>> reconstruct it again from scratch. Following the man page of "git
>>>>> fast-export":
>>>>>
>>>>> [...]
>>>>>
>>>>> However, the repository is very different to the original one. It
>>>>> contains only 191 patches:
>>>> Can you try again with a Git version that contains the commit
>>>> 2075ffb5(fast-export: use an unsorted string list for extra_refs)?
>>> I tried the next branch:
>>>
>>> $ git --version
>>> git version 1.6.0.4.1060.g9433b
>>>
>>> that contains the 2075ffb5 patch. I haven't observed any change ---
>>> the "git log" still only shows 191 commits (git log --all shows
>>> everything).
>>
>> I deleted all tags and then fast-exported and imported, now all the
>> commits show in "git log", however, the patches are wrongly connected.
>> Basically, both repositories are identical (including hashes) up to
>> this commit:
>>
>> d717177d4  (fixed downloads instructions in the README and a typo)
>>
>> However, the original repo (sympy-full-history-20081023) contains 3
>> children at this commit:
>
> There's some nice 3 way branching and double 2 way merging going on. I
> cut out the interesting part of the graph, making d717177d4 and
> 6e869485f parentless. The resulting mini DAG is reproduced correctly by
> export|import, even with -M -C.

I am also trying to make the example simpler. I tried to squash the
first uninteresting ~1500 commits into one, but "git rebase -i"
uterrly fails after squashing about 600 commits. Still investigating.

Ondrej
