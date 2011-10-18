From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: fix multi selected file operation
Date: Tue, 18 Oct 2011 09:13:54 +0100
Message-ID: <87mxcyn2d9.fsf@fox.patthoyts.tk>
References: <87cab38f99075f149a9abe7caf4ec139a0a48213.1318580310.git.bert.wesarg@googlemail.com>
	<87ehydhnwk.fsf@fox.patthoyts.tk>
	<CAKPyHN0iaS301r_d+kc-AVRNVKUprhdMwDpdD0HDf7nKbsPR3Q@mail.gmail.com>
	<877h43l0f3.fsf@fox.patthoyts.tk>
	<CAKPyHN0NUyd2E0UuJGpWoFNQw8h4kUkqP5Lcz0ywKjFNEgXsqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 10:14:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG4oK-0000oc-Ui
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 10:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab1JRIOB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Oct 2011 04:14:01 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:53207 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751043Ab1JRIN6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 04:13:58 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.4])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111018081356.TST13501.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Tue, 18 Oct 2011 09:13:56 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RG4o8-00055u-BW; Tue, 18 Oct 2011 09:13:56 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id D4F972003D; Tue, 18 Oct 2011 09:13:55 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <CAKPyHN0NUyd2E0UuJGpWoFNQw8h4kUkqP5Lcz0ywKjFNEgXsqw@mail.gmail.com>
	(Bert Wesarg's message of "Tue, 18 Oct 2011 08:31:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=dXLFLQziqoYA:10 a=8nJEP1OIZ-IA:10 a=mK_AVkanAAAA:8 a=FP58Ms26AAAA:8 a=Rf460ibiAAAA:8 a=ulsMs1I602axSgVgKyMA:9 a=cvknG8ACCb34ucwqHsMA:7 a=wPNLvfGTeEIA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183873>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>On Tue, Oct 18, 2011 at 00:26, Pat Thoyts
><patthoyts@users.sourceforge.net> wrote:
>> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>>
>>>Hi,
>>>
>>>On Sun, Oct 16, 2011 at 00:48, Pat Thoyts
>>><patthoyts@users.sourceforge.net> wrote:
>>>> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>>>>
>>>>>The current path for what we see the diff is not in the list of se=
lected
>>>>>paths. But when we add single paths (with Ctrl) to the set the cur=
rent path
>>>>>would not be used when the action is performed.
>>>>>
>>>>>Fix this by explicitly putting the path into the list before we st=
art
>>>>>showing the diff.
>>>>>
>>>>>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>>>>---
>>>>> git-gui.sh | =A0 =A01 +
>>>>> 1 files changed, 1 insertions(+), 0 deletions(-)
>>>>>
>>>>>diff --git a/git-gui.sh b/git-gui.sh
>>>>>index f897160..e5dd8bc 100755
>>>>>--- a/git-gui.sh
>>>>>+++ b/git-gui.sh
>>>>>@@ -2474,6 +2474,7 @@ proc toggle_or_diff {w x y} {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [conc=
at $after [list ui_ready]]
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>>> =A0 =A0 =A0 } else {
>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0set selected_paths($path) 1
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_diff $path $w $lno
>>>>> =A0 =A0 =A0 }
>>>>> }
>>>>
>>>> It is not clear what I should be looking for to test this. Can you
>>>> re-write the commit message to be more clear about what you are
>>>> fixing. Is this multiple unstaged files in the staging box? If so =
I
>>>> don't see what path display is changing.
>>>
>>>Sorry, for this bad description. I will give you a recipe here what =
to
>>>do to expose the problem. I try later to form this into a new commit
>>>message:
>>>
>>>You have 2 modified, not staged files A and B. Your current view sho=
ws
>>>the diff for A. Adding B to the selection via Ctrl+Button1 and than
>>>perform the "Stage To Commit" action from the "Commit" menu results
>>>only in the staging of B.
>>>
>>>Note, using Shift+Button1 (i.e. 'adding a range of files to the
>>>selection') results in the staging of both files A and B.
>>>
>>>Bert
>>
>> Ah ok - that explains things and I can see the issue now. I think
>> something like:
>>
>> "When staging a selection of files using Shift-Click to choose a ran=
ge
>> of files then using Ctrl-T or the Stage To Commit menu item will sta=
ge
>> all the selected files. However if a non-sequential range is selecte=
d
>> using Ctrl-Click then only the last name selected gets staged. This
>> commit fixes this to properly stage all selected files by explicitly
>> adding the path to the list before showing the diff."
>
>Thanks for this. A slight, but important, change to the second last se=
ntence:
>
>"...using Ctrl-Click then all but the first name selected gets staged.=
"
>
>Its the first which does not get staged. Ie. that one, which was
>selected just by a Click to view the diff.
>
>Bert
>

Thanks - applied with this change to the message.
--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
