From: Cory Sharp <cory.sharp@gmail.com>
Subject: Re: [Q] merge squash unexpected conflicts
Date: Thu, 14 May 2009 07:47:40 -0700
Message-ID: <bb9d69200905140747j60b2e09flaabbb4db09b371b4@mail.gmail.com>
References: <bb9d69200905131706m61b0dda1xc347ca2e719ec142@mail.gmail.com>
	 <bb9d69200905131942t7a43a29fh9638d2548e9f12dc@mail.gmail.com>
	 <7v4ovo1iap.fsf@alter.siamese.dyndns.org>
	 <bb9d69200905132057u60adc2f8vb9ba9a35791f72ac@mail.gmail.com>
	 <4A0C0BDF.9020803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 14 16:47:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4cDt-0002UF-RH
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 16:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbZENOrm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 10:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752946AbZENOrm
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 10:47:42 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:21591 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbZENOrl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 10:47:41 -0400
Received: by yx-out-2324.google.com with SMTP id 3so740407yxj.1
        for <git@vger.kernel.org>; Thu, 14 May 2009 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j7Tj8OWn6H1gC2rOmbOfzVwnAC2XkvJDGZXptzmvIXU=;
        b=hBGXpbbCH5/wQaivba5UXgSN5meb8OGiNukwzGRWrSvVmHLUeEW73O9ZfUONJQYW2+
         6rXLcumJ3t9CBq+KEKDXA/044rrflWw+P1QxwKSrodaaKCaoxK5lLE4Po5o4iyCNQj8o
         5/G1jmNjct6dc8Ce+JOBNvdJrk6rv62E2zBJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oqDKF9OHs+Mnk6u/PC8o5l95auhXgfl2EKlDu6jYh5rDMPeCEmgEHMLDGKj19iYHNA
         QQ+Prwp43bOm4dIN3wKsG6zm7OEfGc5sFebS4x27VE4opP2MuWxLD8VOwrCgaf1KssC7
         HP+UM5Bq8escJzminDS/5CcKBLxovoUcQbwzE=
Received: by 10.100.41.18 with SMTP id o18mr3233952ano.36.1242312461291; Thu, 
	14 May 2009 07:47:41 -0700 (PDT)
In-Reply-To: <4A0C0BDF.9020803@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119197>

On Thu, May 14, 2009 at 5:17 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Cory Sharp venit, vidit, dixit 14.05.2009 05:57:
>> On Wed, May 13, 2009 at 8:21 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Cory Sharp <cory.sharp@gmail.com> writes:
>>>
>>>> Am I doing something a little wrong or unexpected? =A0Is there a w=
ay
>>>> around this squash conflict behavior? =A0This doesn't seem to happ=
en
>>>> with plain merge without squash.
>>>
>>> Of course. =A0That's the whole point of recording a merge as a merg=
e.
>>>
>>
>> $ git help merge
>>
>> =A0 --squash
>> =A0 =A0 =A0 =A0 =A0 =A0Produce the working tree and index state as i=
f a real merge
>> happened. ... This allows you to create a
>> =A0 =A0 =A0 =A0 =A0 =A0single commit on top of the current branch wh=
ose effect is
>> the same as merging another branch.
>
> The problem is simply in the "...". You cut out the vital part:
>
>
> =A0 =A0 =A0 =A0but do not actually make a commit or
> =A0 =A0 =A0 =A0move the `HEAD`, nor record `$GIT_DIR/MERGE_HEAD` to
> =A0 =A0 =A0 =A0cause the next `git commit` command to create a merge
> =A0 =A0 =A0 =A0commit.
>
> See? Tree: yes, index: yes, merge info: no.
>
> Git does perform a (tree) merge with --squash, but records the result=
ing
> tree as an ordinary non-merge commit (with a single parent).
>
> I'm not sure whether the statement about the index is completely
> correct, though. During a merge the index records info about the merg=
e
> (stages :1: etc.) but that as missing with --squash. Only the resulti=
ng
> tree is added to the index. How about the below?

Now I see, thanks for the help.  The elided part, at the time I elided
it, did not make me understand that merge info was not written,
particularly when surrounded by its original accompanying text.

Thanks again,
Cory
