From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Thu, 6 Mar 2008 12:59:24 +0000
Message-ID: <57518fd10803060459m6e3ffc00n388721ad2e5975ad@mail.gmail.com>
References: <47AAA254.2020008@thorn.ws> <20080207063020.GP24004@spearce.org>
	 <200802071056.19370.robin.rosenberg.lists@dewire.com>
	 <20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>
	 <20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
	 <18368.41742.689290.877767@cargo.ozlabs.ibm.com>
	 <47C190E3.6000407@gmail.com>
	 <18383.57540.26282.526111@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mark Levedahl" <mlevedahl@gmail.com>,
	"Gerrit Pape" <pape@smarden.org>, git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 14:00:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXFhc-0004nB-Ia
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 14:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbYCFM70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 07:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbYCFM70
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 07:59:26 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:13722 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbYCFM7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 07:59:25 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1240433rvb.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 04:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=kxmtqP6MVygAxnuttz7J+j0AV5v2WoOWcmtzp90cuQU=;
        b=YniaEqZMjKnLR71tQNBGjUOHhTobt/68DRPQ9QENwbJCoVQJ1uiIyfUbwvf1o8t6g82W8hhMUOYkhr4iMQQRw7B7gvWSS+m/4mTXFIec4OSNidF9bnZY9cNUCBIYF49Q3q8VhICAVFdZV95gcn4TWwLe9DD1Qz6E7sMBsG3i4kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=jkWw8gceUPovGX323QGCPccdnjtOuGLKAql26DZCZe1XvWSvLfL72KDVLBDlUFNbsTzDCFS5BLuCpocUxvviXt8KSn/7ypXwK+yAbtSozmUmrKqgLiA4ITykdox7JFW9adwb02p23rzVKO8DXlRA9esx7h2bQ6vQQn5WULvJeqM=
Received: by 10.141.86.14 with SMTP id o14mr1893794rvl.148.1204808364459;
        Thu, 06 Mar 2008 04:59:24 -0800 (PST)
Received: by 10.141.86.15 with HTTP; Thu, 6 Mar 2008 04:59:24 -0800 (PST)
In-Reply-To: <18383.57540.26282.526111@cargo.ozlabs.ibm.com>
Content-Disposition: inline
X-Google-Sender-Auth: 9a70926659cf46a8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76391>

On Thu, Mar 6, 2008 at 12:17 PM, Paul Mackerras <paulus@samba.org> wrote:
> Mark Levedahl writes:
>
>  > I can only offer to test the proposed patch, I am unable to predict what
>  > will or won't trip up the buggy geometry engine in Cygwin's Tk. I do
>  > remember I had trouble finding a way to restore the size but not the
>  > position of the main window on Cygwin: that doesn't mean it can't be
>  > done (logically, it should be easy), just that I didn't find the right
>  > spell or incantation that would work. I'll also admit to not having
>  > tried after I got to a completely working geometry solution, so perhaps
>  > just restoring the size without position will now work on Cygwin.
>  >
>  > Using the saved panel sizes in conjunction with the default window size
>  > yields an unusable screen: many elements are obscured. The same occurs
>  > using the defaults altogether: either way the user must resize and
>  > adjust things to get to a workable layout. So, I am very opposed to
>  > disabling the memory altogether. Also, I have a number of X apps that
>  > remember their layout, so gitk's current behavior is not (at least to
>  > me) an aberration and I would like that behavior to at least remain an
>  > option.
>
>  Here's a patch for people to test.  It only restores the width and
>  height, and limits the width and height to be at most the width and
>  height of the screen.  It seems to work fine under X; I would be
>  interested to know what happens under macos and windows.
>
>  Paul.
>  ---
>  diff --git a/gitk b/gitk
>  index f1f21e9..f8f006f 100755
>  --- a/gitk
>  +++ b/gitk
>  @@ -930,9 +930,17 @@ proc makewindow {} {
>      .pwbottom add .bright
>      .ctop add .pwbottom
>
>  -    # restore window position if known
>  +    # restore window width & height if known
>      if {[info exists geometry(main)]} {
>  -        wm geometry . "$geometry(main)"
>  +       if {[scan $geometry(main) "%dx%d" w h] >= 2} {
>  +           if {$w > [winfo screenwidth .]} {
>  +               set w [winfo screenwidth .]
>  +           }
>  +           if {$h > [winfo screenheight .]} {
>  +               set h [winfo screenheight .]
>  +           }
>  +           wm geometry . "${w}x$h"
>  +       }
>      }
>
>      if {[tk windowingsystem] eq {aqua}} {
>
>  --
>


This almost works on OS X.  The only problem is that it's not taking
into account menubars and windowbars.  eg, if I have a screen
resolution of 640x480, setting the window _content_ to that size will
make the entire window including its titlebar about 500px tall.  Not
only that, but the system-wide menubar at the top of the screen also
reduces the available space, meaning that the maximum window size
ought to be around 640x456.  (If you wanted to get even pickier, that
will changing depending on the interface resolution...)

Presumably your patch does nothing to move gitk back on screen if the
monitor it was on last time has gone away?  Or are we still blaming
the window manager for that?
