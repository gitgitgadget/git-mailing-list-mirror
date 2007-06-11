From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Mon, 11 Jun 2007 09:24:36 +0200
Message-ID: <81b0412b0706110024mf975011t27b23555f6a23cc6@mail.gmail.com>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
	 <alpine.LFD.0.99.0706102206590.12885@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com,
	"Johan Herland" <johan@herland.net>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 09:25:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxeH7-00036E-6Z
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 09:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbXFKHYj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 03:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754855AbXFKHYj
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 03:24:39 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:46151 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361AbXFKHYi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 03:24:38 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1364262wxc
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 00:24:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CBw9TQKitAlFTc3DvpV0hzUQTgXDqWOG/CNTkLEVbKQlYORTAL8aNd9rUC2inWXKx3Qd3s19cV5L1Mqmov/lOH2EERwcP7y9P50xu4uEeMBjKUb+uRLNqqSD6gHNo7/4/8oC03HEzlmKmiIkct8GdSo4MpCo2LvvBa9hB/0if5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JHKlEuclhk6aKRUGMBG/gBG0gAvEL31Hsjo5StZ7yBL+jlwso8NT6fGe2RUBxTP6laDFAh5t++IYG4S4KBxrCCy5oNB6NLK2+kItRyeHsUwqwDOBGICUBysfLf7XxC8GBFuvDy1OoMTOPdyrneZR2Ly04HV7Itfc8rra8XItGRU=
Received: by 10.78.183.15 with SMTP id g15mr2034346huf.1181546676896;
        Mon, 11 Jun 2007 00:24:36 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Mon, 11 Jun 2007 00:24:36 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0706102206590.12885@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49826>

On 6/11/07, Nicolas Pitre <nico@cam.org> wrote:
> On Sat, 9 Jun 2007, Johannes Schindelin wrote:
>
> > The annotations are tracked in a new ref, refs/annotations/commits,
> > in the same fan-out style as .git/objects/??/*, only that they only
> > exist in the object database now.
>
> Isn't this abusing the refs namespace a bit?  Why not
> .git/annotations/... instead?
>

It is still a reference, really. Besides, if it is not under refs/, we'd
have to change fetch/push to allow distribution of the notes/annotations
(there are special assumptions regarding reference names starting
with "refs/"). Right now it just works.
