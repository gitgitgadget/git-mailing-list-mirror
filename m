From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Mon, 10 Mar 2008 13:17:55 +0000
Message-ID: <e1dab3980803100617n61429036w7dbbeab1f535dd39@mail.gmail.com>
References: <47AAA254.2020008@thorn.ws> <20080207063020.GP24004@spearce.org>
	 <200802071056.19370.robin.rosenberg.lists@dewire.com>
	 <20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>
	 <20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
	 <18368.41742.689290.877767@cargo.ozlabs.ibm.com>
	 <47C190E3.6000407@gmail.com>
	 <18383.57540.26282.526111@cargo.ozlabs.ibm.com>
	 <20080307111144.GA18108@piper.oerlikon.madduck.net>
	 <18386.29775.512557.202621@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "martin f krafft" <madduck@madduck.net>,
	"Mark Levedahl" <mlevedahl@gmail.com>,
	"Gerrit Pape" <pape@smarden.org>, git@vger.kernel.org,
	442253-quiet@bugs.debian.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 14:19:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYhuG-0000kf-JA
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 14:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbYCJNR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 09:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753217AbYCJNR7
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 09:17:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:25995 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbYCJNR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 09:17:58 -0400
Received: by ug-out-1314.google.com with SMTP id z38so4857287ugc.16
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2EJfJGlePf/qMG3wUNAif0+A7Vyay6/dIRrr8ygUYZc=;
        b=uxnMbBqJXUU4sW5ECvX6dhqT0wvSs0HHcCvPw+dUFItRYGV581TKrB+ib6A233up1AZpo1+Sn/+/JwwMlgJuQqKKtGq2ieWC98ArbpvirGJzDZtr+V8go16NohqaSbOeh4FJdnz/tZo4sMETGobXp7isCc3YiIcYwQpCGFJ+XOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i/1EbR4SKC6nv4XFLLwsc7/bXvuuIuV/AsJzqZmeKG6X6uFFpcg8E3nz2jmq0m+21Wh2OUbdwcxsjMCQY5jEqqN+ezr5tGSlIVmUH06FF2WdcC78NroyJoDuIBAhTMHI80so6drISKGOCwegK6KD0cxUaGjIOhkoBoW0AS3cg3M=
Received: by 10.150.58.5 with SMTP id g5mr2779239yba.20.1205155075598;
        Mon, 10 Mar 2008 06:17:55 -0700 (PDT)
Received: by 10.150.149.2 with HTTP; Mon, 10 Mar 2008 06:17:55 -0700 (PDT)
In-Reply-To: <18386.29775.512557.202621@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76726>

2008/3/8 Paul Mackerras <paulus@samba.org>:
>  > As I said earlier, this is really the job
>  > of a window manager, *not* a configuration option. If your window
>  > manager cannot restore the window to a size you control, then it's
>  > broken. Let's not hack applications to work around that, please.
>
>  I disagree.  It's not a window manager's job to tell an application
>  how big its window should be.

There are some modestly popular tiling window managers that attempt to
remove the bother of having to manually move windows around which take
the view that the window manager's decisions should only be overruled
in the very rare cases where it's absolutely necessary, eg,

Ion http://modeemi.fi/~tuomov/ion/
dwm http://www.suckless.org/wiki/dwm

(The major windows that don't resize well are from image based
programs where you want exactly the underlying image on your display.
Text based programs like gitk work great under autoresizing.) However,
the current gitk appears to work fine on those window managers because
the internal dividers get automtatically resized whenever the global
window resizes, and the wm resizes the window so quickly after
creation I don't have time to notice it.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
