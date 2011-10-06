From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC jn/ident-from-etc-mailname] ident: do not retrieve
 default ident when unnecessary
Date: Thu, 6 Oct 2011 13:48:23 -0500
Message-ID: <20111006184823.GB16942@elie>
References: <20111003045745.GA17604@elie>
 <7v8vp2iqvc.fsf@alter.siamese.dyndns.org>
 <20111003061633.GB17289@elie>
 <4E895FBD.8020904@viscovery.net>
 <20111003074433.GD17289@elie>
 <7vty7pga7y.fsf@alter.siamese.dyndns.org>
 <20111006171719.GB6946@elie>
 <7vy5wyyod1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Matt Kraai <kraai@ftbfs.org>, Gerrit Pape <pape@smarden.org>,
	Ian Jackson <ijackson@chiark.greenend.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 20:48:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBszn-00049G-Gi
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 20:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758961Ab1JFSsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 14:48:33 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50678 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758890Ab1JFSsc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 14:48:32 -0400
Received: by yxl31 with SMTP id 31so2904912yxl.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VLpZKsVAT+k0ArRkKRuFFBgBKfYlj65B3dWDbPo03II=;
        b=T9EH1T9aiB92XySQUr2UQrh76S+0Cna2foO9UluVdQsQC6zWTwd1IqFXgTJNBvdKTf
         BJtDZOR0o953pmw22xhyFxGYPedlT9vt+Iye2gjTINp1WnkIokmVKgxVVf3CfaHn0GCV
         SvGZx5NUUPe5/CdzW1nXAz7JAogGvgPaCI5xc=
Received: by 10.236.178.41 with SMTP id e29mr5245582yhm.117.1317926910921;
        Thu, 06 Oct 2011 11:48:30 -0700 (PDT)
Received: from elie (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d5sm8868584yhl.19.2011.10.06.11.48.29
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 11:48:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vy5wyyod1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183015>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Avoid a getpwuid() call (which contacts the network if the password
>> database is not local), read of /etc/mailname, gethostname() call, and
>> reverse DNS lookup if the user has already chosen a name and email
>> through configuration, the environment, or the command line.
>
> Oh boy that is a hard to parse paragraph that took me three reads.

Here's a possible replacement:

 Avoid looking up the current user's password database entry (which
 might be on another machine) and the current machine's domain name for
 outgoing mail (which can involve a reverse DNS lookup) when the
 environment, configuration, or command line specifies a name and email
 that would override them.

Or it might make sense to drop that paragraph altogether, since the
subject line already says as much.

Thanks for looking it over.

Sleepily,
Jonathan
