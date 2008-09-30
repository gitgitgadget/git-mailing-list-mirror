From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [RFC PATCH (GIT-GUI)] git-gui: Add more integration options to citool.
Date: Tue, 30 Sep 2008 11:53:02 +0400
Organization: HOME
Message-ID: <200809301153.02214.angavrilov@gmail.com>
References: <200809122243.50007.angavrilov@gmail.com> <200809261419.41392.angavrilov@gmail.com> <20080926144536.GA3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 09:56:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kka5U-0005bS-Jp
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 09:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbYI3Hyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 03:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753141AbYI3Hyi
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 03:54:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:46837 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbYI3Hyg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 03:54:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1709498fgg.17
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 00:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dD5pNPIaJ3+UgIfhIpjIMWQwl8Rw+ZmfBC2+CXxcHZM=;
        b=b6KfqnyuPRwe/A0agO1HeSQRDmftRcCpYqVhJxjcAWOemLpY4ZAFvcpXHSFCikYxtF
         1mKwnUrFFE6cVsTcwq2zLEZONvvhK/kTnsCgvIl5/2iWaDeEPtVgy3zY5LnvvMsM8+wL
         0kTlCSCBkD4a/GnvPLtCCCqZH/GrBYXch/Y4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vXl9WLG5IqmwLXtthZsg4g1Wg46gFGvr2vii0N2U1KqB3o6Yi1RIkCRnJ6idsyUdXg
         YZDq4jOhpJoOSqYP1Ms0x8QdA4SuaIQX9c0psZUtJl8oUqvETluP/Img9OUI/rYB9pr4
         VPzOcDr9U4PtSSuBJOj28M5Z7Z9/t7KIceNEE=
Received: by 10.103.247.14 with SMTP id z14mr4569018mur.39.1222761274486;
        Tue, 30 Sep 2008 00:54:34 -0700 (PDT)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id j9sm6503627mue.3.2008.09.30.00.54.32
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 00:54:33 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.26.3-29.fc9.i686; KDE/4.1.1; i686; ; )
In-Reply-To: <20080926144536.GA3669@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97075>

On Friday 26 September 2008 18:45:36 Shawn O. Pearce wrote:
> Alexander Gavrilov <angavrilov@gmail.com> wrote:
> > On Wednesday 24 September 2008 20:52:01 Shawn O. Pearce wrote:
> > > 
> > > --8<--
> > > git-gui: Hide commit related UI during citool --nocommit
> > 
> > I believe that the 'Sign Off' button should better be controlled by the nocommitmsg
> > option; otherwise this looks good to me. But I'm not the best thinker at the
> > moment (had a cold).
> 
> Since I've already pushed that patch in both git-gui.git and git.git
> how is this as a followup?

Yes, it does what I was thinking of.
 
> --8<--
> git-gui: Show/hide "Sign Off" based on nocommitmsg option
> 
> If citool --nocommit is invoked we hide the Sign Off features, as
> the commit message area is not editable.  But we really want the
> selection tied to the message area's editing ability.
> 
> Suggested-by: Alexander Gavrilov <angavrilov@gmail.com>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  git-gui.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 4085e8f..09ce410 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2413,7 +2413,7 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
>  
>  	.mbar.commit add separator
>  
> -	if {![is_enabled nocommit]} {
> +	if {![is_enabled nocommitmsg]} {
>  		.mbar.commit add command -label [mc "Sign Off"] \
>  			-command do_signoff \
>  			-accelerator $M1T-S
> @@ -2743,7 +2743,7 @@ pack .vpane.lower.commarea.buttons.incall -side top -fill x
>  lappend disable_on_lock \
>  	{.vpane.lower.commarea.buttons.incall conf -state}
>  
> -if {![is_enabled nocommit]} {
> +if {![is_enabled nocommitmsg]} {
>  	button .vpane.lower.commarea.buttons.signoff -text [mc "Sign Off"] \
>  		-command do_signoff
>  	pack .vpane.lower.commarea.buttons.signoff -side top -fill x
> -- 
> 1.6.0.2.508.g2bf53a
> 
> 
