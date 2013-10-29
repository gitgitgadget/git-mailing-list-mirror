From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: git-contacts questions
Date: Tue, 29 Oct 2013 10:12:10 +0100
Message-ID: <CAHGBnuP6nyTCGGNntvWVYAtxNX9xgt6=F3HheiEUcPU_9TP-1g@mail.gmail.com>
References: <CAHGBnuPW3dtiL-=6BgvaOB4VvOAPyZhrVS3WGreVH_Pt81=wyg@mail.gmail.com>
	<CAMP44s1+npNnR8-exARL8kamQ81JwyLhhQnnkv6DvK8e3qOfHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 10:12:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb5LU-0006uW-PB
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 10:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab3J2JMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 05:12:13 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:58968 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab3J2JMM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 05:12:12 -0400
Received: by mail-la0-f41.google.com with SMTP id el20so6291287lab.28
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G5a4KdE5WRe5Ao418CgCBvSPjukdTf2D449HxSjQ4Jg=;
        b=VHG5Nbs++yoIKctPDmdR53cRHjD4x1QgqRwe3kl2p382mALyrLSx4pLoYgpoQawwou
         uC7RVxB77Sz97iQVQhnNPzCNCaR7oEUC7odK4ailyePOY6RLt8swvyv96pm5fwqOTVbz
         1Uz1JPvwzIIA16rPdNTe85+TFdcvvmBSO0SRyasTkY5PxX6Z+/L2iThW9jdSHiIKodny
         idDWGmvH8LFbECy3UtUs5UkU27zhYGxuvysYIgprvKw32iYZETrYZwvZp5bK+R0ZuWSC
         nDNpPFY2XOzQPRQtwyHgC6nN0hztGResp0UCAuSOxRgfcvUewL0MFWn/dLOvtnDXQiZj
         5Zlg==
X-Received: by 10.112.11.20 with SMTP id m20mr312219lbb.56.1383037930698; Tue,
 29 Oct 2013 02:12:10 -0700 (PDT)
Received: by 10.114.201.134 with HTTP; Tue, 29 Oct 2013 02:12:10 -0700 (PDT)
In-Reply-To: <CAMP44s1+npNnR8-exARL8kamQ81JwyLhhQnnkv6DvK8e3qOfHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236919>

On Tue, Oct 29, 2013 at 9:57 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

>> 1) Passing just "HEAD" as a committish like in "git contacts HEAD"
>> does not output anything for me, but using the SHA1 for HEAD does
>> neither. My HEAD commit does not add any files, but only modifies
>> previously existing files, so I would have expected some output. In
>> case it turns out to be correct to have no output in my case, could we
>> probably say that in some message to the user?
>
> It should be HEAD^, or -1, like with 'git format-patch'.

Oh, that's pretty much unexpected. Wouldn't it be much more natural if
I had to specify the commit(s) that introduce(s) the changes that I
want others to look at?

>> 2) For some commits I get error messages from "git blame" in function
>> get_blame because multiple -L options are specified:
>>
>> $ git contacts b0783baacd20be7007df40cf274985c4863d63fb
>> fatal: More than one '-L n,m' option given
>> fatal: More than one '-L n,m' option given
>> fatal: More than one '-L n,m' option given
>> fatal: More than one '-L n,m' option given
>>
>> From reading git-blame's man page it indeed seems to me as if only one
>> -L option is allowed, so is this something that needs to be fixed in
>> git-contacts?
>
> You are probably using a newer version of the script on an older version of Git.

Well, I'm running Git for Windows 1.8.4, and according to [1]
git-blame was not changed after 1.8.4.

> You can also try git-related instead[1].
>
> [1] https://github.com/felipec/git-related

I just did very quickly (with Ruby 1.8.7) and I get:

$ git related b0783baacd20be7007df40cf274985c4863d63fb
C:/Program Files (x86)/Git/libexec/git-core/git-related:309:in
`popen': can't convert Array into String (TypeError)
        from C:/Program Files
(x86)/Git/libexec/git-core/git-related:309:in `from_rev_args'
        from C:/Program Files (x86)/Git/libexec/git-core/git-related:345

[1] http://git-scm.com/docs/git-blame.html

-- 
Sebastian Schuberth
