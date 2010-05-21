From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH] edit: Allow setting git tree SHA1 of a patch
Date: Fri, 21 May 2010 15:59:23 +0200
Message-ID: <u5tzkzt73us.fsf@beatles.e.vtech>
References: <20100516172738.5043.94039.stgit@localhost.localdomain>
	<AANLkTikcG3Chw1cpiKB00MrnZz-HZk9xAF_KtTTiVECi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kha@treskal.com, git@vger.kernel.org
To: Gustav =?utf-8?Q?H=C3=A5llberg?= <gustav@gmail.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 16:16:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFT1O-0003Ey-P1
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 16:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666Ab0EUOQN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 10:16:13 -0400
Received: from [62.20.90.206] ([62.20.90.206]:41422 "EHLO beatles.e.vtech"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753666Ab0EUOQM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 10:16:12 -0400
X-Greylist: delayed 999 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 May 2010 10:16:12 EDT
Received: from beatles.e.vtech (localhost.localdomain [127.0.0.1])
	by beatles.e.vtech (8.13.1/8.13.1) with ESMTP id o4LDxS75030483;
	Fri, 21 May 2010 15:59:28 +0200
Received: (from david@localhost)
	by beatles.e.vtech (8.13.1/8.13.1/Submit) id o4LDxNgF030482;
	Fri, 21 May 2010 15:59:23 +0200
X-Authentication-Warning: beatles.e.vtech: david set sender to davidk@lysator.liu.se using -f
In-Reply-To: <AANLkTikcG3Chw1cpiKB00MrnZz-HZk9xAF_KtTTiVECi@mail.gmail.com>
	(Catalin Marinas's message of "Fri, 21 May 2010 13:37:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147457>

Catalin Marinas <catalin.marinas@gmail.com> writes:

> Hi Gustav,
>
> 2010/5/16 Gustav H=C3=A5llberg <gustav@gmail.com>:
>> I would like to have something similar to this patch, which allows f=
or
>> setting the (git) tree of a particular patch. I would like to use it
>> (from the Emacs mode) to make it easier to split an old patch into t=
wo
>> (or more).
>>
>> It might be that this is too "powerful" (read: unsafe), and maybe a
>> better (safer) command would use whatever is currently in the index
>> rather than a SHA1.
>
> I'm not against such option (as long as it is somehow mentioned that'=
s
> dangerous) though I don't fully understand how one would use it,
> especially when the patch is buried under other patches. With a serie=
s
> of patches, any easily accessible tree (sha1) belongs to one of the
> patches.

The idea is that Gustav wants to allow the editing of a file as it
appears in an earlier version. Lets say you have patches A, B, C and
D. You realize that one of the changes in to foo.c in C shuold really b=
e
done in A. So you open the "A version of foo.c" in your editor, do the
change, and then save it. The save operation needs to update A to be
the new tree that contains the updated foo.c, and the remaining patches
will keep their tree. The effect is that the moved change now appears a=
s
a diff in A, but not in C (nor B or D).

Working like this means that we don't really see the series as a string
of pateches, but as a series of named commits that we can go back and
edit. But this is a natural way of working with it once the tools get
powerful enough to support it.

--=20
David K=C3=A5gedal
