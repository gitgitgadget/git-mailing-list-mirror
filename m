From: Chris Patti <cpatti@gmail.com>
Subject: Re: Symbolic 'references' in Git?
Date: Thu, 14 Apr 2011 17:31:13 -0400
Message-ID: <BANLkTik5tD5UOrDkpL8ahEgwFjT+suHACQ@mail.gmail.com>
References: <BANLkTinV8niLibzOQRVraYqwB0hKW1=r1w@mail.gmail.com>
	<201104141524.15212.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 23:31:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAU8V-0003iv-E4
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 23:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab1DNVbR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 17:31:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34245 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368Ab1DNVbO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 17:31:14 -0400
Received: by fxm17 with SMTP id 17so1458773fxm.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 14:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k3CHDy/Z09XgkcEvlXb5jwqYERxmr2bjDsNAlDf1DV4=;
        b=Of6RqxCWQdkcT62UTW1p/qHY+sZ/E2M8nDjPtALahwmistXSIw7sjaN/WURTlrSbRe
         t1fHwjc613qTXx/oItn1HLe+MKFvZJJ+/lMUIOK+dP6vcv1uR4niqeURO1JRCen1UBrA
         46JLrznjwpZ3VWqVzWwUSP0H7oFCmp707HnPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bko6L6zXcQyhU713VEHLAiGWaLfds23UkcrSXnvhNYPbBeRUFj5MAe46CYlGDxmwWO
         XILwldkSZ7PrrGumZEGiJccAlToAWzI7NoiR1YBr657hPoryBhByy8CP5iFkwrZxtvRS
         ocX+ARzpC18NxWR9OiKWSZ+5v+GimmPbneoFo=
Received: by 10.223.64.201 with SMTP id f9mr1339389fai.102.1302816673538; Thu,
 14 Apr 2011 14:31:13 -0700 (PDT)
Received: by 10.223.119.3 with HTTP; Thu, 14 Apr 2011 14:31:13 -0700 (PDT)
In-Reply-To: <201104141524.15212.wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171561>

On Thu, Apr 14, 2011 at 5:24 PM, Wesley J. Landaker <wjl@icecavern.net>=
 wrote:
> On Thursday, April 14, 2011 14:30:59 Chris Patti wrote:
>> We want a way to have our Bamboo configuration utilize a symbol to
>> refer to 'latest release' 'latest patch' etc. in Git, rather than
>> having to go in and change the actual branch name every time we ship=
 a
>> release and create a new one.
>>
>> We thought about using something like:
>>
>> git symbolic-ref -m'new next-release branch build for Bamboo'
>> next-release release-3.15
>>
>> However, this symbolic ref is only local to one repository, and we
>> want it to be global across all of Bamboo.
>>
>> Rather than resorting to manually copying the symbolic ref file
>> around, from repo to repo, is there any way to make such a symbolic
>> 'variable' global?
>
> Why not just use a tag or a branch ?
>
> git tag -F next-release release-3.15
>
> =C2=A0OR
>
> git branch -D next-release
> git branch next-release release-3.15
>
> (I personally think branches are nicer for this since tags are "suppo=
sed" to
> be immutable.)
>


Won't either of those things create a 'next-release' that's frozen in
time where the release-3.15 branch is *right now*?

This is for a CI system (Bamboo) so we need next-release to act as if
we were using release-3.15 itself.

Thanks,
-Chris

--=20
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, =
Pixar
