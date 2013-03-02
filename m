From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Debugging a bizarre problem: What can influence 'git fetch'?
Date: Sat, 2 Mar 2013 18:32:17 +0800
Message-ID: <CALUzUxoFwpi6J3TKTaxuCjLumOkyhWFLqz6k_23X4P0xpwD26A@mail.gmail.com>
References: <20130301143940.7e31f0c2@copperhead.int.arc7.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: git-users@io7m.com
X-From: git-owner@vger.kernel.org Sat Mar 02 11:33:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBjkW-0000pO-4L
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 11:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725Ab3CBKcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Mar 2013 05:32:39 -0500
Received: from mail-ia0-f170.google.com ([209.85.210.170]:62788 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab3CBKci (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Mar 2013 05:32:38 -0500
Received: by mail-ia0-f170.google.com with SMTP id k20so3432821iak.15
        for <git@vger.kernel.org>; Sat, 02 Mar 2013 02:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5kBK5oNfmEN2QMqElpvt1bZnb+Ivjh0qyBkx+eQTyvM=;
        b=PJQX+tkmx4ZZ3in4grY2ASq6pCjbIt9NkCpCY81xei3Rp2tJhAabi8RS1JQLilNSS6
         Vgq98SwR7C4kJF2uIUXq42qGR04yjBkn+ReP6yUclJm9DChU5j6ov0s3bclinzOa41WN
         MZTacVOC/dI+i4Xe+s4nRw9B9pIxCcouoC1bms/55M9CCtpdXBPPE8d5YO3ZlApX9JXs
         PjrA9d9y49vC3mO73dM260we1WcvcA6p2h3ui6DRXKYDaIoIbfrsvQtP6wrgHTyPCNAo
         npgWZ2ML5gNksFjpSmsNmcTV8syjSIPurNnaN7XWdfmwJ+nURcbZix3nYB1YhI/f0MuR
         eoiA==
X-Received: by 10.42.60.197 with SMTP id r5mr12609028ich.21.1362220357616;
 Sat, 02 Mar 2013 02:32:37 -0800 (PST)
Received: by 10.64.18.235 with HTTP; Sat, 2 Mar 2013 02:32:17 -0800 (PST)
In-Reply-To: <20130301143940.7e31f0c2@copperhead.int.arc7.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217324>

On Fri, Mar 1, 2013 at 10:39 PM,  <git-users@io7m.com> wrote:
> Is there some way to get 'git fetch'
> to be more verbose?

It seems that the remote is running the 'dumb' http protocol, you
might want to try setting the GIT_CURL_VERBOSE environment variable
for more verbosity.

Have you tried running git-update-server-info on the remote side?
Perhaps a push/fetch led to packs being created so the f981a2b object
isn't available as a loose object but in a pack but the remote still
indicates otherwise.

--
Cheers,
Ray Chuan
