From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 19:50:38 +0200
Message-ID: <200806031950.39602.jnareb@gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com> <200806031656.04780.jnareb@gmail.com> <b77c1dce0806030807t7654ac2cm96aa06690c7a5c02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Luben Tuikov" <ltuikov@yahoo.com>,
	"Sam Vilain" <sam@vilain.net>
To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 19:51:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3afe-0000d0-GM
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 19:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757137AbYFCRuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 13:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756990AbYFCRuq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 13:50:46 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:16615 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756348AbYFCRuo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 13:50:44 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1352989fkq.5
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=lxJwKqZKWERqpOY5uThtroRuwA9zz+o3vPD173fIR6I=;
        b=hDL23uhNYJ57pWu5KQGga6748taVj6hNft9TK9/v2/VN6zfRsNMRUiO9J893wJMy5Yw2d4JV1ItgkzVIN2tZ38EA4wP/dWJeJdgY+Mgx19HU8x7bIw634zoIw7SMn6s6NytHrAYpy7uk5SdV8z9a76SxmlosSyZl92tK/TER7ig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JHHmEVDCvbQyuS1Yh8uL73Yt7PThU6Kn3c94lcv37bakoewOr8dNte1N01jS3Tk1FxAK3ITs/rhVFbvcbbYNpUXy7MWzK4sbjRGjbBGvkRxDw+R7x9u0tNwOxIpcRj6DxVvJNxlsxICLPesUJQyFOjhLCYmXGorEC45wLYcl4s4=
Received: by 10.125.156.13 with SMTP id i13mr1111489mko.15.1212515442915;
        Tue, 03 Jun 2008 10:50:42 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.199])
        by mx.google.com with ESMTPS id h7sm1817988nfh.34.2008.06.03.10.50.39
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 10:50:41 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <b77c1dce0806030807t7654ac2cm96aa06690c7a5c02@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83682>

On Tue, 3 Jun 2008, Rafael Garcia-Suarez wrote:
> 2008/6/3 Jakub Narebski <jnareb@gmail.com>:

By the way, could you please try to not remove all but last quote 
attributions?  It should be, I think, as simple as replying then 
removing unnecessary parts, instead of selecting parts you want reply 
to and then hitting reply.  TIA

>>>> By the way, what is the difference between '<<' links and 'br' link
>>>> in the above mentioned annotate/blame interface?
>>>
>>> "br" navigates to another branch from which this file has been
>>> integrated (in p4 speak.)
>>
>> Does it mark merge commits then? Or perhaps branch points?  What
>> does "branch from which this file has been integrated" mean in git
>> speak (in the terms of DAG of commits)?
>>
>>
>> If the history of a file looks like this
>>
>>       ....*---*---A---M---C...
>>                      /
>>           ....*---B-/
>>
>> and the line comes from "evil merge" M git-blame would return M as
>> blamed commit.  If the line comes from one or the other branch, from
>> commit A or B, it makes I think no difference to git-blame; git tries
>> to be "branch agnostic" (no special meaning to first parent; well,
>> besides rev~n notation and --first-parent walk option).  I guess it
>> is not the case in Perforce?
> 
> No, in perforce the branch you integrate changes from is always
> explicit. 

So, in git speak, it means that 'br' means that blamed commit (commit 
which brought current version of given line) is not in first-parent 
line, and '<<' means that commit is in --first-parent history of a file 
(taking into account code copying and movement... err, at least in git 
case...), doesn't it?
 
>> [...]
>>>> [...].  Will you want to use git-diff-tree
>>>> to mark differences from the version we came from (marked by 'hp',
>>>> 'hpb' and 'fp' URI parameters), or would you rather extend
>>>> git-blame? 
>>>
>>> I don't know. I'll look at git-diff-tree.
>>
>> What I meant here, would you plan on extending git-blame, or would
>> you use patchset (textual) diff between revision we are at, and
>> revision we came from.  git-diff-tree just compares two trees (and
>> have to have patch output explicitely enabled).  Sorry for the
>> confusion. 
> 
> I'm under the impression that extending git-blame is a more flexible
> solution. 

I don't think that it is correct solution in this case.  I'm not sure if 
it can even be done. 

What you have (what "annotated file view" in Perforce web interface has) 
is difference annotations (one sided side-bys side diff ;-)), something 
like Eclipse QuickDiff, or like word-diff (or "git diff --color-words")
put _ON TOP_ of blame info.  

Generating such single pane in-file diff is orthogonal to generating 
blame info.  I think it would be best solved using patchset (textual) 
diff output; if git-diff would support "context" and not only "unified" 
patch output it could be used there.


What was I thinking when mentioning extending git-blame was "reblame", 
i.e. blaming only those lines which are different from some child 
version.  But while this would be very useful for tools such like 
"git gui blame" or blameview, it just won't work well I guess for web 
application (unless caching everything, and generating blame diff from 
cached blame).


As to extending git-blame --porcelain to output "parents <hash>..." 
header, it is better solution than "git rev-list --no-walk" used as a 
kind of git-rev-parse sequencer not only because it is one fork less 
(and blame has has this parent info anyway), but mainly that it better 
fits with the streaming flow of gitweb's git_blame2().  (I'll write 
about it more in separate letter).

-- 
Jakub Narebski
Poland
