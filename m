From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 23:42:07 +0300
Message-ID: <CAMP44s0Q2A_oKJx27ct9W__KVQkQxzst3H7gq6sZDhrCLDQaag@mail.gmail.com>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
	<20120415213718.GB5813@burratino>
	<CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
	<7vaa2by8nj.fsf@alter.siamese.dyndns.org>
	<20120416160729.GM5813@burratino>
	<CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
	<20120416200941.GD12613@burratino>
	<CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
	<20120416203320.GF12613@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:42:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJskn-0002ne-Qj
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 22:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766Ab2DPUmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 16:42:11 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37443 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab2DPUmJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 16:42:09 -0400
Received: by eaaq12 with SMTP id q12so1399900eaa.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ytK186PZsHZvcgrPqeqhe/THQ/XHf65BjGOs9RYvTLA=;
        b=U3VAY2hHIkqmXwSdimdOuryE2mcGpwv+xxEd0F7c9j6LT4BvYrh5Cfx9IAHtmSNc6N
         CofrsG+YfJK8JGAKHDbRLpG7LqpJuVp5nstUH8EklsRdjjWWaA5WMnQ/kEcL/Pc0yqk9
         ZWvrzzyppb2x1le3qpP3Z9hkEajUTj0QKE+GP7cZpnTxsi3P7QFc6dipaTQDvZcOZ3Ii
         8VylV6iB1ceoImJyxR2WTaaHnuAOTJMbxRLcXQGuCUqTRNhV6VG0J94y96TSHmtzm+kX
         TMTuyKkda22kbVAuBfbSVQ4YHjr93FImYdsI/6Icz0Um93O488ebLo6LfmfgEGN8Kkuj
         hsXA==
Received: by 10.213.16.140 with SMTP id o12mr891645eba.150.1334608927842; Mon,
 16 Apr 2012 13:42:07 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Mon, 16 Apr 2012 13:42:07 -0700 (PDT)
In-Reply-To: <20120416203320.GF12613@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195690>

On Mon, Apr 16, 2012 at 11:33 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Felipe Contreras wrote:
>> On Mon, Apr 16, 2012 at 11:09 PM, Jonathan Nieder <jrnieder@gmail.co=
m> wrote:
>>> Felipe Contreras wrote:
>
>>>> I would like to see a completion script that actually has a functi=
on
>>>> supposed to be exported and that still uses the _ prefix anyway.
>>>
>>> The /etc/bash_completion library itself exports lots and lots of
>>> functions with a _ prefix.
>>
>> We are not making a bash_completion library; I mean a bash completio=
n
>> script (other than the library).
>
> Ok. =C2=A0If you refuse to put two and two together, then I will (as =
usual
> when this happens) just be a little passive aggressive and annoyed an=
d
> let you talk to other people.

Just to be clear; we are making a completion script for the 'git'
command, so if we are looking for guidance on what other 'foo' command
completion scripts do, the bash completion library itself is not good
guidance.

My gut feeling is that there's no completion script that exports
functions meant to be used directly by the user, so there's really no
guidance for this.

Now, even if you use the bash completion library, it still does export
functions without a prefix, so why take the ones with prefix as a
rule, and ignore the other ones? It seems like there's no real
guideline for what gets a prefix and what doesn't, even in the bash
completion library itself, which I don't think should be used a
guideline anyway.

The closest relative of 'git_complete' would be 'complete', both of
course are meant for public usage. I have not seen any other functions
that are similar.

Cheers.

--=20
=46elipe Contreras
