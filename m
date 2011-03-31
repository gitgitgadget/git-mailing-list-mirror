From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Git fails to push to secured webdav
Date: Thu, 31 Mar 2011 11:57:58 +0200
Message-ID: <AANLkTikEnFCUQvEHA6c5PAs_z-_REj9SqNfRjZ_9edzN@mail.gmail.com>
References: <7867a559-ea24-49c3-978b-a2b65100525f@o20g2000yqk.googlegroups.com>
 <AANLkTinrwn7k=69wrgTr8YW6GzwOeBP-mKSs2b+ZZHv2@mail.gmail.com> <4D944EE0.3090806@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Edwin Amsler <edwinguy@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 11:58:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5EeS-0003H6-4o
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 11:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933695Ab1CaJ6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 05:58:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64583 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933544Ab1CaJ6p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 05:58:45 -0400
Received: by fxm17 with SMTP id 17so1700214fxm.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 02:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gBXG0/MC6YWoEc83BZYeKKAsgHSq8o/XUAR0rZVLSSA=;
        b=pNJ22w6GxKVESaPqNeL8cR+Qy1FFcz4xtPUU3xlwpIxqNj1CNHB6AQ1ac0XmA60maT
         gUPlbU8Ocb33yho7o+st+dv5dlzdJ5JzUXcjoY97GFEIHTrfJuut7+fhFCgCxBj2eImK
         liNmyqwYN1Lthk7SvtPdcklPt49/1rvzNss4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=SXhjFrqgpF1o+W7ij6rPamF0RGjgp0yVBN8OuA+cn95K/xIKf/fmS4q6lvAU6811hg
         1SjZDEbKH1p6HkVtkJ3fnLfzjcSk3dIawwVRX7Tx9NJ1W8cR+M9EWTKt9+BUF7pSEfpO
         Tc7tIO6qMu3tiFbKlDiMoVSgBw+NztJft05GM=
Received: by 10.223.125.66 with SMTP id x2mr1658879far.51.1301565498166; Thu,
 31 Mar 2011 02:58:18 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Thu, 31 Mar 2011 02:57:58 -0700 (PDT)
In-Reply-To: <4D944EE0.3090806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170464>

Please don't cull the CC-list (hit "reply all" in your mailing list).
I'm not personally interested in the subject, so I'm not a likely
person to get help from.

On Thu, Mar 31, 2011 at 11:52 AM, Edwin Amsler <edwinguy@gmail.com> wro=
te:
> On 2011-03-31 4:19 AM, Erik Faye-Lund wrote:
>>
>> On Thu, Mar 31, 2011 at 11:06 AM, RandomInsano<edwinguy@gmail.com> =A0=
wrote:
>>>
>>> Aloha!
>>>
>>> I built a simple WebDAV share on my server. WebDAV is working
>>> marvelously! Git isn't :(
>>>
>>> Basically, when I auth with the server, git doesn't use those
>>> credentials when it does a WebDAV PROPFIND command, so it recieves =
a
>>> 401 not authorized response.
>>>
>>> This is the back and forth between git and my webserver:
>>>
>>> [Initial push, failing due to security settings[
>>> 10.0.0.100 - - [31/Mar/2011:03:48:27 -0500] "GET /dav/git/coral.git=
/
>>> info/refs?service=3Dgit-receive-pack HTTP/1.1" 401 409
>>> 10.0.0.100 - - [31/Mar/2011:03:48:31 -0500] "GET /dav/git/coral.git=
/
>>> info/refs?service=3Dgit-receive-pack HTTP/1.1" 401 409
>>> [Git has now asked for my password]
>>> 10.0.0.100 - edwin [31/Mar/2011:03:48:31 -0500] "GET /dav/git/
>>> coral.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 200 0
>>> 10.0.0.100 - edwin [31/Mar/2011:03:48:31 -0500] "GET /dav/git/
>>> coral.git/HEAD HTTP/1.1" 200 23
>>> [Woo! Auth'd!]
>>> 10.0.0.100 - - [31/Mar/2011:03:48:32 -0500] "PROPFIND /dav/git/
>>> coral.git/ HTTP/1.1" 401 397
>>> [WTF?! FAIL!]
>>>
>>> Any ideas what's causing this? Which libraries are to blame, etc?
>>>
>> Didn't you already report this to the main Git list yetsterday?
>>
>> http://article.gmane.org/gmane.comp.version-control.git/170280
>>
>> Besides, it seems to me that this question has been asked and answer=
ed
>> before:
>>
>> http://article.gmane.org/gmane.comp.version-control.git/105397
>
> Indeed I did report to the main list! Sometimes it's best to ask at m=
ultiple
> sources, despite the annoyance for those who are members of both grou=
ps.
> Sorry for the double post for you.
>
> The problem you referenced (git/webdav is refusing to authenticate pr=
operly)
> has the issue that git never tried to authenticate. Mine did. Then ju=
st
> forgot to use the authentication.
>

Did you setup your .netrc file like
Documentation/howto/setup-git-server-over-http.txt tells you to?

http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3DDocumentation/howto=
/setup-git-server-over-http.txt;h=3D622ee5c8dd7c384794a21baa6093d85a47f=
89a54;hb=3DHEAD
