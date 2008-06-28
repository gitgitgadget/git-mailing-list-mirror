From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [PATCH] shrink git-shell by avoiding redundant dependencies
Date: Sat, 28 Jun 2008 20:48:54 +0400
Message-ID: <37fcd2780806280948y143b619p60f05495ca85454b@mail.gmail.com>
References: <1214602538-7888-1-git-send-email-dpotapov@gmail.com>
	 <alpine.DEB.1.00.0806281542160.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 28 18:49:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCdcY-00048r-Jm
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 18:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbYF1Qsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 12:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbYF1Qsz
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 12:48:55 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:31999 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbYF1Qsy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 12:48:54 -0400
Received: by wf-out-1314.google.com with SMTP id 27so902959wfd.4
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iR+H9M1hGwUCEK6/TmCbHBsafliTjNiAL0B9+ZG1B/g=;
        b=vJknXfQPI6j4k8XC9Z0ovs5Gsdhv8T5y0vEVtjxfkudDt0kLe7az96yV9I96GhMnUI
         Zgz2Zhp+ksXYZLgNbDEAhvQIKJT0rGI9PuDwZYIKegzpyxicJ+oAsqDEpD69MXeVeAb+
         9DSSjNzC5nO7StIBruBzUHtWjNDmarYXd2IrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kEMO4w6lvSsIm/1DdhLFA6elJutrUQT7UFzUaQ6872v5gbWVlL6qPHfM/YXvwIuIJB
         piJU6yOP5t0Wbt7A/Er+rU40WndI+T8RKJce+XphNO8XD67u+532ilvoSqc9du7HdFvZ
         JWhMfgLP+hrEy7T7GhnePZzVhVBIzGuR3BTYc=
Received: by 10.142.245.6 with SMTP id s6mr1053254wfh.157.1214671734370;
        Sat, 28 Jun 2008 09:48:54 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Sat, 28 Jun 2008 09:48:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806281542160.9925@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86727>

On Sat, Jun 28, 2008 at 6:51 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> /me wonders if "strip git-shell" would not take care of all that.

"strip" removes only debug information. It has no affect on text, data, and bss
sections. You can try to run "size git-shell" before and after
"strip", and you'll
see the same numbers.

BTW, it is possible to reduce the "text" and "data" size twice more
using the whole
program optimization, as it will discard some functions that are not
actually used,
but I don't think it is worth pursuing as it will complicate complication.

Dmitry
