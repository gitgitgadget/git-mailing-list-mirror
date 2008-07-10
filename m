From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 2/5] Don't display passwords on the console in fetch/push output
Date: Thu, 10 Jul 2008 20:56:43 +0200
Message-ID: <200807102056.43912.robin.rosenberg@dewire.com>
References: <1215670403-19191-1-git-send-email-spearce@spearce.org> <1215670403-19191-2-git-send-email-spearce@spearce.org> <1215670403-19191-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 21:07:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH1TZ-0005yX-I9
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 21:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbYGJTBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 15:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbYGJTBv
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 15:01:51 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12479 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752106AbYGJTBv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 15:01:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 35C1A802846;
	Thu, 10 Jul 2008 21:01:49 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v-0PN0p30974; Thu, 10 Jul 2008 21:01:48 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 976448027F7;
	Thu, 10 Jul 2008 21:01:48 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1215670403-19191-3-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87997>

torsdagen den 10 juli 2008 08.13.20 skrev Shawn O. Pearce:
> When we show the URI we just fetched or pushed against there may
> be a user password embedded in that URI, as saved in the user's
> .git/config file.  We shouldn't display that in public to prying
> eyes so nulling it out will give us a copy of the URI without that
> field in it.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  .../src/org/spearce/jgit/pgm/Fetch.java            |    2 +-
>  .../src/org/spearce/jgit/pgm/Push.java             |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
> index c9c997e..36a0592 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
> @@ -71,7 +71,7 @@ class Fetch extends TextBuiltin {
>  			return;
>  
>  		out.print("From ");
> -		out.print(tn.getURI());
> +		out.print(tn.getURI().setPass(null));

We did this a while ago. Sort of patching broken stuff instead of fixing what's broken, thus we should make URIIsh.toiString
not display the password.

-- robin
