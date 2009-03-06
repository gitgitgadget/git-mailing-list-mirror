From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/3] bash completion: refactor --strategy completion
Date: Fri, 6 Mar 2009 11:12:01 -0500
Message-ID: <76718490903060812q2e7b2eefg5f25c9845f678959@mail.gmail.com>
References: <cover.1236314073.git.jaysoffian@gmail.com>
	 <2d83927582e9eed004b9fd12b77105a184277229.1236314073.git.jaysoffian@gmail.com>
	 <20090306160452.GH16213@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 17:13:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfcg4-00079d-Ox
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 17:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256AbZCFQMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 11:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbZCFQMH
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 11:12:07 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:10413 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbZCFQME (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 11:12:04 -0500
Received: by rv-out-0506.google.com with SMTP id g37so562726rvb.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 08:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YgDfEYDqKRzTp+U3cdsySXWaiSHyuggtmbq46wqxPos=;
        b=QCqXDpSNiBJhNfDCXdmJyKa9/dDWH+WTRldKoQqtOJo/bZi0HKwnBgjPYN68tHCyJR
         sU0l/PX/BeTHLwez6wIScXuNVC2hYZb+k0hmjR2GBYK1JhdmbAHNBJDsK5HtNP2m1lKF
         GOpk5vZvJzTPxtzs+IJh/j2yggXbW0AWikmiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LK77a003GEO8rxhcXy3tRszzqm6zE4WEBQfNP7CMUx93dHEBH9yGX8Od380MuWDrIe
         gMsVX9QPmcvJeh5WuLwtJEr+Ik7+p8QGSJAV/yh3MH7NnKkINLbAj1pkaTx+rq3Rb5Eq
         LFY66iW2UwqWkpXmjXiZKmgaqFyN9N8jONTs0=
Received: by 10.140.136.5 with SMTP id j5mr1364539rvd.39.1236355921861; Fri, 
	06 Mar 2009 08:12:01 -0800 (PST)
In-Reply-To: <20090306160452.GH16213@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112458>

On Fri, Mar 6, 2009 at 11:04 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jay Soffian <jaysoffian@gmail.com> wrote:
>> The code to complete --strategy was duplicated between _git_rebase and
>> _git_merge, and is about to gain a third caller (_git_pull). This patch
>> factors it into its own function.
>>
>> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
>
> Looks OK to me, but I had to squash this in to get it to work.
> Without this the patch breaks git merge completion entirely:

Weird, I had it completely backwards but it seemed to work. Probably
because I was sourcing the new completion into my running shell; I'll
make sure to startup a new shell next time.

With the squash (assuming Junio doesn't mind), is it acked-by you or
should I resend?

j.
