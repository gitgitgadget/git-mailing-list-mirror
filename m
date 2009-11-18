From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] replace: use a GIT_NO_REPLACE_OBJECTS env variable
Date: Wed, 18 Nov 2009 07:48:41 +0100
Message-ID: <200911180748.42061.chriscool@tuxfamily.org>
References: <20091117051125.3588.91072.chriscool@tuxfamily.org> <4B0253DA.1090003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 07:46:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAeJL-0008DQ-2A
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 07:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbZKRGq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 01:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbZKRGq1
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 01:46:27 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:52035 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570AbZKRGq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 01:46:27 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DAB7281809C;
	Wed, 18 Nov 2009 07:46:23 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 15E10818002;
	Wed, 18 Nov 2009 07:46:20 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <4B0253DA.1090003@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133145>

On mardi 17 novembre 2009, Johannes Sixt wrote:
> Christian Couder schrieb:
> > diff --git a/git.c b/git.c
> > index bd2c5fe..7f7d73d 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -89,6 +89,9 @@ static int handle_options(const char ***argv, int
> > *argc, int *envchanged) *envchanged = 1;
> >  		} else if (!strcmp(cmd, "--no-replace-objects")) {
> >  			read_replace_refs = 0;
> > +			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "", 1);
>
> It is safer to set to a non-empty string, e.g., "1".

Ok, I will use a non empty string.

> I think this variable should be added to the list in connect.c around
> line 630 so that it does not propagate to the remote end.

Ok, I have done that in the version I will send.

Thanks,
Christian.
