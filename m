From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 15:27:12 -0500
Message-ID: <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com> 
	<8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 21:27:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcPLX-0000OU-F9
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 21:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607Ab0BBU1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 15:27:34 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:36761 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab0BBU1d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 15:27:33 -0500
Received: by yxe27 with SMTP id 27so459855yxe.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 12:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dD4q0tRtL9uyA8Htc+Bt1JnRaEBa032grJgP/MOekIg=;
        b=PQZCfWXF33wZi3FuTJxE3JK0XvjdRPjQlk5evft8SDoO0bh6x9ZzNxjmJLGvWYgTxB
         D1yBKgYnB/TBF61ejAiBYzvqUfBJCDODn5QOvl5cQHNdZm7RLnBGOD3/dbSEb1p/aneB
         i4AqjmUaQ3ZKTgWYl+HbtjqKF8fplNFN8iFu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=a8MU4q+QWTbhrdTaxnVm4NyIQnPz8O0Zg6dMSrjisoE0UXtZA5NSPipv95HLNPO5vn
         lxgn2H5ADF6otHrPAl+JqAk5rjJdftW8y40LlfeRaObgeewYMHA4lj/HUpOmo66l1tXy
         xxRzFQhYDc6tLFhW/z98PyuboxQ9GSfEGC7iY=
Received: by 10.150.252.4 with SMTP id z4mr9184816ybh.295.1265142452066; Tue, 
	02 Feb 2010 12:27:32 -0800 (PST)
In-Reply-To: <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138751>

On Tue, Feb 2, 2010 at 3:14 PM, Jacob Helwig <jacob.helwig@gmail.com> w=
rote:
> On Tue, Feb 2, 2010 at 12:07, Eugene Sajine <euguess@gmail.com> wrote=
:
>> When git commit --amend is executed it fires up vi so i can change t=
he
>> commit message. If I have something staged, then when I'm exiting vi
>> using :q (without doing/writing any changes), it still commits
>> everything staged with old message.
>>
>> I believe it should actually abort amending and return to the state
>> before the "git commit --amend" was issued.
>
> I don't think this is actually the right way to go. =A0A _very_ commo=
n
> use case for "commit --amend" is to add things to the previous commit=
,
> without changing the commit message at all. =A0Yes, you can avoid hav=
ing
> to fire up the editor at all in this case, but it's still a perfectly
> valid thing to want to do.

I agree and I do this all the time. However, I've also done it
accidentally before I learned the "remove the commit message and save"
trick.

Perhaps what's really missing is more documentation of how to
"unamend" if you change your mind :)  I happen to know about "git
reset HEAD@{1}" but it's not terribly obvious.

Avery
