From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] git-gui: Correctly set up locators in case of preset
 URL variable
Date: Fri, 3 Oct 2008 12:23:29 +0200
Message-ID: <20081003122329.432c6359@pc09.procura.nl>
References: <20080930195839.GK21310@spearce.org>
	<1223028826-10306-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org,
	Petr Baudis <petr.baudis@novartis.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Oct 03 12:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kli4F-0002gp-Aj
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 12:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbYJCKiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 06:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbYJCKiQ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 06:38:16 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:4731 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbYJCKiP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 06:38:15 -0400
X-Greylist: delayed 880 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Oct 2008 06:38:14 EDT
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id m93ANUV4053883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Oct 2008 12:23:30 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <1223028826-10306-1-git-send-email-pasky@suse.cz>
X-Mailer: Claws Mail 3.5.0cvs121 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97410>

On Fri,  3 Oct 2008 12:13:46 +0200, Petr Baudis <pasky@suse.cz> wrote:

> This patch fixes locators setup in case the URL variable is already set,
> e.g. in the clone dialog during 'git gui clone'.

While you are working on git-gui's transport.tcl, would you consider a
user setting to set the default for pushing tags to remote repositories?

After installation/update I always `fix' that by hand now.

> Signed-off-by: Petr Baudis <petr.baudis@novartis.com>
> 
> ---
>  git-gui/lib/transport.tcl |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/git-gui/lib/transport.tcl b/git-gui/lib/transport.tcl
> index 277e6b8..02c4eca 100644
> --- a/git-gui/lib/transport.tcl
> +++ b/git-gui/lib/transport.tcl
> @@ -68,8 +68,13 @@ proc location_input {widget urlvar op} {
>  
>  	global _locator_template _locator_input _locator_var
>  	trace remove variable _locator_input write locator_update
> -	set _locator_template $default_locator
> -	set _locator_input {}
> +	if {[set $urlvar] == {}} {
> +		set _locator_template $default_locator
> +		set _locator_input {}
> +	} else {
> +		set _locator_template "URL"
> +		set _locator_input [set $urlvar]
> +	}
>  	set _locator_var $urlvar
>  	trace add variable _locator_input write locator_update

-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
