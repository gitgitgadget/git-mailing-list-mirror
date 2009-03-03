From: Emily Ren <lingyan.ren@gmail.com>
Subject: Re: How can I merge some files rather than all files modified on one 
	branch to my branch?
Date: Tue, 3 Mar 2009 11:56:03 +0800
Message-ID: <856bfe0e0903021956l549e41d2l97d7e0997067c133@mail.gmail.com>
References: <856bfe0e0903020119y68188a39m90c683949220b2f@mail.gmail.com>
	 <200903022110.23207.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 04:57:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeLlC-0001NA-Od
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 04:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbZCCD4J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 22:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753596AbZCCD4I
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 22:56:08 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:63163 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbZCCD4G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 22:56:06 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1734523yxm.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 19:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tvK6B8ufrlEIrEbk0d8TEnvfyvKoRGo7QGYJ8KHtaQ4=;
        b=OCM3vk7gp5cW3ujuT/pfok+Usp1zUsbgxDs18s2g99fMaApFDqC7yyN/3cxhlahjZq
         YDsM+4hvJoatqdr23jbhhZGrDkISxDpfWmILheb2EaozbHp9eZNH2U6I2nGi+jHPrHDK
         u6qsbjHsNJJ97fha2ZA153vS6tgQ7E49HITwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hrinKXbry4Yk6k42fzNAsiAQbpR5du+59ewqOc1rPK8d5wQldy3FAFkJa55hCt52Ng
         s7lKgEQj19pzPE0iGidzT7JSITx9Xl9M/Om0vDLq7/nOvt5JJdJvhT+U/5atEEjkN4OG
         WPsMGcJQqHXCC91r1yYdoQMhyNGspce7Yq9TA=
Received: by 10.151.42.13 with SMTP id u13mr11679057ybj.130.1236052563426; 
	Mon, 02 Mar 2009 19:56:03 -0800 (PST)
In-Reply-To: <200903022110.23207.bss@iguanasuicide.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111990>

Junio and Boyd,

Thank you very much for your kindly guide ! I'll try these method.

Boyd,
How to rewrite the history of the branch ?

Thanks,
Emily

On Tue, Mar 3, 2009 at 11:10 AM, Boyd Stephen Smith Jr.
<bss@iguanasuicide.net> wrote:
> On Monday 02 March 2009 03:19:05 Emily Ren wrote:
>> I want to merge some files rather than all files modified on one
>> branch to my branch, how can I do?
>
> In addition to what Junio suggested, I'll offer another method, assum=
ing the
> branch you are merging from is not yet published:
> (1) Rewrite the history of the to-be-merged branch so that all the ch=
anges to
> the files you want occur "before" and in separate commits from the fi=
le you
> want to ignore. =A0So the current tree:
>
> A-->B-->C (yours)
> =A0\
> =A0->D-->E (theirs)
>
> becomes:
>
> A-->B-->C (yours)
> =A0\
> =A0->D1-->E1-->D2-->E2 (theirs)
>
> with D1 and D2 being the separate parts of commit D and similarly for=
 E1 and
> E2.
>
> (2) Merge in the rewritten history, but only the part that you want, =
giving:
>
> A-->B-->C--->F (yours)
> =A0\ =A0 =A0 =A0 =A0 /
> =A0->D1-->E1-->D2-->E2 (theirs)
>
> This preserves the full intent of what you are trying to do, a partia=
l merge.
> If you merge "theirs" in fully at some point in the future, you shoul=
dn't see
> any conflicts arising from not recording the merge or missing changes=
 arising
> from recording a full merge that did not happen.
> --
> Boyd Stephen Smith Jr. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ,=3D ,-_-.=
 =3D.
> bss@iguanasuicide.net =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((_/)o o(\_=
))
> ICQ: 514984 YM/AIM: DaTwinkDaddy =A0 =A0 =A0 =A0 `-'(. .)`-'
> http://iguanasuicide.net/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_/
>
>
