From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH] git-gui: highlight trailing whitespace in diff view
Date: Wed, 20 Oct 2010 17:30:26 +0200
Message-ID: <AANLkTimrrxbKSYib7g0O5TXXwt5yDTdkt_bycs69mKT7@mail.gmail.com>
References: <AANLkTikttRVeE+PVUJGiLERC=qdoxSH1oyXa5HLXoW0N@mail.gmail.com>
	<87hbgh7paf.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git mailing list <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Oct 20 17:30:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8ack-0002rm-VQ
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 17:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884Ab0JTPa2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 11:30:28 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35860 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab0JTPa1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 11:30:27 -0400
Received: by pva18 with SMTP id 18so735127pva.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4Dme7Wn4v3ZIvKRD4Bw7e5T1BBdYj2261T/prm0KtF4=;
        b=sW1UOn1LT2WdrlfMAzCzkIoU9zjfxbfnTB71USM6LzcRUC7a80rKyBIZehES6ag4oB
         AYrDSwYaAXfBHHQPTUOmenNaaqcZ/87z8XRpVWkXN59EjhMn429ybLt2UIIenT8LoA/N
         QmGqoTGBu2hnd9RIKrg7mIRYRgvVP4ZNF+MTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZPcKYUSnZvfNoXT34Z4wa2LS1Ih5BE5YA8DqttX/xG2JdOsd4oswDiADqG0hC1UmrN
         CBV6qzZLlmG88/L/FeEOwif/F+UpUEs0RHmuHQ56XXV/khN2iiZpG9/wYmBFJ+EYsWqv
         TIvblWeUDgYGL3dKGz8SpQAgarnb4yMaBoDG4=
Received: by 10.143.18.7 with SMTP id v7mr5966814wfi.254.1287588626366; Wed,
 20 Oct 2010 08:30:26 -0700 (PDT)
Received: by 10.220.76.74 with HTTP; Wed, 20 Oct 2010 08:30:26 -0700 (PDT)
In-Reply-To: <87hbgh7paf.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159413>

On Wed, Oct 20, 2010 at 12:59 AM, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> Highlight any trailing whitespace in the diff view using a red backgr=
ound
> as is done in the terminal when color is enabled.
>
> Suggested-by: Tor Arvid Lund <torarvid@gmail.com>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

Hey, Pat, and thanks for this. It solves my initial question. But in
the time since I asked that question, I started thinking that it
probably should honor the core.whitespace settings, and also work for,
say, 'space-before-tab'. (You seem to say the same thing in your
commit msg, I see)

I tried hacking it for a bit, but my Tcl knowledge is Absolute Zero,
so it got frustrating pretty fast :)

> ---
>
> Tor Arvid Lund <torarvid@gmail.com> writes:
>>Hi, all! When doing "git diff", whitespaces before EOL, for instance,
>>are marked with red background in my terminal.
>>
>>Is it possible to see this coloring in git gui too?
>>
>>-Tor Arvid-
>
> This patch should do the job. It probably should get some configurati=
on
> item to control this though.
>
> =C2=A0git-gui.sh =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0lib/diff.tcl | =C2=A0 =C2=A09 ++++++++-
> =C2=A02 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 25229a4..8d652f0 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -3314,6 +3314,7 @@ pack .vpane.lower.diff.header -side top -fill x
> =C2=A0pack .vpane.lower.diff.body -side bottom -fill both -expand 1
>
> =C2=A0$ui_diff tag conf d_cr -elide true
> +$ui_diff tag conf ws -background red
> =C2=A0$ui_diff tag conf d_@ -foreground blue -font font_diffbold
> =C2=A0$ui_diff tag conf d_+ -foreground {#00a000}
> =C2=A0$ui_diff tag conf d_- -foreground red
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index c628750..83e3f6d 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -434,7 +434,14 @@ proc read_diff {fd cont_info} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ui_diff insert en=
d $line $tags
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if {[regexp -indic=
es {^.*\S(\s+)$} $line -> ndx]} {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set =
ndx [expr {[lindex $ndx 0] - 1}]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 set nonws [string range $line 0 $ndx]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 $ui_diff insert end $nonws $tags \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [string range $line [incr ndx] end]=
 [concat $tags ws]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 $ui_diff insert end $line $tags
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
<snip>

So - what I tried to do was expand on this (to include a
'space-before-tab' filter). I can't make a simple "elseif" for regexp
"( +)\t" (or whatever the right regexp may be).

I mean that currently you can only match one ws-filter per line. So a
line with both space-before-tab and blank-at-eol would not be printed
correctly.

What I wanted to do, in pseudo-code, was:

read git config core.whitespace
for each diff-line #diff-line is any line starting with '+' or '-'
  set temp-ui-line to $line $tags
  if option_enabled core.whitespace.space-before-tab
    if regexp_match space-before-tab-pattern -> indices
      temp-ui-line.replace(indices[0], indices[1]) with-red-bg
  if option_enabled core.whitespace.blank-at-eol
    ...
  ..
end for

#and then
$ui_diff insert end $temp-ui-line
------------------

Maybe this is the easiest thing in the world to do in Tcl, but I don't
have more time to fiddle with it today :)

Thanks for the patch anyways.

-Tor Arvid-
