From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Detached HEAD problem
Date: Tue, 24 Apr 2012 16:45:20 -0400
Message-ID: <CAPZPVFZch7TzWkrYLt_MSAEDrJBGtPsf+Gvjh_e+Uk=O_tHq0Q@mail.gmail.com>
References: <1335298250.31016.YahooMailClassic@web125404.mail.ne1.yahoo.com>
	<CAPZPVFbv7cGzqrHrKWPig0XSbSztbGoS=Twy8xH5Ac5r0xrQFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: M Yep <myep01@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 22:45:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMmc3-0005O2-53
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 22:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757592Ab2DXUpW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Apr 2012 16:45:22 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34725 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab2DXUpW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 16:45:22 -0400
Received: by lbbgf7 with SMTP id gf7so995967lbb.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YN2VVDZdd5YkuMHijbwGWKkXo99m5g8kxHXwi2CleO0=;
        b=j1pWuTOjw/9Eb4qeut11P7ci1qNviYB8WWQngsJkCMhJxSplaOSe2Hs8p4DS2HzKyU
         MWxR83dLgRLEcOBH2lHhtNT+w8Rt1BfzAUhduf42Cs6PU5u+WP3xvexGxublpyLla6N8
         1kJxD3ehDOcdR3vSL/+XN+UonuwemuHexUmSnfUqIlU+TXGqsbGNludEtCmNX6HXWUEl
         Vm+kSDN1WdGu9k86mMYly7aSYY/QHYhxDgiGpVvBBbPrlyFkd4P6Ci8f4Ow2ubx3k7rh
         RtinXiXM/AFVoY7jyW7+VN/thgTid8ldRGSCUHsM4CIfOFDKVdXaI+BbBecqMdieuMfQ
         kwrQ==
Received: by 10.152.130.138 with SMTP id oe10mr35286lab.5.1335300320588; Tue,
 24 Apr 2012 13:45:20 -0700 (PDT)
Received: by 10.112.17.166 with HTTP; Tue, 24 Apr 2012 13:45:20 -0700 (PDT)
In-Reply-To: <CAPZPVFbv7cGzqrHrKWPig0XSbSztbGoS=Twy8xH5Ac5r0xrQFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196250>

On Tue, Apr 24, 2012 at 4:43 PM, Eugene Sajine <euguess@gmail.com> wrot=
e:
> On Tue, Apr 24, 2012 at 4:10 PM, M Yep <myep01@yahoo.com> wrote:
>> Hello
>>
>> I have been working on a project and I realized somewhere I introduc=
ed a
>> bug.
>>
>> I found the closest save point to where i was, i believe it was HEAD=
 -2,
>> and checked it out.
>>
>> I then laid in several commits, and now i cant push
>>
>> here is a view of my history, and the commands i executed to get int=
o this
>> state
>>
>> HISTORY (time flows up)
>>
>> * 1bc1ffb current state
>> * 735d64f
>> * 07dd73d Project working again
>> * c70627c
>> * 4c6a8ea
>> * 2828db4
>> * c38ef0b
>> | * 1815aac
>> | | * fe6e0ac Version bump
>> | | * 32de1e5 BROKE
>> | | * 528cb37 Bug introduced?
>> | |/
>> | * ef4ff7e
>> |/
>> | * ef4ff7e
>> |/
>> * 8238b14 GOOD
>> .
>> .
>> .
>>
>>
>> COMMANDS (time flows down)
>>
>> PUSH 8238b14 GOOD
>> PUSH ef4ff7e
>> PUSH 528cb37 Bug introduced?
>> PUSH 32de1e5 BROKE
>> PUSH fe6e0ac BROKE Version bump
>> CHECKOUT master -> ef4ff7e
>> CHECKOUT ef4ff7e -> dev
>> COMMIT 1815aac
>> CHECKOUT dev -> 8238b14
>> COMMIT c38ef0b
>> COMMIT 2828db4
>> COMMIT 4cba8e9
>> COMMIT c70627c
>> COMMIT 07dd73d =C2=A0Project OK again
>> CHECKOUT 07dd73d -> mvp1
>> CHECKOUT mvp1 -> master
>> COMMIT 735d64f
>> COMMIT 1bc1ffb =C2=A0 =C2=A0current state
>>
>> now when i try to push:
>>
>> user@host:~/workspace/project$ git push
>> To git@github.com:xxxxxxxxxxxxx.git
>> =C2=A0! [rejected] =C2=A0 =C2=A0 =C2=A0 =C2=A0master -> master (non-=
fast-forward)
>> error: failed to push some refs to 'git@github.com:xxxxxxxxxxxxxxxxx=
xx.git'
>> To prevent you from losing history, non-fast-forward updates were re=
jected
>> Merge the remote changes before pushing again. =C2=A0See the 'Note a=
bout
>> fast-forwards' section of 'git push --help' for details.
>>
>>
>> user@host:~/workspace/project$ git status
>> # On branch master
>> # Your branch and 'origin/master' have diverged,
>> # and have 7 and 4 different commit(s) each, respectively.
>> #
>> nothing to commit (working directory clean)
>>
>>
>> user@host:~/workspace/project$ git branch
>> =C2=A0dev
>> * master
>> =C2=A0mvp1
>> =C2=A0noopt
>> =C2=A0temp
>>
>>
>> Any help would be great.
>>
>> Thanks
>>
>> Mike
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
Your second sentence is the answer to you question:
You have moved master back a couple of commits and then started to
create new commit as those two never existed. The remote side doesn't
know about that and still points to the old commit tree.
Therefore it is not possible to move the pointer on the remote side
from its current location to your new location as it will mean that
some commits will be lost.
in order to insist on the push you might use -f, that will force push
operation and overwrite the history on the remote side.
I would recommend to be VERY careful with this option because if the
project is actively developed you might loose somebody else's commits.

Considering the rule of not overwriting published history safer
variant to me would be to rebase your current master on top of the
origin/master and then you will have a fast-forwardable update of the
remote side. That will mean that you will have the commit that
introduced the bug in the history and then you will provide a bug fix
on top of that, which is normal flow to me.

Hope that helps
Eugene
