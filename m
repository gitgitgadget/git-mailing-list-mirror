From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH] rebase -i: add exec command to launch a shell command
Date: Mon, 2 Aug 2010 08:30:01 -0400
Message-ID: <20100802123001.GA3500@localhost.localdomain>
References: <vpqwrs9nxi5.fsf@bauges.imag.fr>
 <1280743433-27803-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 02 14:30:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofu9q-0007iQ-L3
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 14:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab0HBMaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 08:30:09 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54957 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab0HBMaI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 08:30:08 -0400
Received: by qyk7 with SMTP id 7so5335933qyk.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 05:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Bgy0PDBj3oIfej72PtjXMtQ2oEv5dFNhIIdhuSTsJL4=;
        b=hPuEtnE+gHQK7Mv7JdhxeeBQ19u1JxKYC2KY7KU+9Ak6yGrv3wkDDHdGZc1lEJ2Gpn
         3hO6ek+lqumXwPh6FTB6IlaVCvf1qhHINzk04fe4VdudeoOUXwEl14AMG5evwlr2fvze
         tHHb8GZKwpCWzoxF6nbEBPriddUtuulkTwJdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RgAIQinT7vmcIZQJeKYC43Kyhc9SpEqG00UuBfmQNosP5iLH306QuasCD+OQVR1sg4
         LX263fkG8/keI1U6Q/lIZu/5EVadVbyDa2/6GORjy9zh2tjrBc+PzeIVlb1Hn0akTl+a
         wQ4FBmIDgwP7iOeK5m49KBM96oNImNWzljkMY=
Received: by 10.220.75.200 with SMTP id z8mr4183401vcj.57.1280752207284;
        Mon, 02 Aug 2010 05:30:07 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id v11sm6065674vbb.1.2010.08.02.05.30.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 05:30:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280743433-27803-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152406>

On Mon, Aug 02, 2010 at 12:03:53PM +0200, Matthieu Moy wrote:
> The shell command is ran (in the directory where the rebase was started
> by the user)

I disagree with how intuitive this behavior is. "rebase" is a
repository level command - It modifies the objects in the repository.
As a side effect, the working tree attached to a (non-bare) repository
is changed, even outside of where the rebase was ran.

Since the rebase affects the entire repository, I think it makes sense
for the commands to be run out of the repository root.

Perhaps a command-line option for toggling this behavior would be a
good compromise.
