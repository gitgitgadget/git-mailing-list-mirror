From: Ilya Bobyr <illia.bobyr@gmail.com>
Subject: Re: [PATCH] gitk: replace SHA1 entry field on keyboard paste
Date: Wed, 05 Mar 2014 00:48:54 -0800
Message-ID: <5316E4F6.2080803@gmail.com>
References: <1393570297-6012-1-git-send-email-ilya.bobyr@gmail.com> <xmqqmwh5ltjo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ilya Bobyr <ilya.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 09:49:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL7Vm-0005Bz-0w
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 09:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbaCEItE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 03:49:04 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:60297 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbaCEItD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 03:49:03 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so802839pbb.0
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 00:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Op2BaWl2QOsCvWLGbZbhnMpX1q5fw/8Oa3t1YHNrr3o=;
        b=A9ONfhMH68aJaqmr4a+yBooBx/u7zKlt2b6WSp93cbK1aP7pFF67nzFrQyLCVpIhSg
         hgnGYrfw1rsLrGA+elZ/UOuIhC/f/j1eJjzOLDRzJTg4MpPCr++nG8wHARuDsALEPN1a
         7aRruQYgQvgp4uFD/+vox8u5H3bLUgS9hFwMnXcLjLj4BjdD5bz/tAzhLlEhD1EGp9wy
         3cWWrd8jztIT1VNkv+Bk2SCyTc0zxQbNdKRrbX4f7VBqZ3nNVVsUy73H2mNGla+1MAyD
         SGsVC0xAq9aH3SWFM2R9cVd7fBPCrp2u21tznAtAxY5zwbIUv5vo8MM26ALNWNecdGik
         SVQA==
X-Received: by 10.67.23.135 with SMTP id ia7mr5272813pad.5.1394009342022;
        Wed, 05 Mar 2014 00:49:02 -0800 (PST)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id om6sm5549676pbc.43.2014.03.05.00.48.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Mar 2014 00:49:01 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:27.0) Gecko/20100101 Thunderbird/27.0
In-Reply-To: <xmqqmwh5ltjo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243427>

On 3/4/2014 10:15 AM, Junio C Hamano wrote:
> From: Ilya Bobyr <ilya.bobyr@gmail.com>
> Date: Thu, 27 Feb 2014 22:51:37 -0800
>
> We already replace old SHA with the clipboard content for the mouse
> paste event.  It seems reasonable to do the same when pasting from
> keyboard.
>
> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
> ---
>
>   * Paul?  I do not use <<Paste>> on my keyboard, so I am not in the
>     position to say that this patch is correct (or not).  I am just
>     forwarding it in case you think gitk users will find it useful.

I should have included a cover letter with additional details on what is 
this.
I am still a bit new to the process, so I did not realize it would be 
useful until now.

<<Paste>> is the "clipboard paste" shortcut.  Ctrl+V on WIndows and Ubuntu.

SHA fields in gitk is a text field that accepts focus.  My expectation 
is that I can replace SHA already in there with one I have in the clipboard.
The problem is that I was not able to find an easy way.  Not immediately 
at least.
Here is what I observed:
1. If I just click in there and press Ctrl+V, SHA from the clipboard is 
inserted in the spot that I clicked.  Most cases in the middle of the 
SHA symbols already in there.
      Fixing the mess afterwards in just impossible.
2. If I double click "old" SHA in order to select and delete it before 
the paste, selected text is automatically copied into the clipboard (at 
least on Cygwin).
     While the SHA field is now empty to accept "new" SHA, the clipboard 
content is lost and I have to go copy new SHA into the clipboard again.
3. I can click once to give SHA field keyboard focus, delete whatever is 
there using Delete and/or Backspace and then paste new SHA.
     While this works it is not very convenient.  I also keeped pressing 
Ctrl+W to "delete a word" that was closing gitk window completely %)

Now, it turned out that if I use mouse to do the paste, not the 
keyboard, it does do what actually makes sense: removes old SHA and 
pastes the new one.
As SHA's are atomic, there seems to be no value in been able to insert 
one in the middle of another.

The bug, as I see it, is that it happens only if mouse paste is used.  
That would be the "<<PasteSelection>>" in the line above the added one.

When keyboard paste is used old SHA is not cleared.

I guess one would say that inserting with the mouse is actually easier, 
but been a Windows user it was unusual to me to use mouse paste in the GUI.
I have never even thought to do that and was struggling for quite a while.

The patch makes both mouse and keyboard paste work the same.
I think that could help someone else who is not used to mouse paste in 
the GUI text boxes as well.

>     The original patch was done against my tree, so I hand tweaked it
>     to apply to your tree.
>     
>     Thanks.
>
>   gitk |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/gitk b/gitk
> index 90764e8..2f58bcf 100755
> --- a/gitk
> +++ b/gitk
> @@ -2585,6 +2585,7 @@ proc makewindow {} {
>       bind $fstring <Key-Return> {dofind 1 1}
>       bind $sha1entry <Key-Return> {gotocommit; break}
>       bind $sha1entry <<PasteSelection>> clearsha1
> +    bind $sha1entry <<Paste>> clearsha1
>       bind $cflist <1> {sel_flist %W %x %y; break}
>       bind $cflist <B1-Motion> {sel_flist %W %x %y; break}
>       bind $cflist <ButtonRelease-1> {treeclick %W %x %y}
