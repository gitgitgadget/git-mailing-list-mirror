From: Alexey Borzenkov <snaury@gmail.com>
Subject: Re: [PATCH] gitk: restore wm state to normal before saving geometry 
	information
Date: Tue, 15 Sep 2009 16:54:25 +0400
Message-ID: <e2480c70909150554p2e211d60y18049b5534f8922e@mail.gmail.com>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
	 <87eiq8ct40.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Sep 15 14:54:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnXYS-00008a-0R
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 14:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbZIOMyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 08:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbZIOMyX
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 08:54:23 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:62268 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbZIOMyW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 08:54:22 -0400
Received: by fxm17 with SMTP id 17so1532359fxm.37
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 05:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=2G9w7M9Rn/Y3stO/JlsfT6meGng/f4Aj1bp479DS2BE=;
        b=dKULxUnEjyxsg+Xseaf0in6ELaSEs50V9dCdBKHSOmJ+1RxIkDSI8jyurSJrPlAbwp
         RznS0A+Gq+xqN9kDcTfXHdUojtjiWnplMjl/ASPiDgNtS0xh+tLaJwd/B0bb2mpjcYrH
         wMk65sXA5hjmgpaCIa99/Th5L0ebHDuljPJW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fnl3X+nCZ1d24a7dQk/Kxj7uDWmiC16APwoBMxDzfJrIx3A1JtL15hR6dQFC/iLM7q
         WH2ROPf4XOFTuWMf2tUWE/zBkJffbA9MWxizd3bYJ3jYZBXyq5Vwfr/JH3myQZk5zBWU
         9l7k/o64Ei2NU9sg3WLySanRTft17cs3eZOgc=
Received: by 10.223.144.70 with SMTP id y6mr2606691fau.12.1253019265154; Tue, 
	15 Sep 2009 05:54:25 -0700 (PDT)
In-Reply-To: <87eiq8ct40.fsf@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128537>

On Tue, Sep 15, 2009 at 4:03 PM, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
>>gitk now includes patches for saving and restoring wm state, however
>>because it saves wm geometry when window can still be maximized the
>>maximize/restore button becomes useless after restarting gitk (you
>>will get a huge displaced window if you try to restore it). This
>>patch fixes this issue by storing window geometry in normal state.
> I tried this patch on windows and I find that it causes the columns in
> the top view to creep each time you restart the application. This is I
> think due to the way this patch sets the state to normal before
> recording all the settings.


This is strange, as I certainly don't see this behaviour now (I'm
using gitk in version 1.6.4.3). Actually, I did see that behaviour
once, but I believe this was when I ran an unpatched gitk which seemed
to record wrong geometry. As soon as I cleared ~/.gitk of those wrong
coordinates I haven't seen this behaviour anymore.

On the other hand, when I resize columns and then maximize/restore the
window repeatedly I see that their sizes change in a strange way (and
the smaller restored window they stranger are results) until hitting
some sort of equilibrium, then maximize/restore doesn't have effect on
their sizes anymore. So maybe there's a bug not in a way my patch
restores the window, but in a way window resizes are handled.


> I will post an alternative patch that records the normal geometry
> whenever it changes instead which seems to work better for me.


By all means.
