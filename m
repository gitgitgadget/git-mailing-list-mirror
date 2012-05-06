From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: git-scm.com refresh
Date: Sun, 6 May 2012 09:33:10 +0100
Organization: OPDS
Message-ID: <C0239E9A908644EAB06A52AE4A90F401@PhilipOakley>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com> <7vd36j8lc3.fsf@alter.siamese.dyndns.org> <CAP2yMaJsDysqwwUga+fyWhUV-r78FoK7psY7howNBOCnsKLhvA@mail.gmail.com> <7vwr4q6qbh.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 10:33:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQwu3-0001af-Lk
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 10:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530Ab2EFIdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 04:33:11 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:59788 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752430Ab2EFIdI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 04:33:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgEFAFs2pk9cHlGK/2dsb2JhbABEizqnOIEIggcBBAEBBQgBAS4eAQEcBQsCAwUCAQMVAQslFAEECBIGBxcGARIIAgECAwGFOAeCKAgDDweveA2JU4oXaIU9YwSIMIVKk0OFA4JqgV0
X-IronPort-AV: E=Sophos;i="4.75,538,1330905600"; 
   d="scan'208";a="379969675"
Received: from host-92-30-81-138.as13285.net (HELO PhilipOakley) ([92.30.81.138])
  by out1.ip05ir2.opaltelecom.net with SMTP; 06 May 2012 09:33:06 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197157>

From: "Junio C Hamano" <gitster@pobox.com> Sent: Sunday, May 06, 2012 2:39
AM
 > Scott Chacon <schacon@gmail.com> writes:
>
>>> As "diff" is listed in "Basic Snapshotting", and it will not
>>> be able to achieve that without being able to apply its output back to
>>> the
>>> working tree or to the index, I would suggest moving "apply" to the
>>> section as well.
>>
>> I have to disagree.  You are thinking of 'apply' from an internals
>> perspective I have to assume, because I use 'diff' every single day
>> for all sorts of stuff ("what is modified and unstaged?", "what is
>> modified and staged?", "what is different between these two branches?"
>> etc) ...
>
> The other day when I was surfing the 'net, I found a blog that was
> complaining about Git UI.  Some of the things were worth listening to, but
> there was one item I really had to scratch my head where the misconception
> behind the complaint came from.  I am typing from memory without bothering
> to go back to the site to quote, but the complaint essentially was:
>
>        Getting a patch is easy with "git diff", but to apply it you need
>        to make it an email and feed it to "git am"???  That's crazy.
>
<snip>

> "diff" pairs with "apply", and "format-patch" pairs with "am".
>
> I wouldn't mind adding "git patch" as a built-in synonym/alias for "git
> apply", if you think that would make the above pairing more obvious.  Many
> computer users know what "patch" does already even they have never used
> any SCM.
>

Part of the problem is that the `git diff` man page [1] doesn't actively
tell the user that its result will be in a patch format, and that such a
patch can be `apply`ed. There are only 5 uses of 'apply' buried in the body
text, never as a command, as if they are special cases. There is a section
on the -p option, again it feels like it is a special case.

The "--patch" option in [1] is corrupted(?) relative to my desktop in that 
it
misses the "(This is the default.)" ending (which most readers skip over 
when
speed reading).

The normal case of `git diff` for most users is simply as an extended 'what
changed' git status.

The `git apply` page [2] does say its about a diff:
    "DESCRIPTION - Reads the supplied diff output (i.e. "a patch") and
    applies it to files."
so it reads ok in reverse.

Perhaps for `git diff` man page
    NAME - git-diff - Show changes/, usually as a patch,/ between commits,
    commit and working tree, etc.

Then
    DESCRIPTION - Show changes ...two files on disk.
     /You can implement a diff patch by using git-apply(1)./

The main point is that the new user is probably unaware of many of the
conventions others take for granted. This gives them 'a clue' about `apply`.

Philip

[1] http://git-scm.com/docs/git-diff
[2] http://git-scm.com/docs/git-apply.html
