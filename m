From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: What's in git.git
Date: Tue, 12 Feb 2008 10:15:28 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802121010590.416@yvahk3.pbagnpgbe.fr>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 10:33:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOrW9-0005qj-NT
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 10:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbYBLJc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 04:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbYBLJc7
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 04:32:59 -0500
Received: from kluster1.contactor.se ([91.191.140.11]:34829 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369AbYBLJc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 04:32:59 -0500
X-Greylist: delayed 1048 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2008 04:32:58 EST
Received: from linux3.contactor.se (linux3.contactor.se [91.191.140.23])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id m1C9FS4X011790
	for <git@vger.kernel.org>; Tue, 12 Feb 2008 10:15:28 +0100
X-X-Sender: dast@linux3.contactor.se
In-Reply-To: <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73644>

On Mon, 11 Feb 2008, Junio C Hamano wrote:

> Mike Hommey (1):
>  Work around curl-gnutls not liking to be reinitialized

But why reinitialize libcurl at all in the first place? This "work-around"
should rather be the standard behavior since there should be no logical reason 
to re-initialize libcurl's global state during a git's execution.

Even though Mike correctly identified a libcurl bug, it also indirectly 
identified a git flaw: re-initialization with the curl_global_* functions is 
pointless and only wastes time.
