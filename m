From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git doesn't append ".git" to url WAS [PATCH 0/3] http*: refactor 
	fetching code (v2)
Date: Thu, 21 May 2009 23:39:15 +0800
Message-ID: <be6fef0d0905210839i1789dc33uc760ab7779e68b51@mail.gmail.com>
References: <be6fef0d0905210717j174499f5k4740dc2f821bec62@mail.gmail.com>
	 <alpine.LSU.2.00.0905211518430.23333@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu May 21 17:39:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7AMn-0000tk-6d
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 17:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbZEUPjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 11:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754187AbZEUPjZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 11:39:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:26168 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbZEUPjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 11:39:24 -0400
Received: by wa-out-1112.google.com with SMTP id j5so254007wah.21
        for <git@vger.kernel.org>; Thu, 21 May 2009 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KGNfuW1PMC9b1uvg4MJ7jXCvinksS1UnX9DiUEF+HIk=;
        b=EvQFnj2UtkQIJrXF/eeqMraw4rLC0rY9LnxAAkA5Qjewa8y7lZrxfJtWQRH3rfgWQ8
         YxOJB7AyzmwDfuOfocGJ4osDPODGfLBFoMluOeE4je6lGPDZxfiR5e80hqu6A5s83aml
         qIpqZzjiIhD5ShCZATnMq8mMKulfPi58OhjDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nCO0kVk5dcmCRMK5zFK4GZzN8Zm9RJZMXhgw/P1nxbdptl77Km6Q4mhjIWbNwb3Gj9
         BhTEdmOaa6kzGXf0tz2pW56s/BG/ngOEQW49PnPqhy3xfWJcOj6fOa5CrLlHbpHycfWu
         nBoIylRuhmb5Dj5/p0cWxIS0kgddV0WfMQATA=
Received: by 10.114.74.18 with SMTP id w18mr4961285waa.205.1242920355841; Thu, 
	21 May 2009 08:39:15 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.00.0905211518430.23333@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119691>

Hi,

On Thu, May 21, 2009 at 10:29 PM, Tony Finch <dot@dotat.at> wrote:
> ...Git's error message is misleading: the problem is
> nothing to do with running git update-server-info (see below).

you're right. Perhaps git should check if the repo (on http://) exists
first, before printing that message.

> Its
> behaviour is inconsistent: git retries after appending .git if you are
> fetching from a local repository or ssh:// or git:// URLs but not for
> http:// URLs.

that's true too.

> Actually maybe there's a third bug: it says it has initialized
> a repository but it removes it again if the clone fails.

well, if the clone fails, then the cloned repo would be in an
incomplete state, so removing it isn't that bad an idea. Perhaps an
option could be made to prevents clone from doing this, so that one
could try restarting the clone.

-- 
Cheers,
Ray Chuan
