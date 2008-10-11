From: Paul Mackerras <paulus@samba.org>
Subject: Re: [Gitk PATCH 1/6] gitk: Add procedure to create accelerated menus
Date: Sat, 11 Oct 2008 12:40:09 +1100
Message-ID: <18672.1017.68669.913415@cargo.ozlabs.ibm.com>
References: <1223532590-8706-1-git-send-email-robin.rosenberg@dewire.com>
	<1223532590-8706-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 04:47:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoUVq-0002d4-Vx
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 04:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbYJKCqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 22:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753896AbYJKCqK
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 22:46:10 -0400
Received: from ozlabs.org ([203.10.76.45]:41069 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753807AbYJKCqK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 22:46:10 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7EB2ADE187; Sat, 11 Oct 2008 13:46:08 +1100 (EST)
In-Reply-To: <1223532590-8706-2-git-send-email-robin.rosenberg@dewire.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97963>

Robin Rosenberg writes:

> +proc mcw {menubar args} {
> +    set ai [lsearch $args "-label"]
> +    if { $ai > 0 } {
> +	set label [lindex $args [expr {$ai + 1}]]
> +	foreach {l u} [::tk::UnderlineAmpersand $label] {

Where did you find out about ::tk::UnderlineAmpersand?  Is it part of
the exported interface of Tk that we can rely on in future?

> +# Wrapper for mc to remove ampersands used for accelerators.
> +proc mca {label} {
> +    set tl8 [mc $label]
> +    foreach {l u} [::tk::UnderlineAmpersand $tl8] break
> +    return $l

	return [string map {"&" ""} [mc $label]]

instead, perhaps?

Paul.
