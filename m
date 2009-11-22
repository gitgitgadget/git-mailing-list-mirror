From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: new 'add-envelope' option
Date: Sun, 22 Nov 2009 14:37:04 +0200
Message-ID: <94a0d4530911220437l5386b36ds4ef06dc66cc11bcc@mail.gmail.com>
References: <1258825410-28592-1-git-send-email-felipe.contreras@gmail.com>
	 <20091121193600.GA3296@coredump.intra.peff.net>
	 <94a0d4530911211159l1fadad0ldb0d760439ceb57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 22 13:37:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCBgk-0003HJ-H6
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 13:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859AbZKVMg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 07:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbZKVMg6
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 07:36:58 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:62552 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbZKVMg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 07:36:58 -0500
Received: by gxk26 with SMTP id 26so4147010gxk.1
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ElrbutsHVw1cZrVge73pEkLHGYhIIzr8LL8DJxn3wsk=;
        b=ni/eHQWGmuN8GXRmuhcYJTrELexLQFfklCJ8VApF33fkGSpkWanb/0b4ghoThLUQh4
         HFKdV6StLkQNs4sWPHVkrXhG+crdZPiIzy3Fhj3EVZ5fILHW7t/z2hknHad/2cOeIJO6
         ijGPDVy0cWYaVo9CqrIGOHm09HOl2l4cU5rpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gCSHQO/GrxL7PGKVBVz9ICEJ/elz3TyzAJ+zKCQ3wokyfvAotdclk2JDKxbxU6EOvx
         emQ2MS1VKQ3HRK7/1wv9xB2cxEl8Tk5KqaoVEcS3J4LIncV+LwMkbdrVHdZa4wtcKH9F
         EvpXTHCiNccHxElFHu+zn91adiovrKSR9KR8U=
Received: by 10.231.160.143 with SMTP id n15mr1538390ibx.54.1258893424204; 
	Sun, 22 Nov 2009 04:37:04 -0800 (PST)
In-Reply-To: <94a0d4530911211159l1fadad0ldb0d760439ceb57@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133431>

On Sat, Nov 21, 2009 at 9:59 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Nov 21, 2009 at 9:36 PM, Jeff King <peff@peff.net> wrote:
>> --envelope-from is IMHO confusingly similar to
>> --envelope-sender. Maybe --use-from-in-envelope would be a better name?
>
> Ok. I don't have any opinion on the name.

I thought a bit more about this, and in the end what we really want is
to add the sender envelope. The most typical case would be to use the
'from' address, but we should be able to override it (we do both by
using --envelope-sender).

So here are other options.

a) --add-envelope: add the sender envelope, by default it would be the
'from' address, but could be overridden by --envelope-sender.

b) --envelope-sender="" or "auto": this would require minimal changes
but looks a bit strange.

Any thoughts?

-- 
Felipe Contreras
